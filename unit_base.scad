module unit_base() {
  wall_t = 2;
  total_h = 55+7*2;
  total_w = 86;

  base_t = 7;

  bottom_max = 20-base_t;
  bottom_min = 12-base_t;

  fan_side = 40;
  fan_hole_d = 3;
  fan_hole_offset = 3;

  fan_hole_delta = fan_side-2*fan_hole_offset;

  center_h = total_h/2;
  center_w = total_w/2;


  standoff_height=6;
  standoff_width=20+0.5;
  standoff_vert=10+0.5;

  corner_od = 12;
  corner_id = corner_od-wall_t;

  pad_d = 8;

  height = base_t+standoff_vert;


  difference() {

    hull() {
      union() {
	translate([corner_od/2, 0,0])
	  cube([total_w-corner_od, total_h, height]); 
	translate([0,corner_od/2,0])
	  cube([total_w, total_h-corner_od, height]);
      
	for (i = [0,1]) {
	  for (j = [0,1]) {
	    translate([corner_od/2+i*(total_w-corner_od),
		       corner_od/2+j*(total_h-corner_od),
		       0])
	      cylinder(r=corner_od/2, h=height);
	  }
	}
      } // end radii union


      translate([(total_w-standoff_width)/2, 0, base_t]) 
	hull() { 
	cube([standoff_width+0.5, total_h, standoff_vert+1.5]);
	translate([-2.5,0,0])
	cube([standoff_width+5.5, total_h, 1]);
      }

      // Add the sleeves for the assembly screws
      translate([total_w/2, total_h-standoff_height/2,0]) cylinder(h=height,r=8/2);
      translate([total_w/2, standoff_height/2, 0]) cylinder(h=height,r=8/2);
    } // hull with screw sleeves

    // ////////////////////////////////////////////////////
    // Now to remove a bunch of stuff

    // Remove the board's space under the hangers
    translate([-1, corner_od/2+pad_d, base_t-5]) cube([total_w+2, total_h-corner_od-2*pad_d, 5+100]);
    translate([pad_d-1, corner_od/2, base_t-5]) cube([total_w-2*pad_d+2, total_h-corner_od, 5+100]);


    // Remove some screw holes

    for (i = [0,1]) {
      for (j = [0,1]) {
	translate([pad_d/2-1+i*80,
		   corner_od/2+pad_d/2+j*48,
		   0])
	  cylinder(r=3/2, h=height+4);
      }
    }


    // cut out alignment doodads
    translate([0,-1,base_t]) difference() {
      cube([total_w+2, total_h+2, 50]);
      translate([(total_w-standoff_width)/2, -10, 0]) 


	hull() { 
	cube([standoff_width+0.5, total_h+20, standoff_vert+0.4]);
	translate([-2.25,-1]) cube([standoff_width+5, total_h+20, 1]);
      }
    }

    // cut holes for screws

    // binding screws
    // Add the sleeves for the assembly screws
    translate([total_w/2, total_h-standoff_height/2,0]) cylinder(h=50,r=5/2);
    translate([total_w/2, standoff_height/2, 0]) cylinder(h=50,r=5/2);

    translate([total_w/2, total_h-standoff_height/2,-1]) cylinder(h=3+1,r=6.5/2);
    translate([total_w/2, standoff_height/2, -1]) cylinder(h=3+1,r=6.5/2);


    

  } // difference()
}


//color([0,1,0,0.125])
unit_base();
