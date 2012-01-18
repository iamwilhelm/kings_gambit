/* Basic elementary shapes and negative space */

module ring(height, inner_radius, outer_radius) {
  difference() {
    cylinder(height, outer_radius, outer_radius);
    cylinder(height, inner_radius, inner_radius);
  }
}

module groove(height, inner_radius, offset) {
  difference() {
    child(0);
    translate([0, 0, offset]) {
      ring(height, inner_radius, 2 * inner_radius);
    }
  }
}
// groove(3, 5, 5) cylinder(10, 6, 6);

/* Building parts for chess pieces */
module base(height = 5, radius) {
  indent_height = 3;
  indent_ratio = 0.6;
  indent_groove = height * indent_perc * 0.4;
  indent_offset = height * indent_perc * 0.6;

  groove(height * 0.15, radius * 0.8, height * 0.3) {
    intersection() {
      cylinder(h = height, r = radius);
      sphere(radius);
    }
  }
}

module body(height, radius) {
  cylinder(height, radius, radius * 0.8);
}


