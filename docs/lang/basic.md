## Code framework

If you don’t want to dive into the underlying principles, you can memorize this “framework” directly when you are just getting started:

```cpp
#include <cstdio>
#include <iostream>

int main() {
  // do something...
  return 0;
}
```

??? note "What is include？"
     `#include` is actually a preprocessor command, which means to "put" a file at this statement. The file being "put" is called a header file. In other words, when compiling, the compiler will "copy" the content in the header file `iostream` and "paste" it to the statement `#include <iostream>`. In this way, you can use the `std::cin`, `std::cout`, `std::endl` and other objects provided by `iostream`.

    If you have studied the C language, you will find that the header files in C++ that we are currently exposed to generally do not have the suffix `.h`, and those header files in the C language `xx.h` have become `cxx`. For example, `stdio.h` becomes `cstdio`. To maintain compatibility with C, C++ directly uses the header files in the C language. In order to distinguish between C++ header files and C header files, the `c` prefix is used.
      
    Generally speaking, you should determine which header files you want to `#include` according to the C++ program you need to write. But if you `#include` the extra header files, it will only increase the compilation time and will hardly affect the runtime. At present, we have only come into contact with the two header files `iostream` and `cstdio`. If you only need `scanf` and `printf`, then it is not needed to use `#include <iostream>`.

    Can I `#include` the header files written by myself? Yes.

    You can write a header file yourself, such as: `myheader.h`. Then, put it in the same directory as your code, and then `#include "myheader.h"`. It should be noted that the custom header files need to use quotation marks instead of brackets. Of course, you can also use the compilation command `-I <header_file_path>` to tell the compiler where to find the header file, so you don't need to put the header file in the same directory as the code.

??? note "What is `main()` ?"
    It can be understood that the code in `main()` will be executed the moment program starts running.

    In fact, the `main` function is called by the system or external programs. For example, your program is called using the command line, which actually means the `main` function in the program is being called (the construction of the global [variable](./var.md) is finished before this).

    The last `return 0;` means the program has run successfully. By default, when the program ends, it returns 0 to indicate that everything is normal, otherwise the return value indicates an error code. To whom is this value returned? In fact, it is the system or external program that calls the program you write, and it will receive this return value when your program ends. If you don't write the `return` statement, the program ends normally and the default return value is also 0.

    In C or C++, a nonzero return value will cause a runtime error (RE).

## Comment

There are two ways to write comments in C++ code:

1.  Inline comment

    Start with `//`. All content within the same line after this notation are comments.

2.  Block comment

    Start with `/*` and end with `*/`. All content between them are comments, and can cross lines.

The comment has no effect on the running of the program. It can be used to explain the meaning of the program, and can also prevent a certain piece of code from being executed (but it still remains in the source file).

In project development, comments can be convenient for future maintenance and others to read.

In OI, few people write many comments, but comments can make it easier for you to clarify thinking process when writing the code, or for future review. Moreover, if you want to write solutions and tutorials, appropriate comments can help readers with reading and understand the objective of the code.

## Input and output

###  `cin` and `cout` 

```cpp
#include <iostream>

int main() {
  int x, y;                          // declare variables
  std::cin >> x >> y;                // read in x and y
  std::cout << y << std::endl << x;  // output y, change to a new line, then output x
  return 0;                          // end main function
}
```

???+note "What are variables?"
    You can refer to the [variable page](./var.md).

???+note "What is `std`?" 
    std is the **namespace** used by the C++ standard template library. The namespace is used to avoid duplicate names.

    For detailed knowledge of namespaces, please refer to the [namespace](./namespace.md) page.

###  `scanf` 与 `printf` 

 `scanf` and `printf` are actually functions provided by the C language. In most cases, they are faster than `cin` and `cout`, and can easily control the input and output formats.
```cpp
#include <cstdio>

int main() {
  int x, y;
  scanf("%d%d", &x, &y);   // read in x and y
  printf("%d\n%d", y, x);  // output y, change to a new line, then output x
  return 0;
}
```

Among them, `%d` means that the input/output variable is a signed integer (`int` type) variable.

Similarly:

1. `%s` represents a string.
2. `%c` represents a character.
3. `%lf` represents double-precision floating point number (`double`).
4. `%lld` represents long integer (`long long` ). Depending on the system, it may also be `%I64d`.
5. `%u` represents unsigned integer (`unsigned int` ).
6. `%llu` represents unsigned long integer (`unsigned long long` ), and may also be `%I64u`.

In addition to type identifiers, there are also some ways to control the format, though many are not commonly used. We have selected two popular ones listed as follows:

1. `%1d` represents an integer with length 1. When reading in, even if there is no space, the number can be read digit by digit. When outputting, if the specified length is greater than the number of digits, it will be filled with spaces before the number. If the specified length is less than the number of digits, it has no effect.
2.  `%.6lf` is used for output, with six decimal places.

The corresponding places of these two operators can be filled with other numbers. For example, `%.3lf` means to keep three decimal places.

??? note "What are “Double precision floating point“ and “Long integer”?"
    These are the types of variables. Same as above, details will be explained in [variable](./var.md).

??? note "Why is there a `&` operator in `scanf`?"
    Here, `&` is actually the address operator, which returns the address of the variable in memory. The parameter received by scanf is the address of the variable. The specifics is fully explained in [pointer](./pointer.md), so you just need to remember it for now.

??? note "What is `\n`?" 
     It is an **escape character**, which means line break.

    Escape characters are used to represent some characters that cannot be entered directly, such as line breaks due to the inability to wrap in the string literal, quotation marks due to special meaning, inverses due to escape characters, and slashes.

    Commonly used escape characters are:

    1. `\t` represents a tab character.

    2. `\\` represents `\`.

    3. `\"` represents `"`.

    4. `\0` represents a null character, used to indicate the end of a C-style string.

    5. `\r` means carriage return. The newline character in Linux is `\n`, and the newline character in Windows is `\r\n`. In OI, if the output needs to change line, just use `\n`. But when reading in, if you use character-by-character reading, it may cause some problems due to line breaks. This requires extra attention. For example, `gets` treats `\n` as the end of the string. If the newline character is `\r\n`, `\r` will stay at the end of the string.

    6. In particular, `%%` means `%` and can only be used in `printf` or `scanf`. In other cases, just use `%`.

    ??? note "What are literals?"
        "Literal" is a program segment that is directly used as a value in the code. For example, `3` is an `int` literal, and `'c'` is a `char` literal. The `"hello world"` in the program we wrote above is also a string literal.

        Unexplained literals that appear for no reason are also called "magic numbers". If the code needs to be read, this is highly recommended not to do this.

## Extended content

### White space in C++

In C++, all whitespace characters (spaces, tabs, newlines), either multiple or single, are treated equally. (Of course, those within the quotation marks are not counted as part of the string.)

Therefore, you can use any coding style freely (except inline comments, string literals and preprocessor commands which must be on a single line), for example:

```cpp
/* clang-format off */

#include <iostream>

 int 

    main(){
int/**/x, y;  std::cin
>> x >>y;
                std::cout <<
          y  <<std::endl   
     << x
          
          ;
    
    return       0;     }
```

Of course, this is not recommended.

A code style that is also widely used but is different from the code style required by **OI Wiki**:

```cpp
/* clang-format off */

#include <iostream>

int main()
{
    int x, y;

    std::cin >> x >> y;
    std::cout << y << std::endl << x;

    return 0;
}
```

###  `#define` command

 `#define` Is a preprocessor command used to define macros, essentially text replacement. E.g:

```cpp
#include <iostream>
#define n 233
// n is not a variable, but the compiler will replace all the n with 233. 
// However, as a part of the identifier, n will not be replaced.
// For example, fn will not be replaced with f233. Similarly, the string will not be replaced.

int main() {
  std::cout << n;  // output 233
  return 0;
}
```

??? note "What are identifiers?"
    An identifier is a set of characters that can be used as a variable name. For example, `abcd` and `abc1` are both legal identifiers, but not for `1a` or `c+b`.

    Identifiers can not start with digits and can only be consisted of English letters, underscores. It is worth noting that keywords such as `int`, `for`, `if` cannot be used as identifiers.

??? note "What is a preprocessor command?"
    Preprocessor commands are the commands accepted by the pre-processor to make preliminary changes to the code, including `#include` and `#define` etc.

Macros can take parameters, and macros with parameters can be used like functions:

```cpp
#include <iostream>
#define sum(x, y) ((x) + (y))
#define square(x) ((x) * (x))

int main() {
  std::cout << sum(1, 2) << ' ' << 2 * sum(3, 5) << std::endl;  // output 3 16
}
```

But there is a difference between a macro with parameters and a function. That is, for the macros' nature of text replacement, they can cause many problems. For example:

```cpp
#include <iostream>
#define sum(x, y) x + y
// Here it should be #define sum(x, y) ((x) + (y))
#define square(x) ((x) * (x))

int main() {
  std::cout << sum(1, 2) << ' ' << 2 * sum(3, 5) << std::endl;
  // Output is 3 11. Because #define is to replace text, and the following sentence is replaced with 2 * 3 + 5.
  int i = 1;
  std::cout << square(++i) << ' ' << i;
  // Output is undefined because ++i is executed twice
  // It is undefined behavior to modify the same variable multiple times in the same statement (with exceptions)
}
```

Using `#define` is risky (because the scope of `#define` is the entire program, it may cause the text to be accidentally replaced), so please use it with caution. The recommended approach is to use the `const` keyword to declare constants and use functions instead of macros.

However, in OI, `#define` is still useful (the following two usages are not recommended, since it will reduce the format of the code):

1.  `#define int long long` + `signed main()`. Usually used to avoid errors caused by forgetting to use long long variables, or to eliminate the possibility of errors caused by forgetting to use long long during debugging. (It may also lead to increasing the constant or even TLE, or MLE because of the stackoverflow)
2.  `#define For(i, l, r) for (int i = (l); i <= (r); ++i)`, `#define pb push_back`, `#define mid ((l + r) / 2)`, used to shorten the length of the code.

However, `#define` also has some advantages. For example, combining with `#if` and other preprocessor commands produces amazing results, such as:

```cpp
#ifdef LINUX
// code for linux
#else
// code for other OS
#endif
```

You can use `-DLINUX` to control the compiled code when compiling without modifying the source file. This has another advantage: the executable file compiled with `-DLINUX` does not contain code from other OSs because those codes have been deleted during preprocessing.

 `#define` can also use `#` and `##` operators, which facilitates debugging process greatly.
