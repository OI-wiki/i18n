author: Ir1d, cjsoft, Lans1ot

A struct can be considered as a combination of data called member elements, also can be considered as a customized data type.  

The `struct` described by this article is different from `struct` of C. For C++, `class` is extended to a class-specifier similar to [`class`](./class.md).

## Declaration of a Struct

```cpp
struct Object {
  int weight;
  int value;
} e[array_length];

const Object a;
Object b, B[array_length], tmp;
Object *c;
```

In the example, we declared a struct named `Object` with two member elements `value, weight` with type of `int`.

After `}`, we declared a constant `a`, two variables `b` and `tmp`, an array `B` and a pointer `c` with data type of `Object`. For some certain existed type, it is able to declare constants, variables, pointers and arrays using methods here.

*Knowledges about pointer are not required to be acquired.*

### Declaration of a Pointer

如果是定义内置类型的指针，则与平常定义指针一样。

如果是定义结构体指针，在定义中使用 `StructName*` 进行定义。

```cpp
struct Edge {
  /*
  ...
  */
  Edge* nxt;
};
```

上例仅作举例，不必纠结实际意义。

## Access and Modify Member Elements

One can access member elements by `name_of_variable.name_of_member`.

E.g., the following statement will print member `v` from `var`: `cout << var.v`.

One can also use `name_of_pointer->name_of_member` or `(*name_of_pointer).name_of_member` to access member elements.

E.g., the following statements will assign member element `v` of struct pointed by pointer `ptr` to `tmp`: `(*ptr).v = tmp` or `ptr->v = tmp`.

## Reasons to Use Struct

First, as the old saying, all roads lead to Rome. You can achieve same effect without using struct. But, a struct can explicitly bound member elements (or in competitive programming, variables) together. E.g., the struct `Object` from previous example put `value` and `weight` together. As advantage, it restrain from using member elements.  
Imagine that, if we use two array `value[]` and `Value[]` instead of using a struct, in such situation we are easily to get confused. But, if using struct, it can reduce the chance of variable using error.
<!---原文好啰嗦！-->
Another is that different instances of struct can own member elements with same name. E.g., `tmp.value` and `b.value`. These elements with same name have separate memory, e.g., modifying `tmp.value` won't affect the value of `b.value`.  
As an advantage, we can describe a concept with variables as identical or similar as possible. For example, `Object` contains a member variable `value`, and we can define another struct `car` with member `value`. If not using struct, we might need to define arrays with different names like `valueOfObject[]` and `valueOfCar[]` to distinguish them.

*You can also declare member function if you want to describe a thing in more detail. Please refer to [class](./class.md) for detailed information. *

## Want More Operations?

Please Refer to [class](./class.md)

## Cautions

To access memory more efficient, the compiler may align member elements to a certain bitwise location when processing the actual memory of members in a struct, which means there are empty spaces in struct. Because of that, the memory used by the struct may be larger than the sum of memory used by all members of struct.

## Reference

1. [Class - en.cppreference.com](https://en.cppreference.com/w/cpp/language/class)
2. [Data structures - cplusplus.com](http://www.cplusplus.com/doc/tutorial/structures/)
3. [Alignment | Microsoft Docs](https://docs.microsoft.com/en-us/cpp/cpp/alignment-cpp-declarations)
