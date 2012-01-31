use <parts.scad>;

$fn=30;
module bishop_head(head_ratio, neck_radius) {
  difference() {
    // the bishop head with a dollop on top
    union() {
      teardrop(head_ratio, neck_radius)
        sphere(neck_radius / 3);
    }

    // the bishop slot
    rotate(a = -45, v=[0, 1, 0]) 
      translate([neck_radius / 4, -neck_radius, 0]) 
        cube([neck_radius * 2, neck_radius * 2, neck_radius / 4]);
  }
}

module Bishop() {
  base_radius = 12;
  base_height = base_radius * 4 / 5;
  neck_radius = radius_of_sphere_slice(base_radius, base_height);
  neck_height = 4 * neck_radius;

  piece_body(base_radius) {
    neck(neck_height, neck_radius);
    translate([0, 0, neck_height]) {
      saucer(neck_radius, neck_radius);
      translate([0, 0, neck_radius * 0.5]) {
        saucer(10, neck_radius * 0.8);
        translate([0, 0, neck_radius]) { 
          bishop_head(0.45, neck_radius);
        }
      }
    }
  }
}

Bishop();
