use <m3.scad>;
use <unit_base.scad>;
use <unit_top.scad>;

use <parallella_board.scad>;

use <fan_40mm.scad>;

  wall_t = 2;
  total_h = 55+7*2;
  total_w = 86;

  base_t = 5;

  height = 40+wall_t-base_t;

  standoff_height=6;
  standoff_width=20+0.5;
  standoff_vert=10+0.5;


color([0.75,0,0,1]) translate([0,0,7]) unit_top();


//color([1,1,0,0.5]) translate([0.3,55+7-0.6,3]) rotate([0,0,-90]) parallella_board();
color([0,0.5,0,1]) translate([0,0,0]) unit_base();

color([1,1,1,1]) translate([0,20,5]) cube([100,100,100]);


/*color([1,0,0,1]) intersection() {
  translate([0,55+7,5]) rotate([0,0,-90]) parallella_board();
  unit_base();
}
*/


color([0.5,0.5,0.5,1]) 
translate([total_w/2, total_h-standoff_height/2,0]) m3s40();
color([0.5,0.5,0.5,1]) 
translate([total_w/2, standoff_height/2, 0]) m3s40();


/*
 translate([27.5-20+7, 43.25-20, 50-12-4])    fan40mm();


*/
