use <rounded.scad>;
use <servo_arm.scad>;

module mechanicFrame() {
// Central mount bars
difference() {
    union() {
    for ( s = [0:1] )
        for ( h = [0:1] ) {
            rotate([0,0,h*180])
            translate([-15 + s*30,-27,4])
            rotate([90,0,0])
            translate([0,0,-1])

            difference() {
                union() {
                    translate([-4,-4,-35 + 6])
                        cube([8,4,35]);
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

// PN532 risers
translate([-43/2 + 7.5, -41/2 + 7.5 - 5, 0])
difference() {
cylinder(19.5, 3, 3, $fn=50);
    translate([0, 0, 10.5])
cylinder(10, 1.5, 1.5, $fn=50);
}
translate([43/2 - 7, 41/2 - 8 - 5, 0])
difference() {
cylinder(19.5, 3, 3, $fn=50);
    translate([0, 0, 10.5])
cylinder(10, 1.5, 1.5, $fn=50);
}

// Servo risers
translate([-43/2 -(32.5 - 23) + 32.5 + 0.1, -(22.5 + 4.2) + 41/2 +8 -5,0])
difference() {
    union() {
cube([(32.5 - 23) / 2 -0.1, 8, 4 + 6.25]);
translate([(32.5 - 23) / 4-0.05, 8, 4 + 6.25])
    rotate([90,0,0])
    cylinder(8, (32.5 - 23) / 4 - 0.05 , (32.5 - 23) / 4 - 0.05 , $fn = 50);
    }

translate([(32.5 - 23) / 4 -0.05, 8+1, 4 + 6.25])
    rotate([90,0,0])
    cylinder(10, 0.75, 0.75, $fn = 50);
}
translate([-43/2 -(32.5 - 23)/2 - 0.1, -(22.5 + 4.2) + 41/2 +8 -5,0])
difference() {
    union() {
cube([(32.5 - 23) / 2 - 0.1 , 8, 4 + 6.25]);
translate([(32.5 - 23) / 4 -0.05, 8, 4 + 6.25])
    rotate([90,0,0])
    cylinder(8, (32.5 - 23) / 4 - 0.05 , (32.5 - 23) / 4 - 0.05 , $fn = 50);
    }
translate([(32.5 - 23) / 4 , 8+1, 4 + 6.25])
    rotate([90,0,0])
    cylinder(10, 0.75, 0.75, $fn = 50);
}


// Cross bars

translate([-43/2 -(32.5 - 23) / 2,-(22.5 + 4.2) + 41/2 +8 - 5,0])

cube([42.5, 8, 4]);

translate([-12, -28, 0])
cube([25, 4, 4]);

*translate([-43/2, -(22.5 + 4.2) + 41/2 -5, 4])
rotate([0,180,0])
rotate([0,90,90])
servo();

*translate([0, 0, 21])
rotate([0,180,0])
translate([-43.1/2, -41/2 - 5, 0])
pn532();

}


module servo() {
    
    // Body
    color("blue")
    cube([12.5, 23, 22.5]);
    
    // Flange

    color("blue")
    translate([0,-(32.3 - 23) / 2,16])
    difference() {
    cube([12.5, 32.3, 2.6]);
        translate([12.5/2, (32.3 - 23) / 4,-1])
        cylinder(4, 1.25, 1.25, $fn = 50);
        translate([12.5/2, 32.3 - (32.3 - 23) / 4,-1])
        cylinder(4, 1.25, 1.25, $fn = 50);
    }

    // Top round casing
    color("blue")
    translate([12.5/2,9.3/2,22.5])
    cylinder(4.2, 9.3/2, 9.3/2, $fn=50);
    
    // Servo arm connection
    color("white")
    translate([12.5/2,9.3/2,22.5 + 4.2])
    cylinder(1, 5/2, 5/2, $fn=50);


// Servo arm
    color("white")
    translate([12.5/2,9.3/2,22.5 + 4.2 + 1])
    cylinder(3.3, 7/2, 7/2, $fn=50);

    
    color("white")
    translate([12.5/2,9.3/2,22.5 + 4.2 + 1 + 1.8])
    linear_extrude(1.5)
    union() {
    circle(3.5, $fn = 50);
    translate([0, 19.5 - 3.5 - 2,0])
    circle(2, $fn = 50);
    polygon([[2.75, 0], [2, 14], [-2, 14], [-2.75, 0]]);
    }

    color("white")
    translate([12.5/2,9.3/2,22.5 + 4.2 + 1 + 1.8])
    linear_extrude(1.5)
    rotate([0,0,-90])
    union() {
    circle(3.5, $fn = 50);
    translate([0, 19.5 - 3.5 - 2,0])
    circle(2, $fn = 50);
    polygon([[2.75, 0], [2, 14], [-2, 14], [-2.75, 0]]);
    }
    
    for( angle = [0:15:90])
    color("red")
    translate([12.5/2,9.3/2,22.5 + 4.2 + 1 + 1.8 + .5])
        rotate([0, 0, -angle])
            servoArm();
}

module pn532() {
    
    color("red")
    difference() {
    cube([43.1, 41, 1.5]);
        translate([7.5,41-7.5,-0.5])
        cylinder(3, 2.8, 2.8, $fn = 50);
        translate([43.1-7.5,7.5,-0.5])
        cylinder(3, 2.8, 2.8, $fn = 50);
    }

    difference() {
        
        color("grey")
        union() {
        translate([7.5,41-7.5, 0])
        cylinder(1.5, 2.8, 2.8, $fn = 50);
        translate([43.1-7.5,7.5,0])
        cylinder(1.5, 2.8, 2.8, $fn = 50);
        }

        color("grey")
        translate([7.5,41-7.5,-0.5])
        cylinder(3, 1.8, 1.8, $fn = 50);
        color("grey")
        translate([43.1-7.5,7.5,-0.5])
        cylinder(3, 1.8, 1.8, $fn = 50);
    }

    
    // central chip
    
    color("black")
    translate([12.5, 17, 1.5])
    cube([7,7,1]);
    
    // Protocol selector
    
    color("black")
    translate([29, 27.5, 1.5])
    cube([5.4,4.1,2.3]);
}

mechanicFrame();




/*

// Screw holes for the outer shell
for ( s = [0:1] ) 
for ( h = [0:1] ) 
    {
rotate([0,0,h*180])
translate([-15 + s*30, 34,154 - 2 - 4])
rotate([270,0,180])
translate([0,0,-1]) 
    union() {
cylinder(4, 4.5, 0.5, $fn = 50);
cylinder(4, 2, 2, $fn = 50);
}
}
*/

//color("black", 0.5) roundedTube(height+50, 65, 68, 6, 2);
