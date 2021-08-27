import 'package:flutter/material.dart';

class CustomToolTip extends StatefulWidget {
  final String content;

  const CustomToolTip({required this.content});
  @override
  _CustomToolTipState createState() => _CustomToolTipState();
}

class _CustomToolTipState extends State<CustomToolTip> {
  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<State<Tooltip>>();

    return Tooltip(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.secondary,
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(0, 0),
          ),
        ],
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).cardColor,
      ),
      margin: EdgeInsets.all(6.0),
      padding: EdgeInsets.all(12.0),
      key: key,
      message: widget.content,
      textStyle: TextStyle(
        color: Theme.of(context).textTheme.headline1!.color,
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          final dynamic tooltip = key.currentState;
          tooltip?.ensureTooltipVisible();
        },
        child: Icon(
          Icons.info,
          size: 30,
          color: Theme.of(context).textTheme.headline1!.color,
        ),
      ),
    );
  }
}
