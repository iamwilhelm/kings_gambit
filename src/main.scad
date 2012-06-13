use <pawn.scad>
use <bishop.scad>
use <rook.scad>
use <knight.scad>
use <queen.scad>
use <king.scad>

chess_square_side = 64;
spacing = chess_square_side / 2;

translate([-(spacing * 3 / 2), -(spacing * 3 / 2), 0]) {
  for (px = [0:3]) {
    for (py = [0:3]) {
      translate([px * spacing, py * spacing, 0]) {
        assign(linear_idx = px * 4 + py) {
          if (linear_idx >= 8) {
            Pawn();
          } else if (linear_idx == 6 || linear_idx == 7) {
            Knight();
          } else if (linear_idx == 4 || linear_idx == 5) {
            Rook();
          } else if (linear_idx == 3 || linear_idx == 2) {
            Bishop();
          } else if (linear_idx == 1) {
            Queen();
          } else if (linear_idx == 0) {
            King();
          }
        }
      }
    }
  }
}
