## Hash table

[Hash table](https://en.wikipedia.org/wiki/Hash_table), also known as hash map, is a data structure that stores data in the form of "key-value", which means that any key corresponds uniquely to a certain location in memory. You only need to enter the searched value key to quickly find its corresponding value. The hash table can be understood as a kind of advanced array. The index of this array can be a large integer, a floating point number, a string, or even a structure.

## Hash function

To make the key correspond to the location in the memory, it is necessary to calculate the index for the key, that is, calculate where it should be placed. The function that calculates the index based on the key is called the [hash function](https://en.wikipedia.org/wiki/Hash_function). For example, if the key is a person's ID number, the hash function can be the last four digits of the number, or the first four digits. The "tail of phone number" commonly used in life can also be a hash function. In actual applications, the key could be more complex, such as floating-point numbers, strings, and structures, etc. At this time, it is necessary to design a suitable hash function according to the specific situation. The hash function should be easy to calculate, and the calculated index should be as evenly distributed as possible.

In OI, the most common case is using key as an integer. When the range of the key is relatively small, you can directly use it as the index of the array, but when the range is relatively large, such as using an integer in the range of $10^9$ as the key, a hash table is needed. Generally, the key modulo a larger prime number is used as the index, that is, $f(x)=x \bmod M$ is used as the hash function. Another common situation is when the key is a string. In OI, the general case is that string is not directly used as the key, but the hash value of the string is calculated first, and then the hash value is inserted into the hash table as the key.

After we calculate the index for the key, we can know where each value should be placed. Suppose we use array $a$ to store data, and the hash function is $f$, then the key-value pair $(\text{key}, \text{value})$ should be placed on $a[f(\text{key})]$. No matter what type of key is and how large the range is, $f(\text{key})$ is an integer within the acceptable range and can be used as the index of the array.

## Hash collision

If the index calculated by the hash function is different for any key, then just put (key, value) in the corresponding position according to the index. But in fact, there are often two different keys, but their indexes calculated by the hash function are the same. At this time, we would need some methods to deal with collisions. In OI, the most commonly used one is the zipper method.

### Zipper method

Zipper method can also be called open hashing.

The zipper method is to create a linked list in each place where data is stored. If there are multiple keys with the same index, just put them all in the linked list at that location. When querying, you need to scan the entire linked list at the corresponding location, and compare whether the key is consistent with the query key for each data. If the range of the index is 1~M and the size of the hash table is N, then an insert/query needs to perform comparisons in expected time complexity of $O(\frac{N}{M})$ .

### Closed hashing 

The closed hashing method stores all records directly in the hash table. If there is a collision, it will continue probing in a certain way.

For example, linear probing method: if there is a conflict at `d`, check `d+1`, `d+2` in turn...

## Implementation

### Zipper method

```cpp
const int SIZE = 1000000;
const int M = 999997;
struct HashTable {
  struct Node {
    int next, value, key;
  } data[SIZE];
  int head[M], size;
  int f(int key) { return key % M; }
  int get(int key) {
    for (int p = head[f(key)]; p; p = data[p].next)
      if (data[p].key == key) return data[p].value;
    return -1;
  }
  int modify(int key, int value) {
    for (int p = head[f(key)]; p; p = data[p].next)
      if (data[p].key == key) return data[p].value = value;
  }
  int add(int key, int value) {
    if (get(key) != -1) return -1;
    data[++size] = (Node){head[f(key)], value, key};
    head[f(key)] = size;
    return value;
  }
};
```

Here we will provide you with a encapsulated template. It can be used like a map and is shorter.

```cpp
struct hash_map {  // hash table template
  struct data {
    long long u;
    int v, nex;
  };                // forward star list: see reference below
  data e[SZ << 1];  // SZ is a const int representing the size
  int h[SZ], cnt;
  int hash(long long u) { return u % SZ; }
  int& operator[](long long u) {
    int hu = hash(u);  // get head pointer
    for (int i = h[hu]; i; i = e[i].nex)
      if (e[i].u == u) return e[i].v;
    return e[++cnt] = (data){u, -1, h[hu]}, h[hu] = cnt, e[cnt].v;
  }
  hash_map() {
    cnt = 0;
    memset(h, 0, sizeof(h));
  }
};
```

> [forward star list](https://zh.wikipedia.org/wiki/%E9%93%BE%E5%BC%8F%E5%89%8D%E5%90%91%E6%98%9F) is a data structure used to store graph. It was named by [Malash](https://malash.me/200910/linked-forward-star/) but the actual inventor of the algorithm remains unknown.

To explain, the hash function is designed for the type of key and returns a linked list head pointer for query. In this template, we write a hash table of the type like $\text{(long long , int)}$ , and initialize the corresponding val to -1 when a key does not exist. The hash_map() function is initialized when it is defined.

## Sample problem

 [「JLOI2011」non-repeating number](https://www.luogu.com.cn/problem/P4305) (original link in Chinese)
