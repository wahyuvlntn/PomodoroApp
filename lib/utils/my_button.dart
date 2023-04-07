import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const MyButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Theme.of(context).colorScheme.secondary,
      child: Text(text),
    );
  }
}