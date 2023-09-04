import 'package:flutter/material.dart';

class TimeButton extends StatelessWidget {
  final String time;
  final Color bgColor;
  final Color timeColor;

  const TimeButton(
      {super.key,
      required this.time,
      required this.bgColor,
      required this.timeColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.white.withOpacity(0.5),
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        child: Text(
          time,
          style: TextStyle(
            color: timeColor,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
