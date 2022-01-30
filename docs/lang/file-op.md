author: Ir1d, cqnuljs, akakw1, MingqiHuang, Chrogeek, henrytbtrue, Planet6174, StudyingFather

## Concept of files

File is a set of related data collected together according to a specific purpose. C/C++ regards every file as an ordered stream of bytes. Each file ends with **End of File** (EOF). If you want to manipulate a file, the program would first open the file. Whenever a file is opened (please also remember to close the opened file), the file is associated with a stream, which is actually a sequence of bytes.

C/C++ divides files into text files and binary files. Text files are simple text files(emphasis), and binary files are files with special formats or executable code.

## Operation steps of files

1. Open the file, point the file pointer to it, and decide to open the file type;
2. Read and write files (the main operations used in the OI; Some other operations will not be written temporarily);
3. After the file operation, close the file.

##  `freopen` function

### Function introduction

The function is used to redirect the specified input and output streams to the file in a specified way, and is included in the header file `stdio.h (cstdio)`. This function can change the input and output environment without changing the original code. However, it must ensure that the stream is reliable when used.

There are three main ways of the function: read, write and append.

### Command format

```cpp
FILE* freopen(const char* filename, const char* mode, FILE* stream);
```

### Description of parameters

-  `filename`: File name to be opened.
-  `mode`: File opening mode, indicating file access permissions.
-  `stream`: File pointer. It usually uses standard file stream (`stdin/stdout`) or standard error output stream (`stderr`).
- Return value: file pointer, pointing to the opened file.

### File opening format (optional)

-  `r`: Open the file in read-only mode. The file must exist, and data is only allowed to be read in **(common)**
-  `r+`: Open the file in read/write mode. The file must exist. Both reading and writing data are allowed.
-  `rb`: Open the binary file in read-only mode. The file must exist, and only reading data is allowed.
-  `rb+`: Open a binary file in read-write mode. The file must exist, and both reading and writing data is allowed.
-  `rt+`: Open the text file for reading and writing. Both reading and writing are allowed.
-  `w`: Open the file in write-only mode. If the file does not exist, a new file will be created, otherwise the content will be cleared and only data can be written **(common)**.
-  `w+`: Open the file in read/write mode. If the file does not exist, a new file will be created, otherwise the content will be cleared and the data can be read and written.
-  `wb`: Open the binary file in read-only mode. A new file will be created if the file does not exist, otherwise the content will be cleared and data can only be written in.
-  `wb+`: Open the binary file in read-write mode. If the file does not exist, a new file will be created. Otherwise the content will be cleared and the data can be read and written.
-  `a`: Open the write-only file in append mode. A new file will be created if the file does not exist, and the written data will be appended to the end of the file (retain the EOF character).
-  `a+`: Open the write-only file in append mode, a new file will be created if the file does not exist, and the written data will be appended to the end of the file (EOF character is not retained).
-  `at+`: Open the text file in read-write mode. The data written will be appended to the end of the file.
-  `ab+`: Open the binary file in read-write mode. The data written will be appended to the end of the file.

### Instructions

Read in the content of the file:

```cpp
freopen("data.in", "r", stdin);
// data.in: the name of the file to be read; It is in the same directory as the executable file.
```

Output to file:

```cpp
freopen("data.out", "w", stdout);
// data.out:  output name of the output file; it is in the same directory as the executable file.
```

Close the standard input/output stream:

```cpp
fclose(stdin);
fclose(stdout);
```

!!! Note
     Functions such as `printf/scanf/cin/cout` use `stdin/stdout` by default. After redirecting `stdin/stdout`, these functions will input/output to the directed file.

### Template

```cpp
#include <cstdio>
#include <iostream>
int main(void) {
  freopen("data.in", "r", stdin);
  freopen("data.out", "w", stdout);
  /*
  The code in the middle does not need to be changed, just use cin and cout directly
  */
  fclose(stdin);
  fclose(stdout);
  return 0;
}
```

##  `fopen` function (optional)

The function is almost the same as `freopen`. The function will open the specified file and return the pointer to the opened file.

### Function prototype

```cpp
FILE* fopen(const char* path, const char* mode)
```

All parameters have the same meaning as `freopen`. 

### Available read and write functions (basic)

-  `fread/fwrite` 
-  `fgetc/fputc` 
-  `fscanf/fprintf` 
-  `fgets/fputs` 

### Instructions

```cpp
FILE *in, *out;  // define file pointer
in = fopen("data.in", "r");
out = fopen("data.out", "w");
/*
do what you want to do
*/
fclose(stdin);
fclose(stdout);
```

## `ifstream/ofstream` file input and output stream in C++

### Instructions

Read in the file content:

```cpp
ifstream fin("data.in");
// data.in: read the relative/absolute position of the file
```

Output to file:

```cpp
ofstream fout("data.out");
// data.out: output the relative/absolute position of the file
```

Close the standard input/output stream:

```cpp
fin.close();
fout.close();
```

### Template

```cpp
#include <cstdio>
#include <fstream>
ifstream fin("data.in");
ofstream fout("data.out");
int main(void) {
  /*
  The code in the middle changes cin to fin and cout to fout.
  */
  fin.close();
  fout.close();
  return 0;
}
```


## References

- XINXIXUE AOSAI YIBENTONG(One pass to Informatics Olympiad)