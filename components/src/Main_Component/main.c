#include <stdio.h>
#include "C_hello.h"
#include "CPP_hello.h"

int main() {
    printf("Hello, Windows!\n");

    /* Call C code */
    c_say_hello();

    /* Call C++ code */ /* testing main push */
    cpp_say_hello();

    return 0;
}