
module printBar() {
    cylinder(15, 2, 2, $fn=50);
    cylinder(17, 0.9, 0.9, $fn=50);
    translate([0,0,17])
        sphere(0.9, $fn=50);
}

module espBar(corner = 0) {
rotate([0,0,corner*90])
    translate([-1.5,-1.5,0])
    cube([4,4,10]);
    cylinder(12, 1.25, 1.25, $fn=50);
    translate([0,0,12])
        sphere(1.25, $fn=50);
}



module solderJig() {
cube([50, 4, 4]);
cube([4, 48, 4]);
translate([0,48-4,0])
cube([50, 4, 4]);
translate([50-4,0,0])
cube([4, 48, 4]);


translate([2,2.5,0])
printBar();
translate([50-2,2.5,0])
printBar();

cube([2, 20, 15]);
translate([50-2,0,0])
cube([2, 20, 15]);


translate([50-48.3, 48 - 2.5,0])
espBar(1);

translate([50-4.5, 48 - 2.5,0])
espBar(0);

translate([50-4.5, 48 -25.8 + 2.5,0])
espBar(3);

translate([50-48.3, 48 -25.8 + 2.5,0])
espBar(2);

/*
translate([50-48.3-2.5, 48 - 25.8,10])
color("black", 0.2)
cube([48.3, 25.8, 1.5]);
translate([0,0,15])
color("green", 0.2)
cube([50, 31.5, 1.5]);*/
}

solderJig();
