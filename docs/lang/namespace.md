## Overview

The mechanism of **namespace** in C++ can be used to solve the problem of name conflicts in complex projects.

For example, all the contents of the C++ standard library are defined in the `std` namespace. If you define a variable called `cin`, you can access the `cin` variable you defined through `cin`, and `std::cin` to access the `cin` object of the standard library without worrying about conflicts.

## Declaration

The following code declares a namespace named `A`:

```cpp
namespace A {
int cnt;
void f(int x) { cnt = x; }
}  // namespace A
```

After the declaration, outside the namespace, you can access the `f` function inside the namespace `A` through `A::f(x)`.

Namespace declarations can be nested, so the following code is also allowed:

```cpp
namespace A {
namespace B {
void f() { ... }
}  // namespace B
void f() {
  B::f();  // the actual access is A::B::f(), because it is currently in the namespace A
           // so you can omit the preceding A::
}
}  // namespace A

void f()  // what is defined here is the f function of the global namespace, which is the same as A::f and A::B::f
          // there is no conflict
{
  A::f();
  A::B::f();
}
```

##  `using` command

After the namespace is declared, if members inside the namespace are accessed from outside the namespace, it is necessary to add `namespace::` before the member name.

Is there any more convenient way for us to directly access the members in the namespace through the member name? The answer is yes. We can use the `using` directive.

 `using` commands have following two forms:

1. `using namespace::member name;`: This command allows us to omit the namespace before a member name and directly access the member through the member name, which is equivalent to importing this member into the current scope.
2.  `using namespace namespace;`: This command can directly access **any** member of the namespace through the member name, which is equivalent to importing all members of this namespace into the current scope.

Therefore, if `using namespace std;` is executed, all the names in `std` will be imported into the global namespace. In this way, we can use `cin` instead of `std::cin`, and `cout` instead of `std::cout`.

!!! warning "`using` command may cause naming conflicts! "
    Since `using namespace std;` will import all the names in `std`, if a variable or function with the same name as `std` is declared, it may cause compilation errors due to naming conflicts.

    Therefore, it is not recommended to use the `using namespace namespace;` command in the project.

With the `using` directive, the code in [C++ Grammar Basics](./basic.md#cin-cout) can have these two equivalent implementations:

```cpp
#include <iostream>

using std::cin;
using std::cout;
using std::endl;

int main() {
  int x, y;
  cin >> x >> y;
  cout << y << endl << x;
  return 0;
}
```

```cpp
#include <iostream>

using namespace std;

int main() {
  int x, y;
  cin >> x >> y;
  cout << y << endl << x;
  return 0;
}
```

## Application

In some problems with multiple subtasks, we can open a namespace for each subtask, and define the variables and functions we need to solve the subtask in it, so that the subtasks do not interfere with each other and will be convenient for debugging to a certain extent. Also, it will improve the readability of the program.