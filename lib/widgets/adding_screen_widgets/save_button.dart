import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  final Function function;
  const SaveButton({Key? key, required this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          Theme.of(context).colorScheme.secondary,
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
        tr("Save"),
        style: TextStyle(
          color: Theme.of(context).textTheme.headline1!.color,
        ),
      ),
    );
  }
}
