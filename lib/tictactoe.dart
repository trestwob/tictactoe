import 'package:flutter/material.dart';

class TicTacToe extends StatefulWidget {
  const TicTacToe({super.key});

  @override
  State<TicTacToe> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  List<String> _board = List.filled(9, '');
  bool _isXTurn = true;
  String? _winner;

  void _makeMove(int index) {
    if (_board[index] == '' && _winner == null) {
      setState(() {
        _board[index] = _isXTurn ? 'X' : 'O';
        _isXTurn = !_isXTurn;
        _checkWinner();
      });
    }
  }

  void _checkWinner() {
    for (int i = 0; i < 9; i += 3) {
      if (_board[i] != '' &&
          _board[i] == _board[i + 1] &&
          _board[i] == _board[i + 2]) {
        _winner = _board[i];
        return;
      }
    }

    for (int i = 0; i < 3; i++) {
      if (_board[i] != '' &&
          _board[i] == _board[i + 3] &&
          _board[i] == _board[i + 6]) {
        _winner = _board[i];
        return;
      }
    }

    if (_board[0] != '' && _board[0] == _board[4] && _board[0] == _board[8]) {
      _winner = _board[0];
      return;
    }
    if (_board[2] != '' && _board[2] == _board[4] && _board[2] == _board[6]) {
      _winner = _board[2];
      return;
    }

    if (!_board.contains('')) {
      _winner = 'Draw';
    }
  }


  void _resetGame() {
    setState(() {
      _board = List.filled(9, '');
      _isXTurn = true;
      _winner = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: GridView.builder(
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _makeMove(index),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.pink),
                    ),
                    child: Center(
                      child: Text(
                        _board[index],
                        style: const TextStyle(fontSize: 40),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (_winner != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                _winner == 'Draw' ? 'It\'s a Draw!' : '$_winner Wins!',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _resetGame,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                foregroundColor: Colors.white
              ),
              child: const Text('Restart'),
            ),
          ),
        ],
      ),
    );
  }
}
