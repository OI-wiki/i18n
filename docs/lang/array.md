An array is a container for storing objects of the same type. The objects stored in the array cannot be accessed through their location name. Instead, they should be accessed through the indexes. The size of the array is fixed, and the length of the array cannot be changed at will.

## Array definition

The definition of an array is in the form of `a[d]`, where `a` is the name of the array, and `d` is the number of elements in the array. While compiling, `d` should be known, that is, `d` should be a fixed integer.

```cpp
unsigned int d1 = 42;
const int d2 = 42;
int arr1[d1];  // wrong: d1 is not a constant expression
int arr2[d2];  // correct: arr2 is an array of length 42
```

You cannot assign an array directly to another array:

```cpp
int arr1[3];
int arr2 = arr1;  // wrong
arr2 = arr1;      // wrong
```

It is suggested to try to define larger arrays as global variables. Because local variables will be created in the stack area, and an array that is too large (larger than the size of the stack) will cause stack overflow, leading to RE. If the array is declared in the global scope, the array will be created in the static area.

## Access array elements

The elements in the array can be accessed through the index operator `[]`. The index of the array (the value in square brackets) starts from 0. Taking an array of 10 elements as an example, its index is 0-9 instead of 1-10. But in OI, for ease of use, we usually expand the array a bit, and do not use the first element of the array. Instead, we access the array elements starting from index 1.

Example 1: Read an integer $n$ from standard input, then read $n$ numbers and store them in the array. Among them, it's guaranteed that $n\leq 1000$ .

```cpp
#include <iostream>
using namespace std;

int arr[1001];  // the index range of the array arr is [0, 1001)

int main() {
  int n;
  cin >> n;
  for (int i = 1; i <= n; ++i) {
    cin >> arr[i];
  }
}
```

Example 2: (Continued example 1) Sum the elements in the array `arr` and output the sum. it's guaranteed that the sum of all elements in the array is less than or equal to $2^{31}-1$ .

```cpp
#include <iostream>
using namespace std;

int arr[1001];

int main() {
  int n;
  cin >> n;
  for (int i = 1; i <= n; ++i) {
    cin >> arr[i];
  }

  int sum = 0;
  for (int i = 1; i <= n; ++i) {
    sum += i;
  }

  printf("%d\n", sum);
  return 0;
}
```

### Out-of-bound access to index

The index $\mathit{idx}$ of the array should satisfy $0\leq \mathit{idx}< \mathit{size}$ . If the index goes out of range, there may be unpredictable consequences, including causing segmentation fault, and modifying variables other than expected ones.

## Multidimensional Arrays

The essence of multidimensional array is "array of array", that is, the elements of outer array are arrays. The definition of two-dimensional array requires two dimensions: the length of the array and the length of the elements in the array. Two indexes need to be written when accessing a two-dimensional array:

```cpp
int arr[3][4];  // an array of the length of 3, and its elements are "the length of an int that is length of 4
arr[2][1] = 1;  // access two-dimensional array
```

We often use nested for loops to process two-dimensional arrays.

Example: Read two numbers $n$ and $m$ from the standard input, which represents the height and width of the black and white picture respectively, where $n,m\leq 1000$ . For the next $n$ rows of data, there are $m$ numbers separated by spaces in each row representing the brightness value at this position. Now we read this picture and store it in a two-dimensional array.

```cpp
const int maxn = 1001;
int pic[maxn][maxn];
int n, m;

cin >> n >> m;
for (int i = 1; i <= n; ++i)
  for (int j = 1; j <= n; ++j) cin >> pic[i][j];
```

Similarly, you can define three-dimensional, four-dimensional, or even arrays of higher dimensions. 