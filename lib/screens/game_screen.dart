import 'package:flutter/material.dart';
import '../controller/game_controller.dart'; // Import GameController
import '../widgets/game_board.dart';
import '../widgets/player_panel.dart';
import '../widgets/reset_button.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final GameController gameController = GameController(); // ✅ No alias

  void _update() => setState(() {});
  void _resetGame() {
    gameController.resetGame();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            PlayerPanel(isOTurn: gameController.isOTurn),
            const Spacer(),
            GameBoard(controller: gameController, onBoardChange: _update),
            const SizedBox(height: 20),
            ResetButton(onReset: _resetGame),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
