Shell sort is named after its inventor, also known as reduced incremental sorting. Shell sorting compares and moves non-adjacent records:

1. Divide the sequence to be sorted into several subsequences (the elements of each subsequence have the same spacing in the original array)
2. Perform insertion sort on these subsequences
3. Reduce the spacing between elements in each subsequence and repeat the above process until the spacing is reduced to 1

The complexity of the shell sort is related to the selection of the spacing sequence (that is, how the spacing is reduced to 1). For example, the complexity of the shell sorting of "spacing divided by 3 each time" is $O(n^{3/2})$ .