#include <math.h>
#include <stdio.h>

int main() {
    double end;
    scanf("%lf", &end);

    for (double d = 0.0; d < end; d += 0.125) {
        printf("sqrt(%f) = %f\n", d, sqrt(d));
    }
    return 0;
}
