import 'package:flutter/material.dart';

class BuilderCallendarContainer extends StatelessWidget {
  const BuilderCallendarContainer({
    Key? key,
    required this.child,
    required this.color,
    required this.day,
  }) : super(key: key);
  final Widget child;
  final Color color;
  final DateTime day;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(0.5),
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black,
          width: 0.5,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              color: color,
            ),
            width: double.infinity,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                day.day.toString(),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
