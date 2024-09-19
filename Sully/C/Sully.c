#include <fcntl.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/stat.h>

// The source code of the program itself, stored as a string
char *code = "#include <fcntl.h>%1$c#include <stdlib.h>%1$c#include <stdio.h>%1$c#include <unistd.h>%1$c#include <sys/stat.h>%1$c%1$cchar *code = %3$c%5$s%3$c;%1$c%1$cint		main(void)%1$c{%1$c	char buffer[256];%1$c	int i = %4$d;%1$c%1$c	if (i <= 0)%1$c		return (0);%1$c#ifdef CHILD%1$c	i--;%1$c#endif%1$c	sprintf(buffer, %3$cSully_%2$cd.c%3$c, i);%1$c	chmod(buffer, 0644);%1$c	int fd = open(buffer, O_CREAT | O_TRUNC | O_WRONLY, 0644);%1$c	if (fd < 0)%1$c		return (1);%1$c	dprintf(fd, code, 10, 37, 34, i, code);%1$c	close(fd);%1$c	sprintf(buffer, %3$cgcc -Wall -Wextra -Werror -DCHILD Sully_%2$c1$d.c -o Sully_%2$c1$d%3$c, i);%1$c	system(buffer);%1$c	if (i)%1$c	{%1$c		sprintf(buffer, %3$c./Sully_%2$c1$d%3$c, i);%1$c		system(buffer);%1$c	}%1$c	return (0);%1$c}%1$c";

int main(void)
{
	char buffer[256]; // Buffer to hold file names and commands
	int i = 5; // Initial value of the counter

	// If the counter is less than or equal to 0, exit the program
	if (i <= 0)
		return (0);

#ifdef CHILD
	i--; // Decrement the counter if CHILD is defined
#endif

	// Create the file name for the new source file
	sprintf(buffer, "Sully_%d.c", i);
	chmod(buffer, 0644); // Set the file permissions

	// Open the new source file for writing
	int fd = open(buffer, O_CREAT | O_TRUNC | O_WRONLY, 0644);
	if (fd < 0)
		return (1); // Exit if the file could not be opened

	// Write the source code to the new file
	dprintf(fd, code, 10, 37, 34, i, code);
	close(fd); // Close the file

	// Compile the new source file
	sprintf(buffer, "gcc -Wall -Wextra -Werror -DCHILD Sully_%1$d.c -o Sully_%1$d", i);
	system(buffer);

	// If the counter is still greater than 0, execute the new program
	if (i)
	{
		sprintf(buffer, "./Sully_%1$d", i);
		system(buffer);
	}

	return (0); // Exit the program
}