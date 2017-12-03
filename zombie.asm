
_zombie:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(void)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 10             	sub    $0x10,%esp
  if(fork() > 0)
   9:	e8 62 02 00 00       	call   270 <fork>
   e:	85 c0                	test   %eax,%eax
  10:	7e 0c                	jle    1e <main+0x1e>
    sleep(5);  // Let child exit before parent.
  12:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
  19:	e8 ea 02 00 00       	call   308 <sleep>
  exit();
  1e:	e8 55 02 00 00       	call   278 <exit>
  23:	90                   	nop

00000024 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  24:	55                   	push   %ebp
  25:	89 e5                	mov    %esp,%ebp
  27:	57                   	push   %edi
  28:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  29:	8b 4d 08             	mov    0x8(%ebp),%ecx
  2c:	8b 55 10             	mov    0x10(%ebp),%edx
  2f:	8b 45 0c             	mov    0xc(%ebp),%eax
  32:	89 cb                	mov    %ecx,%ebx
  34:	89 df                	mov    %ebx,%edi
  36:	89 d1                	mov    %edx,%ecx
  38:	fc                   	cld    
  39:	f3 aa                	rep stos %al,%es:(%edi)
  3b:	89 ca                	mov    %ecx,%edx
  3d:	89 fb                	mov    %edi,%ebx
  3f:	89 5d 08             	mov    %ebx,0x8(%ebp)
  42:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  45:	5b                   	pop    %ebx
  46:	5f                   	pop    %edi
  47:	5d                   	pop    %ebp
  48:	c3                   	ret    

00000049 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  49:	55                   	push   %ebp
  4a:	89 e5                	mov    %esp,%ebp
  4c:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  4f:	8b 45 08             	mov    0x8(%ebp),%eax
  52:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  55:	90                   	nop
  56:	8b 45 08             	mov    0x8(%ebp),%eax
  59:	8d 50 01             	lea    0x1(%eax),%edx
  5c:	89 55 08             	mov    %edx,0x8(%ebp)
  5f:	8b 55 0c             	mov    0xc(%ebp),%edx
  62:	8d 4a 01             	lea    0x1(%edx),%ecx
  65:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  68:	8a 12                	mov    (%edx),%dl
  6a:	88 10                	mov    %dl,(%eax)
  6c:	8a 00                	mov    (%eax),%al
  6e:	84 c0                	test   %al,%al
  70:	75 e4                	jne    56 <strcpy+0xd>
    ;
  return os;
  72:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  75:	c9                   	leave  
  76:	c3                   	ret    

00000077 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  77:	55                   	push   %ebp
  78:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  7a:	eb 06                	jmp    82 <strcmp+0xb>
    p++, q++;
  7c:	ff 45 08             	incl   0x8(%ebp)
  7f:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  82:	8b 45 08             	mov    0x8(%ebp),%eax
  85:	8a 00                	mov    (%eax),%al
  87:	84 c0                	test   %al,%al
  89:	74 0e                	je     99 <strcmp+0x22>
  8b:	8b 45 08             	mov    0x8(%ebp),%eax
  8e:	8a 10                	mov    (%eax),%dl
  90:	8b 45 0c             	mov    0xc(%ebp),%eax
  93:	8a 00                	mov    (%eax),%al
  95:	38 c2                	cmp    %al,%dl
  97:	74 e3                	je     7c <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  99:	8b 45 08             	mov    0x8(%ebp),%eax
  9c:	8a 00                	mov    (%eax),%al
  9e:	0f b6 d0             	movzbl %al,%edx
  a1:	8b 45 0c             	mov    0xc(%ebp),%eax
  a4:	8a 00                	mov    (%eax),%al
  a6:	0f b6 c0             	movzbl %al,%eax
  a9:	29 c2                	sub    %eax,%edx
  ab:	89 d0                	mov    %edx,%eax
}
  ad:	5d                   	pop    %ebp
  ae:	c3                   	ret    

000000af <strlen>:

uint
strlen(char *s)
{
  af:	55                   	push   %ebp
  b0:	89 e5                	mov    %esp,%ebp
  b2:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
  b5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  bc:	eb 03                	jmp    c1 <strlen+0x12>
  be:	ff 45 fc             	incl   -0x4(%ebp)
  c1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  c4:	8b 45 08             	mov    0x8(%ebp),%eax
  c7:	01 d0                	add    %edx,%eax
  c9:	8a 00                	mov    (%eax),%al
  cb:	84 c0                	test   %al,%al
  cd:	75 ef                	jne    be <strlen+0xf>
    ;
  return n;
  cf:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  d2:	c9                   	leave  
  d3:	c3                   	ret    

000000d4 <memset>:

void*
memset(void *dst, int c, uint n)
{
  d4:	55                   	push   %ebp
  d5:	89 e5                	mov    %esp,%ebp
  d7:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
  da:	8b 45 10             	mov    0x10(%ebp),%eax
  dd:	89 44 24 08          	mov    %eax,0x8(%esp)
  e1:	8b 45 0c             	mov    0xc(%ebp),%eax
  e4:	89 44 24 04          	mov    %eax,0x4(%esp)
  e8:	8b 45 08             	mov    0x8(%ebp),%eax
  eb:	89 04 24             	mov    %eax,(%esp)
  ee:	e8 31 ff ff ff       	call   24 <stosb>
  return dst;
  f3:	8b 45 08             	mov    0x8(%ebp),%eax
}
  f6:	c9                   	leave  
  f7:	c3                   	ret    

000000f8 <strchr>:

char*
strchr(const char *s, char c)
{
  f8:	55                   	push   %ebp
  f9:	89 e5                	mov    %esp,%ebp
  fb:	83 ec 04             	sub    $0x4,%esp
  fe:	8b 45 0c             	mov    0xc(%ebp),%eax
 101:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 104:	eb 12                	jmp    118 <strchr+0x20>
    if(*s == c)
 106:	8b 45 08             	mov    0x8(%ebp),%eax
 109:	8a 00                	mov    (%eax),%al
 10b:	3a 45 fc             	cmp    -0x4(%ebp),%al
 10e:	75 05                	jne    115 <strchr+0x1d>
      return (char*)s;
 110:	8b 45 08             	mov    0x8(%ebp),%eax
 113:	eb 11                	jmp    126 <strchr+0x2e>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 115:	ff 45 08             	incl   0x8(%ebp)
 118:	8b 45 08             	mov    0x8(%ebp),%eax
 11b:	8a 00                	mov    (%eax),%al
 11d:	84 c0                	test   %al,%al
 11f:	75 e5                	jne    106 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 121:	b8 00 00 00 00       	mov    $0x0,%eax
}
 126:	c9                   	leave  
 127:	c3                   	ret    

00000128 <gets>:

char*
gets(char *buf, int max)
{
 128:	55                   	push   %ebp
 129:	89 e5                	mov    %esp,%ebp
 12b:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 12e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 135:	eb 49                	jmp    180 <gets+0x58>
    cc = read(0, &c, 1);
 137:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 13e:	00 
 13f:	8d 45 ef             	lea    -0x11(%ebp),%eax
 142:	89 44 24 04          	mov    %eax,0x4(%esp)
 146:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 14d:	e8 3e 01 00 00       	call   290 <read>
 152:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 155:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 159:	7f 02                	jg     15d <gets+0x35>
      break;
 15b:	eb 2c                	jmp    189 <gets+0x61>
    buf[i++] = c;
 15d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 160:	8d 50 01             	lea    0x1(%eax),%edx
 163:	89 55 f4             	mov    %edx,-0xc(%ebp)
 166:	89 c2                	mov    %eax,%edx
 168:	8b 45 08             	mov    0x8(%ebp),%eax
 16b:	01 c2                	add    %eax,%edx
 16d:	8a 45 ef             	mov    -0x11(%ebp),%al
 170:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 172:	8a 45 ef             	mov    -0x11(%ebp),%al
 175:	3c 0a                	cmp    $0xa,%al
 177:	74 10                	je     189 <gets+0x61>
 179:	8a 45 ef             	mov    -0x11(%ebp),%al
 17c:	3c 0d                	cmp    $0xd,%al
 17e:	74 09                	je     189 <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 180:	8b 45 f4             	mov    -0xc(%ebp),%eax
 183:	40                   	inc    %eax
 184:	3b 45 0c             	cmp    0xc(%ebp),%eax
 187:	7c ae                	jl     137 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 189:	8b 55 f4             	mov    -0xc(%ebp),%edx
 18c:	8b 45 08             	mov    0x8(%ebp),%eax
 18f:	01 d0                	add    %edx,%eax
 191:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 194:	8b 45 08             	mov    0x8(%ebp),%eax
}
 197:	c9                   	leave  
 198:	c3                   	ret    

00000199 <stat>:

int
stat(char *n, struct stat *st)
{
 199:	55                   	push   %ebp
 19a:	89 e5                	mov    %esp,%ebp
 19c:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 19f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 1a6:	00 
 1a7:	8b 45 08             	mov    0x8(%ebp),%eax
 1aa:	89 04 24             	mov    %eax,(%esp)
 1ad:	e8 06 01 00 00       	call   2b8 <open>
 1b2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 1b5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 1b9:	79 07                	jns    1c2 <stat+0x29>
    return -1;
 1bb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1c0:	eb 23                	jmp    1e5 <stat+0x4c>
  r = fstat(fd, st);
 1c2:	8b 45 0c             	mov    0xc(%ebp),%eax
 1c5:	89 44 24 04          	mov    %eax,0x4(%esp)
 1c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1cc:	89 04 24             	mov    %eax,(%esp)
 1cf:	e8 fc 00 00 00       	call   2d0 <fstat>
 1d4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 1d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1da:	89 04 24             	mov    %eax,(%esp)
 1dd:	e8 be 00 00 00       	call   2a0 <close>
  return r;
 1e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 1e5:	c9                   	leave  
 1e6:	c3                   	ret    

000001e7 <atoi>:

int
atoi(const char *s)
{
 1e7:	55                   	push   %ebp
 1e8:	89 e5                	mov    %esp,%ebp
 1ea:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 1ed:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 1f4:	eb 24                	jmp    21a <atoi+0x33>
    n = n*10 + *s++ - '0';
 1f6:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1f9:	89 d0                	mov    %edx,%eax
 1fb:	c1 e0 02             	shl    $0x2,%eax
 1fe:	01 d0                	add    %edx,%eax
 200:	01 c0                	add    %eax,%eax
 202:	89 c1                	mov    %eax,%ecx
 204:	8b 45 08             	mov    0x8(%ebp),%eax
 207:	8d 50 01             	lea    0x1(%eax),%edx
 20a:	89 55 08             	mov    %edx,0x8(%ebp)
 20d:	8a 00                	mov    (%eax),%al
 20f:	0f be c0             	movsbl %al,%eax
 212:	01 c8                	add    %ecx,%eax
 214:	83 e8 30             	sub    $0x30,%eax
 217:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 21a:	8b 45 08             	mov    0x8(%ebp),%eax
 21d:	8a 00                	mov    (%eax),%al
 21f:	3c 2f                	cmp    $0x2f,%al
 221:	7e 09                	jle    22c <atoi+0x45>
 223:	8b 45 08             	mov    0x8(%ebp),%eax
 226:	8a 00                	mov    (%eax),%al
 228:	3c 39                	cmp    $0x39,%al
 22a:	7e ca                	jle    1f6 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 22c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 22f:	c9                   	leave  
 230:	c3                   	ret    

00000231 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 231:	55                   	push   %ebp
 232:	89 e5                	mov    %esp,%ebp
 234:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;

  dst = vdst;
 237:	8b 45 08             	mov    0x8(%ebp),%eax
 23a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 23d:	8b 45 0c             	mov    0xc(%ebp),%eax
 240:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 243:	eb 16                	jmp    25b <memmove+0x2a>
    *dst++ = *src++;
 245:	8b 45 fc             	mov    -0x4(%ebp),%eax
 248:	8d 50 01             	lea    0x1(%eax),%edx
 24b:	89 55 fc             	mov    %edx,-0x4(%ebp)
 24e:	8b 55 f8             	mov    -0x8(%ebp),%edx
 251:	8d 4a 01             	lea    0x1(%edx),%ecx
 254:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 257:	8a 12                	mov    (%edx),%dl
 259:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 25b:	8b 45 10             	mov    0x10(%ebp),%eax
 25e:	8d 50 ff             	lea    -0x1(%eax),%edx
 261:	89 55 10             	mov    %edx,0x10(%ebp)
 264:	85 c0                	test   %eax,%eax
 266:	7f dd                	jg     245 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 268:	8b 45 08             	mov    0x8(%ebp),%eax
}
 26b:	c9                   	leave  
 26c:	c3                   	ret    
 26d:	90                   	nop
 26e:	90                   	nop
 26f:	90                   	nop

00000270 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 270:	b8 01 00 00 00       	mov    $0x1,%eax
 275:	cd 40                	int    $0x40
 277:	c3                   	ret    

00000278 <exit>:
SYSCALL(exit)
 278:	b8 02 00 00 00       	mov    $0x2,%eax
 27d:	cd 40                	int    $0x40
 27f:	c3                   	ret    

00000280 <wait>:
SYSCALL(wait)
 280:	b8 03 00 00 00       	mov    $0x3,%eax
 285:	cd 40                	int    $0x40
 287:	c3                   	ret    

00000288 <pipe>:
SYSCALL(pipe)
 288:	b8 04 00 00 00       	mov    $0x4,%eax
 28d:	cd 40                	int    $0x40
 28f:	c3                   	ret    

00000290 <read>:
SYSCALL(read)
 290:	b8 05 00 00 00       	mov    $0x5,%eax
 295:	cd 40                	int    $0x40
 297:	c3                   	ret    

00000298 <write>:
SYSCALL(write)
 298:	b8 10 00 00 00       	mov    $0x10,%eax
 29d:	cd 40                	int    $0x40
 29f:	c3                   	ret    

000002a0 <close>:
SYSCALL(close)
 2a0:	b8 15 00 00 00       	mov    $0x15,%eax
 2a5:	cd 40                	int    $0x40
 2a7:	c3                   	ret    

000002a8 <kill>:
SYSCALL(kill)
 2a8:	b8 06 00 00 00       	mov    $0x6,%eax
 2ad:	cd 40                	int    $0x40
 2af:	c3                   	ret    

000002b0 <exec>:
SYSCALL(exec)
 2b0:	b8 07 00 00 00       	mov    $0x7,%eax
 2b5:	cd 40                	int    $0x40
 2b7:	c3                   	ret    

000002b8 <open>:
SYSCALL(open)
 2b8:	b8 0f 00 00 00       	mov    $0xf,%eax
 2bd:	cd 40                	int    $0x40
 2bf:	c3                   	ret    

000002c0 <mknod>:
SYSCALL(mknod)
 2c0:	b8 11 00 00 00       	mov    $0x11,%eax
 2c5:	cd 40                	int    $0x40
 2c7:	c3                   	ret    

000002c8 <unlink>:
SYSCALL(unlink)
 2c8:	b8 12 00 00 00       	mov    $0x12,%eax
 2cd:	cd 40                	int    $0x40
 2cf:	c3                   	ret    

000002d0 <fstat>:
SYSCALL(fstat)
 2d0:	b8 08 00 00 00       	mov    $0x8,%eax
 2d5:	cd 40                	int    $0x40
 2d7:	c3                   	ret    

000002d8 <link>:
SYSCALL(link)
 2d8:	b8 13 00 00 00       	mov    $0x13,%eax
 2dd:	cd 40                	int    $0x40
 2df:	c3                   	ret    

000002e0 <mkdir>:
SYSCALL(mkdir)
 2e0:	b8 14 00 00 00       	mov    $0x14,%eax
 2e5:	cd 40                	int    $0x40
 2e7:	c3                   	ret    

000002e8 <chdir>:
SYSCALL(chdir)
 2e8:	b8 09 00 00 00       	mov    $0x9,%eax
 2ed:	cd 40                	int    $0x40
 2ef:	c3                   	ret    

000002f0 <dup>:
SYSCALL(dup)
 2f0:	b8 0a 00 00 00       	mov    $0xa,%eax
 2f5:	cd 40                	int    $0x40
 2f7:	c3                   	ret    

000002f8 <getpid>:
SYSCALL(getpid)
 2f8:	b8 0b 00 00 00       	mov    $0xb,%eax
 2fd:	cd 40                	int    $0x40
 2ff:	c3                   	ret    

00000300 <sbrk>:
SYSCALL(sbrk)
 300:	b8 0c 00 00 00       	mov    $0xc,%eax
 305:	cd 40                	int    $0x40
 307:	c3                   	ret    

00000308 <sleep>:
SYSCALL(sleep)
 308:	b8 0d 00 00 00       	mov    $0xd,%eax
 30d:	cd 40                	int    $0x40
 30f:	c3                   	ret    

00000310 <uptime>:
SYSCALL(uptime)
 310:	b8 0e 00 00 00       	mov    $0xe,%eax
 315:	cd 40                	int    $0x40
 317:	c3                   	ret    

00000318 <getticks>:
SYSCALL(getticks)
 318:	b8 16 00 00 00       	mov    $0x16,%eax
 31d:	cd 40                	int    $0x40
 31f:	c3                   	ret    

00000320 <get_name>:
SYSCALL(get_name)
 320:	b8 17 00 00 00       	mov    $0x17,%eax
 325:	cd 40                	int    $0x40
 327:	c3                   	ret    

00000328 <get_max_proc>:
SYSCALL(get_max_proc)
 328:	b8 18 00 00 00       	mov    $0x18,%eax
 32d:	cd 40                	int    $0x40
 32f:	c3                   	ret    

00000330 <get_max_mem>:
SYSCALL(get_max_mem)
 330:	b8 19 00 00 00       	mov    $0x19,%eax
 335:	cd 40                	int    $0x40
 337:	c3                   	ret    

00000338 <get_max_disk>:
SYSCALL(get_max_disk)
 338:	b8 1a 00 00 00       	mov    $0x1a,%eax
 33d:	cd 40                	int    $0x40
 33f:	c3                   	ret    

00000340 <get_curr_proc>:
SYSCALL(get_curr_proc)
 340:	b8 1b 00 00 00       	mov    $0x1b,%eax
 345:	cd 40                	int    $0x40
 347:	c3                   	ret    

00000348 <get_curr_mem>:
SYSCALL(get_curr_mem)
 348:	b8 1c 00 00 00       	mov    $0x1c,%eax
 34d:	cd 40                	int    $0x40
 34f:	c3                   	ret    

00000350 <get_curr_disk>:
SYSCALL(get_curr_disk)
 350:	b8 1d 00 00 00       	mov    $0x1d,%eax
 355:	cd 40                	int    $0x40
 357:	c3                   	ret    

00000358 <set_name>:
SYSCALL(set_name)
 358:	b8 1e 00 00 00       	mov    $0x1e,%eax
 35d:	cd 40                	int    $0x40
 35f:	c3                   	ret    

00000360 <set_max_mem>:
SYSCALL(set_max_mem)
 360:	b8 1f 00 00 00       	mov    $0x1f,%eax
 365:	cd 40                	int    $0x40
 367:	c3                   	ret    

00000368 <set_max_disk>:
SYSCALL(set_max_disk)
 368:	b8 20 00 00 00       	mov    $0x20,%eax
 36d:	cd 40                	int    $0x40
 36f:	c3                   	ret    

00000370 <set_max_proc>:
SYSCALL(set_max_proc)
 370:	b8 21 00 00 00       	mov    $0x21,%eax
 375:	cd 40                	int    $0x40
 377:	c3                   	ret    

00000378 <set_curr_mem>:
SYSCALL(set_curr_mem)
 378:	b8 22 00 00 00       	mov    $0x22,%eax
 37d:	cd 40                	int    $0x40
 37f:	c3                   	ret    

00000380 <set_curr_disk>:
SYSCALL(set_curr_disk)
 380:	b8 23 00 00 00       	mov    $0x23,%eax
 385:	cd 40                	int    $0x40
 387:	c3                   	ret    

00000388 <set_curr_proc>:
SYSCALL(set_curr_proc)
 388:	b8 24 00 00 00       	mov    $0x24,%eax
 38d:	cd 40                	int    $0x40
 38f:	c3                   	ret    

00000390 <find>:
SYSCALL(find)
 390:	b8 25 00 00 00       	mov    $0x25,%eax
 395:	cd 40                	int    $0x40
 397:	c3                   	ret    

00000398 <is_full>:
SYSCALL(is_full)
 398:	b8 26 00 00 00       	mov    $0x26,%eax
 39d:	cd 40                	int    $0x40
 39f:	c3                   	ret    

000003a0 <container_init>:
SYSCALL(container_init)
 3a0:	b8 27 00 00 00       	mov    $0x27,%eax
 3a5:	cd 40                	int    $0x40
 3a7:	c3                   	ret    

000003a8 <cont_proc_set>:
SYSCALL(cont_proc_set)
 3a8:	b8 28 00 00 00       	mov    $0x28,%eax
 3ad:	cd 40                	int    $0x40
 3af:	c3                   	ret    

000003b0 <ps>:
SYSCALL(ps)
 3b0:	b8 29 00 00 00       	mov    $0x29,%eax
 3b5:	cd 40                	int    $0x40
 3b7:	c3                   	ret    

000003b8 <reduce_curr_mem>:
SYSCALL(reduce_curr_mem)
 3b8:	b8 2a 00 00 00       	mov    $0x2a,%eax
 3bd:	cd 40                	int    $0x40
 3bf:	c3                   	ret    

000003c0 <set_root_inode>:
SYSCALL(set_root_inode)
 3c0:	b8 2b 00 00 00       	mov    $0x2b,%eax
 3c5:	cd 40                	int    $0x40
 3c7:	c3                   	ret    

000003c8 <cstop>:
SYSCALL(cstop)
 3c8:	b8 2c 00 00 00       	mov    $0x2c,%eax
 3cd:	cd 40                	int    $0x40
 3cf:	c3                   	ret    

000003d0 <df>:
SYSCALL(df)
 3d0:	b8 2d 00 00 00       	mov    $0x2d,%eax
 3d5:	cd 40                	int    $0x40
 3d7:	c3                   	ret    

000003d8 <max_containers>:
SYSCALL(max_containers)
 3d8:	b8 2e 00 00 00       	mov    $0x2e,%eax
 3dd:	cd 40                	int    $0x40
 3df:	c3                   	ret    

000003e0 <container_reset>:
SYSCALL(container_reset)
 3e0:	b8 2f 00 00 00       	mov    $0x2f,%eax
 3e5:	cd 40                	int    $0x40
 3e7:	c3                   	ret    

000003e8 <pause>:
SYSCALL(pause)
 3e8:	b8 30 00 00 00       	mov    $0x30,%eax
 3ed:	cd 40                	int    $0x40
 3ef:	c3                   	ret    

000003f0 <resume>:
SYSCALL(resume)
 3f0:	b8 31 00 00 00       	mov    $0x31,%eax
 3f5:	cd 40                	int    $0x40
 3f7:	c3                   	ret    

000003f8 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3f8:	55                   	push   %ebp
 3f9:	89 e5                	mov    %esp,%ebp
 3fb:	83 ec 18             	sub    $0x18,%esp
 3fe:	8b 45 0c             	mov    0xc(%ebp),%eax
 401:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 404:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 40b:	00 
 40c:	8d 45 f4             	lea    -0xc(%ebp),%eax
 40f:	89 44 24 04          	mov    %eax,0x4(%esp)
 413:	8b 45 08             	mov    0x8(%ebp),%eax
 416:	89 04 24             	mov    %eax,(%esp)
 419:	e8 7a fe ff ff       	call   298 <write>
}
 41e:	c9                   	leave  
 41f:	c3                   	ret    

00000420 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 420:	55                   	push   %ebp
 421:	89 e5                	mov    %esp,%ebp
 423:	56                   	push   %esi
 424:	53                   	push   %ebx
 425:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 428:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 42f:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 433:	74 17                	je     44c <printint+0x2c>
 435:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 439:	79 11                	jns    44c <printint+0x2c>
    neg = 1;
 43b:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 442:	8b 45 0c             	mov    0xc(%ebp),%eax
 445:	f7 d8                	neg    %eax
 447:	89 45 ec             	mov    %eax,-0x14(%ebp)
 44a:	eb 06                	jmp    452 <printint+0x32>
  } else {
    x = xx;
 44c:	8b 45 0c             	mov    0xc(%ebp),%eax
 44f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 452:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 459:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 45c:	8d 41 01             	lea    0x1(%ecx),%eax
 45f:	89 45 f4             	mov    %eax,-0xc(%ebp)
 462:	8b 5d 10             	mov    0x10(%ebp),%ebx
 465:	8b 45 ec             	mov    -0x14(%ebp),%eax
 468:	ba 00 00 00 00       	mov    $0x0,%edx
 46d:	f7 f3                	div    %ebx
 46f:	89 d0                	mov    %edx,%eax
 471:	8a 80 e8 0a 00 00    	mov    0xae8(%eax),%al
 477:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 47b:	8b 75 10             	mov    0x10(%ebp),%esi
 47e:	8b 45 ec             	mov    -0x14(%ebp),%eax
 481:	ba 00 00 00 00       	mov    $0x0,%edx
 486:	f7 f6                	div    %esi
 488:	89 45 ec             	mov    %eax,-0x14(%ebp)
 48b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 48f:	75 c8                	jne    459 <printint+0x39>
  if(neg)
 491:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 495:	74 10                	je     4a7 <printint+0x87>
    buf[i++] = '-';
 497:	8b 45 f4             	mov    -0xc(%ebp),%eax
 49a:	8d 50 01             	lea    0x1(%eax),%edx
 49d:	89 55 f4             	mov    %edx,-0xc(%ebp)
 4a0:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 4a5:	eb 1e                	jmp    4c5 <printint+0xa5>
 4a7:	eb 1c                	jmp    4c5 <printint+0xa5>
    putc(fd, buf[i]);
 4a9:	8d 55 dc             	lea    -0x24(%ebp),%edx
 4ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4af:	01 d0                	add    %edx,%eax
 4b1:	8a 00                	mov    (%eax),%al
 4b3:	0f be c0             	movsbl %al,%eax
 4b6:	89 44 24 04          	mov    %eax,0x4(%esp)
 4ba:	8b 45 08             	mov    0x8(%ebp),%eax
 4bd:	89 04 24             	mov    %eax,(%esp)
 4c0:	e8 33 ff ff ff       	call   3f8 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 4c5:	ff 4d f4             	decl   -0xc(%ebp)
 4c8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4cc:	79 db                	jns    4a9 <printint+0x89>
    putc(fd, buf[i]);
}
 4ce:	83 c4 30             	add    $0x30,%esp
 4d1:	5b                   	pop    %ebx
 4d2:	5e                   	pop    %esi
 4d3:	5d                   	pop    %ebp
 4d4:	c3                   	ret    

000004d5 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4d5:	55                   	push   %ebp
 4d6:	89 e5                	mov    %esp,%ebp
 4d8:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4db:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 4e2:	8d 45 0c             	lea    0xc(%ebp),%eax
 4e5:	83 c0 04             	add    $0x4,%eax
 4e8:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 4eb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4f2:	e9 77 01 00 00       	jmp    66e <printf+0x199>
    c = fmt[i] & 0xff;
 4f7:	8b 55 0c             	mov    0xc(%ebp),%edx
 4fa:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4fd:	01 d0                	add    %edx,%eax
 4ff:	8a 00                	mov    (%eax),%al
 501:	0f be c0             	movsbl %al,%eax
 504:	25 ff 00 00 00       	and    $0xff,%eax
 509:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 50c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 510:	75 2c                	jne    53e <printf+0x69>
      if(c == '%'){
 512:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 516:	75 0c                	jne    524 <printf+0x4f>
        state = '%';
 518:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 51f:	e9 47 01 00 00       	jmp    66b <printf+0x196>
      } else {
        putc(fd, c);
 524:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 527:	0f be c0             	movsbl %al,%eax
 52a:	89 44 24 04          	mov    %eax,0x4(%esp)
 52e:	8b 45 08             	mov    0x8(%ebp),%eax
 531:	89 04 24             	mov    %eax,(%esp)
 534:	e8 bf fe ff ff       	call   3f8 <putc>
 539:	e9 2d 01 00 00       	jmp    66b <printf+0x196>
      }
    } else if(state == '%'){
 53e:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 542:	0f 85 23 01 00 00    	jne    66b <printf+0x196>
      if(c == 'd'){
 548:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 54c:	75 2d                	jne    57b <printf+0xa6>
        printint(fd, *ap, 10, 1);
 54e:	8b 45 e8             	mov    -0x18(%ebp),%eax
 551:	8b 00                	mov    (%eax),%eax
 553:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 55a:	00 
 55b:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 562:	00 
 563:	89 44 24 04          	mov    %eax,0x4(%esp)
 567:	8b 45 08             	mov    0x8(%ebp),%eax
 56a:	89 04 24             	mov    %eax,(%esp)
 56d:	e8 ae fe ff ff       	call   420 <printint>
        ap++;
 572:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 576:	e9 e9 00 00 00       	jmp    664 <printf+0x18f>
      } else if(c == 'x' || c == 'p'){
 57b:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 57f:	74 06                	je     587 <printf+0xb2>
 581:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 585:	75 2d                	jne    5b4 <printf+0xdf>
        printint(fd, *ap, 16, 0);
 587:	8b 45 e8             	mov    -0x18(%ebp),%eax
 58a:	8b 00                	mov    (%eax),%eax
 58c:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 593:	00 
 594:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 59b:	00 
 59c:	89 44 24 04          	mov    %eax,0x4(%esp)
 5a0:	8b 45 08             	mov    0x8(%ebp),%eax
 5a3:	89 04 24             	mov    %eax,(%esp)
 5a6:	e8 75 fe ff ff       	call   420 <printint>
        ap++;
 5ab:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5af:	e9 b0 00 00 00       	jmp    664 <printf+0x18f>
      } else if(c == 's'){
 5b4:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 5b8:	75 42                	jne    5fc <printf+0x127>
        s = (char*)*ap;
 5ba:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5bd:	8b 00                	mov    (%eax),%eax
 5bf:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 5c2:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 5c6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5ca:	75 09                	jne    5d5 <printf+0x100>
          s = "(null)";
 5cc:	c7 45 f4 9b 08 00 00 	movl   $0x89b,-0xc(%ebp)
        while(*s != 0){
 5d3:	eb 1c                	jmp    5f1 <printf+0x11c>
 5d5:	eb 1a                	jmp    5f1 <printf+0x11c>
          putc(fd, *s);
 5d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5da:	8a 00                	mov    (%eax),%al
 5dc:	0f be c0             	movsbl %al,%eax
 5df:	89 44 24 04          	mov    %eax,0x4(%esp)
 5e3:	8b 45 08             	mov    0x8(%ebp),%eax
 5e6:	89 04 24             	mov    %eax,(%esp)
 5e9:	e8 0a fe ff ff       	call   3f8 <putc>
          s++;
 5ee:	ff 45 f4             	incl   -0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5f4:	8a 00                	mov    (%eax),%al
 5f6:	84 c0                	test   %al,%al
 5f8:	75 dd                	jne    5d7 <printf+0x102>
 5fa:	eb 68                	jmp    664 <printf+0x18f>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5fc:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 600:	75 1d                	jne    61f <printf+0x14a>
        putc(fd, *ap);
 602:	8b 45 e8             	mov    -0x18(%ebp),%eax
 605:	8b 00                	mov    (%eax),%eax
 607:	0f be c0             	movsbl %al,%eax
 60a:	89 44 24 04          	mov    %eax,0x4(%esp)
 60e:	8b 45 08             	mov    0x8(%ebp),%eax
 611:	89 04 24             	mov    %eax,(%esp)
 614:	e8 df fd ff ff       	call   3f8 <putc>
        ap++;
 619:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 61d:	eb 45                	jmp    664 <printf+0x18f>
      } else if(c == '%'){
 61f:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 623:	75 17                	jne    63c <printf+0x167>
        putc(fd, c);
 625:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 628:	0f be c0             	movsbl %al,%eax
 62b:	89 44 24 04          	mov    %eax,0x4(%esp)
 62f:	8b 45 08             	mov    0x8(%ebp),%eax
 632:	89 04 24             	mov    %eax,(%esp)
 635:	e8 be fd ff ff       	call   3f8 <putc>
 63a:	eb 28                	jmp    664 <printf+0x18f>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 63c:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 643:	00 
 644:	8b 45 08             	mov    0x8(%ebp),%eax
 647:	89 04 24             	mov    %eax,(%esp)
 64a:	e8 a9 fd ff ff       	call   3f8 <putc>
        putc(fd, c);
 64f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 652:	0f be c0             	movsbl %al,%eax
 655:	89 44 24 04          	mov    %eax,0x4(%esp)
 659:	8b 45 08             	mov    0x8(%ebp),%eax
 65c:	89 04 24             	mov    %eax,(%esp)
 65f:	e8 94 fd ff ff       	call   3f8 <putc>
      }
      state = 0;
 664:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 66b:	ff 45 f0             	incl   -0x10(%ebp)
 66e:	8b 55 0c             	mov    0xc(%ebp),%edx
 671:	8b 45 f0             	mov    -0x10(%ebp),%eax
 674:	01 d0                	add    %edx,%eax
 676:	8a 00                	mov    (%eax),%al
 678:	84 c0                	test   %al,%al
 67a:	0f 85 77 fe ff ff    	jne    4f7 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 680:	c9                   	leave  
 681:	c3                   	ret    
 682:	90                   	nop
 683:	90                   	nop

00000684 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 684:	55                   	push   %ebp
 685:	89 e5                	mov    %esp,%ebp
 687:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 68a:	8b 45 08             	mov    0x8(%ebp),%eax
 68d:	83 e8 08             	sub    $0x8,%eax
 690:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 693:	a1 04 0b 00 00       	mov    0xb04,%eax
 698:	89 45 fc             	mov    %eax,-0x4(%ebp)
 69b:	eb 24                	jmp    6c1 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 69d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a0:	8b 00                	mov    (%eax),%eax
 6a2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6a5:	77 12                	ja     6b9 <free+0x35>
 6a7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6aa:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6ad:	77 24                	ja     6d3 <free+0x4f>
 6af:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b2:	8b 00                	mov    (%eax),%eax
 6b4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6b7:	77 1a                	ja     6d3 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6bc:	8b 00                	mov    (%eax),%eax
 6be:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6c1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6c7:	76 d4                	jbe    69d <free+0x19>
 6c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6cc:	8b 00                	mov    (%eax),%eax
 6ce:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6d1:	76 ca                	jbe    69d <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 6d3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6d6:	8b 40 04             	mov    0x4(%eax),%eax
 6d9:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6e0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6e3:	01 c2                	add    %eax,%edx
 6e5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e8:	8b 00                	mov    (%eax),%eax
 6ea:	39 c2                	cmp    %eax,%edx
 6ec:	75 24                	jne    712 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 6ee:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6f1:	8b 50 04             	mov    0x4(%eax),%edx
 6f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f7:	8b 00                	mov    (%eax),%eax
 6f9:	8b 40 04             	mov    0x4(%eax),%eax
 6fc:	01 c2                	add    %eax,%edx
 6fe:	8b 45 f8             	mov    -0x8(%ebp),%eax
 701:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 704:	8b 45 fc             	mov    -0x4(%ebp),%eax
 707:	8b 00                	mov    (%eax),%eax
 709:	8b 10                	mov    (%eax),%edx
 70b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 70e:	89 10                	mov    %edx,(%eax)
 710:	eb 0a                	jmp    71c <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 712:	8b 45 fc             	mov    -0x4(%ebp),%eax
 715:	8b 10                	mov    (%eax),%edx
 717:	8b 45 f8             	mov    -0x8(%ebp),%eax
 71a:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 71c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 71f:	8b 40 04             	mov    0x4(%eax),%eax
 722:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 729:	8b 45 fc             	mov    -0x4(%ebp),%eax
 72c:	01 d0                	add    %edx,%eax
 72e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 731:	75 20                	jne    753 <free+0xcf>
    p->s.size += bp->s.size;
 733:	8b 45 fc             	mov    -0x4(%ebp),%eax
 736:	8b 50 04             	mov    0x4(%eax),%edx
 739:	8b 45 f8             	mov    -0x8(%ebp),%eax
 73c:	8b 40 04             	mov    0x4(%eax),%eax
 73f:	01 c2                	add    %eax,%edx
 741:	8b 45 fc             	mov    -0x4(%ebp),%eax
 744:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 747:	8b 45 f8             	mov    -0x8(%ebp),%eax
 74a:	8b 10                	mov    (%eax),%edx
 74c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 74f:	89 10                	mov    %edx,(%eax)
 751:	eb 08                	jmp    75b <free+0xd7>
  } else
    p->s.ptr = bp;
 753:	8b 45 fc             	mov    -0x4(%ebp),%eax
 756:	8b 55 f8             	mov    -0x8(%ebp),%edx
 759:	89 10                	mov    %edx,(%eax)
  freep = p;
 75b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 75e:	a3 04 0b 00 00       	mov    %eax,0xb04
}
 763:	c9                   	leave  
 764:	c3                   	ret    

00000765 <morecore>:

static Header*
morecore(uint nu)
{
 765:	55                   	push   %ebp
 766:	89 e5                	mov    %esp,%ebp
 768:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 76b:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 772:	77 07                	ja     77b <morecore+0x16>
    nu = 4096;
 774:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 77b:	8b 45 08             	mov    0x8(%ebp),%eax
 77e:	c1 e0 03             	shl    $0x3,%eax
 781:	89 04 24             	mov    %eax,(%esp)
 784:	e8 77 fb ff ff       	call   300 <sbrk>
 789:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 78c:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 790:	75 07                	jne    799 <morecore+0x34>
    return 0;
 792:	b8 00 00 00 00       	mov    $0x0,%eax
 797:	eb 22                	jmp    7bb <morecore+0x56>
  hp = (Header*)p;
 799:	8b 45 f4             	mov    -0xc(%ebp),%eax
 79c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 79f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7a2:	8b 55 08             	mov    0x8(%ebp),%edx
 7a5:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 7a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7ab:	83 c0 08             	add    $0x8,%eax
 7ae:	89 04 24             	mov    %eax,(%esp)
 7b1:	e8 ce fe ff ff       	call   684 <free>
  return freep;
 7b6:	a1 04 0b 00 00       	mov    0xb04,%eax
}
 7bb:	c9                   	leave  
 7bc:	c3                   	ret    

000007bd <malloc>:

void*
malloc(uint nbytes)
{
 7bd:	55                   	push   %ebp
 7be:	89 e5                	mov    %esp,%ebp
 7c0:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7c3:	8b 45 08             	mov    0x8(%ebp),%eax
 7c6:	83 c0 07             	add    $0x7,%eax
 7c9:	c1 e8 03             	shr    $0x3,%eax
 7cc:	40                   	inc    %eax
 7cd:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 7d0:	a1 04 0b 00 00       	mov    0xb04,%eax
 7d5:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7d8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7dc:	75 23                	jne    801 <malloc+0x44>
    base.s.ptr = freep = prevp = &base;
 7de:	c7 45 f0 fc 0a 00 00 	movl   $0xafc,-0x10(%ebp)
 7e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7e8:	a3 04 0b 00 00       	mov    %eax,0xb04
 7ed:	a1 04 0b 00 00       	mov    0xb04,%eax
 7f2:	a3 fc 0a 00 00       	mov    %eax,0xafc
    base.s.size = 0;
 7f7:	c7 05 00 0b 00 00 00 	movl   $0x0,0xb00
 7fe:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 801:	8b 45 f0             	mov    -0x10(%ebp),%eax
 804:	8b 00                	mov    (%eax),%eax
 806:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 809:	8b 45 f4             	mov    -0xc(%ebp),%eax
 80c:	8b 40 04             	mov    0x4(%eax),%eax
 80f:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 812:	72 4d                	jb     861 <malloc+0xa4>
      if(p->s.size == nunits)
 814:	8b 45 f4             	mov    -0xc(%ebp),%eax
 817:	8b 40 04             	mov    0x4(%eax),%eax
 81a:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 81d:	75 0c                	jne    82b <malloc+0x6e>
        prevp->s.ptr = p->s.ptr;
 81f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 822:	8b 10                	mov    (%eax),%edx
 824:	8b 45 f0             	mov    -0x10(%ebp),%eax
 827:	89 10                	mov    %edx,(%eax)
 829:	eb 26                	jmp    851 <malloc+0x94>
      else {
        p->s.size -= nunits;
 82b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 82e:	8b 40 04             	mov    0x4(%eax),%eax
 831:	2b 45 ec             	sub    -0x14(%ebp),%eax
 834:	89 c2                	mov    %eax,%edx
 836:	8b 45 f4             	mov    -0xc(%ebp),%eax
 839:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 83c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 83f:	8b 40 04             	mov    0x4(%eax),%eax
 842:	c1 e0 03             	shl    $0x3,%eax
 845:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 848:	8b 45 f4             	mov    -0xc(%ebp),%eax
 84b:	8b 55 ec             	mov    -0x14(%ebp),%edx
 84e:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 851:	8b 45 f0             	mov    -0x10(%ebp),%eax
 854:	a3 04 0b 00 00       	mov    %eax,0xb04
      return (void*)(p + 1);
 859:	8b 45 f4             	mov    -0xc(%ebp),%eax
 85c:	83 c0 08             	add    $0x8,%eax
 85f:	eb 38                	jmp    899 <malloc+0xdc>
    }
    if(p == freep)
 861:	a1 04 0b 00 00       	mov    0xb04,%eax
 866:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 869:	75 1b                	jne    886 <malloc+0xc9>
      if((p = morecore(nunits)) == 0)
 86b:	8b 45 ec             	mov    -0x14(%ebp),%eax
 86e:	89 04 24             	mov    %eax,(%esp)
 871:	e8 ef fe ff ff       	call   765 <morecore>
 876:	89 45 f4             	mov    %eax,-0xc(%ebp)
 879:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 87d:	75 07                	jne    886 <malloc+0xc9>
        return 0;
 87f:	b8 00 00 00 00       	mov    $0x0,%eax
 884:	eb 13                	jmp    899 <malloc+0xdc>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 886:	8b 45 f4             	mov    -0xc(%ebp),%eax
 889:	89 45 f0             	mov    %eax,-0x10(%ebp)
 88c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 88f:	8b 00                	mov    (%eax),%eax
 891:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 894:	e9 70 ff ff ff       	jmp    809 <malloc+0x4c>
}
 899:	c9                   	leave  
 89a:	c3                   	ret    
