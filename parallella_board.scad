module parallella_board() { 
  parallella_width=86.5; // 90mm
  parallella_height=55; // 55mm deep -- credit card size

  base_thickness = 1.6;

  hole_offset_w = 3.1; // offset of holes along width
  hole_offset_h = 3.2; // and along height

  hole_dia = 3;

  heatsink_side = 15;


  union() {

    // expansion headers
    for (i = [0:1]) {
      for (j = [0:1]) {
	translate([ j*(parallella_height-8),
		   6 + i*(parallella_width-26-6-6),
		   0])
	  cube([8, 26,4]);
	  }
    }

	

    translate([0,0,4])

      difference() {

      union() {
	cube([parallella_height, parallella_width, base_thickness]);

	// NB Aside from the ethernet height of 17mm up, the following
	// numbers are all BS. Err, excuse me, approximate.

	// ethernet jack
	translate([hole_offset_w*2+4, -2, base_thickness])
	  cube([15, 22, 13]);

	// power jack
	translate([parallella_height-hole_offset_h*2-8, -2, base_thickness]) 
	  cube([8,16,12]);

	// heat sink

	translate([parallella_height/2-heatsink_side/2,
		   parallella_width/2-heatsink_side/2,
		   base_thickness])
	  cube([heatsink_side, heatsink_side, 10]);



	
      }


      union() {
	for (i = [0:1]) {
	  for (j = [0:1]) {
	    translate([ hole_offset_h + j*48,
		        hole_offset_w + i*80,
			-0.1])
	      cylinder(h=base_thickness+0.2, r=hole_dia/2);
	  }
	}
      }

    }

    
  } 
}

parallella_board();