#include <stdio.h>

int main() {
  int array[10];
  int n = 0;

  while (scanf("%d", &array[n]) == 1) {
    n++;
  }

  printf("%d", array[0]);
  printf("end\n");
}
