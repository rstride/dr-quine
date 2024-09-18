#include <stdio.h>

/*
	this is the f function
*/
void		f(void)
{
	char *code = "#include <stdio.h>%1$c%1$c/*%1$c	this is the f function%1$c*/%1$cvoid		f(void)%1$c{%1$c	char *code = %2$c%3$s%2$c;%1$c	printf(code, 10, 34, code);%1$c}%1$c%1$cint			main(void)%1$c{%1$c	/*%1$c		I'm  a super useful comment%1$c	*/%1$c	f();%1$c	return (0);%1$c}%1$c";
	printf(code, 10, 34, code);
}

int			main(void)
{
	/*
		I'm  a super useful comment
	*/
	f();
	return (0);
}