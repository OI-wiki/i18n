[Bucket sort](https://en.wikipedia.org/wiki/Bucket_sort#:~:text=Bucket%20sort%2C%20or%20bin%20sort,applying%20the%20bucket%20sorting%20algorithm.) is suitable for cases where the range of data to be sorted is large but the distribution is relatively uniform. It is a sorting algorithm with an expected time complexity of $O(n)$ .

The general idea is to divide the range into blocks and sort each block separately. Since there are not many elements in each block, insertion sort is generally used. If a stable algorithm is used for inner sorting, and the relative order is not changed when the elements are inserted into the bucket, then the bucket sort is stable.

If the data to be sorted is randomly generated, the expected time complexity of dividing the range into $n$ blocks is $O(n)$ . The proof can be found in the [introduction to algorithms](https://en.wikipedia.org/wiki/Introduction_to_Algorithms) or [analysis of time complexity in wikipedia](https://en.wikipedia.org/wiki/Bucket_sort#Analysis).

C++ code:

```cpp
const int N = 100010;

int n, w, a[N];
vector<int> bucket[N];

void insertion_sort(vector<int>& A) {
  for (int i = 1; i < A.size(); ++i) {
    int key = A[i];
    int j = i - 1;
    while (j >= 0 && A[j] > key) {
      A[j + 1] = A[j];
      --j;
    }
    A[j + 1] = key;
  }
}

void bucket_sort() {
  int bucket_size = w / n + 1;
  for (int i = 0; i < n; ++i) {
    bucket[i].clear();
  }
  for (int i = 1; i <= n; ++i) {
    bucket[a[i] / bucket_size].push_back(a[i]);
  }
  int p = 0;
  for (int i = 0; i < n; ++i) {
    insertion_sort(bucket[i]);
    for (int j = 0; j < bucket[i].size(); ++j) {
      a[++p] = bucket[i][j];
    }
  }
}
```
