author: Ir1d, aofall

## Arithmetic Operators

| Operator      | Function             |
| ------------- | -------------------- |
|  `+` (Unary)  | Positive(Signedness) |
|  `-` (Unary)  | Negative(Signedness) |
|  `*` (Binary) | Multiplication       |
|  `/`          | Division             |
|  `%`          | Modulo               |
|  `+` (Binary) | Addition             |
|  `-` (Binary) | Subtraction          |

??? note "Unary Operator and Binary Operator "
    A unary operator is an operator with only one operand, while a binary operator has two operands. For example, the addition operator in `1 + 2` is a binary operator, with two operands `1` and `2`. Besides, C++ has a lone ternary operator `?:`.

Arithmetic operators consist of two unary operators (positive and negative) and five binary operators (multiply, division, modulo, addition, subtraction). The unary operator has the higher precedence.

The modulo operator `%` means calculating the remainder of a division between two integers.

`-` is a subtraction operator when being a binary operator, e.g., `2-1`; when being a unary operator it is unary minus, e.g., `-1`.

Here is an example usage of arithmetic operator:

`op=x-y*z` 

The result value of `op` follows the precedence law of four basic rules of arithmetic: Perform high-precedent operations first; Operate from left to right if the precedences are same; a pair of brackets will promote the precedence.

### Conversions during Arithmetic Operations

For binary arithmetic operators, if two operands have the same data type, no variable conversion will happen and the result will be the same type of operands. Otherwise, a variable conversion will happen to ensure the two variables having the same data type.

The rules of conversion are listed below:
<!---The following is compiled from original article and https://en.cppreference.com/w/cpp/language/operator_arithmetic-->
- First, promote any `` 
- Otherwise, if either operand is `long double`, the other operand is converted to long `double`; 
- Otherwise, if either operand is `double`, the other operand is converted to `double`; 
- Otherwise, if either operand is `float`, the other operand is converted to `float`; 
- Otherwise, or, if two operands both have integer types:
    - If both operands are signed or both are unsigned, the operand with lesser conversion rank is converted to the operand with the greater integer conversion rank;
    - Otherwise, if the unsigned operand's conversion rank is greater or equal to the conversion rank of the signed operand, the signed operand is converted to the unsigned operand's type;
    - Otherwise, if the signed operand's type can represent all values of the unsigned operand, the unsigned operand is converted to the signed operand's type;
    - Otherwise, both operands are converted to the unsigned counterpart of the signed operand's type. 

For example, for an integer variable (`int`) $x$ and a double-precision floating-point type variable `double`:

- The return of `x/3` will be an integer;
- The return of `x/3.0` will be a `double`;
- The return of `x/y` will be a `double`;
- The return of `x*1/3` will be a integer;
- The return of `x*1.0/3` will be a `double`.

## Bitwise Operators

| Operator      | Function            |
| ------------- | ------------------- |
|  `~`          | Bitwise NOT         |
|  `&` (Binary) | Bitwise AND         |
|  `|`          | Bitwise OR          |
|  `^`          | Bitwise XOR         |
|  `<<`         | Bitwise left shift  |
|  `>>`         | Bitwise right shift |

For the detail of bitwise operation, please refer to the [main article](../math/bit.md). Be cautious that the precedence of bitwise operator is lower than normal arithmetic operators.

## Increment/decrement Operators

Increment and decrement operators `++` and `--` are useful when we need to add or subtract one to the variable.

Increment and decrement operators can be placed before or after the variable, calling prefix or suffix increment or decrement operators. No special distinction between them when using alone. However you need to pay attention if using them inside a expression. Details are in the following example. For more details please refer to examples in [reference](./reference.md).

```cpp
i = 100;

op1 = i++;  // op1 = 100, equivalent to `op1 = i; i = i + 1;`

i = 100;

op2 = ++i;  // op2 = 101, equivalent to `i = i + 1; op2 = i;`

i = 100;

op3 = i--;  // op3 = 100, equivalent to `op3 = i; i = i - 1;`

i = 100;

op4 = --i;  // op4 = 99, equivalent to `i = i + 1; op4 = i;`
```

## Compound Assignment Operators

Compound assignment operators are actually abbreviated form of expressions.

`op=op+2` is equivalent to `op+=2`;

`op=op-2` is equivalent to `op-=2`;

`op=op*2` is equivalent to `op*=2`.

## Comparison Operators

| Operator | Function                 |
| -------- | ------------------------ |
|  `>`     | Greater than             |
|  `>=`    | Greater than or equal to |
|  `<`     | Less than                |
|  `<=`    | Less than or equal to    |
|  `==`    | Equal to                 |
|  `!=`    | Not equal to             |

One thing that you should pay more attention is the difference between equal-to operator and the assignment operator. This is significantly important in conditional execution statements.

For example, even though `if(op=1)` seems similar to `if(op==1)`, they are completely different from each other. The former statement is performing an assignment to op. This returns true if the value is non-zero, which always satisfies the condition of expression. The expression doesn't serve as a condition checker. The latter statement is the one that actually check the value of `op`. 

## Logical Operators

| Operator | Function       |
| -------- | -------------- |
|  `&&`    | AND            |
|  `||`    | Inclusive OR   |
|  `!`     | Negation / NOT |

```cpp
Result = op1 && op2;  // Result will be true if `op1` and `op2` are all true.

Result = op1 || op2;  // Result will be true if either `op1` or `op2` is true.

Result = !op1;  // Result will be true if `op1` is false.
```

## Comma Operator

The comma operator can separate multiple expressions. Expressions separated by the operator will be computed from left to right in order, and returns the value of last separated expression. Comma expressions have the **lowest** precedence among all operators'.

```cpp
exp1, exp2, exp3;  // The final value is the result of `exp3`.

Result = 1 + 2, 3 + 4, 5 + 6;
// The value of `Result` is 3 instead of 11. This is because assignment operator has higher precedence 
// than comma assignment's. The assignment operation is performed first and then comma operation.

Result = (1 + 2, 3 + 4, 5 + 6);

// To make the value of `Result` to be the result of the whole comma operation, you need to promote the 
// precedence of expression by using brackets operators. By doing so the value of `Result` will be 11.
```

## Member Access Operators

| Operator     | Function                |
| ------------ | ----------------------- |
|  `[]`        | Subscript (of an array) |
|  `.`         | Member of object        |
|  `&` (Unary) | Address of              |
|  `*` (Unary) | Indirection             |
|  `->`        | Member of pointer       |

These operators are used to access member of object or memory. All operator except `->` are overloadable. Detailed contents related to `&`, `*` and `->` please refer to the two article: [Pointer](./pointer.md) and [Reference](./reference.md). Here are omitted two rarely used operator `.*` and `->*`. For detail please refer to [cppreference](https://en.cppreference.com/w/cpp/language/operator_member_access).

```cpp
auto result1 = v[1];    // Get object in v with subscript of 2
auto result2 = p.q;     // Get member q of object p
auto result3 = p -> q;  // Get member q of the object pointed by pointer p, equivalent to (*p).q
auto result4 = &v;      // Get the pointer pointing to v
auto result5 = *v;      // Get the object pointed by pointer v
```

## C++ Operator Precedence

This is compiled from [C++ Operator Precedence - cppreference.com](https://en.cppreference.com/w/cpp/language/operator_precedence) and [Baidu Baike(Chinese)](https://baike.baidu.com/item/运算符优先级/4752611 )with modifications.

| Operator             | Description | Example | Overloadable |
| :------------------: | :------: | :----------------------------------------------------------: | :--: |
| **Level 1**          |          |                                                              |      |
|         `::`         |  作用域解析符  |                       `Class::age = 2;`                      | 不可重载 |
|       **第二级别**       |          |                                                              |      |
|         `()`         |   函数调用   |                        `isdigit('1')`                        |  可重载 |
|         `()`         |   成员初始化  |          `c_tor(int x, int y) : _x(x), _y(y*10){};`          |  可重载 |
|         `[]`         |  数组数据获取  |                        `array[4] = 2;`                       |  可重载 |
|         `->`         |  指针型成员调用 |                       `ptr->age = 34;`                       |  可重载 |
|          `.`         |  对象型成员调用 |                        `obj.age = 34;`                       | 不可重载 |
|         `++`         |  后自增运算符  |           `for (int i = 0; i < 10; i++) cout << i;`          |  可重载 |
|         `--`         |  后自减运算符  |           `for (int i = 10; i > 0; i--) cout << i;`          |  可重载 |
|     `const_cast`     |  特殊属性转换  |               `const_cast<type_to>(type_from);`              | 不可重载 |
|    `dynamic_cast`    |  特殊属性转换  |              `dynamic_cast<type_to>(type_from);`             | 不可重载 |
|     `static_cast`    |  特殊属性转换  |              `static_cast<type_to>(type_from);`              | 不可重载 |
|  `reinterpret_cast`  |  特殊属性转换  |            `reinterpret_cast<type_to>(type_from);`           | 不可重载 |
|       `typeid`       |   对象类型符  |  `cout << typeid(var).name(); cout << typeid(type).name();`  | 不可重载 |
|   **第三级别** （从右向左结合）  |          |                                                              |      |
|          `!`         |   逻辑取反   |                        `if( !done ) …`                       |  可重载 |
|          `~`         |   按位取反   |                       `flags = ~flags;`                      |  可重载 |
|         `++`         |  前自增运算符  |             `for (i = 0; i < 10; ++i) cout << i;`            |  可重载 |
|         `--`         |  前自减运算符  |             `for (i = 10; i > 0; --i) cout << i;`            |  可重载 |
|          `-`         |    负号    |                         `int i = -1;`                        |  可重载 |
|          `+`         |    正号    |                         `int i = +1;`                        |  可重载 |
|          `*`         |   指针取值   |                     `int data = *intPtr;`                    |  可重载 |
|          `&`         |   值取指针   |                    `int *intPtr = &data;`                    |  可重载 |
|         `new`        | 动态元素内存分配 |  `long *pVar = new long; MyClass *ptr = new MyClass(args);`  |  可重载 |
|       `new []`       | 动态数组内存分配 |                 `long *array = new long[n];`                 |  可重载 |
|       `delete`       | 动态析构元素内存 |                        `delete pVar;`                        |  可重载 |
|      `delete []`     | 动态析构数组内存 |                      `delete [] array;`                      |  可重载 |
|       `(type)`       |  强制类型转换  |                   `int i = (int) floatNum;`                  |  可重载 |
|       `sizeof`       |  返回类型内存  |    `int size = sizeof floatNum; int size = sizeof(float);`   | 不可重载 |
|       **第四级别**       |          |                                                              |      |
|         `->*`        |  类指针成员引用 |                       `ptr->*var = 24;`                      |  可重载 |
|         `.*`         |  类对象成员引用 |                       `obj.*var = 24;`                       | 不可重载 |
|       **第五级别**       |          |                                                              |      |
|          `*`         |    乘法    |                       `int i = 2 * 4;`                       |  可重载 |
|          `/`         |    除法    |                    `float f = 10.0 / 3.0;`                   |  可重载 |
|          `%`         | 取余数（模运算） |                      `int rem = 4 % 3;`                      |  可重载 |
|       **第六级别**       |          |                                                              |      |
|          `+`         |    加法    |                       `int i = 2 + 3;`                       |  可重载 |
|          `-`         |    减法    |                       `int i = 5 - 1;`                       |  可重载 |
|       **第七级别**       |          |                                                              |      |
|         `<<`         |    位左移   |                    `int flags = 33 << 1;`                    |  可重载 |
|         `>>`         |    位右移   |                    `int flags = 33 >> 1;`                    |  可重载 |
|       **第八级别**       |          |                                                              |      |
|          `<`         |    小于    |                      `if( i < 42 ) ...`                      |  可重载 |
|         `<=`         |   小于等于   |                      `if( i <= 42 ) ...`                     |  可重载 |
|          `>`         |    大于    |                      `if( i > 42 ) ...`                      |  可重载 |
|         `>=`         |   大于等于   |                      `if( i >= 42 ) ...`                     |  可重载 |
|       **第九级别**       |          |                                                              |      |
|         `==`         |    等于    |                      `if( i == 42 ) ...`                     |  可重载 |
|         `!=`         |    不等于   |                      `if( i != 42 ) ...`                     |  可重载 |
|       **第十级别**       |          |                                                              |      |
|          `&`         |   位与运算   |                     `flags = flags & 42;`                    |  可重载 |
|       **第十一级别**      |          |                                                              |      |
|          `^`         |   位异或运算  |                     `flags = flags ^ 42;`                    |  可重载 |
|       **第十二级别**      |          |                                                              |      |
|          `|`         |   位或运算   |                     `flags = flags | 42;`                    |  可重载 |
|       **第十三级别**      |          |                                                              |      |
|         `&&`         |   逻辑与运算  |              `if (conditionA && conditionB) ...`             |  可重载 |
|       **第十四级别**      |          |                                                              |      |
|         `||`         |   逻辑或运算  |              `if (conditionA || conditionB) ...`             |  可重载 |
|   **第十五级别** （从右向左结合） |          |                                                              |      |
|         `? :`        |   条件运算符  |                   `int i = a > b ? a : b;`                   | 不可重载 |
|          `=`         |    赋值    |                         `int a = b;`                         |  可重载 |
|         `+=`         |   加赋值运算  |                           `a += 3;`                          |  可重载 |
|         `-=`         |   减赋值运算  |                           `b -= 4;`                          |  可重载 |
|         `*=`         |   乘赋值运算  |                           `a *= 5;`                          |  可重载 |
|         `/=`         |   除赋值运算  |                           `a /= 2;`                          |  可重载 |
|         `%=`         |   模赋值运算  |                           `a %= 3;`                          |  可重载 |
|         `&=`         |  位与赋值运算  |                     `flags &= new_flags;`                    |  可重载 |
|         `^=`         |  位异或赋值运算 |                     `flags ^= new_flags;`                    |  可重载 |
|         `|=`         |  位或赋值运算  |                     `flags |= new_flags;`                    |  可重载 |
|         `<<=`        |  位左移赋值运算 |                        `flags <<= 2;`                        |  可重载 |
|         `>>=`        |  位右移赋值运算 |                        `flags >>= 2;`                        |  可重载 |
|   **第十六级别** （从右向左结合） |          |                                                              |      |
|        `throw`       |   异常抛出   |                  `throw EClass("Message");`                  | 不可重载 |
|       **第十七级别**      |          |                                                              |      |
|          `,`         |   逗号分隔符  |          `for (i = 0, j = 0; i < 10; i++, j++) ...`          |  可重载 |


<!---Reference: https://en.wikipedia.org/wiki/Modulo_operation-->