module unit_base() {

  side_width = 7;
  parallella_h = 55;
  parallella_w = 86;

  base_t = 2;

   standoff_height=6;
   standoff_width=20;
   standoff_vert=10;


  difference() {
    union() {
      translate([0,0,-base_t])
	cube([parallella_h+2*side_width,
	      parallella_w,
	      base_t]);

      for (i = [0,1]) {
	for (j = [0,1]) {
	  translate([side_width+i*(parallella_h-2*3),
		     j*(parallella_w-2*3),
		     -1])
	    difference() {
	    cube([6,6,7]);
	    translate([3,3,-base_t-1]) cylinder(h=6+base_t+2, r=2.9/2);
	  }	     
	}
      }


   

      translate([0,
		 (parallella_w-standoff_width)/2,
		 -1]) 
		 hull() { 
	cube([standoff_height, standoff_width, standoff_vert+1]);

	translate([0,-2.5, 0]) cube([standoff_height+2, standoff_width+5, 1]);
      }

      #translate([parallella_h+side_width*2-standoff_height,
		 (parallella_w-standoff_width)/2,
		 -1]) 		 hull() { 
	cube([standoff_height, standoff_width, standoff_vert+1]);

	translate([-2,-2.5, 0]) cube([standoff_height+2, standoff_width+5, 1]);
      }

    }

    translate([standoff_height/2, parallella_w/2, -10]) cylinder(h=30, r=3/2);
    translate([standoff_height/2, parallella_w/2, -base_t-1]) cylinder(h=3+1, r=6.5/2);



    translate([parallella_h+2*side_width-standoff_height/2, parallella_w/2, -10]) cylinder(h=30, r=3/2);
    translate([parallella_h+2*side_width-standoff_height/2, parallella_w/2, -base_t-1]) cylinder(h=base_t+1, r=6.5/2);


  }


}


//color([0,1,0,0.125])
unit_base();
