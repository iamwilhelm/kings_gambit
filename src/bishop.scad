use <parts.scad>;

$fn=30;
module teardrop(head_ratio, radius) {
  theta = asin(head_ratio);
  r = radius * cos(theta);
  h = r * tan(90 - theta);

  sphere(radius);
  translate([0, 0, radius * head_ratio])
    cylinder(h, r, 0);
    translate([0, 0, 1.1 * h]) child(0);
}

module bishop_head(head_ratio, body_radius) {

  difference() {
    union() {
      teardrop(head_ratio, body_radius)
        sphere(body_radius / 3);
    }

    // the bishop slot
    rotate(a = -45, v=[0, 1, 0]) 
      translate([body_radius / 4, -body_radius, 0]) 
        cube([body_radius * 2, body_radius * 2, body_radius / 4]);
  }

}

module Bishop() {
  base_radius = 12;
  base_height = base_radius * 4 / 5;
  body_radius = base_radius * cos(asin (base_height / base_radius));

  piece_body(base_radius, 2.5) {
    saucer(body_radius, body_radius);
    translate([0, 0, body_radius * 0.5]) {
      saucer(10, body_radius * 0.8);
      translate([0, 0, body_radius]) { 
        bishop_head(0.45, body_radius);
      }
    }
  }
}

Bishop();
