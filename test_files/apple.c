#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char *argv[])
{
  char* apple = "apple";

  char* apple2 = strdup(apple);
  if (apple2 == NULL) { return 1; }

  printf("%s == %s\n", apple, apple2);

  free(apple2);

  return 0;
}
