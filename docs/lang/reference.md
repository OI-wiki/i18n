Reference can be seen as a pointer encapsulated by C++ to pass the object it points to. In fact, in C++, you often deal with references that don't show explicitly. The basic principle of reference is that the object must be pointed to when it is declared, and all operations of the reference are equivalent to those of the original object. In addition, references are not objects, so there are no referenced arrays, pointers, or references.

> Although the reference is not an object, it can be objectified through [`reference_wrapper`](https://en.cppreference.com/w/cpp/utility/functional/reference_wrapper) to achieve similar effect indirectly.

There are two main types of references: lvalue reference and rvalue reference. In addition, there are two special cases: forward reference and dangling reference, but we wouldn't get into details here. In addition, this article also introduces a part of the constant values, please refer to [constant value](./const.md) for more details.

## lvalue reference

??? note "lvalue and rvalue"
    In the assignment expression `X = Y`, we say that X is a lvalue, which is used in the **address** in memory and can be known at compile time; While Y is a rvalue that is used for its **content** (value) and can only be known at runtime. After C++11, the concept of value is further classified into glvalue, prvalue and xvalue. For details, please refer to [cppreference - value category](https://en.cppreference.com/w/cpp/language/value_category). It is worth mentioning that, although rvalue references were only supported after C++11, its concept was defined earlier。

??? note "lvalue expression"
    If an expression returns a lvalue (that is, modification is allowed), it is called the lvalue expression. The rvalue expression works the same way.

Usually the reference we see is the lvalue reference, which is usually used to be assigned, accessed, or point to the rvalue. Its name comes from the fact that it is usually placed on the left side of the equal sign. The lvalue needs to **have entity in memory**, and cannot point to a temporary variable. The following is a sample code from [reference manual](https://en.cppreference.com/w/cpp/language/reference).

```cpp
#include <iostream>
#include <string>

int main() {
  std::string s = "Ex";
  std::string& r1 = s;
  const std::string& r2 = s;

  r1 += "ample";  // modify r1, that is, modify s
  //  r2 += "!";               // error: cannot be modified by reference of const
  std::cout << r2 << '\n';  // print r2, visit s, and output "Example"
}
```

The most common case for lvalue reference is the function parameters. Passing parameters through lvalue references can have the same effect as passing parameters through pointers.

```cpp
#include <iostream>
#include <string>

// the s in the parameter is a reference. no copy will occur when the function is called
char& char_number(std::string& s, std::size_t n) {
  s += s;          // 's' and 'str' in main() are the same object
                   // it also means that the lvalue can be placed on the right side of the equal sign
  return s.at(n);  // string::at() return reference of char
}

int main() {
  std::string str = "Test";
  char_number(str, 1) = 'a';  // function returns a lvalue, which can be assigned
  std::cout << str << '\n';   // output "TastTest" here
}
```

## rvalue references (C++ 11)

The rvalue reference is a reference used to point the values assigned to other variables to the rvalue, and its name comes from the fact that it is usually placed on the right side of the assignment operator. The rvalue **can be in the memory or in the CPU register**. In addition, rvalue references can be viewed as a way to **extend the lifetime of temporary objects**.

```cpp
#include <iostream>
#include <string>

int main() {
  std::string s1 = "Test";
  //  std::string&& r1 = s1;           // error: cannot bind to lvalue

  const std::string& r2 = s1 + s1;  // ok: lvalue reference of constant types extends the lifetime cycle
  //  r2 += "Test";                    // error: cannot modify by reference of constant value

  std::string&& r3 = s1 + s1;  // ok: rvalue reference extends the lifetime cycle
  r3 += "Test";  // ok: can be modified by rvalue reference of non-constant values
  std::cout << r3 << '\n';
}
```

In the above code, `r3` is a rvalue reference, which refers to the rvalue `s1 + s1`. `r2` is a lvalue reference. It can be found that **rvalue reference can be converted to lvalue reference modified with const**.

## Some examples

###  `++i` and `i++` 

 `++i` and `i++` are typical lvalues and rvalues. The implementation of `++i` is to directly add one to the i variable, and then return i itself. Because i is a variable in memory, it can be a lvalue. In fact, the signature of the previous auto-increment function is `T& T::operator++();`. But `i++` is different. Its implementation is to store i in a temporary variable, and then add one to i. The variable returned is temporary, so it is a rvalue. The signature of the post-increment function is `T T::operator++(int);`.

```cpp
int n1 = 1;
int n2 = ++n1;
int n3 = ++++n1;  // lvalue, can continue to operate
int n4 = n1++;
//  int n5 = n1++ ++;   // error, cannot operate right value
//  int n6 = n1 + ++n1; // undefined behaviour
int&& n7 = n1++;  // use rvalue references to extend life cycle
int n8 = n7++;    // n8 = 1
```

### Move semantics and `std::move` (C++11)

After C++11, C++ uses rvalue references to offer support for move semantics to avoid copying objects in the heap space (but stack space copying is unavoidable). The STL container has full support for this feature and the specific features are [move constructor](https://en.cppreference.com/w/cpp/language/move_constructor), [move assignment](https://en.cppreference.com/w/cpp/language/move_assignment ), and functions with moving capabilities (with rvalue references in the parameters).

In addition, the `std::move` function can be used to generate rvalue references, and the `<utility>` header file must be included.

```cpp
// move constructor
std::vector<int> v{1, 2, 3, 4, 5};
std::vector<int> v2(std::move(v));  // move v to v2, no copy operations
assert(v.empty());

// move assignment function
std::vector<int> v3;
v3 = std::move(v2);
assert(v2.empty());

// function with ability to move
std::string s = "def";
std::vector<std::string> numbers;
numbers.push_back(std::move(s));
```

Note that the above code is only available after C++11.

### Function return reference

Let the function return a reference value to avoid copying the return value when returning the function. For example:

```cpp
char &get_val(std::string &str, int index) { return str[index]; }
```

You cannot return a reference to a local variable in a function. If it must be a variable within the function, please use dynamic memory. For example, the following two functions will produce [dangling references](https://stackoverflow.com/questions/17997228/what-is-a-dangling-pointer) and result in undefined behavior.

```cpp
std::vector<int>& getLVector() {  // error: return the lvalue reference of local variable
  std::vector<int> x{1};
  return x;
}
std::vector<int>&& getRVector() {  // error: return rvalue reference of local variable
  std::vector<int> x{1};
  return std::move(x);
}
```

When the space pointed to by the rvalue has been allocated before entering the function, the rvalue reference can avoid the return value copy.

```cpp
struct Beta {
  Beta_ab ab;
  Beta_ab const& getAB() const& { return ab; }
  Beta_ab&& getAB() && { return std::move(ab); }
};

Beta_ab ab = Beta().getAB();  // here is the move semantics, not copy
```

## References

1.  [C++ documentation - Reference declaration](https://en.cppreference.com/w/cpp/language/reference) 
2.  [C++ documentation - value category](https://en.cppreference.com/w/cpp/language/value_category) 
3.  [Is returning by rvalue reference more efficient?](https://stackoverflow.com/questions/1116641/is-returning-by-rvalue-reference-more-efficient) 
