use <parts.scad>;

$fn=30;
module Pawn() {
  base_radius = 10;
  base_height = base_radius * 4 / 5;
  neck_radius = radius_of_sphere_slice(base_radius, base_height);
  neck_height = 3 * neck_radius;
  
  piece_body(base_radius) {
    neck(neck_height, neck_radius);
    translate([0, 0, neck_height]) {
      saucer(neck_radius, neck_radius);
      translate([0, 0, neck_radius]) sphere(neck_radius);
    }
  }
}

Pawn();

