use <parts.scad>;

$fn=30;
module Pawn() {
  base_radius = 10;
  base_height = base_radius * 4 / 5;
  body_radius = base_radius * cos(asin (base_height / base_radius));
  
  piece_body(base_radius, 2) {
    saucer(body_radius, body_radius);
    translate([0, 0, body_radius]) sphere(body_radius);
  }
}

Pawn();

