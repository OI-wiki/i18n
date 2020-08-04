## String matching problem

### Single string match

There are a pattern string (pattern), and a string to be matched. We need to find all occurrences of the former in the latter.

### Multi-string matching

There are multiple pattern strings, and one string to be matched (multiple strings to be matched can be directly concatenated).

It is certainly possible to treat it as a single string matching problem, but the efficiency is not good enough.

### Other types of string matching problems

For example, match any suffix of one string, and match any suffix of multiple strings, etc.

## Brute force solution

For each position, try to compare the pattern string with the string to be matched.

Template Code:

(pseudocode)

```cpp
std::vector<int> match(char *a, char *b, int n, int m) {
  std::vector<int> ans;
  for (i = 0; i < n - m + 1; i++) {
    for (j = 0; j < m; j++) {
      if (a[i + j] != b[j]) break;
    }
    if (j == m) ans.push_back(i);
  }
  return ans;
}
```

Time complexity analysis:

The worst time complexity is $O(nm)$ , and the best is $O(n)$ .

If the size of the character set is greater than 1 (there exists at least two different characters), the average time complexity is $O(n)$ . But in OI problems, the strings given are generally not purely random.

## Hash method

See [Hash](./hash.md)

## KMP Algorithm

See [KMP](./kmp.md)