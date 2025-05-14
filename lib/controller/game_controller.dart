class GameController {
  List<String> board = List.filled(9, '');
  bool isOTurn = true;

  bool makeMove(int index) {
    if (board[index] == '') {
      board[index] = isOTurn ? 'O' : 'X';
      isOTurn = !isOTurn;
      return true;
    }
    return false;
  }

  String checkWinner() {
    const List<List<int>> winPatterns = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var pattern in winPatterns) {
      final a = board[pattern[0]];
      final b = board[pattern[1]];
      final c = board[pattern[2]];
      if (a != '' && a == b && b == c) {
        return a;
      }
    }

    if (!board.contains('')) {
      return 'Draw';
    }

    return '';
  }

  void resetGame() {
    board = List.filled(9, '');
    isOTurn = true;
  }
}
