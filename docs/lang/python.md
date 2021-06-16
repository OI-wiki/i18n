## About Python
 
Python is an interpreted object-oriented programming language that has been widely used around the world. It is very suitable for testing algorithm segments and prototypes. It can also be used to practice OJ questions.

### Why should we learn Python?

- Python is an **interpreted** language: similar to PHP and Perl, it does not require compilation during the development, can be used immediately, and has great cross-platform compatibility.
- Python is an **interactive** language: you can enter the code directly after the prompt `>>>` on the command line, which makes your code easier to debug.
- Python is easy to learn and use, and covers a wide range of topics: from simple I/O to scientific calculations and even large-scale web applications, Python can help you quickly write a program that suits your need at a very low learning cost. This could add a practical skill for your future study and work, and help your programming career in the long run.
- Python is easy to read and widely used: this means that you can get support **faster** and solve problems **faster** than using other languages.
- The environment of Python is easy to configure in each platform, and most of the popular Linux distributions (even `NOI Linux`) on the market have the **built-in** Python with a slightly older version, which means you can really use it during the competition, making it your best OI partner.

### Things to pay attention to when learning Python

- The current Python has two versions: Python 2 and Python 3. Although Python 2 is [almost abandoned](https://pythonclock.org/), it is still used by some old systems and codebases. Usually we are not sure about the version that can be used in OIs, so we will **introduce the newer version of Python**. However, it is still recommended that readers understand the syntax of Python 2 and compare the differences between the two.
- If you have used the C++ language before, please keep in mind that the syntax of Python is quite different from that of C++. Please be careful not to confuse it when using it.
- Since Python is a **highly dynamic interpreted** language, there is a lot of extra overhead during its program operation. Generally speaking, the less Python code we write to achieve the same function, the faster it is (but don't go extreme). Especially **for loops are incredibly slow in Python**. Therefore, if you want to achieve high performance, try to use the built-in functions such as `filter` and `map`, or use ["list comprehension"](https://www.pythonforbeginners.com/basics/list-comprehensions-in-python) to avoid loops.

## Environment setup

### Windows

Visit <https://www.python.org/downloads/> to download the version you need and install it.
In addition, for convenience, please be sure to check **`Add Python 3.x to PATH`** to ensure that Python is added to the environment variable.

For example, in the following Python 3.7.4 installation interface, the bottom check box should be checked as shown in the figure.

![py3.7.4](./images/python1.png)

After the installation is complete, you can find the installed Python in the start menu.

![start](./images/python2.png)

If `add environment variables` is checked as shown in the figure above, you can also use Python through the **Command Prompt** (`Win + R` -> `cmd` ).

After normal startup, it will first display the welcome message and version information, and then the copyright statement, and then the prompt **`>>>`** will appear, generally as follows:

```bash
$ python3
Python 3.6.4 (v3.6.4:d48eceb, Dec 19 2017, 06:54:40) [MSC v.1900 64 bit (AMD64)] on win32
Type "help", "copyright", "credits" or "license" for more information.
>>>
```

This is the **IDLE** of Python.

???+ note "What is [**IDLE**](https://docs.python.org/3/library/idle.html)？"
    The IDLE of Python is the abbreviation of "Integrated Development and Learning Environment". It is the basic programming and interpreting environment that comes with the Python standard distribution. Other Python distributions (such as Anaconda) also include more advanced IDEs such as [IPython](https://ipython.org/), and [Spyder](https://www.spyder-ide.org/).

### macOS/Linux

Normally, as mentioned above, most Linux distributions already come with Python. If you only plan to learn the grammar and there is no special requirement, you don't need to install it. Generally speaking, running `python` in a Linux terminal enters Python 2, and running `python3` enters Python 3.

However, due to various dependency issues (such as CentOS's yum), we usually need to deal with these after self-compiling and installation, which is beyond the scope of this article.

In this case, you can install it directly through the package manager, such as installing `Python 3` under Ubuntu:

```bash
sudo apt install python3
```

For more details, you can directly use the keyword `system name (logo version) install Python 2/3` on the search engine to find the corresponding tutorial.

???+ note "Run `python` or `python3`？"
    According to [Python 3 official documentation](https://docs.python.org/3/tutorial/interpreter.html), on Unix systems, the `Python 3.X` interpreter **is installed by default** (referring to installation using the package manager) and the executable files after the installation is not called `python`, so that it will not conflict with the `Python 2.X` installed at the same time. The pip software installed by default works the same way. The file name of the Python 3 package manager is `pip3`. You can create your own soft chain or shell alias according to your own habits, but please be careful not to conflict with the built-in software.

### About pip

???+ note "What is [**pip**](https://pypi.org/project/pip/)"
    Pip is Python's default package manager, used to install third-party Python libraries. It is very powerful, able to handle version dependencies, and supports binary installation through the wheel file. The pip library is now hosted on the [PyPI](https://pypi.org) (ie "Python Package Index") platform, and users can also specify a third-party package hosting platform.

## Basic syntax

Python is known for its concise and easy-to-understand syntax. Its basic grammatical structure can be easily found on the Internet, for example, [Python For Beginners](https://www.python.org/about/gettingstarted/) has a good introduction. Here are only some language features that are more practical for OIers.

### About Comment

Here is a statement in advance about the writing of comments in Python, because it will be used frequently in the following explanation.

```python3
# single line comment starts with # character

""" Strings spanning multiple 
    lines will be wrapped in three quotation marks, but they are also often used to make multi-line comments. (NOTE: Indentation is not considered in the string)
"""
```

Adding comment code will not affect the normal operation of the program. We encourage adding comments to make your code easier to understand and use.

### Basic data types and operations

Some people say that you can use the Python installed in your system as a multi-purpose calculator. And this is a fact.

You can enter an expression after the prompt `>>>`, just like most other languages (such as C++), use the operators `+`, `-`, `*`, `/` to perform operations on numbers ; You can also use `()` to group according to the associative law, for example:

```python3
>>> 233
233

>>> 5 + 6
11
>>> 50 - 4 * 8
18
>>> (50 - 4) * 8
368

>>> 15 / 3 # division will always return float type
5.0
>>> (50 - 4 * 8) / 9
2.0
>>> 5 / 3
1.6666666666666667

>>> 5.0 * 6 # The result of a floating point operation is also a floating point number
30.0
```

Integers (such as `5`, `8`, `16`) have the `int` type, and those with a fractional part (such as `2.33`, `6.0`) have the `float` type. As you learn more deeply you may come into contact with more data types, but these are enough to use for the beginners.

In the above practice, you have also seen that division operations(`/`) always return the floating point types(integers in Python 2). If you want an integer or rounded down result, you can use integer division(`//`). Similarly, you can use modulus(`%`) to calculate the remainder as in C++.

```python3
>>> 5 / 3 # Normal operations will output floating point numbers
1.6666666666666667
>>> 5 // 3 # Use integer division to round down and output the integer type
1
>>> -5 // 3 # Comply with the principle of rounding down, note that it is different from C/C++
-2
>>> 5.0 // 3.0 # You can do this if you insist on rounding down the floating point number
1.0
>>> 5 % 3 # Get modulus
2
>>> -5 % 3 # The result of taking the modulus of a negative number must be a non-negative number, which is also different from C/C++, but both satisfy (a//b)*b+(a%b)==a
1
```

In particular, Python encapsulates the algorithm of exponentiation (`**`), and also provides the efficient implementation of [quick power](../math/quick-pow.md) with the built-in `pow(a, b, mod)`.

At the same time, Python also provides support for large integers, but floating point numbers have the same errors as C/C++.

```python3
>>> 5 ** 2
25
>>> 2 ** 16
65536
>>> 2 ** 512
13407807929942597099574024998205846127479365820592393377723561443721764030073546976801874298166903427690031858186486050853753882811946569946433649006084096
>>> pow(2, 512, 10000) # That is the fast implementation of 2**512% 10000 
4096

>>> 2048 ** 2048 # Try big integers in IDLE?
```

### IO

Input and output in Python are mainly done through the built-in functions `raw_input` (Python 2)/ `input` (Python 3) and `print`. For this part, please refer to [Python official documentation](https://docs.python.org/3/tutorial/inputoutput.html). The `input` function is used to read a line from the standard input stream, and `print` is to output a line to the standard output stream. In Python 3, the `end` parameter is added to `print` to specify the ending character, which can be used to avoid automatic line wrapping of `print`. If you need more flexible IO operations, you can use the `sys.stdin` and `sys.stdout` operating standards as input and output streams after the introduction of the `sys` package.

In addition, if you want to format the output, you can use the string syntax in Python. There are two ways to format, one is to use the `%` operator, and the other is to use the `format` function. The former syntax is compatible with C, while the latter syntax is more complicated. You can refer to the [official Document](https://docs.python.org/3/library/string.html#formatstrings).

```python3
>>> print(12)
12
>>> print(12, 12) # This method behaves differently in Python 2 and Python 3
12 12
>>> print("%d" % 12) # Compatible with C syntax
12
>>> print("%04d %.3f" % (12, 1.2))
0012 1.200
>>> print("{name} is {:b}".format(5, name="binary of 5"))
binary of 5 is 101
```

### Create array

Students who have transferred from C++ may be confused about how to create arrays in Python. Here is the syntax for it in Python.

#### Use `list` 

The main use is the feature of Python lists (`list`). It is worth noting that the implementation of lists in Python is similar to `vector` in C++.

```python3
>>> [] # Empty list
[]
>>> [1] * 10 # Create an array of 10 elements
[1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
>>> [1, 1] + [2, 3] # Array concatenation 
[1, 1, 2, 3]
>>> a1 = list(range(8)) # Create an array of natural numbers
>>> a1
[0, 1, 2, 3, 4, 5, 6, 7]

>>> [[1] * 3] * 3 # Create a 3*3 array
[[1, 1, 1], [1, 1, 1], [1, 1, 1]]
>>> [[1] * 3 for _ in range(3)] # Create a 3*3 array
[[1, 1, 1], [1, 1, 1], [1, 1, 1]]
>>> a2 = [[1]] * 5; a[0][0] = 2; # Guess what's the result?
>>> a2
[[2], [2], [2], [2], [2]]

>>> # The following is the methods of array operations
>>> len(a1) # Length of the array
8
>>> a1.append(8) # Add a number to the end
>>> a1[0] = 0 # Access and assignment
>>> a1[-1] = 7 # Visit from the end
>>> a1[2:5] # Extract a section of the array
[2, 3, 4]
>>> a1[5:2:-1] # Reverse access
[5, 4, 3]
>>> a1.sort() # Sort array

>>> a2[0][0] = 10 # Access and assign two-dimensional arrays
>>> for i, a3 in enumerate(a2):
        for j, v in enumerate(a3):
            temp = v # Where v is a[i][j]
```

Pease pay attention to the method of creating multi-dimensional arrays mentioned in the above case. Since the multiplication of a list is only a copy of a reference, the three `[1]` generated by a code like `[[1]] * 3` are actually the same object, and modifying its contents will cause all arrays to be modified. So using for loops when opening multidimensional arrays can avoid this problem.

#### Use Numpy

??? note "What is Numpy?"
     [Numpy](https://numpy.org/) is a famous Python scientific computing library that provides high-performance numerical and matrix operations. When testing algorithm prototypes, you can use Numpy to avoid algorithms such as handwriting sorting and finding the best value. The core data structure of `Numpy` is `ndarray`, which is an n-dimensional array, which is stored continuously in memory and has a fixed length. In addition, the core of Numpy is written in C, which is very efficient.

The following code will introduce how to use Numpy to create a multidimensional array and access it.

```python3
>>> import numpy as np # Numpy is a third-party library that needs to be installed and imported

>>> np.empty(3) # Create a 3 empty array
array([0.00000000e+000, 0.00000000e+000, 2.01191014e+180])

>>> np.empty((3, 3)) # Create a 3*3 empty array
array([[6.90159178e-310, 6.90159178e-310, 0.00000000e+000],
       [0.00000000e+000, 3.99906161e+252, 1.09944918e+155],
       [6.01334434e-154, 9.87762528e+247, 4.46811730e-091]])

>>> np.zeros((3, 3)) # Create a 3*3 array and initialize it to 0
array([[0., 0., 0.],
       [0., 0., 0.],
       [0., 0., 0.]])

>>> a1 = np.zeros((3, 3), dtype=int) # Open a 3×3 integer array
>>> a1[0][0] = 1 # Access and assignment
>>> a1[0, 0] = 1 # More friendly syntax
>>> a1.shape # Shape of the array
(3, 3)
>>> a1[:2, :2] # Get the sub-matrix formed by the first two rows and the first two columns without copy
array([[1, 0],
       [0, 0]])
>>> a1[0, 2] # Get columns 1 and 3 without copy
array([[1, 0],
       [0, 0],
       [0, 0]])

>>> np.max(a1) # Get the maximum value of the array
1
>>> a1.flatten() # Flatten the array
array([1, 0, 0, 0, 0, 0, 0, 0, 0])
>>> np.sort(a1, axis=1) # Sort the array along the row direction and return the sorted result
array([[0, 0, 1],
       [0, 0, 0],
       [0, 0, 0]])
>>> a1.sort(axis=1) # Sort the array in place along the row
```

## Type check and tips

Whether you are doing a competition or building a project, using type hints can make it easier for you to infer code, find subtle errors, and maintain a clean architecture. The latest versions of Python allow you to specify specific types for hints, and some tools can use these hints to help you develop code more effectively. Python's type checking mainly uses type annotations and type comments. For OIer, it is enough to just master the basic operations of the Python type checking system. In the actual project, if you want to write code with better style and easy type checking, you can refer to [Mypy's documentation](https://mypy.readthedocs.io/).

### Dynamic type checking

Python is a dynamic type checking language that handles types in a flexible but implicit way. The Python interpreter only checks whether the type is correct at runtime, and allows the variable type to be changed at runtime.

```python
>>> if False:
...     1 + "two"  # This line never runs, so no TypeError is raised
... else:
...     1 + 2
...
3

>>> 1 + "two"  # Now this is type checked, and a TypeError is raised
TypeError: unsupported operand type(s) for +: 'int' and 'str'
```

### Short example of type hint

We first briefly explain through an example. If we want to add information about the type to the function, we first need to set the type annotations for its parameters and return values as follows:

```python
# headlines.py

def headline(text: str, align: bool = True) -> str:
    if align:
        return f"{text.title()}\n{'-' * len(text)}"
    else:
        return f" {text.title()} ".center(50, "o")

print(headline("python type checking"))
print(headline("use mypy", centered=True))
```

However, adding type hints in this way has no runtime effect. If we use the wrong type of `align` parameter, the program can still run normally without reporting errors or warnings.

```bash
$ python headlines.py
Python Type Checking
--------------------
oooooooooooooooooooo Use Mypy oooooooooooooooooooo
```

Therefore, we need static checking tools to rule out such errors (for example, [PyCharm](https://www.jetbrains.com/pycharm/) includes this kind of checking). The most commonly used static type checking tool is [Mypy](http://mypy-lang.org/).

```bash
$ pip install mypy
Successfully installed mypy.

$ mypy headlines.py
Success: no issues found in 1 source file
```

If no error is reported, it means it has passed the type check; otherwise, the problem will be prompted. *It is worth noting that type checking can be downward (subtype not subclass) compatible. For example, integers can pass the floating point type annotation check in Mypy (int is the subtype of double, but not its subclass).*

This kind of inspection is very helpful for writing code that is more readable - Bernát Gábor once wrote in his [The State of Type Hints in Python](https://www.bernat.tech/the-state-of-type-hints-in-python/) said, "Type hints should appear in any code worthy of unit testing".

### Type annotation

Type annotation is a feature introduced since Python 3.0, and is an important way to add type hints. For example, this code introduces type annotations. You can view all type annotations in the function by calling `circumference.__annotations__`.

```python
import math

def circumference(radius: float) -> float:
    return 2 * math.pi * radius
```

Of course, in addition to functions, variables can also be type-annotated. You can view all type annotations in the function by calling `__annotations__`.

```python
pi: float = 3.142

def circumference(radius: float) -> float:
    return 2 * pi * radius
```

Variable type annotation gives Python the nature of a static language, that is, the separation of declaration and assignment:

```python
>>> nothing: str
>>> nothing
NameError: name 'nothing' is not defined

>>> __annotations__
{'nothing': <class 'str'>}
```

### Type comment

As mentioned above, Python's type annotation is only supported after 3.0, which means that if you need to write code that supports legacy Python, you cannot use annotation. In order to deal with this problem, you can try to use type comments, which is a special format of code comments, as a type hint for your code.

```python
import math

pi = 3.142  # type: float

def circumference(radius):
    # type: (float) -> float
    return 2 * pi * radius
  
def headline(text, width=80, fill_char="-"):
    # type: (str, int, str) -> str
    return f" {text.title()} ".center(width, fill_char)

def headline(
    text,           # type: str
    width=80,       # type: int
    fill_char="-",  # type: str
):                  # type: (...) -> str
    return f" {text.title()} ".center(width, fill_char)

print(headline("type comments work", width=40))
```

This kind of annotation is not included in the type annotation, and you can't find it through `__annotations__`. Like the type annotation, you can still get the type check result by running `Mypy`.

## Commonly used built-in libraries

Here are some built-in libraries that could be used to write algorithms. For specific usage, you can search or read [official documents](https://docs.python.org/3/library/index.html).

| package name                                                                      | usage             |
| ----------------------------------------------------------------------- | ---------------- |
|  [ `array` ](https://docs.python.org/3/library/array.html)              |  fixed-length array   |
|  [ `argparse` ](https://docs.python.org/3/library/argparse.html)        |    command line argument parsing     |
|  [ `bisect` ](https://docs.python.org/3/library/bisect.html)         | binary search   |
|  [ `collections` ](https://docs.python.org/3/library/collections.html)  | provide data structures such as ordered dictionaries and deques |
|  [ `fractions` ](https://docs.python.org/3/library/fractions.html)      |  rational number     |
|  [ `heapq` ](https://docs.python.org/3/library/heapq.html)           |   heap-based priority queue  |
|  [ `io` ](https://docs.python.org/3/library/io.html)    |     file stream, memory stream   |
|  [ `itertools` ](https://docs.python.org/3/library/itertools.html)      |       iterator related      |
|  [ `math` ](https://docs.python.org/3/library/math.html)                | commonly used mathematical functions  |
|  [ `os.path` ](https://docs.python.org/3/library/os.html)               |   system path related     |
|  [ `random` ](https://docs.python.org/3/library/random.html)            | random number             |
|  [ `re` ](https://docs.python.org/3/library/re.html)                    | regular expression    |
|  [ `struct` ](https://docs.python.org/3/library/struct.html)            |   convert structure and binary data    |
|  [ `sys` ](https://docs.python.org/3/library/sys.html)                  | system information            |

## Compare C++ and Python

You may have mastered most of OIers have mastered the syntax of C++98. Next we will show some applications of Python syntax.

The following example is the code of [Luogu P4779 "[Template] Single-source shortest path (standard version)" (original link in Chinese)](https://www.luogu.com.cn/problem/P4779). We will compare the C++ code with Python code:

We start by declaring some constants:

C++：

```cpp
#include <bits/stdc++.h>
using namespace std;
const int N = 1e5 + 5, M = 2e5 + 5;
```

Python：

```python
try:
    import Queue as pq #python version < 3.0
except ImportError:
    import queue as pq #python3.*

N = int(1e5 + 5)
M = int(2e5 + 5)
INF = 0x3f3f3f3f
```

Then declare the linked forward star structure and some other variables.

C++：

```cpp
struct qxx {
  int nex, t, v;
};
qxx e[M];
int h[N], cnt;
void add_path(int f, int t, int v) { e[++cnt] = (qxx){h[f], t, v}, h[f] = cnt; }

typedef pair<int, int> pii;
priority_queue<pii, vector<pii>, greater<pii>> q;
int dist[N];
```

Python：

```python
class qxx:  # Linked forward star (structure)
    def __init__(self):
        self.nex = 0
        self.t = 0
        self.v = 0

e = [qxx() for i in range(M)]  # linked list
h = [0 for i in range(N)]
cnt = 0

dist = [INF for i in range(N)]
q = pq.PriorityQueue()  # Define the priority queue, the default min heap

def add_path(f, t, v):  # Add edge to forward star
    # If you want to modify global variables, use global for statement
    global cnt, e, h
    # Output statement when debugging, multiple variables use tuples
    # print("add_path(%d,%d,%d)" % (f,t,v))
    cnt += 1
    e[cnt].nex = h[f]
    e[cnt].t = t
    e[cnt].v = v
    h[f] = cnt
```

Then there is the Dijkstra algorithm code for finding the shortest path:

C++：

```cpp
void dijkstra(int s) {
  memset(dist, 0x3f, sizeof(dist));
  dist[s] = 0, q.push(make_pair(0, s));
  while (q.size()) {
    pii u = q.top();
    q.pop();
    if (dist[u.second] < u.first) continue;
    for (int i = h[u.second]; i; i = e[i].nex) {
      const int &v = e[i].t, &w = e[i].v;
      if (dist[v] <= dist[u.second] + w) continue;
      dist[v] = dist[u.second] + w;
      q.push(make_pair(dist[v], v));
    }
  }
}
```

Python：

```python
def nextedgeid(u):  # Generator, can be used in for loop
    i = h[u]
    while i:
        yield i
        i = e[i].nex


def dijkstra(s):
    dist[s] = 0
    q.put((0, s))
    while not q.empty():
        u = q.get()  # The get function will also delete the corresponding element in the heap
        if dist[u[1]] < u[0]:
            continue
        for i in nextedgeid(u[1]):
            v = e[i].t
            w = e[i].v
            if dist[v] <= dist[u[1]]+w:
                continue
            dist[v] = dist[u[1]]+w
            q.put((dist[v], v))
```

Finally, the main function part.

C++：

```cpp
int n, m, s;
int main() {
  scanf("%d%d%d", &n, &m, &s);
  for (int i = 1; i <= m; i++) {
    int u, v, w;
    scanf("%d%d%d", &u, &v, &w);
    add_path(u, v, w);
  }
  dijkstra(s);
  for (int i = 1; i <= n; i++) printf("%d ", dist[i]);
  return 0;
}
```

Python：

```python
# If you run this python code directly (not called by the module), execute the command
if __name__ == '__main__':
    # Read multiple integers in one line. Note that it will read the entire line in
    n, m, s = map(int, input().split())
    for i in range(m):
        u, v, w = map(int, input().split())
        add_path(u, v, w)

    dijkstra(s)

    for i in range(1, n+1):
        # both syntax are ok
        print("{}".format(dist[i]), end=' ')
        # print("%d" % dist[i],end=' ')

    print()  # end in newline
```

The complete code is as follows:

??? note "C++"
    ```cpp
    #include <bits/stdc++.h>
    using namespace std;
    const int N = 1e5 + 5, M = 2e5 + 5;
    
    struct qxx {
      int nex, t, v;
    };
    qxx e[M];
    int h[N], cnt;
    void add_path(int f, int t, int v) { e[++cnt] = (qxx){h[f], t, v}, h[f] = cnt; }
    
    typedef pair<int, int> pii;
    priority_queue<pii, vector<pii>, greater<pii>> q;
    int dist[N];
    
    void dijkstra(int s) {
      memset(dist, 0x3f, sizeof(dist));
      dist[s] = 0, q.push(make_pair(0, s));
      while (q.size()) {
        pii u = q.top();
        q.pop();
        if (dist[u.second] < u.first) continue;
        for (int i = h[u.second]; i; i = e[i].nex) {
          const int &v = e[i].t, &w = e[i].v;
          if (dist[v] <= dist[u.second] + w) continue;
          dist[v] = dist[u.second] + w;
          q.push(make_pair(dist[v], v));
        }
      }
    }
    
    int n, m, s;
    int main() {
      scanf("%d%d%d", &n, &m, &s);
      for (int i = 1; i <= m; i++) {
        int u, v, w;
        scanf("%d%d%d", &u, &v, &w);
        add_path(u, v, w);
      }
      dijkstra(s);
      for (int i = 1; i <= n; i++) printf("%d ", dist[i]);
      return 0;
    }
    ```

??? note "Python"
    ```python
    try:
        import Queue as pq  # python version < 3.0
    except ImportError:
        import queue as pq  # python3.*
    
    N = int(1e5+5)
    M = int(2e5+5)
    INF = 0x3f3f3f3f
    
    class qxx:  # Linked forward star (structure)
        def __init__(self):
            self.nex = 0
            self.t = 0
            self.v = 0
    
    e = [qxx() for i in range(M)]  # Linked list
    h = [0 for i in range(N)]
    cnt = 0
    
    dist = [INF for i in range(N)]
    q = pq.PriorityQueue()  # Define the priority queue, the default min heap
    
    def add_path(f, t, v):  # Add edge to forward star
        # If you want to modify global variables, use global for statement
        global cnt, e, h
        # Output statement when debugging. Multiple variables use tuples
        # print("add_path(%d,%d,%d)" % (f,t,v))
        cnt += 1
        e[cnt].nex = h[f]
        e[cnt].t = t
        e[cnt].v = v
        h[f] = cnt
    
    def nextedgeid(u):  # Generator can be used in for loop
        i = h[u]
        while i:
            yield i
            i = e[i].nex
    
    def dijkstra(s):
        dist[s] = 0
        q.put((0, s))
        while not q.empty():
            u = q.get()
            if dist[u[1]] < u[0]:
                continue
            for i in nextedgeid(u[1]):
                v = e[i].t
                w = e[i].v
                if dist[v] <= dist[u[1]]+w:
                    continue
                dist[v] = dist[u[1]]+w
                q.put((dist[v], v))
    
    # If you run this python code directly (not called by the module), execute the command
    if __name__ == '__main__':
        # Read multiple integers in one line. Note that it will read the entire line in
        n, m, s = map(int, input().split())
        for i in range(m):
            u, v, w = map(int, input().split())
            add_path(u, v, w)
    
        dijkstra(s)
    
        for i in range(1, n+1):
            # Both output syntaxes are ok
            print("{}".format(dist[i]), end=' ')
            # print("%d" % dist[i],end=' ')
    
        print()  # end in newline
    ```

## References

1. Python Documentation, <https://www.python.org/doc/> 
2. Python Official Tutorial <https://docs.python.org/3/tutorial/> 
3. Learn Python3 In Y Minutes, <https://learnxinyminutes.com/docs/python3/> 
4. Real Python Tutorials, <https://realpython.com/> 
5. GeeksforGeeks: Python Tutorials, <https://www.geeksforgeeks.org/python-programming-language/> 
