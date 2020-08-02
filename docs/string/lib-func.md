author: Frankaiyou, henrytbtrue

# Strings in the C/C++ Standard Library

## Standard library in C

The C standard library operates on character arrays

###  `strlen` 

 `int strlen(const char *str)`: returns the number of characters from `str[0]` to `'\0'`. Note that when O2 optimization is not used, the time complexity of this operation in the loop condition is $\Theta(N)$ .

###  `printf` 

 `printf("%s", s)`: uses `%s` to output a string (character array).

###  `scanf` 

 `scanf("%s", s)`: uses `%s` to read a string (character array).

###  `sscanf` 

 `sscanf(const char *__source, const char *__format, ...)`: reads variables from the string `__source`, such as `sscanf(str,"%d",&a)`.

###  `sprintf` 

 `sprintf(char *__stream, const char *__format, ...)`: outputs the content in the `__format` string to `__stream`, such as `sprintf(str,"%d",i)`.

###  `strcmp` 

 `int strcmp(const char *str1, const char *str2)`: compares `str1` and `str2` in lexicographic order. If `str1` is lexicographically smaller, the function returns a negative value; if it's the same, the function returns 0; otherwise, it returns a positive value. Please note that don't simply assume that there are only three types which are `0, 1, -1`. The values returned on different platforms all follow the positive/negative rule, but they are not necessarily all `0, 1, -1`.

###  `strcpy` 

 `char *strcpy(char *str, const char *src)`: copies the characters in `src` to `str`. `str` and `src` are all head pointers of the char arrays, and the value returned is `str` containing null terminator `'\0'`.

###  `strncpy` 

 `char *strncpy(char *str, const char *src, int cnt)`: copies at most `cnt` characters to `str`. If `src` terminates and the number is smaller than `cnt`, write null characters to `str` until a total of `cnt` characters are written.

###  `strcat` 

 `char *strcat(char *str1, const char *str2)`: concatenates `str2` to the end of `str1`, replaces `'\0'` at the end of `str1` with `*str2`, and return `str1`.

###  `strstr` 

 `char *strstr(char *str1, const char *str2)`: if `str2` is a substring of `str1`, the function returns the address of the first occurrence of `str2` in `str1`; if `str2` is not a substring of `str1`, it returns `NULL`.

###  `strchr` 

 `char *strchr(const char *str, int c)`: the function finds and returns the position where the character `c` first appears in the string `str`. If the character is not found, it returns `NULL`.

###  `strrchr` 

 `char *strrchr(const char *str, char c)`: the function finds and returns the position where the character `c` last appears in the string `str`. If the character is not found, it returns `NULL`.

## C++ standard library

The C++ standard library operates on string objects and also provides compatibility with character arrays.

###  `std::string` 

-   The right side of the assignment operator `=` can be `const string/string/const char*/char*` 。
-   The access operator `[cur]` returns a reference to the position of `cur`.
-   The access function `data()/c_str()` returns a `const char*` pointer with the same content as `string`.
-   The capacity function `size()` returns the number of characters in a string.
-   There are other functions like `find()` for finding and returning the position of the character.
-   `std::string` overloads the comparison logic operator, and the time complexity is $\Theta(N)$ .
