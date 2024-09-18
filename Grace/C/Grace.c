#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/stat.h>

/*
	Wait...What ?
*/
#define	FT(x)	int ㅤ(void){char *code = "#include <fcntl.h>%1$c#include <stdio.h>%1$c#include <unistd.h>%1$c#include <sys/stat.h>%1$c%1$c/*%1$c	Wait...What ?%1$c*/%1$c#define	FT(x)	int ㅤ(void){char *code = %2$c%3$s%2$c;chmod(%2$cGrace_kid.c%2$c, 0644);int fd = open(%2$cGrace_kid.c%2$c, O_CREAT | O_TRUNC | O_WRONLY, 0644);if (fd < 0){return (1);}dprintf(fd, code, 10, 34, code);close(fd);return (0);}%1$c#define ㅤ		f(n, a, m, e, _, a)%1$c#define			f(f, l, o, w, e, r) o##l##i##f%1$c%1$cFT(I don't know what I'm doing)%1$c";chmod("Grace_kid.c", 0644);int fd = open("Grace_kid.c", O_CREAT | O_TRUNC | O_WRONLY, 0644);if (fd < 0){return (1);}dprintf(fd, code, 10, 34, code);close(fd);return (0);}
#define ㅤ		f(n, a, m, e, _, a)
#define			f(f, l, o, w, e, r) o##l##i##f

FT(I don't know what I'm doing)