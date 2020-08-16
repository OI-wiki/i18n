author: Ir1d, cjsoft, Lans1ot
A class is an extension of the structure. It can not only have member elements, but also member functions.

In object-oriented programming (OOP), objects are instances of classes, that is, variables.

The `struct` keyword in C++ also defines classes. The definition of **structure** above comes from C. For some historical reasons, C++ stays and expands `struct`.

## Class definition 

Classes are defined using keywords `class` or `struct`. The following example uses `class`.

```cpp
class ClassName {
  ...
};

// Example:
class Object {
 public:
  int weight;
  int value;
} e[array_length];

const Object a;
Object b, B[array_length];
Object *c;
```

Similar to using `struct`. This example defines a class named `Object`. This class has four member elements, namely `weight, value`; and an array `B` is defined after `}`.

The pointer that defines the class is the same as [`struct` ](./struct.md).

### Access specifiers

Different from the example in [`struct`](./struct.md), `public` in this example is an access specifier.

-  `public`: All members after the access specifier can be publicly accessed, which means both **in-class** and **out-of-class** can be accessed.
-  `protected`: Each member after the access specifier can be accessed by members **inside classes**, derived classes or friend, but **cannot be accessed outside of the class**.
-  `private`: The members after the access specifier can **only** be accessed by members of **inside classes** or friend, and cannot be accessed from outside or derived classes.

For `struct`, all its members are `public` by default. For `class`, all its members are `private` by default.

*For "friend" and "derived classes", you can refer to the folding box below, or search for more details online.*

*For algorithm competitions, friend and derived classes are not essential knowledge to master.*

??? note "Basic concepts about friend and derived classes"

    `friend`: use the `friend` keyword to modify a function or class. It is possible to make the **modified element** access the private (`private`) or protected (`protected`) members of the class without becoming a member function or member class. Simply put, as long as you have the `friend` tag of the class, you can access private or protected member elements.

    `derived class`: C++ allows a class to be used as a **base class**, and a **derived class** can be derived from the base class. The derived class (according to specific rules) inherits the member variables and member functions from the base class. It can be used to improve the code reuse rate.

    Derive classes are similar to the "is" relationship. For example, cat (derived class) "is" mammal (base class).

     The difference between `private` and `protected` above can be seen as the derived class can access the elements of the base class `protected` (the same as for `public`), but not the `private` elements.

## Access and modify the value of member elements

The method is the same as [`struct`](./struct.md).

- For variables, use the `.` symbol.
- For pointers, use the `->` symbol.

## Member function

Member function, as the name implies, is the function contained in the class.

??? note "Examples of common member functions"
    ```cpp
    vector.push_back();
    set.insert();
    queue.empty();
    ```

```cpp
class Class_Name {
  ... type Funciton_Name(...) { ... }
};

// Example:
class Object {
 public:
  int weight;
  int value;
  void print() {
    cout << weight << endl;
    return;
  }
  void change_w(int);
};

void Object::change_w(int _weight) { weight = _weight; }
```

This class has a function to print the member element of `Object` and a function to change the member element `weight`.

Similar to functions, member functions can also be declared first, in the definition, such as line 14 (declaration) and after line 17 (definition).

If you want to call the `print` member function of `var`, you can use `var.print()`.

### Overloading operators

??? note "What is overloading"
    C++ allows writers to specify different definitions for functions or operators with the same name. This is called **overload**.

    If one or more of the parameter types, numbers, and return types of functions with the same name are not the same, then these functions are considered different.

    If there is no confusion when loading (referring to when calling some functions with the same name; the called function cannot be uniquely determined based on the type and number of parameters filled in. It often occurs in functions with default parameters), the compiler will use parameters filled in to judge which function should be called.

    The above process is called overload resolution.

Overloading operators can partially replace functions and simplify the code.

The following gives examples of overloading operators.

```cpp
class Vector {
 public:
  int x, y;
  Vector() : x(0), y(0) {}
  Vector(int _x, int _y) : x(_x), y(_y) {}
  int operator*(const Vector& other) { return x * other.y + y * other.x; }
  Vector operator+(const Vector&);
  Vector operator-(const Vector&);
};

Vector Vector::operator+(const Vector& other) {
  return Vector(x + other.x, y + other.y);
}

Vector Vector::operator-(const Vector& other) {
  return Vector(x - other.x, y - other.y);
}
// 4 and 5 lines means assigning values for x and y. Please refer to the following paragraph for specific implementation.
```

This example defines a vector class and overloads the `* + -` operator, which respectively represent vector inner product, vector addition, and vector subtraction.

The template of overloading operators can be roughly divided into the following parts.

```text
/*Overloading in class definition*/ return types symbol(parameter){...}

/*declared inside the class definition, defined outside*/ Return type Class name::operator symbol(parameter){...}
```

For custom classes, if some operators are overloaded (generally only the comparison operator `<` needs to be overloaded), the corresponding STL container or algorithm can be used, such as [`sort`](../basic/stl-sort.md).

*For more information, see article 4 of "References" section.*

??? note "Operators that can be overloaded"

      ```cpp
         =
         +  -  *  /  =  %
         +=  -=  *=  /=  %=
         <  >  ==  !=  <=  >=
         &  |  !  ^  ~
         &=  |=  ^=
         //----------
         <<  <<=  >>  >>=
         ++  --
         &&  ||
         []  ()  ,
         ->*  ->  new  delete  new[]  delete[]
      ```

### Set initial values when instantiating variables

To accomplish this kind of operation, you need to define the **Default constructor**.

```cpp
class ClassName {
  ... ClassName(...)... { ... }
};

// Example:
class Object {
 public:
  int weight;
  int value;
  Object() {
    weight = 0;
    value = 0;
  }
};
```

This example defines the default constructor of `Object`, which can initialize all member elements to `0` when we instantiate a variable of type `Object`.

If there is no explicit constructor, the compiler considers the class to have an implicit default constructor. In other words, if no constructor is defined, the compiler will automatically generate a default constructor and initialize it according to the type of the member element (the same as defining the built-in type variable).

In this case, the member elements are uninitialized, and the result of accessing the uninitialized variable is undefined (that is, it is not known to return the sum value).

If you need to customize the initialized value, you can redefine (or overload) the constructor.

??? note "About defining (or overloading) the constructor"
    Generally speaking, the default constructor takes no parameters, which is different from the constructor. The definition of the constructor and the default constructor is similar, but the number of parameters is different.

    The constructor can be overloaded (of course the first time it is called definition). It should be noted that if a constructor has been defined and the parameter list of the constructor is not empty, the compiler will no longer generate a default constructor without parameters. This may cause the behavior of trying to construct variables in the default method to fail to compile (referring to not filling in the initialization parameters).

When using C++11 or above, you can use `{}` to initialize variables.

??? note "About `{}`"
    Use `{}` for initialization, which requires using std::initializer_list, a lightweight proxy object for initialization.

    The initialization steps are roughly as follows:

    1. Try to find the default constructor with `std::initializer_list` in the parameters, and call it if there is one (after the call, the following search will not be performed, the same below).

    2. Try to fill the elements in `{}` into other construction parameters. If the parameters can be filled in order (default parameters are also included), call the default constructor.

    3. If there is no `private` member element, try to assign values in the order of element definition or index order outside the **class**.

    _The above process is only a simplified version, see "reference 9" for details_

```cpp
class Object {
 public:
  int weight;
  int value;
  Object() {
    weight = 0;
    value = 0;
  }
  Object(int _weight = 0, int _value = 0) {
    weight = _weight;
    value = _value;
  }
  // the same as
  // Object(int _weight,int _value):weight(_weight),value(_value) {}
};

// the same as
// Object::Object(int _weight,int _value){
//   weight = _weight;
//   value = _value;
// }
//}

Object A;        // ok
Object B(1, 2);  // ok
Object C{1, 2};  // ok,(C++11)
```

??? note "About implicit type conversion"
    Sometimes we might write the following code:

    ```cpp
    class Node {
     public:
      int var;
      Node(int _var) : var(_var) {}
    };
    Node a = 1;
    ```

    This does not seem very logical. An int type cannot be converted to a node type. But the compiler will not give an error prompt.

    The reason is that when assigning, first call `node::node(int)` with `1` as a parameter, and then call the default copy function for assignment.

    But in most cases, the writer will want the compiler to report an error. At this time, you can add the `explicit` keyword before the constructor. This would tell the compiler that it must be called explicitly.

    ```cpp
    class Node {
     public:
      int var;
      explicit Node(int _var) : var(_var) {}
    };
    ```

    In other words, `node a=1` will report an error, but `node a=node(1)` will not. Because the latter explicitly calls the constructor. Of course most people will not write the latter one. But this example is enough to illustrate the role of explicit.

    _However, in OIs, in order to avoid such situations, the commonly used technique is to "enhance the degree of standardization of the code" and avoid it from the source._

### Destroy

This is an inevitable problem. Each variable will be destroyed at the end of the scope.

But for a pointer that has already pointed to dynamically allocated memory, the pointer will not automatically release the pointed memory when it is destroyed, and dynamic memory needs to be manually released.

If the member elements of the structure contain pointers, you will also encounter this problem. It is necessary to use the destructor to manually release dynamic memory.

 **destruct** function(Destructor) will be called when the variable is destroyed. The overloaded method is the same as the constructor, but you need to add `~` before it. 

*The destructor defined by default is usually enough for OIs. Usually we only overload the destructor when the member element contains a pointer.*

```cpp
class Object {
 public:
  int weight;
  int value;
  int* ned;
  Object() {
    weight = 0;
    value = 0;
  }
  ~Object() { delete ned; }
};
```

### Assign values to class variables

By default, the assignment will follow the rules for assigning the corresponding member elements. You can also use `class name()` or `class name{}` as temporary variables for assignment.

The former just calls the copy constructor, and the latter calls the default constructor before calling the copy constructor.

In addition, the assignments are performed by **shallow copy** between corresponding elements by default. If there is a pointer in the member element, the member pointers of the two variables have the same address after the assignment is completed.

```cpp
// type of A,tmp1,tmp2,tmp3 is Object
tmp1 = A;
tmp2 = Object(...);
tmp3 = {...};
```

For solving the pointer problem or more operations, you need to overload the corresponding constructor.

*For more information on the constructor, see article 6 of "References".*

## References

1.  [cppreference class](https://en.cppreference.com/w/cpp/language/class) 
2.  [cppreference access](https://en.cppreference.com/w/cpp/language/access) 
3.  [cppreference default_constructor](https://en.cppreference.com/w/cpp/language/default_constructor) 
4.  [cppreference operator](https://en.cppreference.com/w/cpp/language/operators) 
5.  [cplusplus Data structures](http://www.cplusplus.com/doc/tutorial/structures/) 
6.  [cplusplus Special members](http://www.cplusplus.com/doc/tutorial/classes2/) 
7.  [C++11 FAQ](http://www.stroustrup.com/C++11FAQ.html) 
8.  [cppreference Friendship and inheritance](http://www.cplusplus.com/doc/tutorial/inheritance/) 
9.  [cppreference value initialization](https://en.cppreference.com/w/cpp/language/value_initialization) 
