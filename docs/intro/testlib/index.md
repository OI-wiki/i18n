If you are using C++ to create an OI problem, Testlib is an excellent helper tool when writing related programs (generator, validator, checker, interactor). It has become indispensable for OI problem authors from Russia and some other countries, and many competitions are using it as well: ROI, ICPC regional competitions, all Codeforces round ...

The Testlib library has only one file called `testlib.h`, so you only need to add `#include "testlib.h"` at the beginning of the program.

The specific usage of Testlib:

- Write [generator](./generator.md), which is the data generator.
- Write [validator](./validator.md) to determine whether the generated data meets the requirements of the problem, such as data range, format, etc.
- Write [interactor](./interactor.md), the interactive device, which is used for interactive questions.
- Write [checker](./checker.md), which is [Special Judge](../spj.md).

Testlib is fully compatible with [Polygon](https://polygon.codeforces.com/) which is developed by Codeforces.

 `testlib.h` was migrated from `testlib.pas` in 2005 and has been updated ever since. Testlib is compatible with most compilers, such as VC++, GCC g++, and compatible with C++11.

 **This article is mainly translated from [Testlib - Codeforces](https://codeforces.com/testlib). The GitHub repository of `testlib.h` is [MikeMirzayanov/testlib](https://github.com/MikeMirzayanov/testlib).**