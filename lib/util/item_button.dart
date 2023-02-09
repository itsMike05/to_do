import 'package:flutter/material.dart';

class ItemButton extends StatelessWidget {
  final String buttonText;
  VoidCallback onPressed;

  ItemButton({super.key, required this.buttonText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Theme.of(context).primaryColor,
      child: Text(buttonText),
    );
  }
}
