use <parts.scad>

$fn=30;

module knight_head() {
  rotate([90, 0, 0])
    linear_extrude(height = 8, convexity = 10,
                   center = true)
      import("knight.dxf");
}

module Knight() {
  intersection() {
    knight_head();
  }
}

Knight();


