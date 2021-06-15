import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math';

class SortingVisualization extends StatefulWidget {

  static const String id='SortingVisualization';

  const SortingVisualization({Key? key}) : super(key: key);

  @override
  _SortingVisualizationState createState() => _SortingVisualizationState();
}

class _SortingVisualizationState extends State<SortingVisualization> {
  List<int> _numbers = [];
  int _sampleSize = 500;
  int _speed = 0;
  int _duration = 150;
  int m = 0;
  bool isRunning = false;
  bool isSorted = false;
  String _currentSortAlgo = 'Bubble';
  StreamController<List<int>> _streamController = StreamController();


  _randomize() {
    _numbers.clear();
    for (int i = 0; i < _sampleSize; i++) {
      _numbers.add(Random().nextInt(_sampleSize));
      if (_numbers[_numbers.length - 1] > m) m = _numbers[_numbers.length - 1];
    }
    //print(_numbers);
    isSorted = false;
    setState(() {});
  }

  _checkAndResetIfSorted() async {
    if (isSorted) {
      _randomize();
      await Future.delayed(Duration(milliseconds: 200));
    }
  }

  _changeSpeed() {
    if (_speed >= 5) {
      _speed = 0;
      _duration = 100;
    } else {
      _speed++;
      _duration = _duration ~/ 3;
    }
    print(_speed.toString() + " " + _duration.toString());
    setState(() {});
  }

  _bubbleSort() async {
    for (int i = 0; i < _numbers.length - 1; i++) {
      for (int j = 0; j < _numbers.length - i - 1; j++) {
        if (_numbers[j] > _numbers[j + 1]) {
          int temp = _numbers[j];
          _numbers[j] = _numbers[j + 1];
          _numbers[j + 1] = temp;
        }
      }
      await Future.delayed(Duration(milliseconds: _duration),);
      _streamController.add(_numbers);
    }
  }

  _insertionSort() async {
    int i, key, j;
    for (i = 1; i < _numbers.length; i++) {
      key = _numbers[i];
      j = i - 1;
      while (j >= 0 && _numbers[j] > key) {
        _numbers[j + 1] = _numbers[j];
        j = j - 1;
      }
      await Future.delayed(Duration(milliseconds: _duration),);
      _numbers[j + 1] = key;
      _streamController.add(_numbers);
    }
  }

  _mergeSort(int leftIndex, int rightIndex) async {
    Future<void> merge(int leftIndex, int middleIndex, int rightIndex) async {
      int leftSize = middleIndex - leftIndex + 1;
      int rightSize = rightIndex - middleIndex;

      List leftList = List.filled(leftSize, null, growable: false);
      List rightList = List.filled(rightSize, null, growable: false);

      for (int i = 0; i < leftSize; i++) leftList[i] = _numbers[leftIndex + i];
      for (int j = 0; j < rightSize; j++) rightList[j] = _numbers[middleIndex + j + 1];

      int i = 0, j = 0;
      int k = leftIndex;

      while (i < leftSize && j < rightSize) {
        if (leftList[i] <= rightList[j]) {
          _numbers[k] = leftList[i];
          i++;
        } else {
          _numbers[k] = rightList[j];
          j++;
        }

        await Future.delayed(Duration(milliseconds: _duration),);
        _streamController.add(_numbers);

        k++;
      }

      while (i < leftSize) {
        _numbers[k] = leftList[i];
        i++;
        k++;

        await Future.delayed(Duration(milliseconds: _duration),);
        _streamController.add(_numbers);
      }

      while (j < rightSize) {
        _numbers[k] = rightList[j];
        j++;
        k++;

        await Future.delayed(Duration(milliseconds: _duration),);
        _streamController.add(_numbers);
      }
    }

    if (leftIndex < rightIndex) {
      int middleIndex = (rightIndex + leftIndex) ~/ 2;

      await _mergeSort(leftIndex, middleIndex);
      await _mergeSort(middleIndex + 1, rightIndex);

      await Future.delayed(Duration(milliseconds: _duration),);

      _streamController.add(_numbers);

      await merge(leftIndex, middleIndex, rightIndex);
    }
  }

  cf(int a, int b) {
    if (a < b) {
      return -1;
    } else if (a > b) {
      return 1;
    } else {
      return 0;
    }
  }

  _quickSort(int leftIndex, int rightIndex) async {
    Future<int> _partition(int left, int right) async {
      int p = (left + (right - left) / 2).toInt();
      var temp = _numbers[p];
      _numbers[p] = _numbers[right];
      _numbers[right] = temp;
      await Future.delayed(Duration(milliseconds: _duration),);
      _streamController.add(_numbers);
      int cursor = left;
      for (int i = left; i < right; i++) {
        if (cf(_numbers[i], _numbers[right]) <= 0) {
          var temp = _numbers[i];
          _numbers[i] = _numbers[cursor];
          _numbers[cursor] = temp;
          cursor++;
          await Future.delayed(Duration(milliseconds: _duration),);
          _streamController.add(_numbers);
        }
      }
      temp = _numbers[right];
      _numbers[right] = _numbers[cursor];
      _numbers[cursor] = temp;
      await Future.delayed(Duration(milliseconds: _duration),);
      _streamController.add(_numbers);
      return cursor;
    }
    if (leftIndex < rightIndex) {
      int p = await _partition(leftIndex, rightIndex);
      await _quickSort(leftIndex, p - 1);
      await _quickSort(p + 1, rightIndex);
    }
  }

  _selectionSort() async {
    for (int i = 0; i < _numbers.length; i++) {
      for (int j = i + 1; j < _numbers.length; j++) {
        if (_numbers[i] > _numbers[j]) {
          int temp = _numbers[j];
          _numbers[j] = _numbers[i];
          _numbers[i] = temp;
        }
      }
      await Future.delayed(Duration(milliseconds: _duration),);
      _streamController.add(_numbers);
    }
  }




  _start() async {
    setState(() {
      isRunning = true;
    });

    if (isSorted) await _checkAndResetIfSorted();

    Stopwatch stopwatch = new Stopwatch()..start();

    if (_currentSortAlgo == 'Bubble')
      await _bubbleSort();
    else if (_currentSortAlgo == 'Insertion')
      await _insertionSort();
    else if(_currentSortAlgo=='Selection')
      await _selectionSort();
    else if(_currentSortAlgo=='Merge')
      await _mergeSort(0, _numbers.length-1);
    else if(_currentSortAlgo=='Quick')
      await _quickSort(0, _numbers.length-1);

    stopwatch.stop();

    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Sorting completed in ${stopwatch.elapsed.inMilliseconds} ms.",
        ),
      ),
    );

    setState(() {
      isRunning = false;
      isSorted = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _randomize();
    _streamController=StreamController<List<int>>();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _streamController.close();
    super.dispose();
    
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height - AppBar().preferredSize.height - kBottomNavigationBarHeight;
    //print(h);
    //print(MediaQuery.of(context).size.height);
    //print(MediaQuery.of(context).size.width);
    //print(AppBar().preferredSize.height);
    //print(kBottomNavigationBarHeight);
    return Scaffold(
      appBar: AppBar(
        title: Text('$_currentSortAlgo Sort'),
        centerTitle: true,
        backgroundColor: const Color(0xff224c63),
        actions: <Widget>[
          PopupMenuButton<String>(
            elevation: 3.0,
            initialValue: _currentSortAlgo,
            enabled: isRunning? false :true ,
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: 'Bubble',
                  child: FittedBox(child: Text("Bubble Sort")),
                ),
                PopupMenuItem(
                  value: 'Selection',
                  child: FittedBox(child: Text("Selection Sort")),
                ),
                PopupMenuItem(
                  value: 'Insertion',
                  child: FittedBox(
                    child: Text("Insertion Sort"),
                  ),
                ),
                PopupMenuItem(
                  value: 'Quick',
                  child: FittedBox(
                    child: Text(
                        "Quick Sort"),
                  ),
                ),
                PopupMenuItem(
                  value: 'Merge',
                  child: FittedBox(child: Text("Merge Sort")),
                ),
              ];
            },
            onSelected: (String value) {
              _randomize();
              _currentSortAlgo = value;
              print(_currentSortAlgo);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(1.0, 0.0, 1.0, 0.0),
          //height: MediaQuery.of(context).size.height,
          //width: double.infinity,
          child: StreamBuilder <Object>(
            stream: _streamController.stream,
            builder: (context,snapshot) {
              int counter = -1;
              return Row(
                children: _numbers.map(
                      (int number) {
                    counter++;
                    return CustomPaint(
                      painter: BarPainter(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width / (_sampleSize),
                          value: m >= h
                              ? ((h.toDouble() - 1) / m) * number
                              : number.toDouble(),
                          index: counter),
                    );
                  },
                ).toList(),
              );
            }
          ),
        ),
      ),
      bottomNavigationBar: Row(
        children: <Widget>[
          Expanded(
            child: TextButton(
              child: FittedBox(child: Text('Randomize')),
              onPressed: isRunning ? null : _randomize,
            ),
          ),
          Expanded(
            child: TextButton(
              child: FittedBox(child: Text('Start')),
              onPressed: isRunning ? null : _start,
            ),
          ),
          Expanded(
            child: TextButton(
              child: FittedBox(child: Text( '${_speed + 1}x')),
              onPressed: isRunning ? null : _changeSpeed,
            ),
          ),
        ],
      ),
    );
  }
}

class BarPainter extends CustomPainter {
  final double width;
  final double value;
  final int index;

  BarPainter({this.width = 0.0, this.value = 0, this.index = 0});

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint paint = Paint();
    if (this.value < 500 * .10) {
      paint.color = Color(0xFFDEEDCF);
    } else if (this.value < 500 * .20) {
      paint.color = Color(0xFFBFE1B0);
    } else if (this.value < 500 * .30) {
      paint.color = Color(0xFF99D492);
    } else if (this.value < 500 * .40) {
      paint.color = Color(0xFF74C67A);
    } else if (this.value < 500 * .50) {
      paint.color = Color(0xFF56B870);
    } else if (this.value < 500 * .60) {
      paint.color = Color(0xFF39A96B);
    } else if (this.value < 500 * .70) {
      paint.color = Color(0xFF1D9A6C);
    } else if (this.value < 500 * .80) {
      paint.color = Color(0xFF188977);
    } else if (this.value < 500 * .90) {
      paint.color = Color(0xFF137177);
    } else {
      paint.color = Color(0xFF0E4D64);
    }
    paint.strokeWidth = width;
    paint.strokeCap = StrokeCap.round;

    //print('$value-$index');

    canvas.drawLine(Offset(index * width, 0),
        Offset(index * width, value.toDouble()), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
