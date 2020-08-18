author: Ir1d, cjsoft, Lans1ot

Structure(struct) can be regarded as a series of combinations called member elements.

It can be regarded as a custom data type.

*The `struct` described on this page is different from the `struct` in C. In C++, `struct` is expanded to a class specifier like [`class`](./class.md)*.

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

In the above example, a struct named `Object` with two member elements `value, weight` is defined. The type of both elements is `int`.

After `}`, a constant `a` with the data type of `Object`, a variable `b`, a variable `tmp`, an array `B`, and a pointer `c` are defined. For an existing type, you can use the method here to define constants, variables, pointers, arrays, etc.

*About pointers: it is not necessary to master this.*

### Define pointers

If it is a pointer that defines a built-in type, it is the same as the usual definition of a pointer.

If it is to define a structure pointer, `StructName*` is used to define it.

```cpp
struct Edge {
  /*
  ...
  */
  Edge* nxt;
};
```

The above example is for reference only. There is no need to spend too much time worrying about the actual meaning.

## Access/modify member elements

You can use `variable_name.member_element_name` for access (the double quotes are not written in program, same below).

For example: output the `v` member of `var`: `cout << var.v`.

You can also use `pointer_name -> member_element_name` or use `(*pointer_name).member_element_name` for access.

For example: Assign the member element `v` of the structure pointed by the structure pointer `ptr` to `tmp`: `(*ptr).v = tmp` or `ptr->v = tmp`.

## Why struct is needed?

First of all, "all roads lead to Rome", and the same effect can be achieved without using struct. But the struct can explicitly bind the member elements (usually variables in the OIs) together, such as the `Object` structure in this example, and put the `value, weight` together (The actual meaning of defining this struct is to indicate the weight and value of an item). The advantage is that it limits the use of member elements.

Imagine if you don't use a structure and there are two arrays `value[], Value[]`, it is easy to cause confusion. But if you use a struct, the chance of using variables incorrectly is reduced.
 
And different structures (struct types, such as `Object`) or different structure variables (instances of structures, such as the above `e` array) can have member elements with the same name (such as `tmp.value, b.value`). The member elements with the same name are independent of each other, and all have their own memory.For example, modifying `tmp.value` will not affect the value of `b.value`).

The advantage of this is that you can use the same or similar variables as much as possible to describe an item. For example, there is a member variable of `value` in `Object`; we can also define a `Car` structure, which also has a member of `value`; If the structure is not used, we might need to define `valueOfObject[], valueOfCar[]` and other arrays with different names.

*If you want to describe a thing in a more detailed manner, you can define a member function. Please refer to [Class](./class.md) for details.*

## More operations?

See [class](./class.md) for details.

## References

1.  [cppreference class](https://en.cppreference.com/w/cpp/language/class) 
2.  [cplusplus Data structures](http://www.cplusplus.com/doc/tutorial/structures/) 
