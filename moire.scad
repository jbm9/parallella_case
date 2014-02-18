module concentrics(r, tbar, tgap, z) {
  for (i = [0:(tbar+tgap):(r/2)]) {
      difference() {
	cylinder(r=r/2-i, h=z);
	translate([0,0,-1])
	  cylinder(r=r/2-i-tbar, h=z+2);
      }
    }
}


module moire(r, tbar, tgap, z, s) {
  concentrics(r, tbar, tgap, z);
  translate([s,0,0])
    concentrics(r, tbar, tgap, z);
}

module trimoire(r, tbar, tgap, z, s) {
  for  (i = [0:120:359]) {
    rotate([0,0,i])
      translate([s,0,0])
      concentrics(r, tbar, tgap, z);
  }

}



module pentmoire(r, tbar, tgap, z, s) {

  for (i = [0:72:359]) {
    rotate([0,0,i])
      translate([s,0,0])
      concentrics(r, tbar, tgap, z);
  }
}



//translate([50, 50, 0]) concentrics(20, 1,2, 3);
//$fn=50;
//pentmoire(38, 2, 10, 3, 8);

difference() {
  cylinder(r=42/2, h=3);
  translate([0,0,-1])
  cylinder(r=38/2, h=5);
}
intersection() {
  cylinder(r=38/2, h=3);
  trimoire(38, 1.5, 8, 3, 12);
}
 
