#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int
main(int argc, char **argv)
{
	const char code[] =
//START
"\x68\x31\x32\x33\x34\xc7\x44\x24"
"\x04\x35\x36\x37\x38\xb8\x01\x00"
"\x00\x00\xbf\x01\x00\x00\x00\x48"
"\x89\xe6\xba\x08\x00\x00\x00\x0f"
"\x05\xb8\x3c\x00\x00\x00\xbf\x00"
"\x00\x00\x00\x0f\x05";
//END

	(*(void (*)())code)();
	return 0;
}
