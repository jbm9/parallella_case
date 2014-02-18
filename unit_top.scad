use <moire.scad>;
use <exp_blob.scad>;


module unit_top() {
  wall_t = 2;
  total_h = 55+7*2;
  total_w = 86;

  base_t = 5;

  height = 40+wall_t-base_t;

  bottom_max = 23-base_t;
  bottom_min = 15-base_t;

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

	// Add the sleeves for the assembly screws
	translate([total_w/2, total_h-standoff_height/2,0]) cylinder(h=height,r=8/2);
	translate([total_w/2, standoff_height/2, 0]) cylinder(h=height,r=8/2);
      } // hull with screw sleeves

      // ////////////////////////////////////////////////////

  
    // cut out central volume
      translate([corner_od/2, corner_od/2, -3])
	union() {
	for(i = [0,total_w-corner_od]) {
	  for (j = [0, total_h-corner_od]) {
	    translate([i,j,0])
	      cylinder(r=corner_id/2, h=height-wall_t+3);
	  }
	}
	translate([wall_t-corner_od/2, 0,0])
	  cube([total_w-2*wall_t, total_h-corner_od, height-wall_t+3]);
	
	translate([0, wall_t-corner_od/2, 0])
	  cube([total_w-corner_od, total_h-2*wall_t, height-wall_t+3]);


      }

    // Cut out all of the lower bottom volume
      translate([-1, corner_od/2, -1]) 
      cube([total_w+2, total_h-corner_od, bottom_min]); 

    // cut out the higher bottom volume on the zero side
      translate([-1, corner_od/2, -1])
	    cube([wall_t+10, total_h-corner_od, bottom_max]);

    
      // Cut out the alignment doodads
    translate([(total_w-standoff_width)/2, -10, -1]) 
      hull() { 
      cube([standoff_width+0.5, total_h+20, standoff_vert+1.5]);
      translate([-2.5,0, 0]) cube([standoff_width+5.5, total_h+20, 1]);
    }


    // Fan hole
    translate([total_w/2, total_h/2, 0]) 
      difference() {
      cylinder(r=(fan_side-2)/2, h=height+3);
      trimoire(38, 1.5, 8, height+3, 12);
  //      pentmoire(38, 0.4, 3, height+3, 4); // sigh. borked.

    }

    translate([total_w/2, total_h/2, height-wall_t-1])
    // fan mounting holes
    for (i = [0:90:359]) {
      rotate([0,0,i+45]) translate([32/2*sqrt(2), 0, 0]) cylinder(r=3/2, h=wall_t+2);
    }


    // power jack hole
    translate([-5, 30, (height+bottom_max)/2]) rotate([0, 90, 0]) cylinder(r=8/2, h=10);


    // binding screws
    // Add the sleeves for the assembly screws
    translate([total_w/2, total_h-standoff_height/2,0]) cylinder(h=height-wall_t,r=5/2);
    translate([total_w/2, standoff_height/2, 0]) cylinder(h=height-wall_t,r=5/2);
    
  } // difference with central chamber

  translate([total_w/2-4.5, standoff_height/2-3, height-wall_t-6])
    difference() {
     cube([9,9,6]);
     translate([1, 1, 3]) cube([7, 9, 3]);
     translate([4.5,3,0]) cylinder(r=5/2, h=30);
    translate([4.5,3,3]) cylinder(r=7/2, h=3);
  }


  translate([total_w/2-4.5, total_h-(standoff_height/2-3), height-wall_t-6])
    mirror([0,1,0])
    difference() {
    cube([9,9,6]);
     translate([1, 1, 3]) cube([7, 9, 3]);
    translate([4.5,3,0]) cylinder(r=5/2, h=30);
    translate([4.5,3,3]) cylinder(r=7/2, h=3);
  }




  // Add the support structures
  translate([15, wall_t, -0.1])
    rotate([0,0,90])
    union() {
    exp_blob(0.5,7.5,0.1,10, height-wall_t, 10, 10);
    mirror([0,1,0] ) exp_blob(0.5,7.5,0.1,10, height-wall_t, 10, 10);
  }

translate([total_w-15, wall_t, -0.1])
    rotate([0,0,90])
    union() {
    exp_blob(0.5,7.5,0.1,10, height-wall_t, 10, 10);
    mirror([0,1,0] ) exp_blob(0.5,7.5,0.1,10, height-wall_t, 10, 10);
  }



 translate([0,total_h,0])
 mirror([0,1,0]) {
   // Add the support structures
   translate([15, wall_t, -0.1])
     rotate([0,0,90])
     union() {
     exp_blob(0.5,7.5,0.1,10, height-wall_t, 10, 10);
     mirror([0,1,0] ) exp_blob(0.5,7.5,0.1,10, height-wall_t, 10, 10);
   }

   translate([total_w-15, wall_t, -0.1])
     rotate([0,0,90])
     union() {
     exp_blob(0.5,7.5,0.1,10, height-wall_t, 10, 10);
     mirror([0,1,0] ) exp_blob(0.5,7.5,0.1,10, height-wall_t, 10, 10);
   }
 }


// check fan footprint
//   color([0.5,0.5,1,0.1])  translate([total_w/2-20, total_h/2-20, height+3]) cube([40,40,1]);

}




module unit_top_old() {
  wall_t = 2;
  total_h = 55+7*2;
  total_w = 86;

  base_t = 5;

  height = 40-base_t;

  bottom_max = 23-base_t;
  bottom_min = 15-base_t;

  fan_side = 40;
  fan_hole_d = 3;
  fan_hole_offset = 3;

  fan_hole_delta = fan_side-2*fan_hole_offset;

  center_h = total_h/2;
  center_w = total_w/2;


  standoff_height=6;
  standoff_width=20+0.5;
  standoff_vert=10+0.5;

  corner_id = 6;
  corner_od = 12;

  difference() {
    union() {
      difference() {
	  hull() {
	    intersection() {
	      union() {
		for (i = [0,1]) {
		  for (j = [0,1]) {
#		      translate([corner_od/2+i*(total_h-corner_od),
		    corner_od/2+j*(total_w-corner_od),
		      0])
		  difference() {
		    cylinder(r=corner_od/2, h=height);
		    cylinder(r=corner_id/2, h=height);
		    cube([corner_od,corner_od,height]);
		  }
	      }
	    }

	    // main case
	    cube([total_h, total_w, height]);


	  }
	}


	// Add the sleeves for the assembly screws
	translate([total_h-standoff_height/2, total_w/2, 0]) cylinder(h=height,r=8/2);
	translate([standoff_height/2, total_w/2, 0]) cylinder(h=height,r=8/2);
   
      }
      // cut out central volume
      translate([wall_t, -10, -1])
	cube([total_h-2*wall_t, total_w+20, height-wall_t+1]);
    }	  
    // Add back one endwall
    translate([0,0,bottom_max])
      cube([total_h, wall_t, height-bottom_max]);

    // add back the other endwall
    translate([0,total_w-wall_t,bottom_min])
      cube([total_h, wall_t, height-bottom_min]);

  }

  // ////////////////////////////////////////////////////

  // Add the support structures
  translate([wall_t, 15, -0.1])
    union() {
    exp_blob(0.5,7.5,0.1,10, height-wall_t, 10, 10);
    mirror([0,1,0] ) exp_blob(0.5,7.5,0.1,10, height-wall_t, 10, 10);
  }

  translate([wall_t, total_w-15, -0.1])
    union() {
    exp_blob(0.5,7.5,0.1,10, height-wall_t, 10, 10);
    mirror([0,1,0] ) exp_blob(0.5,7.5,0.1,10, height-wall_t, 10, 10);
  }


  translate([total_h,0,0]) mirror([1,0,0]) {
    translate([wall_t, 15, -0.1])
      union() {
      exp_blob(0.5,7.5,0.1,10, height-wall_t, 10, 10);
      mirror([0,1,0] ) exp_blob(0.5,7.5,0.1,10, height-wall_t, 10, 10);
    }

    translate([wall_t, total_w-15, -0.1])
      union() {
      exp_blob(0.5,7.5,0.1,10, height-wall_t, 10, 10);
      mirror([0,1,0] ) exp_blob(0.5,7.5,0.1,10, height-wall_t, 10, 10);
    }
  }





  // ////////////////////////////////////////////////////
  // Fan stuff

  // fan mounting holes
  for (i = [-1,1]) {
    for (j = [-1,1]) {
      translate([ center_h+i*fan_hole_delta/2,
		  center_w+j*fan_hole_delta/2,
		  height-wall_t-1])
	cylinder(h=wall_t+2, r=fan_hole_d/2);
    }
  }

  // Main fan hole
  translate([center_h, center_w, height-wall_t-1])
    cylinder(h=wall_t+2, r=(fan_side-2)/2);



  // //////////////////////////////////////////////////
  // Cut out the standoff/alignment notches
    
  translate([-10, (total_w-standoff_width)/2, -1]) 
    hull() { 
    cube([total_h+20, standoff_width+0.5, standoff_vert+1.5]);
    translate([0,-2.75, 0]) cube([total_h+20, standoff_width+5.5, 1]);
  }


  // //////////////////////////////////////////////////
  // Screw holes for assembly
  translate([total_h-standoff_height/2, total_w/2, 0]) cylinder(h=height,r=5/2);
  translate([standoff_height/2, total_w/2, 0]) cylinder(h=height,r=5/2);

  translate([total_h-standoff_height/2, total_w/2, height-wall_t]) rotate([0,0,30]) cylinder(h=wall_t+1, r=3.5, $fn=6);
  translate([standoff_height/2, total_w/2, height-wall_t]) rotate([0,0,30]) cylinder(h=wall_t+1, r=3.5, $fn=6);




}
}

rotate([-180,0,0]) unit_top();


/*translate([0,20,0]) cylinder(r=10, $fn=100, h=4);
  translate([0,20,4]) cylinder(r=10, $fn=6);*/
