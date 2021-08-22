import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  final Function function;
  const SaveButton({Key? key, required this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          Theme.of(context).accentColor,
        ),
      ),
      onPressed: () {
        function();
        Navigator.of(context).pop();
      },
      icon: Icon(
        Icons.save,
        color: Theme.of(context).textTheme.headline1!.color,
      ),
      label: Text(
        "Zapisz wynik",
        style: TextStyle(
          color: Theme.of(context).textTheme.headline1!.color,
        ),
      ),
    );
  }
}
