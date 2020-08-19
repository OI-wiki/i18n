disqus:

## Environment configuration

"The expectations of life depend upon diligence; the mechanic that would perfect his work must first sharpen his tools." - Confucius

### Integrated development environment

The use of IDE's is relatively easy, which is one of the reasons why beginners usually choose it to write code. The most common one in OI is [Dev-C++](./editor/devcpp.md) (if the contest environment is the Windows system, this IDE is also provided).

### Compilers

#### Windows

The GNU compiler is recommended. You need to go to [MinGW Distro](https://nuwen.net/mingw.html) to download and install MinGW. You can also choose [Microsoft Visual C++ Compiler](https://docs.microsoft.com/en-us/cpp/build/projects-and-build-systems-cpp) under Windows, which requires you to download and install under [Visual Studio page](https://visualstudio.microsoft.com/downloads/).

#### macOS

Execute in the terminal:

```bash
xcode-select --install
```

#### Linux

Use `g++ -v` to check if `g++` is installed.

Use the following command to install:

```bash
sudo apt update && sudo apt install g++
```

#### Compile the code using command line

After a while, some players could use a more flexible command line to compile the code, so that they do not need to rely on the IDE. Instead, they can choose whichever the text editor they are familiar with to write the code.

```bash
g++ test.cpp -o test -lm
```

 `g++` is the C++ compiler (the C compiler is `gcc`). `-o` is used to specify the file name of the executable file, and the compiler option `-lm` is used to link the math library `libm`, so that the code using `math.h` can be compiled and run normally.

Note: C++ programs can compile and run normally without `-lm`. The C++ compilation options of NOI/NOIP contest problems over the years all contains `-lm`, so it is also used here.

## First code

Let's start the C++ journey with a sample program:

C++ language

```c++
#include <iostream>  // reference header file

using namespace std;
// introduce a namespace (related material: https://oi-wiki.org/lang/namespace/#using)

int main() {                // define main function
  cout << "Hello, world!";  // output Hello, world!
  return 0;                 // return 0, end main function
}
```

C language

```c
#include <stdio.h>          // reference header file

int main() {                // define main function
  printf("Hello, world!");  // output Hello, world!
  return 0;                // return 0, end main function
}
```

Note: The C language here is for reference only (it is basically outdated). C++ is fully compatible with the C language and has many new features that will allow players to achieve more with less. For details, please see [difference between C and C++](/lang/c-cpp/).
