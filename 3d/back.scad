use <rounded.scad>;

module backplate() {
difference() {
    union() {
translate([0, 0, 1])
cube([49 + 2*6, 52 + 2*6, 2], center = true);
    for ( s = [0:1] ) 
        for ( h = [0:1] ) {
            rotate([0,0,h*180])
            translate([-15 + s*30,-27,6])
            rotate([90,0,0])
            translate([0,0,-1])

            difference() {
                union() {
                translate([-4,-5,0])
                cube([8,5,6]);
                cylinder(6, 4, 4, $fn = 50);
                }
                translate([0,0,-1])
                    cylinder(8, 1.25, 1.25, $fn = 50);
            }
        }
        
        
    }
color("black")
    translate([0,0,-1])
roundedTube(24, 65, 68, 6, 2.2);

}
translate([-25, -25]) {
    linear_extrude(12) {
        difference() {
            union() {
                translate([4.5, 48 - 2.5, 0])
                    circle(3, $fn=50);
                translate([4.5 - 1, 48 - 2.5 - 12, 0])
                    square([2, 12]);
            }
            translate([4.5, 48-2.5])
                circle(1.5, $fn=50);
        }

        difference() {
            union() {
                translate([48.3, 48-2.5])
                    circle(3, $fn=50);
                translate([48.3 - 1, 48-2.5 - 12])
                    square([2, 12]);
            }
                circle(3, $fn=50);
            translate([48.3, 48-2.5])
                circle(1.5, $fn=50);
        }
    }

    linear_extrude(7) {
        difference() {
            union() {
                square([2, 30]);
                translate([2, 2])
                    circle(3, $fn=50);
            }
            translate([2, 2])
            circle(1, $fn=50);
        }
        difference() {
            union() {
                translate([48, 0])
                    square([2, 30]);
                translate([48, 2])
                    circle(3, $fn=50);
            }
            translate([48, 2])
            circle(1, $fn=50);
        }
    }
*translate([0,0,7])
color("green", 0.4)
cube([50, 32, 1.5]);

/*translate([3.6 + 2.54*4, 6.1 + 2.54 * 3, 8.5])
color("black")
cube([9*2.54, 2.54, 14]);

translate([3.6 + 2.54*7, 6.1 + 2.54 * 0, 8.5])
color("black")
cube([2*2.54, 2.54, 14]);

translate([3.6 + 2.54*3, 6.1 + 2.54 * 6, 8.5])
color("black")
cube([3*2.54, 2.54, 14]);

translate([3.6 + 2.54*7, 6.1 + 2.54 * 6, 8.5])
color("black")
cube([4*2.54, 2.54, 14]);

translate([3.6 + 2.54*15, 6.1 + 2.54 * 4, 8.5])
color("black")
cube([2.54, 3*2.54, 14]);
*/

*translate([2.5, 48-25.8,12])
color("black", 0.4)
cube([48.3, 25.8, 1.5]);

/*
translate([0,0,7])
color([0.8, .8, .8])
for (r = [0:9])
for (c = [0:17])
translate([3.6 + 2.54*c, 5.9++2.54*r,-0.25])
cylinder(2, 1, 1, $fn = 50);
*/

}
}

//translate([0,0,154])
//rotate([180,0,0])
backplate();
//color("black", 0.5) roundedTube(height+50, 65, 68, 6, 2);
