import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart'; //Used For Beautiful Glowing circle avatar

class Avatar extends StatelessWidget {
  const Avatar({
    Key? key,
    required this.screenWidth,
    required this.image
  }) : super(key: key);

  final double screenWidth;
  final String image;

  @override
  Widget build(BuildContext context) {
    return AvatarGlow(
      glowColor: Colors.blue,
      endRadius: screenWidth / 4,
      //90.0,  //Maximum radius of ripple
      duration: Duration(milliseconds: 2000),
      // Duration of Each ripple
      repeat: true,
      showTwoGlows: true,
      repeatPauseDuration: Duration(milliseconds: 100),
      //Time Gap between repetition
      child: Material(
        // Replace this child with your own
        elevation: 8.0,
        shape: CircleBorder(),
        child: CircleAvatar(
          backgroundColor: Colors.grey[100],
          child: Image.asset(
            image,
            height: screenWidth / 4.5, // Image diameter
          ),
          radius: screenWidth / 8.8, //white border radius
        ),
      ),
    );
  }
}