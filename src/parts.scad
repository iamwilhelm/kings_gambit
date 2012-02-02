/* Basic elementary shapes and negative space */

module ring(height, inner_radius, outer_radius) {
  difference() {
    cylinder(height, outer_radius, outer_radius);
    cylinder(height, inner_radius, inner_radius);
  }
} 
// ring(10, 8, 12);
 
module groove(height, inner_radius, offset) {
  difference() {
    child(0);
    translate([0, 0, offset]) {
      ring(height, inner_radius, 2 * inner_radius);
    }
  }
}
// groove(3, 5, 5) cylinder(10, 6, 6);

module toytop(height, radius) {
  cylinder(height / 2, radius, 0);
  translate([0, 0, -height / 2]) cylinder(height / 2, 0, radius);
}

module saucer(height, radius, inner_radius) {
  slice_height = height_of_cone_slice(radius, height / 2, inner_radius);

  difference() {
    toytop(height, radius);
    for (i = [0 : 1]) {
      mirror([0, 0, i]) 
        translate([0, 0, slice_height]) 
          cylinder(height, inner_radius, inner_radius);
    }
  }
}
// saucer(8, 10, 5);

module teardrop(head_ratio, radius) {
  theta = asin(head_ratio);
  r = radius * cos(theta);
  h = r * tan(90 - theta);

  sphere(radius);
  translate([0, 0, radius * head_ratio]) {
    cylinder(h, r, 0);
    translate([0, 0, 1.1 * h]) child(0);
  }
}
// teardrop(0.5, 10);

/* Building parts for chess pieces */
module base(height = 5, radius) {
  indent_height = 3;
  indent_ratio = 0.6;
  indent_groove = height * 0.4;
  indent_offset = height * 0.6;

  groove(height * 0.15, radius * 0.8, height * 0.3) {
    intersection() {
      cylinder(h = height, r = radius);
      sphere(radius);
    }
  }
}
// base(10, 10);

module neck(height, radius) {
  union() {
    cylinder(height * 0.2, radius, radius * 0.8);
    cylinder(height, radius * 0.6, radius * 0.8 * 0.6);
  }
}
// neck(20, 10);

module double_collar(neck_radius) {
  toytop(neck_radius, neck_radius);
  translate([0, 0, neck_radius * 0.5]) {
    toytop(10, neck_radius * 0.8);
    translate([0, 0, neck_radius]) { 
      for (i = [0 : $children - 1]) {
        child(i);
      }
    }
  }
}
// double_collar(10);

module piece_body(base_radius) {
  base_height = 0.8 * base_radius;

  union() {
    base(base_height, base_radius);

    translate([0, 0, base_height]) { 
      for (i = [0 : $children - 1]) {
        child(i);
      }
    }
  }
}
// piece_body(10);

/* calculates the radius of a circle cross-section if we took a slice of a sphere
 * height has to be less than radius 
 */
function radius_of_sphere_slice(radius, slice_height) = 
  radius * cos(asin(slice_height / radius));

/* calculate the height from midpoint of circle cross-section if we took a slice of 
 * a sphere */
function height_of_sphere_slice(radius, slice_radius) = 
  radius * sin(acos(slice_radius / radius));

/* calculates the radius of a perpendicular slice of a cone given the slice height */
function radius_of_cone_slice(radius, cone_height, slice_height) = 
  radius * (1 - slice_height / cone_height);

/* calculates the height of a perpendicular slice of a cone given the slice radius */
function height_of_cone_slice(radius, cone_height, slice_radius) = 
  cone_height * (1 - slice_radius / radius);

