use <parts.scad>

$fn=30;

module knight_profile() {
  rotate([90, 0, 0])
    translate([-7, 0, 0])
      linear_extrude(height = 10, convexity = 10, center = true)
        import("knight_profile.dxf");
}

// every 15px in inkscape is 4 units in openscad
module knight_face() {
  rotate([90, 0, 90])
    translate([-4.1, 0, 0])
      linear_extrude(height = 25, convexity = 10, center = true)
        import("knight_face.dxf");
}

module knight_angled() {
  translate([0, 0, 9])
    rotate([0, 15, 0])
      translate([0, 0, -9.5])
        child(0);
}

module knight_head(radius) {
  difference() {
    scale(1.8) {
      intersection() {
        knight_profile();
        knight_angled() knight_face();
      }
    }

    // countersunk ring
    difference() {
      cylinder(10, 2 * radius, 2 * radius);
      cylinder(10, radius, 1.6 * radius);
    }
  }
}

module Knight(base_radius = 12) {
  base_height = base_radius * 4 / 5;
  neck_radius = radius_of_sphere_slice(base_radius, base_height);
  neck_height = 4;

  piece_body(base_radius) {
    cylinder(base_radius / 4, neck_radius, neck_radius); // glue
    knight_head(neck_radius);
  }
}

Knight();

