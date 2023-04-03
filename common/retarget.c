#include <stdio.h>

extern void uart_putc(const char ch);
extern unsigned char uart_getc();

int _write (int fd, char *pBuffer, int size)
{
	for (int i = 0; i < size; i++)
	{
		uart_putc(pBuffer[i]);
	}
	return size;
}
int _read (int fd, char *pBuffer, int size)
{
	for (int i = 0; i < size; i++)
	{
		pBuffer[i] = uart_getc();
	}
	return size;
}

