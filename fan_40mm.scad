
module fan40mm() {
  difference() {
    cube([40,40,12]);
    translate([20,20,-0.1]) cylinder(h=12+0.2, r=30/2);

    for (i = [0:1]) {
      for (j = [0:1]) {
	translate([ 3 + j*(40-2*3),
		    3 + i*(40-2*3),
		    -0.1])
	  cylinder(h=12+0.2, r=3/2);
      }
    }
  }
}

