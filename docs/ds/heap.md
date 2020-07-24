author: ouuan

A [heap](https://en.wikipedia.org/wiki/Heap_(data_structure)) is a tree, each node of which has a key value. The value of each node is greater than or equal to/less than or equal to the value of its parent.

The heap whose value of each node is greater than or equal to its parent value is called the min heap, otherwise it is called the max heap. The `priority_queue` in [STL](https://en.cppreference.com/w/cpp/container/priority_queue) is actually a max heap.

The main operations supported by the (min) heap are: insert a number, query the minimum value, delete the minimum value, merge two heaps, and reduce the value of an element.

Some powerful heaps (parallel heaps) can also (efficiently) support operations such as merge.

Some more powerful heaps also support persistence, that is, to query or operate on any historical version to generate a new version.

## Types of Heap

|         Operation\data structure        |                                    Pairing heap                                    |       Binary heap     |      Leftist tree      |       Binomial heap      |     Fibonacci heap     |
| :---------------------: | :-----------------------------------------------------------------------: | :------------: | :------------: | :------------: | :-----------: |
|        insert       |                                   $O(1)$                                  |   $O(\log n)$  |   $O(\log n)$  |     $O(1)$     |     $O(1)$    |
|     find-min     |                                   $O(1)$                                  |     $O(1)$     |     $O(1)$     |   $O(\log n)$  |     $O(1)$    |
|    delete-min    |                                $O(\log n)$                                |   $O(\log n)$  |   $O(\log n)$  |   $O(\log n)$  |  $O(\log n)$  |
|        merge       |                                   $O(1)$                                  |     $O(n)$     |   $O(\log n)$  |   $O(\log n)$  |     $O(1)$    |
| decrease-key |  $o(\log n) (Lower bound\Omega(\log \log n) ，\\\\Upper bound O(2^{2\sqrt{\log \log n}}) )$  |   $O(\log n)$  |   $O(\log n)$  |   $O(\log n)$  |     $O(1)$    |
|         Whether to support persistence        |                                  $\times$                                 |  $\checkmark$  |  $\checkmark$  |  $\checkmark$  |    $\times$   |

Traditionally, when referring to "heap" without any restrictions, we are referring to a binary heap.