import 'package:flutter/material.dart';

// iOS style swipeable indicator on top or bottom for show that widget is expandable by swipe
class SwipeableIndicator extends StatelessWidget {
  const SwipeableIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5, top: 5),
      width: 40.0,
      height: 4.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.grey.shade400,
      ),
    );
  }
}
