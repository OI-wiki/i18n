## Data types<span id="variable-type"></span>

The C++ language provides six built-in basic data types:

| Type   | Keyword    |
| ---- | ------ |
| Boolean  | bool   |
| Character  | char   |
| Integer   | int    |
| Single-precision Floating-point Type  | float  |
| Double-precision Floating-point Type | double |
| No Type  | void   |

### Boolean<span id="bool"></span>

A variable of `bool` type can be either `true` or `false`

Generally, a variable of `bool` only occupies one byte of memory space (and normally $1$ byte = $8$ bits).

### Character<span id="char"></span>

A variable of `char` type is used to store characters, which is actually integers and corresponds by [ASCII Encoding](http://www.asciitable.com/). The number of bits in `char` is typically $8$.

Typically the range of `char` is between $-128 \sim 127$.

### Integer<span id="int"></span>

A variable of `int` type is used to store integers.

???+note "The size of `int`"
    The C++ Standard specifies that a variable of `int` is at least $16$ bits long.
    
    However, in fact, for most platforms nowadays an `int` variable is mostly $32$ bits in length.

The `int` keyword can be characterized by the following type qualifier keywords:

Signedness:

- `signed`: Indicates that the variable is a signed integer, which is applied by default.
- `unsigned`: Indicates that the variable is an unsigned integer.
  
Length:

- `short`: Indicates that the variable is **at least** $16$ bits long.
- `long`: Indicates that the variable is **at least** $32$ bits long.
- `long long`: Indicates that the variable is **at least** $64$ bits long.

The table below displays that, **in general situations**, the size of bit widths and range of values of each integer types. Notice that minor platforms may have different range of values.

| Type Name                      | Bit Width   | Range of Values                   |
| ------------------------ | ---- | ---------------------- |
| `short int`              | $16$ | $-2^{15}\sim 2^{15}-1$ |
| `unsigned short int`     | $16$ | $0 \sim 2^{16}-1$      |
| `int`                    | $32$ | $-2^{31}\sim 2^{31}-1$ |
| `unsigned int`           | $32$ | $0 \sim 2^{32}-1$      |
| `long int`               | $32$ | $-2^{31}\sim 2^{31}-1$ |
| `unsigned long int`      | $32$ | $0 \sim 2^{32}-1$      |
| `long long int`          | $64$ | $-2^{63}\sim 2^{63}-1$ |
| `unsigned long long int` | $64$ | $0 \sim 2^{64}-1$      |

???+note "Equivalent Type Description"
    Without raising ambiguity, it is allowed to omit some qualifier keywords, or adjust their order, which means that one type may have multiple equivalent expressions.
    
    For example, `int`, `signed`, `int signed`, `signed int` represent a same data type, and `unsigned long` and `unsigned long int` represent another same data type.

### Single-precision Floating-point<span id="float"></span>

A variable of `float` type indicates that this is a single-precision floating-point data, which is normally $32$ bits long.

The range of value is between $-3.4\times 10^{38} \sim 3.4\times 10^{38}$ .

As `float` type has a small range of value and low precision, it is more often to use the double-precision type `double` to represent a floating-point number in practice.

### Double-precision Floating-point<span id="double"></span>

A variable of `double` type indicates that this is a double-precision floating-point data, which is normally $64$ bits long.

The range of value is between $-1.7\times 10^{308} \sim 1.7\times 10^{308}$ .

### No type/Void<span id="void"></span>

An object of `void` type indicates that this object has no type. Different from the previous types, is is not allowed to declare a variable as `void` type. But the return value of a function is allowed to be `void`, indicating the function has no returning value.

## Variables Conversion<span id="variable-conversion"><span>

In some cases, for example, a function accept arguments of `int` type, but a variable of `double` were passed, we need to convert one type to another.

Data conversion of C++ is complicated. Here we mainly introduce two kinds of conversion for basic data type: numeric promotions and numeric conversion.

### Numeric promotions

The value won't change during numeric promotions.

- When a variable of `char` is performing arithmetic operations with `short`, it will be automatically promoted to `int`. Similarly, a `unsigned short` variable will be promoted to `unsigned int` when doing so.
- An integral variable with smaller bit width can be promoted to the one with larger bit width if necessary. For example, passing a variable of `int` to a function which accepting arguments of `long long`. Note that the signedness should remain unchanged, otherwise a numeric conversion will happen. It is common that a variable with smaller bit width will be converted to the one with larger bit width when performing arithmetic operations between them. 
- Floating-point number with smaller bit width can be converted to the one with larger bit width without changing the value. For example, when performing arithmetic operation between variables of `float` and `double`, the `float` one will be promoted to `double`.
- A variable of `bool` can be promoted to an integer. `false` will be converted to $0$ while `true`'s is $1$.

### Numeric conversions

The value may change during numeric conversions.

- If target data type is unsigned integer with bit width of $x$, the result of conversion can be recognized as the result of $\text{Origin Value} \bmod 2^x$ . For example, when converting a `short` type integer $-1$ (or $1111\ 1111\ 1111\ 1111$ in binary) to `unsigned int`, the result will be `65535` (or $0000\ 0000\ 0000\ 0000\ 1111\ 1111\ 1111\ 1111$ in binary).
- If target data type is signed integer with bit width of $x$, then **in normal cases**,the result of conversion can be recognized as the result of $\text{Origin Value} \bmod 2^x$ .[^note1] For example, when converting an `unsigned int` data $4\ 294\ 967\ 295$ （or $1111\ 1111\ 1111\ 1111\ 1111\ 1111\ 1111\ 1111$ in binary to `short`, the result will be $-1$ (or $1111\ 1111\ 1111\ 1111$ in binary).
- When converting a floating point with larger bit width to the one with smaller bit width, the number will be rounded to the closest value under the target type.
- When converting a floating-point number to an integer, the entire fractional part of the floating-point number will be discarded.
- When converting an integer to a floating point number, it will be rounded to the closest value under the target type.
- When converting other types to `bool`, data with value of zero will be converted to `false`, and non-zero data will be `true`.

## Declaring Variables

Briefly talking[^note2], declaring a variable need contain type specifier and identifier as the name of the variable.

For example, the following statements are all variable definition statements.

```c++
int oi;
double wiki;
char org = 'c';
```

In the codes we have met so far, all variables declared in curly brackets are local variables, and those which weren't are global variables. In fact, there are exceptions, but for now you are not required to get familiar with.

Global variables that are not initialized when declaring will be initialized to 0, while local variables don't have this feature and need to be manually assign a initial value. Otherwise it may occur bugs that are difficult to find.

## Scopes

A scope is a part of a program where a variable is valid and works.

The scope of a global variable is from where its definition[^note3] to the end of file.

The scope of a local variable is from where its definition to the end of the block.

A block of code consists of several statements enclosed by a pair of curly brackets.

```c++
int g = 20;  // Declare a global variable;
int main() {
  int g = 10;         // Declare a local variable;
  printf("%d\n", g);  // Print `g`
  return 0;
}
```

If a variable inside an inner block of a bigger block is declared with the same name, then it will be unavailable for inner block to access variables in outer block with same name.

For example, in previous code block, the $g$ to be printed will be $10$. So, please try to avoid name conflict between local variables and global variables in order to avoid unexpected errors.

## Constants

A constant is a fixed value. It cannot be modified during the execution of program

The value of a constant cannot be modified after declaration. To declare a constant, add the keyword `const` as the type qualifier.

```c++
const int a = 2;
a = 3;
```

The compiler will throw an error during compiling if a constant is modified: `error: assignment of read-only variable ‘a’`.

## References and Footnotes

[^note1]: Since C++20. Until C++20 he result is implementation-defined. For more information please refer to [Integral conversions - cppreference](https://en.cppreference.com/w/cpp/language/implicit_conversion#Integral_conversions).

[^note2]: When declaring a variable, it is allowed to contain other qualifier other than type identifier<!---看不懂-->. For more information please refer to [Declarations - cppreference](https://en.cppreference.com/w/cpp/language/declarations).

[^note3]: Or more accurate, [point of declaration](https://en.cppreference.com/w/cpp/language/scope#Point_of_declaration).

## Translation Information

- Original Article: https://oi-wiki.org/lang/var/
- Last Translated commit: https://github.com/OI-wiki/OI-wiki/pull/3566/commits/c0b8844d80af280c579c58f4928b2e2f624057c8
- Translator: CamberLoid