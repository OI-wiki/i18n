author: tsagaanbar, Enter-tainer, Xeonacid

## Address and Pointer

Every data has the address where it stores. During each actual execution of program, the locations of variables in physical memory are different. However, we are still able to obtain the address of data in memory by a certain statement while programming.

Addresses are also data. The variable type that stores address has a special name called *pointer variable*, or simply, *pointer*.

???+ note "The Size of Pointer Variable"
    In different environment, the sizes of a pointer variable are different. In a machine of 32-bits, an address is represented by a binary integer of 32 bits long. Therefore the size of a pointer variable is 4 bytes. As for 64-bits machine, an address is represented by a binary integer of 64 bits long. Therefore the size will be 8 bytes.

<!---地址只是一个刻度一般的数据，--> Pointer variables have different type for different type of data. E.g., the stored address in a pointer variable with type of `int` corresponds the beginning address of a 32-bit long space; the stored address in a pointer variable with type of `char` corresponds the beginning address of a 8-bit long space.

Actually, users can also declare a pointer variable pointing to pointer variable.

Assume that the user declares a struct:

```cpp
struct ThreeInt {
  int a;
  int b;
  int c;
};
```

Then, a pointer to `ThreeInt` corresponds a space of $3 \times 32 = 96 \text{bit}$.

## Declaration and Usage of Pointer

In C/C++, the data specifier of pointer variable is original data specifier plus a asterisk `*`. E.g., the specifier of pointer variable of `int` is `int*`.

We can use `&` operator to get the address of a variable.

To access the memory corresponding to the stored address of pointer, or the memory **pointed to** by the pointer, we need to perform **dereference** on pointer variable using `*` operator.

```cpp
int main() {
  int a = 123;  // a: 123
  int* pa = &a;
  *pa = 321;  // a: 321
}
```

It is similar to struct variables. To access members of struct pointed to by the pointer, it is required to perform dereference to pointer, then use member-of-object operator `.`. However, it is more recommended to use the "arrow" member-of-pointer operator `->`, which is a simpler way of writing codes.

```cpp
struct ThreeInt {
  int a;
  int b;
  int c;
};

int main() {
  ThreeInt x{1, 2, 3}, y{6, 7, 8};
  ThreeInt* px = &x;
  (*px) = y;    // x: {6,7,8}
  (*px).a = 4;  // x: {4,7,8}
  px->b = 5;    // x: {4,5,8}
}
```

## Pointer Offset

Pointer variables are able to perform addition or subtraction operation **with integers**. For pointer of `int`, every increment of $1$ makes the pointed address shift for $32 \text{bits} = 4 \text{bytes}$; if the increment is $2$ it will shift for $2 \times 32 = 64 \text{bits}$. Similarly, for pointer of `char`, every increment of $1$ makes the pointed address shift for $8 \text{bits} = 1 \text{byte}$. 

### Using Pointer Offset to Access Array

As we mentioned before, an array is a continuum of memory space. In C/C++, the lone array's identifier represents the beginning address of this array.

```cpp
int main() {
  int a[3] = {1, 2, 3};
  int* p = a;  // `p` points to `a[0]`
  *p = 4;      // `a`: [4, 2, 3]
  p = p + 1;   // `p` points to `a[1]`
  *p = 5;      // `a`: [4, 5, 3]
  p++;         // `p` points to `a[2]`
  *p = 6;      // `a`: [4, 5, 6]
}
```

When accessing elements in arrays by pointers, it is always needed to use pointer offset. In other words, access elements by a base address plus offsets.

We usually use subscript operator `[]` to access element in an arrya at a certain offset. E.g., `a[3]` and `p[4]`. This kind of expression is equivalent to computing pointer and dereferencing then. E.g., `p[4]` and `*(p + 4)` are two equivalent expressions. 

## Advanced Usage of Pointer

With pointer, the programmer is able to manipulate data everywhere during the execution of program without limitation of scopes.

### Pass by Pointer

Except passing by reference, parameters are passed to sub-process by copying when calling a function (process). In default, a function can only return the result bu returning value. However, in such situations that if a function is willing to modify external data, or when the data of some struct/class is too large to perform copy, we can pass the address of external data to access or even modify external data inside the sub-process.

For example, the function `my_swap` in the following code swaps the value of two variables of `int` type by receiving two pointer of `int` type and using middle variable.

```cpp
void my_swap(int *a, int *b) {
  int t;
  t = a;
  a = b;
  b = t;
}

int main() {
  int a = 6, b = 10;
  my_swap(&a, &b);
  // After calling, the value of `a` in `main()` becomes 10 and `b`'s becomes 6.
}
```

C++ introduces reference, which is easier to use and safer than pointer. For detail please refer to p[C++: Reference](./reference.md) and [Differences between C and C++: Pointer and Reference](./c-cpp.md).

### Dynamical Instantiation

When programming it is always involved dynamical memory allocation. That is, the program will dynamically allocate or return memory from the operating system that used to store data during execution. To use the space we need to store the address to a pointer.

In C++, we use the operator `new` to obtain a block of memory, and use the operator `delete` to free a space pointed to by a pointer. 

```cpp
int* p = new int(1234);
/* ... */
delete p;
```

Statements in the example above use the operator `new` to allocate a memory with size of `int` from the operating system, initialize it to `1234`, and declare a pointer with the type of `int` pointing to the space.

Similarly, we can create a new object using new-statement:

```cpp
class A {
  int a;

 public:
  A(int a_) : a(a_) {}
};

int main() {
  A* p = new A(1234);
  /* ... */
  delete p;
}
```

As above shows, the `new` expression will try to allocating a block of memory space of corresponding size, and return the address of this space.

```cpp
struct ThreeInt {
  int a;
  int b;
  int c;
};

int main() {
  ThreeInt* p = new ThreeInt{1, 2, 3};
  /* ... */
  delete p;
}
```

???+ note "List Initializations"
    The operators `{}` can be used to initialize struct that doesn't have its constructor. Besides, the using of operators `{}` can make the form of variable initialization more unified. For more detail please refer to [list initialization (since C++11)](https://en.cppreference.com/w/cpp/language/list_initialization).

Be cautious that it is needed to use delete-statement to free the space if not using memory allocated by the new-statement. It is not allowed to free one block of memory twice or more times. But use delete-statement for  null pointer `nullptr` is legal.。

### Dynamically Create Array

You can also use operator `new[]` to create a array, which returns the beginning address of created array, also known as the address of the first element of array. We can store this address with pointer of correct type. When freeing it is needed to use operator `delete[]`.

```cpp
size_t element_cnt = 5;
int *p = new int[element_cnt];
delete[] p;
```

The storage of elements in a array is continuous. That is, `p + 1` is pointing to the successor of `p`.

### 2-Dimensional Array

When storing data in form of matrix, you may need to use a data type called 2-dimensional array, which is an array consists of arrays in semantically speaking. However, a computer's memory can be regarded as a long long 1-dimensional array. Therefore, a concept about whether the array is contiguous or not appears when storing a 2-dimensional array in computer.

When we saying a 2-dimensional array is contiguous, we indicate that the ending of any row and the beginning of next row are adjacent in physical address. In other words, the whole 2-dimensional array can be treated as a 1-dimensional array. Otherwise, the two are not always adjacent to each other physically.

For a contiguous 2-dimensional array, one is able to use only one loop to enumerate all data of the array by using a incremental pointer. But for a non-contiguous array, it is needed to get the address of row beginning first and then access elements inside, as each rows are not contiguous.

???+note "Storing 2-dimensional Array"
    这种按照“行（row）”存储数据的方式，称为行优先存储；相对的，也可以按照列（column）存储数据。由于计算机内存访问的特性，一般来说，访问连续的数据会得到更高的效率。因此，需要按照数据可能的使用方式，选择“行优先”或“列优先”的存储方式。

### Dynamically Create 2-Dimensional Array

In C/C++, we can declare a 2-dimensional array with $N$ rows and $M$ columns using statements similar to the following example, which will be contiguous physically.

???+note "描述数组的维度"
    Another common way to describe the multi-dimensional array is using the n-th dimension concept. E.g., for row-first storage, the length of 1st dimension is $N$ and 2nd dimension is $M$

```cpp
int a[N][M];
```

Using this method of declaration requires that $N$ and $M$ are constant expressions that can be determined in compile time.

In C/C++, the subscript of the first element of an array is `0`. Therefore, for example, an expression like `a[r][c]` represents the $c+1$-th element in the $r+1$-th row of 2-dimensional array `a`. It also calls the subscript of this element as `(r, c)`.

However, in practice, the size of a multi-dimensional array is not always fixed. It is needed to allocate memory dynamically.

A common approach is to declare an **1-dimensional array** with length of $N \times M$, where we access 2-dimensional element with subscript `(r, c)` by using subscript `[r * m + c]`.

```cpp
int* a = new int[N * M];
```

Using this method can guarantee the 2-dimensional array is **contiguous**.

???+note "Linear Storage of Array in Physical Layer"
    In fact, data can be considered to be stored linearly in memory. So it is able to store n-dimensional array by dynamically allocate memory of 1-dimensional array under certain rules.

Besides, it is able to allocate and use memory basing on the concept *array of arrays*. An array storing several arrays is actually an array storing several beginning addresses of arrays, i.e., an array storing several pointers.

We need a variable to store the beginning address of this "array of arrays", which is the address of a pointer. This variable is a *pointer pointing to a pointer*, also known as *double pointer*, as the example below:

```cpp
int** a = new int*[5];
```

Then we need to allocate memory for each arrays:

```cpp
for (int i = 0; i < 5; i++) {
  a[i] = new int[5];
}
```

To this point, we finished the allocation of memory. As for freeing memory allocated by this method, it is required to perform a reverse operation: free every sub-array first, then free the array storing the beginning addresses of arrays, as the following example:

```cpp
for (int i = 0; i < 5; i++) {
  delete[] a[i];
}
delete[] a;
```

Be cautious that the contiguousness of the space allocated by this way cannot be guaranteed.

There is another approach using the *pointer pointing to arrays*:

???+note 
    我们之前说到，在 C/C++ 中，直接使用数组名，值等于数组首元素的地址。但是数组名表示的这一变量的类型实际上是整个数组，而非单个元素。
    
    ```cpp
    int main() { int a[5] = {1, 2, 3, 4, 5}; }
    ```
    
    从概念上说，代码中标识符 `a` 的类型是 `int[5]`；从实际上来说，`a + 1` 所指向的地址相较于 `a` 指向的地址的偏移量为 5 个 `int` 型变量的长度。

```cpp
int main() {
  int(*a)[5] = new int[5][5];
  int* p = a[2];
  a[2][1] = 1;
  delete[] a;
}
```

这种方式获得到的也是连续的内存，但是可以直接使用 `a[n]` 的形式获得到数组的第 n + 1 行（row）的首地址，因此，使用 `a[r][c]` 的形式即可访问到下表为 `(r, c)` 的元素。

由于指向数组的指针也是一种确定的数据类型，因此除数组的第一维外，其他维度的长度均须为一个能在编译器确定的常量。不然，编译器将无法翻译如 `a[n]` 这样的表达式（`a` 为指向数组的指针）。

## Pointer Pointing to a Function

关于函数的介绍请参见 [C++ 函数](./func.md) 章节。

简单地说，要调用一个函数，需要知晓该函数的参数类型、个数以及返回值类型，这些也统一称作接口类型。

可以通过函数指针调用函数。有时候，若干个函数的接口类型是相同的，使用函数指针可以根据程序的运行 **动态地** 选择需要调用的函数。换句话说，可以在不修改一个函数的情况下，仅通过修改向其传入的参数（函数指针），使得该函数的行为发生变化。

假设我们有若干针对 `int` 类型的二元运算函数，则函数的参数为 2 个 `int`，返回值亦为 `int`。下边是一个使用了函数指针的例子：

```cpp
#include <iostream>

int (*binary_int_op)(int, int);

int foo1(int a, int b) { return a * b + b; }

int foo2(int a, int b) { return (a + b) * b; }

int main() {
  int choice;
  std::cin >> choice;
  if (choice == 1) {
    binary_int_op = foo1;
  } else {
    binary_int_op = foo2;
  }

  int m, n;
  std::cin >> m >> n;
  std::cout << binary_int_op(m, n);
}
```

???+ note "`&`、`*` 和函数指针"
    在 C 语言中，诸如 `void (*p)() = foo;`、`void (*p)() = &foo;`、`void (*p)() = *foo;`、`void (*p)() = ***foo` 等写法的结果是一样的。
    
    因为函数（如 `foo`）是能够被隐式转换为指向函数的指针的，因此 `void (*p)() = foo;` 的写法能够成立。
    
    使用 `&` 运算符可以取得到对象的地址，这对函数也是成立的，因此 `void (*p)() = &foo;` 的写法仍然成立。
    
    对函数指针使用 `*` 运算符可以取得指针指向的函数，而对于 `**foo` 这样的写法来说，`*foo` 得到的是 `foo` 这个函数，紧接着又被隐式转换为指向 `foo` 的指针。如此类推，`**foo` 得到的最终还是指向 `foo` 的函数指针；用户尽可以使用任意多的 `*`，结果也是一样的。
    
    同理，在调用时使用类似 `(*p)()` 和 `p()` 的语句是一样的，可以省去 `*` 运算符。
    
    参考资料：[Why do function pointer definitions work with any number of ampersands '&' or asterisks '\*'? - stackoverflow.com](https://stackoverflow.com/questions/6893285/why-do-function-pointer-definitions-work-with-any-number-of-ampersands-or-as)

可以使用 `typdef` 关键字声明函数指针的类型。

```cpp
typedef int (*p_bi_int_op)(int, int);
```

这样我们就可以在之后使用 `p_bi_int_op` 这种类型，即指向“参数为 2 个 `int`，返回值亦为 `int`”的函数的指针。

可以通过使用 `std::function` 来更方便的引用函数。（未完待续）

使用函数指针，可以实现“回调函数”。（未完待续）
