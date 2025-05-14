import 'package:flutter/material.dart';

class ResetButton extends StatelessWidget {
  final VoidCallback onReset;

  const ResetButton({super.key, required this.onReset});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onReset,
      child: const Text('Reset Game'),
    );
  }
}
