use <pawn.scad>
use <bishop.scad>
use <rook.scad>

translate([-45, -45, 0]) {
  for (px = [0:3]) {
    for (py = [0:3]) {
      translate([px * 30, py * 30, 0]) {
        assign(linear_idx = px * 4 + py) {
          echo(linear_idx);
          if (linear_idx >= 8) {
            echo("pawn");
            Pawn(10);
          } else if (linear_idx == 6 || linear_idx == 7) {
            Bishop(12);
          } else if (linear_idx == 4 || linear_idx == 5) {
            Rook(12);
          }
        }
      }
    }
  }
}

