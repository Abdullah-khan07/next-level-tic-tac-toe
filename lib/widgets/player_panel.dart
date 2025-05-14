import 'package:flutter/material.dart';

class PlayerPanel extends StatelessWidget {
  final bool isOTurn;
  const PlayerPanel({super.key, required this.isOTurn});

  @override
  Widget build(BuildContext context) {
    return Text(
      isOTurn ? "O's Turn" : "X's Turn",
      style: const TextStyle(fontSize: 24, color: Colors.white),
    );
  }
}
