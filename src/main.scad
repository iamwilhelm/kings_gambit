use <pawn.scad>
use <bishop.scad>
use <rook.scad>

for (px = [0:3]) {
  for (py = [0:3]) {
    translate([px * 30, py * 30, 0]) {
      assign(linear_idx = px * 4 + py) {
        echo(linear_idx);
        if (linear_idx < 8) {
          echo("pawn");
          Pawn(10);
        } else if (linear_idx == 8 || linear_idx == 9) {
          echo("bishop");
          Bishop(12);
        } else if (linear_idx == 10 || linear_idx == 11) {
          Rook(12);
        }
      }
    }
  }
}
