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
  rotate([110, 0, 90])
    translate([-4.1, 0, 0])
      linear_extrude(height = 25, convexity = 10, center = true)
        import("knight_face.dxf");
}

// specialized module to angularlize the horse's face
module angle_face() {
  translate([0, 0, 9])
    rotate([0, 15, 0])
      translate([0, 0, -9.5])
        child(0);
}

module knight_head(radius, ratio = 1.8) {
  neck_countersink_ratio = 1.6 / 1.8 * ratio;
  neck_mid_height = ratio * 100 / 18;
  height = ratio * 16;

  difference() {
    scale(ratio) {
      intersection() {
        knight_profile();
        angle_face() knight_face();
      }
    }

    // countersunk ring to fit the horse on the base
    countersunk_ring(neck_mid_height, 
                     [radius, neck_countersink_ratio * radius], 
                     ratio * radius);
  }
}

module Knight(base_radius = 12) {
  base_height = base_radius * 4 / 5;
  neck_radius = radius_of_sphere_slice(base_radius, base_height);
  neck_height = 4;

  piece_body(base_radius) {
    toytop(base_radius, 1.4 * neck_radius); // glue
    knight_head(neck_radius);
  }
}

Knight();

