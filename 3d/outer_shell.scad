use <rounded.scad>;

height = 154;



// To extract
//inside
//roundedTube(height + 2, 71, 74, 9, 5);
//outside
//roundedTube(height + 2, 75, 78, 11, 5);

module magnetClamp() {
translate([-10, -10, 0])
union() {
translate([5, 2, 0])
    difference() {
linear_extrude(4)
square([3, 16]);
    translate([-.5, -3.5, 0])
rotate([30,0,0])    
linear_extrude(4)
square([4, 16]);
    translate([-.5, 8, 6.5])
rotate([-30,0,0])    
linear_extrude(4)
square([4, 16]);
    }
    
translate([12, 2, 0])
    difference() {
linear_extrude(4)
square([3, 16]);
    translate([-.5, -3.5, 0])
rotate([30,0,0])    
linear_extrude(4)
square([4, 16]);
    translate([-.5, 8, 6.5])
rotate([-30,0,0])    
linear_extrude(4)
square([4, 16]);
    }

    
}


}

module magnetHole() {
    translate([0,0,-1])
cylinder(4, 4, 4, $fn = 100);
}
module magnet() {
cylinder(3, 4, 4, $fn = 100);
}

//color("black", 0.5)
module outerShell() {
difference() {
union() {
roundedTube(height, 65, 68, 6, 2);


// Magnet holes at front
translate([0,34,20])
rotate([90,0,0])
magnetClamp();

rotate([0,0,90])
translate([10,32.5,30])
rotate([90,0,0])
magnetClamp();

rotate([0,0,180])
translate([0,34,20])
rotate([90,0,0])
magnetClamp();

rotate([0,0,270])
translate([-10,32.5,30])
rotate([90,0,0])
magnetClamp();

// Magnet holes at back

translate([0,34,90])
rotate([90,0,0])
magnetClamp();

rotate([0,0,90])
translate([-10,32.5,80])
rotate([90,0,0])
magnetClamp();

rotate([0,0,180])
translate([0,34,90])
rotate([90,0,0])
magnetClamp();

rotate([0,0,270])
translate([10,32.5,80])
rotate([90,0,0])
magnetClamp();


}

// Magnet holes at front
translate([0,34,20])
rotate([90,0,0])
    magnetHole();
rotate([0,0,90])
translate([10,32.5,30])
rotate([90,0,0])
    magnetHole();
rotate([0,0,180])
translate([0,34,20])
rotate([90,0,0])
    magnetHole();
rotate([0,0,270])
translate([-10,32.5,30])
rotate([90,0,0])
    magnetHole();

// Magnet holes at back
translate([0,34,90])
rotate([90,0,0])
    magnetHole();
rotate([0,0,90])
translate([-10,32.5,80])
rotate([90,0,0])
    magnetHole();
rotate([0,0,180])
translate([0,34,90])
rotate([90,0,0])
    magnetHole();
rotate([0,0,270])
translate([10,32.5,80])
rotate([90,0,0])
    magnetHole();

// Hall actuator magnets holes
rotate([0,0,180])
translate([0,35,50])
rotate([90,0,0])
cylinder(4, 2.5, 2.5, $fn = 50);
rotate([0,0,270])
translate([0,33.5,50])
rotate([90,0,0])
cylinder(4, 2.5, 2.5, $fn = 50);

// Hall sensor locations
translate([-2.5,32.5,48])
rotate([90,0,0])
cube([5, 4, 1]);

rotate([0,0,90])
translate([-2.5,31,48])
rotate([90,0,0])
cube([5, 4, 1]);

// Forsænkning
for ( s = [0:1] ) 
for ( h = [0:1] ) {
// Inner shell screw holes
translate([-15 + s*30,-34,20 + h*60])
rotate([90,0,180])
translate([0,0,-1]) 
    union() {
cylinder(4, 4.5, 0.5, $fn = 50);
cylinder(4, 2, 2, $fn = 50);
}

// Back plate screw holes
rotate([0,0,h*180])
translate([-15 + s*30, 34,154 - 2 - 4])
rotate([270,0,180])
translate([0,0,-1]) 
    union() {
cylinder(4, 4.5, 0.5, $fn = 50);
cylinder(4, 2, 2, $fn = 50);
    }

// Mechanical assembly
rotate([0,0,h*180])
translate([-15 + s*30, 34,121])
rotate([270,0,180])
translate([0,0,-1]) 
    union() {
cylinder(4, 4.5, 0.5, $fn = 50);
cylinder(4, 2, 2, $fn = 50);
    }

}


}
}

intersection() {
//color("black", 0.25)
outerShell();
//cube([80,80,50], center= true);
}


/*
// Magnet holes at front
color("silver")
translate([0,34,20])
rotate([90,0,0])
    magnet();
color("silver")
rotate([0,0,90])
translate([10,32.5,30])
rotate([90,0,0])
    magnet();
color("silver")
rotate([0,0,180])
translate([0,34,20])
rotate([90,0,0])
    magnet();
color("silver")
rotate([0,0,270])
translate([-10,32.5,30])
rotate([90,0,0])
    magnet();

// Magnet holes at back
color("silver")
translate([0,34,90])
rotate([90,0,0])
    magnet();
color("silver")
rotate([0,0,90])
translate([-10,32.5,80])
rotate([90,0,0])
    magnet();
color("silver")
rotate([0,0,180])
translate([0,34,90])
rotate([90,0,0])
    magnet();
color("silver")
rotate([0,0,270])
translate([10,32.5,80])
rotate([90,0,0])
    magnet();

// Hall actuator magnets holes
color("silver")
rotate([0,0,180])
translate([0,34,50])
rotate([90,0,0])
cylinder(3, 2.5, 2.5, $fn = 50);
color("silver")
rotate([0,0,270])
translate([0,32.5,50])
rotate([90,0,0])
cylinder(3, 2.5, 2.5, $fn = 50);
*/

