use <parts.scad>;

$fn=30;

module cross(height, width, depth, thickness) {
  // vertical bar
  translate([0, 0, height / 2])
    cube([depth, thickness, height], center = true);
  // horizontal bar
  translate([0, 0, height - thickness])
    cube([depth, width, thickness], center = true);
}

module holy_hand_grenade(height, radius) {
  cross_height = height - radius;
  cross_width = 1.25 * radius;
  cross_depth = 0.2 * height;
  cross_thickness = 0.4 * height;

  sphere(radius);
  translate([0, 0, 0.5 * radius])
    cross(cross_height + 1.5 * radius, cross_width, cross_depth, cross_thickness);
}

module king_head(height, radius) {
  crown_height = 0.8 * height;
  crown_radius = 1.75 * radius;
  crown_round = crown_radius / 8;

  crown_rim_offset = 0.2 * height;
  crown_rim_radius = 0.4 * height;
  crown_rim_bump_radius = 0.1 * crown_rim_radius;

  cross_height = 0.4 * height;
  cross_radius = 0.8 * radius;

  rounded_cylinder(crown_height, radius, crown_radius, crown_round); 
  translate([0, 0, crown_rim_offset])
    torus(crown_rim_radius, crown_rim_bump_radius);
  translate([0, 0, crown_height - cross_radius / 2])
    holy_hand_grenade(cross_height, cross_radius);
}

module King(base_radius = 15) {
  base_height = base_radius * 4 / 5;
  neck_radius = radius_of_sphere_slice(base_radius, base_height);
  neck_height = 4.5 * neck_radius;
  inner_collar_radius = 0.65 * neck_radius; 
  outer_collar_radius = neck_radius;
  head_height = 1.5 * base_height;

  piece_body(base_radius) {
    neck(neck_height, neck_radius);
    translate([0, 0, neck_height]) {
      double_collar(inner_collar_radius, outer_collar_radius) {
        king_head(head_height, inner_collar_radius);
      }
    }
  }
}

King();
