author: Ir1d, cjsoft, Lans1ot

[Struct](https://en.cppreference.com/w/c/language/struct) can be regarded as a combination of series of member elements.

It can be regarded as a custom data type.

*The `struct` described on this page is different from the `struct` in C. In C++, the definition of `struct` has expanded to a class specifier like [`class`](./class.md)*.

## Define struct

```cpp
struct Object {
  int weight;
  int value;
} e[array_length];

const Object a;
Object b, B[array_length], tmp;
Object *c;
```

In the above example, a structure named `Object` is defined. It has two member elements `value, weight` with `int` types.

After `}`, a constant `a` with a type of `Object`, a variable `b`, a variable `tmp`, an array `B`, and a pointer `c` are defined. For an existing type, you can use the methods here to define constants, variables, pointers, arrays, etc.

*Note: it is NOT mandatory to master pointers.*

### Define pointers

If it's a pointer that defines a built-in type, it is the same as the usual definition of a pointer.

If it's to define a structure pointer, using `StructName*` in the definition is required.

```cpp
struct Edge {
  /*
  ...
  */
  Edge* nxt;
};
```

The above code is for example only, there's no need to worry about the actual meaning.

## Access/modify member elements

You can use `variable_name.member_element_name` for access (the double quotes are not written into the program, the same applies below).

For example: output member `v` of `var`: `cout << var.v`.

You can also use `pointer_name->member_element_name` or use `(*pointer_name).member_element_name` for access.

For example: assign the member element `v` of the struct pointed to by the struct pointer `ptr` to `tmp`: `(*ptr).v = tmp` or `ptr->v = tmp`.

## Why do we need struct?

First of all, it is NOT mandatory. *All roads lead to Rome*, and same effect can be achieved without using structs. But struct can explicitly bind the member elements (usually variables in OIs) together. For example, the `Object` struct above puts the `value, weight` together (The actual meaning of defining this struct is to represent the weight and value of an item). The advantage of this is that it limits the use of member elements.
Imagine if you don't use a struct and there are two arrays `value[],Value[]`, it is easy to cause confusion. But if you do, you can reduce the chance of using variables incorrectly.

And different structs (struct types, such as the `Object` structure) or different struct variables (instances of the struct, such as the `e` array above) can have member elements with the same name (such as `tmp. value,b.value`), and the member elements with the same name are independent of each other. This means they have seperate memory. For example, modifying `tmp.value` will not affect the value of `b.value`.

The advantage of this is that we can use the same or similar variables as mcuh as possible to describe an item. For example, there is a member variable of `value` in `Object`; we can also define a `Car` struct, which also has a member of `value`; But if we do not use a struct, the definition of `valueOfObject[], valueOfCar[]` and other arrays with different names may be required.

*If you want to describe an item in more details, you can also use a member function. Please refer to [Class](./class.md) for details.*

## More operations?

For more details, please refer to [class](./class.md). 

## References

1.  [cppreference class](https://en.cppreference.com/w/cpp/language/class) 
2.  [cplusplus Data structures](http://www.cplusplus.com/doc/tutorial/structures/) 
