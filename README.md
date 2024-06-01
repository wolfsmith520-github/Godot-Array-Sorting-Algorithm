# Godot Array Sorting Algorithm
 This is an attempt to use classic sorting algorithm to sort arrays in godot 4.
 
 I started learning sorting algorithm in collage, so I decide to put my knowledge to good use.

 I am not a good programmer currently, and feel free to pull request to help make this project better.

 ## What is in the project
 Currently there are 6 sorting algorithm, all of them have ascending sort and descending sort, you cancheck the DES on the HUD to switch.

 ### [Quick Sort](https://en.wikipedia.org/wiki/Quicksort)
 Good old and the best sorting algorithm
 Worst-case performance: {\displaystyle O(n^{2})}
 ### [Bubble Sort](https://en.wikipedia.org/wiki/Bubble_sort)
 Very easy to achieve this algorithm but the performance sometimes are very bad

 ### [Insertion Sort](https://en.wikipedia.org/wiki/Insertion_sort)
 Good for small array bad for large array

 ### [Binary Insertion Sort](https://en.wikipedia.org/wiki/Insertion_sort)
 Just insertion sort, but a little bit faster

 ### [Selection Sort](https://en.wikipedia.org/wiki/Selection_sort)
 An in-place comparison sorting algorithm. It inefficient on large lists, and generally performs worse than the similar insertion sort. 

 ### [Heap Sort](https://en.wikipedia.org/wiki/Heapsort)
 heapsort is a comparison-based sorting algorithm which can be thought of as "an implementation of selection sort using the right data structure."

 ## About the Timer
 Since GDscript is base on Python, doing large add is so slow, the timer's result only contain the time used to sort, so if the game freeze, it's most likely Godot's fault (lol)
