#include <stdio.h>

/** Sphinx RST Example
 * ====================
 */


/** Regular macro. */
#define REGULAR_MACRO 123

/** Function like macro. */
#define MY_FUNCLIKE_MACRO(x,y) \
    invoke_a_function()

/** Simple typedef. */
typedef uint8_t my_flag_t;

/** Struct typedef. */
typedef struct my_struct {
    const char* field1;
    int         field2;
} my_struct_t;

/** Function prototype (note: this will also catch typedefs...) */
int my_function(const char* f1, int f2);


/** Main
 * ------
 *
 * Here's some raw code:
 *
 */
int main(int argc, char** argv)
{
    puts("Hello, world!");
    return 0;
}

