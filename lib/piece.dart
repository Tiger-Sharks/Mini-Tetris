import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:tetris/board.dart';
import 'package:tetris/values.dart';

class Piece {

  // Tetris Pieces

  Tetrimino type;

  Piece({required this.type});

  // Pieces = List Integers

  List<int> position = [];

  // Piece Colors
  Color get color {
    return tetriminoColors[type] ?? const Color(0xFFFFFFFF);
  }

  // Generating Integers

  void initializePiece() {
    switch (type) {
      case Tetrimino.L:
        position = [
          -26, -16, -6, -5,
        ];
        break;
      case Tetrimino.J:
        position = [
          -25, -15, -5, -6,
        ];
        break;
      case Tetrimino.I:
        position = [
          -4, -5, -6, -7,
        ];
        break;
      case Tetrimino.O:
        position = [
          -15, -16, -5, -6,
        ];
        break;
      case Tetrimino.S:
        position = [
          -15, -14, -6, -5,
        ];
        break;
      case Tetrimino.Z:
        position = [
          -17, -16, -6, -5,
        ];
        break;
      case Tetrimino.T:
        position = [
          -26, -16, -6, -15,
        ];
        break;
    }
  }

  // Moving the piece
  void movePiece(Direction direction) {
    switch (direction) {
      case Direction.down:
        for (int x = 0; x < position.length; x++) {
          position[x] += rows;
        }
        break;

      case Direction.left:
        for (int x = 0; x < position.length; x++) {
          position[x] -= 1;
        }
        break;

      case Direction.right:
        for (int x = 0; x < position.length; x++) {
          position[x] += 1;
        }
        break;

      default:
    }
  }

  // Rotate Piece
  int rotateState = 1;
  void rotatePiece() {
    List<int> newPos = [];

    // Rotate based on type
    switch (type) {
      case Tetrimino.L:
        switch (rotateState) {
          case 0:
            /*
            o
            o
            o  o
             */

            // Get New Position
            newPos = [
              position[1] - rows,
              position[1],
              position[1] + rows,
              position[1] + rows + 1,
            ];

            // New Move Validity before Assigning
            if (piecePosIsValid(newPos)) {
              // Update Positon
              position = newPos;

              // Update Rotate State
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 1:
          /*
            o  o  o
            o
          */

          // Get New Position
            newPos = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rows - 1,
            ];

            // New Move Validity before Assigning
            if (piecePosIsValid(newPos)) {
              // Update Positon
              position = newPos;

              // Update Rotate State
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 2:
          /*
            o  o
               o
               o
          */

          // Get New Position
            newPos = [
              position[1] + rows,
              position[1],
              position[1] - rows,
              position[1] - rows - 1,
            ];

            // New Move Validity before Assigning
            if (piecePosIsValid(newPos)) {
              // Update Positon
              position = newPos;

              // Update Rotate State
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 3:
          /*
                  o
            o  o  o
          */

          // Get New Position
            newPos = [
              position[1] -  rows + 1,
              position[1],
              position[1] + 1,
              position[1] - 1,
            ];

            // New Move Validity before Assigning
            if (piecePosIsValid(newPos)) {
              // Update Positon
              position = newPos;

              // Update Rotate State
              rotateState = (rotateState + 1) % 4;
            }
            break;
        }
        break;

      case Tetrimino.J:
        switch (rotateState) {
          case 0:
          /*
               o
               o
            o  o
          */

          // Get New Position
            newPos = [
              position[1] - rows,
              position[1],
              position[1] + rows,
              position[1] + rows - 1,
            ];

            // New Move Validity before Assigning
            if (piecePosIsValid(newPos)) {
              // Update Positon
              position = newPos;

              // Update Rotate State
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 1:
          /*
            o
            o  o  o
          */

          // Get New Position
            newPos = [
              position[1] - rows - 1,
              position[1],
              position[1] - 1,
              position[1] + 1,
            ];

            // New Move Validity before Assigning
            if (piecePosIsValid(newPos)) {
              // Update Positon
              position = newPos;

              // Update Rotate State
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 2:
          /*
            o  o
            o
            o
          */

          // Get New Position
            newPos = [
              position[1] + rows,
              position[1],
              position[1] - rows,
              position[1] - rows - 1,
            ];

            // New Move Validity before Assigning
            if (piecePosIsValid(newPos)) {
              // Update Positon
              position = newPos;

              // Update Rotate State
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 3:
          /*
            o  o  o
                  o
          */

          // Get New Position
            newPos = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] + rows + 1,
            ];

            // New Move Validity before Assigning
            if (piecePosIsValid(newPos)) {
              // Update Positon
              position = newPos;

              // Update Rotate State
              rotateState = (rotateState + 1) % 4;
            }
            break;
        }
        break;

      case Tetrimino.I:
        switch (rotateState) {
          case 0:
          /*
            o  o  o  o
          */

          // Get New Position
            newPos = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + 2,
            ];

            // New Move Validity before Assigning
            if (piecePosIsValid(newPos)) {
              // Update Positon
              position = newPos;

              // Update Rotate State
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 1:
          /*
            o
            o
            o
            o
          */

          // Get New Position
            newPos = [
              position[1] - rows,
              position[1],
              position[1] + rows,
              position[1] + 2 * rows,
            ];

            // New Move Validity before Assigning
            if (piecePosIsValid(newPos)) {
              // Update Positon
              position = newPos;

              // Update Rotate State
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 2:
          /*
            o  o  o  o
          */

          // Get New Position
            newPos = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] - 2,
            ];

            // New Move Validity before Assigning
            if (piecePosIsValid(newPos)) {
              // Update Positon
              position = newPos;

              // Update Rotate State
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 3:
          /*
            o
            o
            o
            o
          */

          // Get New Position
            newPos = [
              position[1] + rows,
              position[1],
              position[1] - rows,
              position[1] - 2 * rows,
            ];

            // New Move Validity before Assigning
            if (piecePosIsValid(newPos)) {
              // Update Positon
              position = newPos;

              // Update Rotate State
              rotateState = (rotateState + 1) % 4;
            }
            break;
        }
        break;

      case Tetrimino.O:
        /*
          o  o
          o  o
        */
        // No need to rotate
        break;

      case Tetrimino.S:
        switch (rotateState) {
          case 0:
          /*
               o  o
            o  o
          */

          // Get New Position
            newPos = [
              position[1],
              position[1] + 1,
              position[1] + rows - 1,
              position[1] + rows,
            ];

            // New Move Validity before Assigning
            if (piecePosIsValid(newPos)) {
              // Update Positon
              position = newPos;

              // Update Rotate State
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 1:
          /*
            o
            o  o
               o
          */

          // Get New Position
            newPos = [
              position[0] - rows,
              position[0],
              position[0] + 1,
              position[0] + rows + 1,
            ];

            // New Move Validity before Assigning
            if (piecePosIsValid(newPos)) {
              // Update Positon
              position = newPos;

              // Update Rotate State
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 2:
          /*
               o  o
            o  o
          */

          // Get New Position
            newPos = [
              position[1],
              position[1] + 1,
              position[1] + rows - 1,
              position[1] + rows,
            ];

            // New Move Validity before Assigning
            if (piecePosIsValid(newPos)) {
              // Update Positon
              position = newPos;

              // Update Rotate State
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 3:
          /*
            o
            o  o
               o
          */

          // Get New Position
            newPos = [
              position[0] - rows,
              position[0],
              position[0] + 1,
              position[0] + rows + 1,
            ];

            // New Move Validity before Assigning
            if (piecePosIsValid(newPos)) {
              // Update Positon
              position = newPos;

              // Update Rotate State
              rotateState = (rotateState + 1) % 4;
            }
            break;
        }
        break;

      case Tetrimino.Z:
        switch (rotateState) {
          case 0:
          /*
            o  o
               o  o
          */

          // Get New Position
            newPos = [
              position[0] + rows - 2,
              position[1],
              position[2] + rows - 1,
              position[3] + 1,
            ];

            // New Move Validity before Assigning
            if (piecePosIsValid(newPos)) {
              // Update Positon
              position = newPos;

              // Update Rotate State
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 1:
          /*
               o
            o  o
            o
          */

          // Get New Position
            newPos = [
              position[0] - rows + 2,
              position[1],
              position[2] - rows + 1,
              position[3] - 1,
            ];

            // New Move Validity before Assigning
            if (piecePosIsValid(newPos)) {
              // Update Positon
              position = newPos;

              // Update Rotate State
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 2:
          /*
            o  o
               o  o
          */

          // Get New Position
            newPos = [
              position[0] + rows - 2,
              position[1],
              position[2] + rows - 1,
              position[3] + 1,
            ];

            // New Move Validity before Assigning
            if (piecePosIsValid(newPos)) {
              // Update Positon
              position = newPos;

              // Update Rotate State
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 3:
          /*
               o
            o  o
            o
          */

          // Get New Position
            newPos = [
              position[0] - rows + 2,
              position[1],
              position[2] - rows + 1,
              position[3] - 1,
            ];

            // New Move Validity before Assigning
            if (piecePosIsValid(newPos)) {
              // Update Positon
              position = newPos;

              // Update Rotate State
              rotateState = (rotateState + 1) % 4;
            }
            break;
        }
        break;

      case Tetrimino.T:
        switch (rotateState) {
          case 0:
          /*
            o
            o  o
            o
          */

          // Get New Position
            newPos = [
              position[2] - rows,
              position[2],
              position[2] + 1,
              position[2] + rows,
            ];

            // New Move Validity before Assigning
            if (piecePosIsValid(newPos)) {
              // Update Positon
              position = newPos;

              // Update Rotate State
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 1:
          /*
            o  o  o
               o
          */

          // Get New Position
            newPos = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rows,
            ];

            // New Move Validity before Assigning
            if (piecePosIsValid(newPos)) {
              // Update Positon
              position = newPos;

              // Update Rotate State
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 2:
          /*
               o
            o  o
               o
          */

          // Get New Position
            newPos = [
              position[1] - rows,
              position[1] - 1,
              position[1],
              position[1] + rows,
            ];

            // New Move Validity before Assigning
            if (piecePosIsValid(newPos)) {
              // Update Positon
              position = newPos;

              // Update Rotate State
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 3:
          /*
               o
            o  o  o
          */

          // Get New Position
            newPos = [
              position[2] - rows,
              position[2] - 1,
              position[2],
              position[2] + 1,
            ];

            // New Move Validity before Assigning
            if (piecePosIsValid(newPos)) {
              // Update Positon
              position = newPos;

              // Update Rotate State
              rotateState = (rotateState + 1) % 4;
            }
            break;
        }
        break;


      default:
    }
  }

  // Check Position Validity
  bool posIsValid(int position) {
    // Get Row and Column Position
    int row = (position / rows).floor();
    int col = position % rows;

    // Check Position taken
    if (row < 0 || col < 0 || gameBoard[row][col] != null) {
      return false;
    } else {
      return true;
    }
  }

  // Check Piece Position Validity
  bool piecePosIsValid(List<int> piecePos) {
    bool firstColOccu = false;
    bool lastColOccu = false;

    for (int pos in piecePos) {
      if (!posIsValid(pos)) {
        return false;
      }

      int col = pos % rows;

      // Check First and Last Column Occupancy
      if (col == 0) {
        firstColOccu = true;
      }
      if (col == rows - 1) {
        lastColOccu = true;
      }
    }

    // Check Wall Pass through
    return !(firstColOccu && lastColOccu);
  }
}