This article introduces differences between C and C++ that are important or might be easily overlooked. Although C++ is almost a superset of C, there is generally no problem with mixing C/C++ code. But understanding the important difference between C/C++ can help avoid certain strange bugs. If you are an OIer using C as the primary language, this article will also let you get started with C++ more smoothly. The uniqueness of C++ compared to C can be read in the tutorial in the [C++ Advanced](./class.md).

## Macros and templates

One purpose of C++ templates at the beginning of the design is to replace macro definitions. Learning template programming is an important step from C to C++. Template is different from the text replacement of the macro. It will get a more comprehensive compiler check when compiling, thus making it easier to write more robust code. Using the inline keyword can also get the compiler's full optimization. The template feature also supports variable-length template parameter table after C++11, which can be used to replace variable-length functions in C and ensure type safety.

## Pointers and references

In C++, you can still use C-style pointers, but for variable passing, it is recommended to use [reference](./reference.md) feature in C++ to achieve similar effects. Since the object pointed to by the reference cannot be null, some null address access problems can be avoided. However, pointers still have their uses due to their flexibility. It is worth mentioning that the `NULL` in C has a type-safe alternative to `nullptr` since C++11. Reference and pointer can be converted mutually through [`*` and `&` operators](./op.md).

## struct

Although both C and C++ have the concept of struct, what they correspond to cannot be mixed! The struct in C is used to describe a fixed memory organization structure, while the struct in C++ is a kind of class. The only difference between struct in C++ and a class is that its members and inheritance behavior are public by default, while the default of general class is private. This is especially fatal when writing C/C++ mixed code.

In addition, C++ does not need to be as complicated as C when declaring struct. 

C version:

```c
typedef struct Node_t{
    struct Node_t *next;
    int key;
} Node;
```

C++ version:

```cpp
struct Node {
  Node *next;
  int key;
};
```

## const

In C, const only has the function of limiting variables that cannot be modified. In C++, due to the emergence of a large number of new features, const has also been given more usage. The successor of C const in C++ is constexpr. For the usage of const in C++, please refer to the description on the [constant value](./const.md).

## Memory allocation

The keywords `new` and `delete` have been added to C++ to allocate space on the "free storage area", which can either be a heap or a static area to match the "class". Among them, `delete[]` can also directly release the memory of the dynamic array, which is very convenient. The `new` and `delete` keywords will call the type's constructor and destructor. Compared with the C's `malloc()`, `realloc()`, and `free()` functions, they have a more complete type support, but not as efficient as these functions in C.

In short, if the object you need to dynamically allocate memory to is basic type or their array, then you can use `malloc()` for more efficient memory allocation; but if your newly created objects are non-basic types, then it is recommended to use `new` to have a security check. It is worth noting that although both `new` and `malloc()` return pointers, the pointers from `new` can only be recycled with `delete`, while the pointers from `malloc()` can only use `free()` to recycle. Otherwise there might be a risk of memory leaks.
