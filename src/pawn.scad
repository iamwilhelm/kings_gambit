use <parts.scad>;

$fn=30;
module Pawn() {
  base_radius = 10;
  base_height = base_radius * 4 / 5;
  neck_radius = radius_of_sphere_slice(base_radius, base_height);
  
  piece_neck(base_radius, 2) {
    saucer(neck_radius, neck_radius);
    translate([0, 0, neck_radius]) sphere(neck_radius);
  }
}

Pawn();

