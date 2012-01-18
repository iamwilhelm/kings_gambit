use <parts.scad>;

module Pawn() {
  base_radius = 10;
  base_height = 8;
  body_radius = base_radius * cos(asin (base_height / base_radius));
  body_height = 20;

  union() {
    base(base_height, base_radius);
    translate([0, 0, base_height]) {
      union() {
        body(body_height * 0.2, body_radius);
        body(body_height, body_radius * 0.6);
      }
      translate([0, 0, body_height]) { 
        ring(1, 0, body_radius);
        translate([0, 0, 6]) sphere(6);
      }
    }
  }
}

Pawn();

