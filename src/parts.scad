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

module saucer(height, radius) {
  cylinder(height / 2, radius, 0);
  translate([0, 0, -height / 2]) cylinder(height / 2, 0, radius);
}
// saucer(8, 10);

module teardrop(head_ratio, radius) {
  theta = asin(head_ratio);
  r = radius * cos(theta);
  h = r * tan(90 - theta);

  sphere(radius);
  translate([0, 0, radius * head_ratio])
    cylinder(h, r, 0);
    translate([0, 0, 1.1 * h]) child(0);
}

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

module neck(height, radius) {
  union() {
    cylinder(height * 0.2, radius, radius * 0.8);
    cylinder(height, radius * 0.6, radius * 0.8 * 0.6);
  }
}
// neck(20, 10);

module piece_neck(base_radius, neck_base_ratio) {
  base_height = 0.8 * base_radius;
  neck_radius = radius_of_sphere_slice(base_radius, base_height);
  neck_height = neck_base_ratio * base_radius;

  union() {
    base(base_height, base_radius);

    translate([0, 0, base_height]) {
      neck(neck_height, neck_radius);

      translate([0, 0, neck_height]) { 
        for (i = [0 : $children - 1]) {
          child(i);
        }
      }
    }
  }
}

/* calculates the radius of a circle cross-section if we took a slice of a sphere
 * height has to be less than radius 
 */
function radius_of_sphere_slice(radius, height) = 
  radius * cos(asin (height / radius));


