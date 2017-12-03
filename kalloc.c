// Physical memory allocator, intended to allocate
// memory for user processes, kernel stacks, page table pages,
// and pipe buffers. Allocates 4096-byte pages.

#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "spinlock.h"
#include "container.h"
#include "proc.h"

#define NULL ((void*)0)


void freerange(void *vstart, void *vend);
extern char end[]; // first address after kernel loaded from ELF file
                   // defined by the kernel linker script in kernel.ld

struct run {
  struct run *next;
};

struct {
  struct spinlock lock;
  int use_lock;
  struct run *freelist;
  int i;
} kmem;

// Initialization happens in two phases.
// 1. main() calls kinit1() while still using entrypgdir to place just
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
  freerange(vstart, vend);
}

void
kinit2(void *vstart, void *vend)
{
  freerange(vstart, vend);
  kmem.use_lock = 1;
  kmem.i = 0;
}

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
    kfree(p);
}
//PAGEBREAK: 21
// Free the page of physical memory pointed at by v,
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
  struct run *r;


  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);

  if(kmem.use_lock){
    acquire(&kmem.lock);
    if(ticks > 1){
      int x = find(myproc()->cont->name);
      if(x >= 0){
        reduce_curr_mem(1, x);
      }
    }
  }
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  kmem.i--;
  if(kmem.use_lock)
    release(&kmem.lock);
}

// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock){
    acquire(&kmem.lock);
  }
  r = kmem.freelist;
  if(r)
    kmem.freelist = r->next;
  kmem.i++;
  if((char*)r != 0){
    if(ticks > 0){
      int x = find(myproc()->cont->name);
      if(x >= 0){
        int before = get_curr_mem(x);
        set_curr_mem(1, x);
        int after = get_curr_mem(x);
        if(before == after){
          cstop_container_helper(myproc()->cont);
        }
      }
   }
  }
  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}

int mem_usage(void){
  return kmem.i;
}
