// Grid Dimensions
import 'dart:ui';

int rows = 10;
int columns = 15;

enum Direction {
  left,
  right,
  down,
}

enum Tetrimino {
  L,
  J,
  I,
  O,
  S,
  Z,
  T,

  /*

    O
    O
    O  O

       O
       O
       O
    O  O

    O
    O
    O
    O

    O  O
    O  O

       O  O
    O  O

    O  O
       O  O

    O
    O  O
    O

   */
}

const Map<Tetrimino, Color> tetriminoColors = {
  Tetrimino.L: Color(0xFFFFA500),
  Tetrimino.J: Color.fromARGB(255, 0, 102, 255),
  Tetrimino.I: Color.fromARGB(155, 242, 0, 255),
  Tetrimino.O: Color(0xFFFFFF00),
  Tetrimino.S: Color(0xFF008000),
  Tetrimino.Z: Color(0xFFFF0000),
  Tetrimino.T: Color.fromARGB(255, 144, 0, 255),

};