import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  ReusableCard({this.colour, this.child, this.onPress});

  final Color colour;
  final Widget child;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPress();
      },
      child: Container(
        child: child,
        margin: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: colour,
        ),
      ),
    );
  }
}
