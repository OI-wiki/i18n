<!---i18n/docs/lang/basic.md-->
<!---Translation reference: 
1. https://www.cplusplus.com/doc/tutorial/program_structure/
2. https://docs.microsoft.com/en-us/cpp/preprocessor/hash-include-directive-c-cpp?view=msvc-160
3. https://docs.microsoft.com/en-us/cpp/cpp/address-of-operator-amp?view=msvc-160
4. https://docs.microsoft.com/en-us/cpp/preprocessor/preprocessor
-->
## Basic Structure

In case you don't want to dig deeper how it works, you can just getting started in hard way by remembering the following structure:

```cpp
#include <cstdio>
#include <iostream>

int main() {
  // do something...
  return 0;
}
```

??? note "What is `#include`?"
    `#include` is a preprocessor directive. It tells the preprocessor to include the contents of a specified file at the point where the directive appears, which means, for example, when compiling the compiler will copy the header file `iostream` to the directive  `#include <iostream>`. By doing so you will be able to use objects provided by `iostream` like `std::cin`, `std::cout` and `std::endl`.
    
    If you are familiar with C, you may notice that headers we come across so far in C++ don't have `.h` suffix. Header files in C `balabala.c` have transformed to `cbalabala`, i.e., `stdio.h` to `cstdio`. This is because of C++'s forward compatibility to C, it uses all headers in C. To distinguish headers of C++ and C, a prefix `c` is introduced.

    Generally speaking, you should determine which header you need to `#include` based on your program. However, adding more headers will only increase compiling time and has barely no impact to performance. So far we have only come across `iostream` and `cstdio` the two headers. `#include<iostream>` will be not needed if you only use `scanf` and `printf`.
    
    Is it possible to `#include` self-defined headers? The answer is yes.
    
    You can write a your own header, for example, `myheader.h`. Then, place it to the folder where your code located. Finally `#include "myheader.h"`. Be cautious that custom headers should use quotation mark `""` instead of angle bracket `<>`. Of course, you can also use compiling parameters `-I <header_file_path>` to tell compiler where to find headers. This will save you from placing headers to the same directory of code.

??? note "What is `main()`?"
    When a program runs, it will run codes in `main()` first.
    
    Actually, `main` function is called by system or external programs. E.g., running your program in your terminal is equal to calling `main` funtion in your program. (Before which it first finishes construction of [global variables](./var.md).)

    The `return 0;` in the end indicates that program has successful ran and exit. By default, a return value of 0 represents all-green, otherwise it represents error codes. (For Windows it can be referred by [Windows Error Codes](https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-erref/).) You may wonder who does the value return to? It returns to operating system or external programs calling the program you wrote, which will receive the value when your program exits. Even if you choose not to write `return` statement it will return 0 when the program normally exits.
    
    In competitive programming,; for C and C++, a non-zero return value will end up with a runtime error (RE).

## Comments

In C++ code, there are two types of comments:

1.  Single-line comments

    A single-line comment starts with `//`. Anything after it in the line are comments.

2.  Multi-line comments

    A multi-line comment begins with `/*` and ends with `*/`, Anything between which are considered to be comments. 

Comments have no affect on the operation of program. It can be used to explain programs, and make a certain block of code not to be compiled without being deleted from source file. 

在工程开发中，注释可以便于日后维护、他人阅读。

Few people write many comments in competitive programming. However, comments can be useful for clarifying ideas when writing codes, or for reviewing later. Additionally, an appropriate amount of comments is useful for readers to read and comprehend the purpose of code.

## Input and Output

### `cin` and `cout`

```cpp
#include <iostream>

int main() {
  int x, y;                          // Declare Variable
  std::cin >> x >> y;                // Read x and y.
  std::cout << y << std::endl << x;  // 输出 y，换行，再输出 x
  return 0;                          // 结束主函数
}
```

???+note "What is `variables`"
    Please refer to main article: [Variables](./var.md)

???+note "What is `std`" 
    Main article: [Namespace](./namespace.md)
    `std` is a namespace used by C++ standard library. The purpose of using namespaces in programming is to avoid name collisions.

### `scanf` and `printf`

`scanf` and `printf` is functions provided by C. In most cases they are faster than `cin` and `cout`, and can easily control the format of input and output.

```cpp
#include <cstdio>

int main() {
  int x, y;
  scanf("%d%d", &x, &y);   // Read x and y.
  printf("%d\n%d", y, x);  // 输出 y，换行，再输出 x
  return 0;
}
```

In which, a `%d` indicates that the inputting/outputting variable is a signed integer(`int`) type variable.

Similarly:

1. `%s` represents a string `char[]`;
2. `%c` represents a character;
3. `%lf` represents a double‑precision floating‑point (`double`);
4. `%lld` (or `%I64d` in certain operating system) represents a long integer (`long long`);
5. `%u` represents an unsigned integer (`unsigned int`);
6. `%llu` (or `%I64u` in certain operating system) represents a long unsigned integer (`unsigned long long`).

Besides format string specifications, there are other ways to control the format, which are not frequently used. Here take two commonly used ways listed below as example: 

1. `%1d` represents an integer whose length is 1. While inputting, it can read numbers digit by digit even there is no spaces; When outputting, if the specified length is longer than the number of digits, it will be filled with spaces before the number; Otherwise nothing will happen.
2. `.6lf`, which represents retaining six decimal digits when outputting.

Both format string specifications mentioned above can be filled with other numbers in the corresponding places, for example, `%.3lf` means that three decimal places are reserved.

??? note "What is double‑precision floating‑point? And what is long integer?"
    Both of them represents different types of variables. For more please refer to main article: [Variables](./var.md).

??? note "Why there is a `&` operator in `scanf`?"
    Here `&` is an address-of operator, returning the variable's address in memory which is the parameter received by scanf. For more detail please refer to main article [Pointers](./pointer.md).

??? note "What is `\n`" 
    `\n` is one of **escape characters**, indicating that there is a line break.
    
    Escape characters represents characters that cannot by typed directly, such as, newlines as string literal cannot break new line directly, or quotes as they have special meanings, or backslashes as they are used to present escape characters.  
    
    Here lists some frequently used escape characters:
    
    1. `\t` represents a tab;
    
    2. `\\` represents `\`;
    
    3. `\"` represents `"`;
    
    4. `\0` represents empty characters, which are used as the ending of C-style string;
    
    5. `\r` represents newline. For linux it is `\n`, and for Windows it is `\r\n`. In competitive programming, for a newline you can just use `\n`. However, be cautious that some issues may occur because of newline characters if read character by character. For example, `gets()` takes `\n` as the ending of a string, and if the newline character if `\r\n`, the `\r` will be retained at the end of string.
    
    6. Specially, in and only in `printf` and `scanf`, `%%` represents `%`. For other literals you may just simply use `%`.
    
    ??? note "What are *literals*?"
        A literal is a notation for representing a fixed value in source code. For example, `3` is a literal of `int`, `'c'` is a literal of `char`. `"hello world"` from previous code is also a string literal.

        A literal without explanations and reasons are also called a *magic number*, which is strongly discouraged if the code is needed to be read by others. 

## Advanced Readings

### Whitespace Characters

In C++, all the whitespace characters, including space, tab and newline, multi or single, are all treaded as same the by the compiler. (Not including characters as a part of a string.)

Because of which, you are able to use any code style freely, as long as  in-line comments, string literals and preprocessing directives are on a single line. E.g.,

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

Of course, doing so is not recommended.

一种也被广泛使用但与 **OI Wiki** 要求的码风不同的代码风格：

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

### `#define` Preprocessor

`#define` is a preprocessor directive using to create a macro, or essentially, text replacement. For example:

```cpp
#include <iostream>
#define n 233
// n is not a variable. However, the compiler will replace all `n` appearing as an identifier with the token `233`,
// which is, the `n` will not be replaced if it is appeared as a part of longer identifier, e.g., `n` in `fn`.
// Similarly, identifier appears in a string will not be replaced either.

int main() {
  std::cout << n;  // Print "233" to terminal.
  return 0;
}
```

??? note "What is an identifier?"
    Identifier is a group of characters which can be used as the name of a variable. For example, `abcd` and `abc1` are legal identifiers in C/C++, while `1a` and `c+b` are illegal.
    
    In C/C++, an identifier can only start with english characters and undersocre, and consist of english characters, underscore and numbers. It is noteworthy that keywords like `int`, `for` and `if` cannot be used as an identifier.

??? note "What is preprocessor directives?"
    Preprocessor directives are directives accepted by preprocessor. It is used to perform early-stage text manipulation of code. For example, the previous file includes operations `#include` and `#define`. By defaults GCC doesn't keep the output `.i` file of preprocessing stage, and it can be kept by adding `-E` parameter.

A macro can be along with arguments. Macro with arguments can be used like a function:

```cpp
#include <iostream>
#define sum(x, y) ((x) + (y))
#define square(x) ((x) * (x))

int main() {
  std::cout << sum(1, 2) << ' ' << 2 * sum(3, 5) << std::endl;  // Expected output: 3 16
}
```

However, there are differences between a macro with arguments and a function. It may cause some issues as macros are literally text replacing. E.g.:

```cpp
#include <iostream>
#define sum(x, y) x + y
// Which should be: #define sum(x, y) ((x) + (y))
#define square(x) ((x) * (x))

int main() {
  std::cout << sum(1, 2) << ' ' << 2 * sum(3, 5) << std::endl;
  // 输出为 3 11，因为 #define 是文本替换，后面的语句被替换为了 2 * 3 + 5
  int i = 1;
  std::cout << square(++i) << ' ' << i;
  // The output is undefined because `++i` were performed twice,
  // as multiple modifying a same variable in a same statement is an undefined behaviour. (With exceptions.)
}
```

Using `#define` is so risky that it should be used cautiously, as `#define`'s scope is the whole program, which may lead to accidental text replacement, and needs to be canceled by using `#undef` in time. A recommended practice is that using `const` to declare a constant and using functions instead of macros.

However, in competitive programming, `#define` still has its use. Note that the following two example is not recommended because it will reduce the specification <!---?--> of the code:

1. `#define int long long`+`signed main()`: This is usually used to avoid issues caused by forgetting to use `long long`. Note that this may lead to TLE as the increasing pressure of bottom layer,<!---!!!--> or MLE as it increases memory used.
2. `#define For(i, l, r) for (int i = (l); i <= (r); ++i)`, `#define pb push_back`, `#define mid ((l + r) / 2)`: This is usually used to shorten the code.

Nevertheless, `#define` has its pros, especially, for example, with the `#if` preprocessor declaratives, it works with unexpectedly awesome effect. E.g.,

```cpp
#ifdef LINUX
// code for linux
#else
// code for other OS
#endif
```

In the example, we use the compiler parameter `-DLINUX` to control the code compiled without modifying the source. Another advantage is that the output executable file compiled with `-DLINUX` doesn't contain codes of systems other than linux, as they are deleted in the preprocessing stage. 

`#define` can also work with the `#`, `##` operators, which greatly simplifies debugging.
