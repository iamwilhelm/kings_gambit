use <parts.scad>;

$fn=30;
module bishop_head(head_ratio, body_radius) {
  head_ratio = 0.45;
  theta = asin(head_ratio);
  r = body_radius * cos(theta);
  h = r * tan(90 - theta);
 
  difference() {
    union() {
      sphere(body_radius);
      translate([0, 0, body_radius * head_ratio]) {
        cylinder(h, r, 0);
        translate([0, 0, h - body_radius / 3]) sphere(body_radius / 3);
      }
    }

    // the bishop slot
    rotate(a = -45, v=[0, 1, 0]) translate([2, -8, 0]) cube([16, 16, 2]);
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
