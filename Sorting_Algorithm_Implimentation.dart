///Program:  Sorting Algorithm Implimentation
///Author:  Justin Monubi Ogenche

import 'dart:math';

// Quick Sort Implementation
void quickSort(List<int> list, int low, int high) {
  if (low < high) {
    int pi = partition(list, low, high);

    quickSort(list, low, pi - 1); // Before pi
    quickSort(list, pi + 1, high); // After pi
  }
}

int partition(List<int> list, int low, int high) {
  int pivot = list[high];
  int i = (low - 1);

  for (int j = low; j < high; j++) {
    if (list[j] <= pivot) {
      i++;
      _swap(list, i, j);
    }
  }
  _swap(list, i + 1, high);
  return i + 1;
}

void _swap(List<int> list, int i, int j) {
  int temp = list[i];
  list[i] = list[j];
  list[j] = temp;
}

// Bubble Sort Implementation
void bubbleSort(List<int> list) {
  int n = list.length;
  for (int i = 0; i < n - 1; i++) {
    for (int j = 0; j < n - i - 1; j++) {
      if (list[j] > list[j + 1]) {
        _swap(list, j, j + 1);
      }
    }
  }
}

// Generate a random list of integers
List<int> generateRandomList(int length) {
  Random random = Random();
  return List.generate(length, (index) => random.nextInt(1000));
}

void main() {
  // Measure the execution time of Quick Sort
  List<int> quickSortList = generateRandomList(1000);
  Stopwatch stopwatch = Stopwatch()..start();
  quickSort(quickSortList, 0, quickSortList.length - 1);
  stopwatch.stop();
  print('Quick Sort time: ${stopwatch.elapsedMilliseconds} ms');

  // Measure the execution time of Bubble Sort
  List<int> bubbleSortList = generateRandomList(1000);
  stopwatch = Stopwatch()..start();
  bubbleSort(bubbleSortList);
  stopwatch.stop();
  print('Bubble Sort time: ${stopwatch.elapsedMilliseconds} ms');
}
