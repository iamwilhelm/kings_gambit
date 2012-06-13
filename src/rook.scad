use <parts.scad>;

$fn=30;

module rook_neck(height, radius) {
  cylinder(height, radius, 0.9 * radius);
  translate([0, 0, height]) {
    for (i = [0 : $children - 1]) {
      child(0);
    }
  }
}

module rook_collar(radius) {
  collar_radius = 1.2 * radius;
  collar_cone_height = 1.2 * radius;
  collar_height = height_of_cone_slice(collar_radius, 
                                       collar_cone_height, 
                                       radius);

  translate([0, 0, collar_height]) {
    saucer(2 * collar_cone_height, collar_radius, radius);
    translate([0, 0, collar_height]) {
      child(0);
    }
  }
}

module rook_battlement(height, radius) {
  neck_radius = radius;
  battlement_radius = 1.4 * radius;
  inner_battlement_radius = 0.6 * battlement_radius;

  cylinder(0.2 * height, neck_radius, battlement_radius);
  translate([0, 0, 0.2 * height]) {
    difference() {
      // the battlement
      cylinder(0.8 * height, battlement_radius, battlement_radius);

      // cut out the loopholes
      for (i = [0:5]) {
        rotate(a = [0, 0, i * 360 / 6]) 
          translate([-1.5, 0, 0.5 * height])
            cube([3, 10, 4]);
      }

      // cut out circular space at top
      translate([0, 0, 0.5 * height]) {
        cylinder(height, inner_battlement_radius, inner_battlement_radius);
        sphere(inner_battlement_radius);
      }
    }
  }
}

module Rook(base_radius = 14.5) {
  base_height = base_radius * 4 / 5;
  neck_bottom_radius = radius_of_sphere_slice(base_radius, base_height);
  neck_top_radius = 0.9 * neck_bottom_radius; // should be encapsulated in rook neck
  neck_height = 4 * neck_bottom_radius;

  piece_body(base_radius) {
    rook_neck(neck_height, neck_bottom_radius) {
      rook_collar(neck_top_radius) {
        rook_battlement(10, neck_top_radius) {
          translate([0, 0, 10]) sphere(5);
        }

      }
    }
  }
}

Rook();
