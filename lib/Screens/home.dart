import 'package:algo_visualizer_analyzer/Widgets/glowing_avatar.dart';
import 'package:flutter/material.dart';
import 'package:algo_visualizer_analyzer/Screens/sorting_analyzer_home.dart';
import 'package:algo_visualizer_analyzer/Screens/sorting_visualization.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:avatar_glow/avatar_glow.dart';

class Home extends StatefulWidget {

  static const String id='Home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final screenDetails = MediaQuery.of(context);
    final screenHeight = screenDetails.size.height-AppBar().preferredSize.height;
    final screenWidth = screenDetails.size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Algorithm Analyzer and Visualizer'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Avatar(screenWidth: screenWidth>=screenHeight?screenHeight:screenWidth, image: 'assets/graph.png'),
              Container(
                alignment: Alignment.center,
                width: screenWidth/2,
                height: screenHeight/10,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, SortingAnalyzer.id);
                  },
                  child: FittedBox(child: Text('Analyze Sorting Algorithms')),
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: screenWidth/2,
                height: screenHeight/10,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, SortingVisualization.id);
                  },
                  child: FittedBox(child: Text('Visualize Sorting Algorithms')),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
