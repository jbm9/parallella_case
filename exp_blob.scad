module exp_slice(w1, w2, h, z, nsteps) {

  dw = w2-w1;

  union() {
    for (k = [0:1:(nsteps)]) {

      translate([0,0,z*(1 - k/nsteps)])

	//	cube([w1, h1, 1] + k* [ dw, dh, 0 ]/nsteps);

	cube([w2,h,z/nsteps] + [ -dw*sqrt(1-(k/nsteps)*(k/nsteps)),
			   0,
			   0
			  ]);
    }
  }

}

module ell_slice(w1, w2, h1, h2, z, n) {
  difference() {
    cube([w2,h2,z]);
    translate([w2,h2,-1]) scale([(w2-w1),(h2-h1),1]) cylinder(r=1, h=z+2, $fn=n*4);
  }
}




module exp_blob(w1, w2, h1, h2, z, nsteps_w, nsteps_h) {

  dw = w2-w1;
  dh = h2-h1;


  dz = z/nsteps_w;

  translate([0,0,0])
  union() {
    for (k = [0:(1/nsteps_w):((nsteps_w-1)/nsteps_w)]) {
      translate([0,0,z*k])
	ell_slice(h1, h2-dh*sqrt(1-k*k), w1, w2-dw*sqrt(1-k*k), dz+0.1, nsteps_h);
    }
  }
}


//translate([20,0,0]) exp_slice(1,20, 3, 15, 8);

exp_blob(1, 20, 1, 10, 30, 4,3);
/*
cube(10,10,10);
*/
//translate([20,0,0]) rotate([90,0,0]) ell_slice(1, 20, 0, 15, 3, 8);

