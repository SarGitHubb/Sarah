import 'package:flutter/material.dart';

void main() => runApp(TicTacToeApp());

class TicTacToeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TicTacToeGame(),
    );
  }
}

class TicTacToeGame extends StatefulWidget {
  @override
  _TicTacToeGameState createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  late List<List<String>> board;
  late String currentPlayer;
  late bool gameFinished;

  @override
  void initState() {
    super.initState();
    startNewGame();
  }

  void startNewGame() {
  board = List.generate(3, (row) => List.generate(3, (col) => ""));
  currentPlayer = "X";
  gameFinished = false;
}

  void makeMove(int row, int col) {
    if (board[row][col] == "" && !gameFinished) {
      setState(() {
        board[row][col] = currentPlayer;
        if (checkWinner(row, col)) {
          gameFinished = true;
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text("Game Over"),
              content: Text("$currentPlayer menang!"),
              actions: <Widget>[
                TextButton(
                  child: Text("Main lagi"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    startNewGame();
                  },
                ),
              ],
            ),
          );
        } else if (board.every((row) => row.every((cell) => cell.isNotEmpty))) {
          gameFinished = true;
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text("Game Over"),
              content: Text("Seri!"),
              actions: <Widget>[
                TextButton(
                  child: Text("Main lagi"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    startNewGame();
                  },
                ),
              ],
            ),
          );
        } else {
          currentPlayer = (currentPlayer == "X") ? "O" : "X";
        }
      });
    }
  }

  bool checkWinner(int row, int col) {
    // cek barisan
    if (board[row][0] == currentPlayer &&
        board[row][1] == currentPlayer &&
        board[row][2] == currentPlayer) {
      return true;
    }

    // cek kolom
    if (board[0][col] == currentPlayer &&
        board[1][col] == currentPlayer &&
        board[2][col] == currentPlayer) {
      return true;
    }

    // cek diagonal
    if ((row == col ||
            (row == 0 && col == 2) ||
            (row == 2 && col == 0)) &&
        (board[0][0] == currentPlayer &&
            board[1][1] == currentPlayer &&
            board[2][2] == currentPlayer)) {
      return true;
    }

    if ((row == col ||
            (row == 0 && col == 2) ||
            (row == 2 && col == 0)) &&
        (board[0][2] == currentPlayer &&
            board[1][1] == currentPlayer &&
            board[2][0] == currentPlayer)) {
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Game Tic-Tac-Toe"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          for (int i = 0; i < 3; i++)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                for (int j = 0; j < 3; j++)
                  GestureDetector(
                    onTap: () => makeMove(i, j),
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                      child: Center(
                        child: Text(
                          board[i][j],
                          style: TextStyle(fontSize: 40),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          SizedBox(height: 20),
          gameFinished
              ? ElevatedButton(
                  child: Text("Coba lagi?"),
                  onPressed: () {
                    setState(() {
                      startNewGame();
                    });
                  },
                )
              : Container(),
        ],
     ),
  );
 }
}
