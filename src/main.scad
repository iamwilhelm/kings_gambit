use <pawn.scad>
use <bishop.scad>
use <rook.scad>
use <knight.scad>
use <queen.scad>

chess_square_side = 64;
spacing = chess_square_side / 2;

translate([-(spacing * 3 / 2), -(spacing * 3 / 2), 0]) {
  for (px = [0:3]) {
    for (py = [0:3]) {
      translate([px * spacing, py * spacing, 0]) {
        assign(linear_idx = px * 4 + py) {
          echo(linear_idx);
          if (linear_idx >= 8) {
            Pawn(10);
          } else if (linear_idx == 6 || linear_idx == 7) {
            Knight(12);
          } else if (linear_idx == 4 || linear_idx == 5) {
            Rook(12);
          } else if (linear_idx == 3 || linear_idx == 2) {
            Bishop(12);
          } else if (linear_idx == 1) {
            Queen(15);
            % cylinder(r=15, h=75);
          } else if (linear_idx == 0) {
            // US Chess Federation's official rules of chess state that 
            // King's diameter is about 40% of its height 
            cylinder(r=15, h=80);
          }
        }
      }
    }
  }
}
