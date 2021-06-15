import 'package:flutter/material.dart';
import 'package:algo_visualizer_analyzer/Screens/sorting_analyzer_home.dart';
import 'package:algo_visualizer_analyzer/Screens/sorting_visualization.dart';
import 'package:algo_visualizer_analyzer/Screens/home.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //primaryColor: Colors.green[900],
        appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: const Color(0xff224c63),
        ),
        textTheme: TextTheme(
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Color(0xFF0E4D64)),
          ),
        )
      ),
      home: SortingVisualization(),
      initialRoute: Home.id,
      routes: {
        Home.id: (context) => Home(),
        SortingVisualization.id: (context) => SortingVisualization(),
        SortingAnalyzer.id: (context) => SortingAnalyzer(),
      },
    );
  }
}
