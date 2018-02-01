#ifndef EMERALD_VMC_ASSERT_H
#define EMERALD_VMC_ASSERT_H
#ifndef FILE
#include <stdio.h>
#endif

#include <stdlib.h> // abort

# ifdef lint
#  define assert(ex) {int assert__x_; assert__x_ = (ex); assert__x_ = assert__x_;}
#  define _assert(ex) {int assert__x_; assert__x_ = (ex); assert__x_ = assert__x_;}
# else
#  ifndef NDEBUG
#   define assertMessage "Assertion failed: file %s, line %d\n"
#   define _assert(ex) {if (!(ex)){fprintf(stderr,\
     assertMessage, __FILE__, __LINE__); abort();}}
#   define assert(ex) {if (!(ex)){fprintf(stderr,\
     assertMessage, __FILE__, __LINE__);abort();}}
#  else
#   define _assert(ex) ;
#   define assert(ex) ;
#  endif
# endif
#endif // EMERALD_VMC_ASSERT_H
