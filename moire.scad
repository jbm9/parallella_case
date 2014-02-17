module concentrics(r, tbar, tgap, z) {
  for (i = [0:(tbar+tgap):r]) {
      difference() {
	cylinder(r=r-i, h=z);
	translate([0,0,-1])
	  cylinder(r=r-i-tbar, h=z+2);
      }
    }
}


module moire(r, tbar, tgap, z, s) {
  concentrics(r, tbar, tgap, z);
  translate([s,0,0])
    concentrics(r, tbar, tgap, z);
}

module trimoire(r, tbar, tgap, z, s) {
  concentrics(r, tbar, tgap, z);
  translate([s*cos(60),s*sin(60),0])
    concentrics(r, tbar, tgap, z);
  translate([s,0,0])
    concentrics(r, tbar, tgap, z);
}



module pentmoire(r, tbar, tgap, z, s) {

  for (i = [0:72:359]) {
    rotate([0,0,i])
      translate([s,0,0])
      concentrics(r, tbar, tgap, z);
  }
}



translate([50, 50, 0]) concentrics(20, 1,2, 3);

pentmoire(38, 0.4, 3, 3, 2);
