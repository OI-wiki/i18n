Endianness is the storage rule for program objects that cross multiple bytes, and represents the arrangement method of the bytes of an object.

There are two endianness: little endian and big endian.

In fact, there is no difference between these two endianness. The names of these two sequences (`little endian` and `big endian`) are exactly taken from the book "Gulliver's Travels". The reason for which the two factions can't stop fighting in the book is that they cannot agree on which end to break shell of the egg. And similar to the egg problem, the choice of endianness has become an argument unrelated to technical reasons.

Of course, the inconsistency of the endianness will cause the binary data to be reversed when transmitting between different types of machines. To avoid this, the network application has established a set of standards to ensure that the agreed network standard is used during the transmitting process, rather than the internal representation of different machines.

Below, we take a variable located at `0x100` with type `int` and hexadecimal value `0x01234567` as an example to introduce two endianness:

Here `0x01` is the most significant byte, and `0x67` is the least significant byte.

## Little endian

Little endian means that the machine chooses to store objects in the memory in the order from the **lowest** effective byte to the **highest** effective byte.

The variables mentioned above are expressed as follows:

| .... | 0x100 | 0x101 | 0x102 | 0x103 | .... |
| ---- | ----- | ----- | ----- | ----- | ---- |
| .... | 67    | 45    | 23    | 01    | .... |

## Big endian

Big endian means that the machine chooses to store objects in the memory in the order from the **highest** effective byte to the **lowest** effective byte.

The variables mentioned above are expressed as follows:

| .... | 0x100 | 0x101 | 0x102 | 0x103 | .... |
| ---- | ----- | ----- | ----- | ----- | ---- |
| .... | 01    | 23    | 45    | 67    | .... |

## Convention

Little endian: x86, ARM processors running Android, iOS, and Windows.

Big endian: Sun, PPC Mac, Internet.
