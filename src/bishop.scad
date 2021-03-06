use <parts.scad>;

$fn=30;
module bishop_head(head_ratio, neck_radius) {
  translate([0, 0, neck_radius])
    difference() {
      // the bishop head with a dollop on top
      union() {
        teardrop(head_ratio, neck_radius)
          translate([0, 0, -neck_radius / 3]) sphere(neck_radius / 3);
      }

      // the bishop slot
      rotate(a = -45, v=[0, 1, 0]) 
        translate([neck_radius / 4, -neck_radius, 0]) 
          cube([neck_radius * 2, neck_radius * 2, neck_radius / 4]);
    }
}

module Bishop(base_radius = 14.5) {
  base_height = base_radius * 4 / 5;
  neck_radius = radius_of_sphere_slice(base_radius, base_height);
  neck_height = 3 * neck_radius;
  inner_collar_radius = 0.65 * neck_radius; 
  outer_collar_radius = neck_radius;

  piece_body(base_radius) {
    neck(neck_height, neck_radius);
    translate([0, 0, neck_height]) {
      double_collar(inner_collar_radius, outer_collar_radius) {
        bishop_head(0.45, neck_radius);
      }
    }
  }
}

Bishop();
