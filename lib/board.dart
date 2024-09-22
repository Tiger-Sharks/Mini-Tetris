import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tetris/piece.dart';
import 'package:tetris/pixel.dart';
import 'package:tetris/values.dart';

/*
GAME BOARD

A 2x2 grid with null, for an empty space
A non empty space will have the color to represent the landed pieces

 */

// Game Board
List<List<Tetrimino?>> gameBoard = List.generate(
    columns,
    (x) => List.generate(
      rows,
      (y) => null,
    ),
);

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {

  // Current Piece
  Piece currentPiece = Piece(type: Tetrimino.L);

  // Current Score
  int currScore = 0;

  // Game Over Status
  bool gameOver = false;

  @override
  void initState() {
    super.initState();

    // Start game whe app initializes
    startGame();

  }

  void startGame() {
    currentPiece.initializePiece();

    // Refresh Frames
    Duration frameRate = const Duration(milliseconds: 500);
    gameLoop(frameRate);
  }

  // Game Loop
  void gameLoop(Duration frameRate) {
    Timer.periodic(
      frameRate,
        (timer) {
          setState(() {
            // Clear Lines
            clearLines();

            // Check Landing
            checkLanding();

            // Check if game over
            if (gameOver == true) {
              timer.cancel();
              gameOverDialog();
            }

            // Moving Current Piece Down
            currentPiece.movePiece(Direction.down);
          });
        },
    );
  }

  // Game Over Dialog
  void gameOverDialog() {
    showDialog(context: context, builder: (context) => AlertDialog(
      title: Text("Game Over"),
      content: Text("Your Score is $currScore"),
      actions: [
        TextButton(
            onPressed: () {
              // Reset Option
              resetGame();
              
              Navigator.pop(context);
            },
            child: Text('Play Again'))
        ],
      ),
    );
  }

  // Reset Game
  void resetGame() {
    // Clear Board
    gameBoard = List.generate(
        columns,
        (x) => List.generate(
          rows,
            (y) => null,
        ),
    );

    // New Game
    gameOver = false;
    currScore = 0;

    // New Piece
    createNewPiece();

    // Start Game
    startGame();
  }

  // Check Collision
  // True -> Collision
  // False -> No Collision
  bool checkCollision(Direction direction) {
    // Loop through each piece position
    for (int x = 0; x < currentPiece.position.length; x++) {
      // Calculate Row and Column
      int row = (currentPiece.position[x] / rows).floor();
      int col = currentPiece.position[x] % rows;

      // Adjusting Row and Column
      if (direction == Direction.left) {
        col -= 1;
      } else if (direction == Direction.right) {
        col += 1;
      } else if (direction == Direction.down) {
        row += 1;
      }

      // Check Out of Bound
      if (row >= columns || col < 0 || col >= rows) {
        return true;
      }

      // Check for Other Pieces
      if (row >= 0 && gameBoard[row][col] != null) {
        return true;
      }
    }

    // No Collisions detected
    return false;
  }

  void checkLanding() {
    // Check Down Occupancy
    if (checkCollision(Direction.down)) {
      // Mark position as Occupied
      for (int x = 0; x < currentPiece.position.length; x++) {
        int row = (currentPiece.position[x] / rows).floor();
        int col = currentPiece.position[x] % rows;

        if (row >= 0 && col >= 0) {
          gameBoard[row][col] = currentPiece.type;
        }
      }

      // Create New Piece, Once Landed
      createNewPiece();
    }
  }

  void createNewPiece() {
    // Generate Random Piece
    Random rand = Random();

    // Create new piece
    Tetrimino randomType = Tetrimino.values[rand.nextInt(Tetrimino.values.length)];
    currentPiece = Piece(type: randomType);
    currentPiece.initializePiece();

    /*

    Check for new piece initialized in the top row to
    Rectify False Positive in Game Over Condition

    */
    if (isOver()) {
      gameOver = true;
    }
  }

  // Move Left
  void moveLeft() {
    if (!checkCollision(Direction.left)) {
      setState(() {
        currentPiece.movePiece(Direction.left);
      });
    }
  }

  // Move Right
  void moveRight() {
    if (!checkCollision(Direction.right)) {
      setState(() {
        currentPiece.movePiece(Direction.right);
      });
    }
  }

  // Rotate
  void rotatePiece() {
    setState(() {
      currentPiece.rotatePiece();
    });
  }

  // Clear Line
  void clearLines() {
    // Looping through each line, Bottom to Up
    for (int row = columns - 1; row >= 0; row--) {
      // Initialize variable if row is full
      bool rowFull = true;

      // Check if row is full
      for (int col = 0; col < rows; col++) {
        // If an empty block, set rowFull to false
        if (gameBoard[row][col] == null) {
          rowFull = false;
          break;
        }
      }

      // If row full, clear and shift down
      if (rowFull) {
        // Move the rows
        for (int r = row; r > 0; r--) {
          gameBoard[r] = List.from(gameBoard[r-1]);
        }
        // Set top row empty
        gameBoard[0] = List.generate(row, (index) => null);

        // Increment score
        currScore++;
      }
    }
  }

  // Game Over
  bool isOver() {
    // Check if top row filled or not
    for (int col = 0; col < rows; col++) {
      if (gameBoard[0][col] != null) {
        return true;
      }
    }

    // Top row is empty
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [

          // Game Grid
          Expanded(
            child: GridView.builder(
              itemCount: rows * columns,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: rows
            ),
                itemBuilder: (context, index) {
                // Get Index Row and Column
                int row = (index / rows).floor();
                int col = index % rows;
            
                // Current Piece
                if (currentPiece.position.contains(index)){
                  return Pixel(
                    color: currentPiece.color,
                  );
                }
            
                // Landed Pieces
                else if (gameBoard[row][col] != null) {
                  final Tetrimino? tetriminoType = gameBoard[row][col];
                  return Pixel(color: tetriminoColors[tetriminoType]);
            
                }
            
                // Blank Piece
                else {
                  return Pixel(
                    color: Colors.grey[900],
                  );
                }
              },
            ),
          ),

          // Score Board
          Text(
            "Score: $currScore",
            style: TextStyle(color: Colors.white),
          ),
          
          // Game Controls
          Padding(
            padding: const EdgeInsets.only(bottom: 80.0, top: 50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              // Left
              IconButton(
                  onPressed: moveLeft,
                  color: Colors.white,
                  icon: Icon(Icons.arrow_back_ios)),

              // Rotate
              IconButton(
                  onPressed: rotatePiece,
                  color: Colors.white,
                  icon: Icon(Icons.rotate_right)),

              // Right
              IconButton(
                  onPressed: moveRight,
                  color: Colors.white,
                  icon: Icon(Icons.arrow_forward_ios)),
            ],),
          )

        ],
      ),
    );
  }
}
