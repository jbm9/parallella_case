use <unit_base.scad>;

use <parallella_board.scad>;



use <fan40mm.scad>;



module unit_top() {
  wall_t = 4;
  total_h = 55+7*2;
  total_w = 86;

  height = 50;

  fan_side = 40;
  fan_hole_d = 3;
  fan_hole_offset = 3;

  fan_hole_delta = fan_side-2*fan_hole_offset;

  center_h = total_h/2;
  center_w = total_w/2;


   standoff_height=6;
   standoff_width=20+0.5;
   standoff_vert=10+0.5;

  difference() {
    cube([total_h, total_w, height]);

    translate([wall_t, -10, -1])
      cube([total_h-2*wall_t, total_w+20, height-wall_t+1]);


    // fan mounting holes
    for (i = [-1,1]) {
      for (j = [-1,1]) {
	translate([ center_h+i*fan_hole_delta/2,
		    center_w+j*fan_hole_delta/2,
		    height-wall_t-1])
	  cylinder(h=wall_t+2, r=fan_hole_d/2);
      }
    }

    translate([center_h, center_w, height-wall_t-1])
      cylinder(h=wall_t+2, r=(fan_side-10)/2);


    
    translate([-0.5, (total_w-standoff_width)/2, -1]) cube([8, standoff_width, standoff_vert+1]);
    translate([total_h-standoff_height, (total_w-standoff_width)/2, -1]) cube([8, standoff_width, standoff_vert+1]);

    translate([total_h-standoff_height/2, total_w/2, 0]) cylinder(h=30,d=3);
    translate([standoff_height/2, total_w/2, 0]) cylinder(h=30,d=3);


  }
}


color([0,1,0,0.125])
unit_base();

color([1,1,0,0.5]) translate([7,0,2])  parallella_board();




 color([1,0,0,0.25])
 unit_top();
 translate([27.5-20+7, 43.25-20, 50-12-4])    fan40mm();


