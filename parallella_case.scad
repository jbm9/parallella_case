use <unit_base.scad>;
use <unit_top.scad>;

use <parallella_board.scad>;



use <fan40mm.scad>;




color([0,1,0,0.125])
unit_base();

color([1,0,0,0.25])
unit_top();


/*
color([1,1,0,0.5]) translate([7,0,2])  parallella_board();




 translate([27.5-20+7, 43.25-20, 50-12-4])    fan40mm();


*/
