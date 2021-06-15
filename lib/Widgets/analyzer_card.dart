import 'package:flutter/material.dart';

class AnalyzerCard extends StatelessWidget {
  const AnalyzerCard({
    Key? key,
    required this.screenWidth,
    required this.time,
    required this.title,
  }) : super(key: key);

  final double screenWidth;
  final int time;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      child: Card(
        elevation: 8.0,
        child: ListTile(
          leading: FittedBox(
            child: Icon(
              Icons.sort,
              color: Colors.blue,
            ),
          ),
          title: Text(
            '$title Sort',
            style: TextStyle(
              fontSize: screenWidth / 20,
            ),
          ),
          trailing: Container(
            child: FittedBox(
              child: Text(
                '$time us',
                style: TextStyle(fontSize: screenWidth / 20, color: Colors.red),
              ),
            ),
          ),
        ),
      ),
    );
  }
}