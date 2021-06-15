import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:algo_visualizer_analyzer/Constants/constants.dart';
import 'package:algo_visualizer_analyzer/Widgets/glowing_avatar.dart';
import 'package:algo_visualizer_analyzer/Widgets/analyzer_card.dart';

class SortingAnalyzer extends StatefulWidget {
  static const String id = 'SortingAnalyzer';

  @override
  _SortingAnalyzerState createState() => _SortingAnalyzerState();
}

class _SortingAnalyzerState extends State<SortingAnalyzer> {
  String? answer;
  List<double> arr = [];
  final _formKey = GlobalKey<FormState>();
  int bubble = 0;
  int insertion = 0;
  int quick=0;
  int merge=0;
  int selection=0;

  _bubbleSort() async{
    List<double> a = [];
    for (int i = 0; i < arr.length; i++) a.add(arr[i]);

    Stopwatch stopwatch1 = new Stopwatch()..start(); //Starting Stopwatch starts immediately after allocation

    for (var i = 0; i < a.length; i++) {
      bool swapped = false;
      for (var j = i + 1; j < a.length; j++) {
        if (a[i] > a[j]) {
          var tmp = a[i];
          a[i] = a[j];
          a[j] = tmp;
          swapped = true;
        }
      }
      if (!swapped) break;
    }
    int stop = stopwatch1.elapsedMicroseconds; //stopping stopwatch
      bubble = stop;
  }

  _insertionSort() async{
    List<double> a = [];
    for (int i = 0; i < arr.length; i++) a.add(arr[i]);

    Stopwatch stopwatch1 = new Stopwatch()..start();
    for (var i = 0; i < a.length; i++) {
      var x = a[i], j = i;

      while (j > 0 && a[j - 1] > x) {
        a[j] = a[j - 1];
        a[j - 1] = x;
        j--;
      }

      a[j] = x;
    }
    int stop = stopwatch1.elapsedMicroseconds;
    insertion=stop;
  }

  _selectionSort ()async
  {
    List<double> a = [];
    for (int i = 0; i < arr.length; i++) a.add(arr[i]);


    Stopwatch stopwatch1 = new Stopwatch()..start();

    int i, j, minIdx;

    // One by one move boundary of unsorted subarray
    for (i = 0; i < a.length-1; i++)
    {
      // Find the minimum element in unsorted array
      minIdx = i;
      for (j = i+1; j < a.length; j++)
        if (a[j] < a[minIdx])
          minIdx = j;

      // Swap the found minimum element with the first element
      double temp =a[i];
      a[i]=a[minIdx];
      a[minIdx]=temp;
    }

    int stop = stopwatch1.elapsedMicroseconds; //stopping stopwatch
    print(stop);
    selection=stop;
  }

  cf(double a, double b) {
    if (a < b) {
      return -1;
    } else if (a > b) {
      return 1;
    } else {
      return 0;
    }
  }

  _quicksort() async
  {

    List<double> a = [];
    for (int i = 0; i < arr.length; i++) a.add(arr[i]);

    Stopwatch stopwatch1 = new Stopwatch()..start();
    _quickSort(int leftIndex, int rightIndex) async {
      Future<int> _partition(int left, int right) async {
        int p = (left + (right - left) / 2).toInt();

        var temp = a[p];
        a[p] = a[right];
        a[right] = temp;

        int cursor = left;

        for (int i = left; i < right; i++) {

          if (cf(a[i], a[right]) <= 0) {
            var temp = a[i];
            a[i] = a[cursor];
            a[cursor] = temp;
            cursor++;

          }
        }

        temp = a[right];
        a[right] = a[cursor];
        a[cursor] = temp;
        return cursor;
      }

      if (leftIndex < rightIndex) {
        int p = await _partition(leftIndex, rightIndex);
        await _quickSort(leftIndex, p - 1);
        await _quickSort(p + 1, rightIndex);
      }
    }
    int stop = stopwatch1.elapsedMicroseconds; //stopping stopwatch
    quick=stop;
  }


  _mergesort() async
  {
    List<double> a = [];
    for (int i = 0; i < arr.length; i++) a.add(arr[i]);

    Stopwatch stopwatch1 = new Stopwatch()..start();

    _mergeSort(int leftIndex, int rightIndex) async {
      Future<void> merge(int leftIndex, int middleIndex, int rightIndex) async {
        int leftSize = middleIndex - leftIndex + 1;
        int rightSize = rightIndex - middleIndex;

        List leftList =List.filled(leftSize, null, growable: false);
        List rightList = List.filled(rightSize, null, growable: false);

        for (int i = 0; i < leftSize; i++) leftList[i] = a[leftIndex + i];
        for (int j = 0; j < rightSize; j++) rightList[j] = a[middleIndex + j + 1];

        int i = 0, j = 0;
        int k = leftIndex;

        while (i < leftSize && j < rightSize) {
          if (leftList[i] <= rightList[j]) {
            a[k] = leftList[i];
            i++;
          } else {
            a[k] = rightList[j];
            j++;
          }

          k++;
        }

        while (i < leftSize) {
          a[k] = leftList[i];
          i++;
          k++;

        }

        while (j < rightSize) {
          a[k] = rightList[j];
          j++;
          k++;

     }
      }

      if (leftIndex < rightIndex) {
        int middleIndex = (rightIndex + leftIndex) ~/ 2;

        await _mergeSort(leftIndex, middleIndex);
        await _mergeSort(middleIndex + 1, rightIndex);

        await merge(leftIndex, middleIndex, rightIndex);
      }
    }

    int stop = stopwatch1.elapsedMicroseconds; //stopping stopwatch
    merge = stop;
  }




  bool validationLogic(String? value) {
    //print(value);
    if (value == null || value.length == 0) return false;
    List<String> val = value.split(',');

    for (String ans in val) {
      try {
        double.parse(ans);
      } catch (error) {
        return false;
      }
    }
    return true;
  }

  void generateArray(String? answer) {
    if (answer == null) return;
    arr.clear();
    List<String> val = answer.split(',');
    for (String ans in val) {
      arr.add(double.parse(ans));
    }
    //print(arr);
  }

  _start() async{
    await _bubbleSort();
    await _insertionSort();
    await _quicksort();
    await _selectionSort();
    await _mergesort();
    await _bubbleSort();
    await _insertionSort();
    await _quicksort();
    await _selectionSort();
    await _mergesort();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //print(name);
    final screenDetails = MediaQuery.of(context);
    final screenHeight = screenDetails.size.height;
    final screenWidth = screenDetails.size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Sorting Algorithm Analyzer'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Avatar(screenWidth: screenWidth,image: 'assets/sort.png',),
              Form(
                key: _formKey,
                child: TextFormField(
                  //style: ,
                  //obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    answer = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your Array separated with commas',
                  ),
                  validator: (String? value) {
                    return validationLogic(value)
                        ? null
                        : 'Please Enter Valid input';
                  },
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                alignment: Alignment.center,
                width: screenWidth / 2,
                height: screenHeight / 13,
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      generateArray(answer);
                      _start();
                      //print(arr);
                    }
                  },
                  icon: Expanded(
                    child: FittedBox(
                      child: Icon(Icons.sort),
                    ),
                  ),
                  label: Expanded(
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text('Analyze'),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              AnalyzerCard(screenWidth: screenWidth, time: bubble, title: 'Bubble'),
              AnalyzerCard(screenWidth: screenWidth, time: selection, title: 'Selection'),
              AnalyzerCard(screenWidth: screenWidth, time: insertion, title: 'Insertion'),
              AnalyzerCard(screenWidth: screenWidth, time: merge, title: 'Merge'),
              AnalyzerCard(screenWidth: screenWidth, time: quick, title: 'Quick'),
            ],
          ),
        ),
      ),
    );
  }
}


