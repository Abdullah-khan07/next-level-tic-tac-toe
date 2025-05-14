import 'dart:ui';
import 'package:flutter/material.dart';
import '../controller/game_controller.dart';

class GameBoard extends StatelessWidget {
  final GameController controller;
  final VoidCallback onBoardChange;

  const GameBoard({
    super.key,
    required this.controller,
    required this.onBoardChange,
  });

  void _handleTap(BuildContext context, int index) {
    if (controller.makeMove(index)) {
      onBoardChange();

      String winner = controller.checkWinner();
      if (winner.isNotEmpty) {
        Future.delayed(const Duration(milliseconds: 300), () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => Dialog(
              backgroundColor: Colors.transparent,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: _AnimatedWinDialog(
                      winner: winner,
                      onPlayAgain: () {
                        controller.resetGame();
                        Navigator.pop(context);
                        onBoardChange();
                      },
                    ),
                  ),
                ),
              ),
            ),
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 9,
      shrinkWrap: true,
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
      itemBuilder: (context, index) {
        final symbol = controller.board[index];
        return GestureDetector(
          onTap: () => _handleTap(context, index),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Text(
                  symbol,
                  key: ValueKey(symbol),
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: symbol == 'X' ? Colors.cyanAccent : Colors.pinkAccent,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// 🎯 Custom Widget with Animated “🎉 Congratulations!”
class _AnimatedWinDialog extends StatefulWidget {
  final String winner;
  final VoidCallback onPlayAgain;

  const _AnimatedWinDialog({
    required this.winner,
    required this.onPlayAgain,
  });

  @override
  State<_AnimatedWinDialog> createState() => _AnimatedWinDialogState();
}

class _AnimatedWinDialogState extends State<_AnimatedWinDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _scaleAnim = CurvedAnimation(parent: _controller, curve: Curves.elasticOut);
    _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ScaleTransition(
          scale: _scaleAnim,
          child: FadeTransition(
            opacity: _fadeAnim,
            child: Text(
              '🎉 Congratulations!',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white.withOpacity(0.95),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          '${widget.winner} Wins!',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white.withOpacity(0.85),
          ),
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white.withOpacity(0.2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          onPressed: widget.onPlayAgain,
          child: const Text(
            'Play Again',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
