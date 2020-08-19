C++ defines a complete set of methods for defining read-only variables. Objects or types modified by the constant modifier `const` are all read-only. The memory storage of read-only variables is of no difference from general variables defining, but the compiler will check for conflicts to avoid modification of read-only variables during the compilation phase. Therefore, reasonable use of the `const` modifier can increase code robustness.

## Regular type

Adding a const modification before the name of a type will mark the variable of that type as immutable. There are two types of specific usage: constant and constant reference (pointer).

### Constant

The constant here is a constant variable, which refers to a variable of const type (instead of read-only variable we generally refer to in the title). The constant-typed variables cannot be reassigned after declaration, nor can it access its mutable members, only its constant members. See the text below for the definition of constant members.

??? note "Type qualifier"
    There are three types of type qualifiers in C++: constant (const), mutable (mutable) and volatile (volatile). By default, they are mutable variables. The declaration of mutable variables is to avoid compiler optimization.

```cpp
const int a = 0;  // Type of a is const int

// a = 1; // Error, constants cannot be modified
```

### Constant reference, constant pointer

Constant references and constant pointers are also similar to constants, but the difference is that they restrict access without changing the type of the original variable.

```cpp
int a = 0;
const int b = 0;

int *p1 = &a;
*p1 = 1;
const int *p2 = &a;
// *p2 = 2; // Error, the variable cannot be modified through the constant pointer
// int *p3 = &b; // Error, can't use ordinary pointer to point to const variable
const int *p4 = &b;

int &r1 = a;
r1 = 1;
const int &r2 = a;
// r2 = 2; // 
// int &p3 = b; // Error, can't use ordinary reference to point to const variable
const int &r4 = b;
```

Also, we need to distinguish between "constant pointer" and "constant pointer variable" (i.e. constant pointer, pointer constant). For example, for the following statement:

```cpp
int* const p1;        // Constant pointer of type int, needs to be initialized
const int* p2;        // Pointer of type const int
const int* const p3;  // Constant pointer of type const int

int (*f1)(int);  // Ordinary function pointer
// int (const *f2)(int); // Pointer to constant function, cannot work
int (*const f3)(int) = some_func;  // Constant pointer to function, need to be initialized
int const* (*f4)(int);             // Pointer to function that returns constant pointer
int const* (*const f5)(int) = some_func;  // Constant pointer to a function that returns a constant pointer
```

We call constant type pointers **low-level pointers** and constant pointer variables **top-level pointers**.

In addition, C++ also provides the `const_cast` operator to forcibly remove or increase the const restriction of reference or pointer types. Please do not use this keyword when it is not the last solution.

### Constant parameter

Limiting parameters to constant types in function parameters can avoid accidental type modification of parameters. This method is usually used to reference parameters. In addition, adding const modifiers to type parameters can also increase code readability and distinguish between input and output parameters.

```cpp
void sum(const std::vector<int> &data, int &total) {
  for (auto iter = data.begin(); iter != data.end(); ++iter)
    total += *iter;  // iter is a const iterator, the type after dereference is const int
}
```

## Regular members

Constant members refer to the members of the type that are modified by const. Constant members can be used to restrict the modification of constant objects. Among them, the constant member variable is the same as the constant declaration, and the declaration method of constant member function is to add the const modifier at the end of the member function declaration (to the right side of the closing parenthese of the parameter list).

```cpp
// Examples of constant members
struct X {
  X();
  const int* p;  // Constant members of type int*
  int* const q;  // Mutable member of type const int*

  const int r() const;
  // The first const modifies the return value, and the last const modifies the member function.
};

X a;
*(a.p)++;  // OK
// *(a.q)++; // Error, cannot modify const int type variable

// Examples of constant member functions
const std::vector<int> c{1, 2};
// c.push_back(3); // Error, variable members of constants cannot be accessed
// vector::push_back() Not a constant member
int s = c.size();  // vector::size() is a constant, can be accessed
```

## Constant expression constexpr（C++11）

The function of the constexpr specifier is to declare that the value of a function or variable can be obtained at compile time. Its behavior is consistent with the const keyword in the C language, and the variable result is directly compiled into the stack space. constexpr can also be used to replace constants defined by macros to avoid the [risk of macro definitions](./basic.md#define). constexpr modifies variables and functions, while const modifies types.

> Actually we can think const as **"readonly"**, and constexpr as **"const"**. This is more intuitive.

```cpp
constexpr int a = 10;  // directly define constant variable

constexpr int FivePlus(int x) { return 5 + x; }

void test(const int x) {
  std::array<x> c1;            // Error, x is unknown at compile time
  std::array<FivePlus(6)> c2;  // OK, can be inferred during FivePlus compilation
}
```

## Reference

-  [C++ keyword - const](https://en.cppreference.com/w/cpp/keyword/const) 
-  [C++ keyword - constexpr](https://en.cppreference.com/w/cpp/keyword/constexpr) 
