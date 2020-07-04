This page mainly shares the mistakes commonly made in the competition.

## Could Cause Compile Error

We left the detailed explanation out since this type of errors is pretty straightforward and self-explanatory.

-   Use `int mian()` instead of `int main()` .

-   Forget to write a semicolon after `struct` or `class`.

-   If the array size is too large, or an illegal function (such as multithreading) is used on OJ, or the function is declared but undefined, it will cause the `LinkError`.

-   When using the `max` function in `algorithm`, one parameter type is defined as `int` and the other one is defined as `long long`.
    -   Example:
        ```cpp
        printf("%lld\n", max(0, query(1, 1, n, l, r)); // query returns long long type
        ```

-    Skipped the initialization of some local variables while `goto`.

    -    Skipped the initialization of some local variables while `switch-case`.

## Does not cause Compile Error but will cause Warning error

This kind of error is hard to find, but it will be pointed out by the compiler when compiling with the `-W{warningtype}` parameter. You should familiarize yourself with the [Warning Options](https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html). Common ones in `-W{warningtype}` include `-Wall`, `- Wextra`, `-Wshadow`, etc.

-   Error caused by operator priority.
    -    `1 << 1 + 1` : 1 is shifted to the left by 2, that is, the value returned by the expression is 4.

-   The `static` modifier is used incorrectly.

-    `-1 >> 1 == 1`

-   Cannot distinguish between assignment operator and `==`.
    -   Example:
            ```cpp
            if (n = 1)
              puts("Yes");
            else
              puts("No");
            ```
            No matter what the previous value of `n` was, the output must be `Yes`.
        **Tips**: If you really want to use the assignment operator (such as `while (foo = bar)`) directly in `if` / `while`, and you do not want to receive Warning, you can use **double brackets**: `while ((foo = bar))`.

-   When reading using `scanf`, the address character `&` is not added. More generally, when using `scanf` or `printf`, the parameter type does not match the format specifier.

-   Did not consider the case where the array index appears negative.

-   Use both bitwise and logical operators (`==`) without parentheses (eg `(x>>j)&3==2` ).

-   `int` literal overflow, for example: `long long x = 0x7f7f7f7f7f7f7f7f`, `1<<62`.

-   Uninitialized local variables, causing local variables to be assigned with initial garbage values.

-   The local and global variables have the same name, causing the global variables to be accidentally overwritten. (Open `-Wshadow` to check for such errors.)

## Neither causes Compile Error nor Warning error

Such errors cannot be discovered by the compiler, so you need to rely on yourself when debugging.

### Could Cause WA

-   Multiple sets of data have not cleared the array.

-   Reading optimization forgets to check negative numbers.

-   The data type used is not large enough, causing overflow, which means that because the usage of `long long` (opening `long long`) leads to losing huge points.

-   When saving the graph, the node number starts from 0, and the number of the two endpoints in the edge starts from 1, and forgets -1 when reading it.

-   > or < sign are wrong or reversed.

-   After executing `ios::sync_with_stdio(false);`, the usage of two IOs are mixed, resulting in messy input/output.
    -   Example:
        ```cpp
        // This example will illustrate the consequences of mixing two IOs after turning off synchronization with stdio
        // It is recommended to use single-step operation to observe the effect
        #include <cstdio>
        #include <iostream>
        int main() {
          std::ios::sync_with_stdio(false);
          // After the synchronization is turned off, 
          // cin/cout will use a separate buffer 
          // instead of synchronizing the output to the scanf/printf buffer, 
          // thereby reducing IO time
          std::cout << "a\n";
          // In cout, when using'\n' line feed, 
          // the content will be buffered and not output immediately. 
          // You should use endl to wrap and refresh the buffer immediately
          printf("b\n");
          // printf'\n' will flush printf's buffer, causing the output to be misplaced
          std::cout << "c\n";
          return 0;  // At the end of the program, the buffer of cout will be output
        }
        ```
    -   In particular, you cannot use `freopen` after executing `ios::sync_with_stdio(false);`.

-   Errors caused by macro expansion without parentheses:
    ```cpp
    #define square(x) x* x
    printf("%d", square(2 + 2));
    ```
    The value returned by this macro is not $4^2 = 16$ but $2+2\times 2+2 = 8$.

-   When hashing, `unsigned` is not used, because the right shift operation for negative numbers will be complemented by 1 at the highest bit. For details, see [Bit Operation](../math/bit.md) 

-   Forgets to delete the debugging information.

-   Add `;` by mistake.
    -   Example:
        ```cpp
        /* clang-format off */
        while (1);
            printf("OI Wiki!\n");
        ```

-   The sentinel value is not set correctly. For example, the `0` node of a balanced tree.

-   In the constructor of a class or structure, use `:` to initialize the variable, and the variable declaration order does not meet the dependency at the time of initialization. Because the order of initialization of member variables is only related to the order in which they are declared in the class, not the order in the initialization list.

-   When merging two union-find sets, forgets to merge the ancestors of the two elements;

```cpp
f[a] = b;              // right
f[find(a)] = find(b);  // wrong
```

### Could Cause RE

-   Divide the integer by $0$.
    -  Reverse $0$.

-   Forgets file deletion operation (for some OJ).

-   Errors in comparison functions when sorting. `std::sort` requires comparison functions to be strictly weakly ordered: `a<a` is `false`; if `a<b` is `true`, then `b<a` is `false`; if `a<b` is `true` and `b<c` is` true`, then `a<c` is `true`. Pay special attention to the second point.
    If the above requirements are not met, it is likely to be RE when sorting.
    For example, when writing the parity order of the Mo's Algorithm, this is wrong:
    ```cpp
    bool operator<(const int a, const int b) {
      if (block[a.l] == block[b.l])
        return (block[a.l] & 1) ^ (a.r < b.r);
      else
        return block[a.l] < block[b.l];
    ```
    In the above code, `(block[a.l]&1)^(a.r<b.r)` does not meet the strict weak order requirement 2.
    Changed to this would be correct.
    ```cpp
    bool operator<(const int a, const int b) {
      if (block[a.l] == block[b.l])
        return (block[a.l] & 1) ? (a.r < b.r) : (a.r > b.r);
      else
        return block[a.l] < block[b.l];
    ```

-   Dereference of the null pointer.

### Could Cause TLE

-   Divide and conquer without boundary check leads to recursion.

-   Dead loop:

    -   Use the same name for the loop variable.

    -   The direction of circulation is reversed.

-   BFS does not mark whether a state has been visited.

-   Use macro expansion to write min/max.

    Although this approach technically is not an "error", it still needs to be mentioned here.

    The common way of writing looks like this:

    ```cpp
    #define Min(x, y) ((x) < (y) ? (x) : (y))
    #define Max(x, y) ((x) > (y) ? (x) : (y))
    ```

    Although there is no problem in the correctness of this writing, if you directly take the max of the return value of the function, such as `a = Max(func1(), func2())`, and the running time of this function is longer, the performance of the program will be greatly affected. Because after the macro expanded, it will be `a = func1()> func2()? Func1(): func2()`. The function is called three times, which is called once more than the normal max function.

    This kind of error is especially common when a beginner writes a segment tree, which will greatly increase the running time of the program and even directly affect the time complexity of the code. For example, this error code:

    ```cpp
    #define max(x, y) ((x) > (y) ? (x) : (y))

    int query(int t, int l, int r, int ql, int qr) {
      if (ql <= l && qr >= r) {
        ++ti[t];  // Record the number of node visits for easy testing
        return vi[t];
      }

      int mid = (l + r) >> 1;
      if (mid >= qr) {
        return query(lt(t), l, mid, ql, qr);
      }
      if (mid < ql) {
        return query(rt(t), mid + 1, r, ql, qr);
      }
      return max(query(lt(t), l, mid, ql, qr), query(rt(t), mid + 1, r, ql, qr));
    }
    ```

    Will be stuck to a single query $\Theta(n)$ leading to TLE.

-   Forgets file deletion operation (for some OJ).

-    `for (int i = 0; i < strlen(s); ++i)`: Repeatedly execute functions with complexity other than $O(1)$ in the loop. (Strictly speaking, this may cause a change in time complexity.)

### Could Cause MLE

-   The array is too large.

-   Too many elements are inserted in the STL container.

    -   It is often an endless loop that inserts elements into the STL.

    -   It may also be stuck.

###  [Undefined behavior](https://en.cppreference.com/w/cpp/language/ub) 

-   The array is out of bounds. Both count up and down. (Mostly RE.)

    -   Fail to set the initial value of the loop correctly, leading to the access to the value with index -1.

    -   The undirected graph edge table is not declared twice the size.

    -   The segment tree does not declare 4 times the space.

    -   Reading the data range wrong, miss a zero in declaration.

    -   Miscalculate the space complexity of the algorithm.

    -   When writing a segment tree, `pushup` or `pushdown` leaf nodes.

-   Dereference wild pointers.

    -   The pointer is dereferenced without initialization.

    -   The area pointed to by the pointer is already `free` or `delete`.

### Cause constant to be too large

-   When defining the modulus, a global variable (such as `int mod = 998244353` is used. For the convenience of compiler processing by constants, the correct practice is `const int mod = 998244353` ).

-   Unnecessary recursion is used (note that tail recursion is not included).

-   When converting recursion into iteration, a lot of extra operations are introduced.

### Errors that only take effect when the program is running locally

-   Errors that may occur during file operations:

    -   If the file pointer is not cleared during the beat, that is, `fclose(fp)`, then `fp = fopen()`, which will cause a large number of file pointers in the process.

    -    The file names in `freopen()` are not added with `.in` / `.out`.

-   Forget about `delete` or `free` while using the heap space. 
