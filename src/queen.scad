use <parts.scad>;

$fn=30;

module queen_head(height, radius) {
  rim_height = 0.6 * height;
  rim_radius = 1.75 * radius;
  rim_round = rim_radius / 8;
  rim_cutout_origin_height = 2 * rim_height;
  rim_cutout_angle = 2 * atan(rim_cutout_origin_height / rim_radius);
  rim_valley_radius = 0.8 * rim_radius;

  poof_radius = rim_valley_radius;
  poof_offset = 2 / 3 * rim_height;
  dollop_radius = 0.35 * poof_radius;
  dollop_offset = poof_radius + 0.25 * dollop_radius;

  // the notched rim for the crown
  difference() {
    // make the rounded rim
    // NOTE: we add the rim round because we just need it a little bigger to get the 
    // right size to cut out the crown notches
    rounded_cylinder(rim_height + rim_round, radius, rim_radius + rim_round, rim_round);

    // then cut out the notches in the rim
    translate([0, 0, rim_cutout_origin_height]) {
      for (i = [0 : 10]) {
        rotate([rim_cutout_angle, 0, i * 360 / 10]) 
          cylinder(h = rim_cutout_origin_height, r = rim_radius / 5);
      }
    }

    // then cut out the valley in the crown 
    translate([0, 0, rim_height])
      translate([0, 0, height_of_sphere_slice(rim_height, rim_valley_radius)])
        sphere(rim_height);
  }

  // add the poofy part of crown on top.
  translate([0, 0, poof_offset]) {
    sphere(poof_radius);
    translate([0, 0, dollop_offset])
      sphere(dollop_radius);
  }
}

module Queen(base_radius = 15) {
  base_height = base_radius * 4 / 5;
  neck_radius = radius_of_sphere_slice(base_radius, base_height);
  neck_height = 4.65 * neck_radius;
  inner_collar_radius = 0.65 * neck_radius; 
  outer_collar_radius = neck_radius;
  head_height = 1.5 * base_height;

  piece_body(base_radius) {
    neck(neck_height, neck_radius);
    translate([0, 0, neck_height]) {
      double_collar(inner_collar_radius, outer_collar_radius) {
        queen_head(head_height, inner_collar_radius);
      }
    }
  }
 
}

Queen();
