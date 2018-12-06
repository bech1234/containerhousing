// Comment
module servoArm() {
difference() {
    linear_extrude(2)
    union() {
    circle(5.5, $fn = 50);
    translate([0, 35,0])
    circle(4, $fn = 50);
    polygon([[4.5, 0], [2, 35], [-2, 35], [-4.5, 0]]);
    }
    translate([0,0,-.5])
    linear_extrude(1.5)
    union() {
    circle(4, $fn = 50);
    translate([0, 19.5 - 3.5 - 2,0])
    circle(2.5, $fn = 50);
    polygon([[4, 0], [2.5, 14], [-2.5, 14], [-4, 0]]);
    }
    translate([0,0,-0.5])
    linear_extrude(5)
    circle(2.5, $fn = 50);

    translate([0,0,-0.5])
    linear_extrude(5)
    polygon([[2, 18], [1, 35], [-1, 35], [-2, 18]]);

    translate([0, 35,-0.5])
    linear_extrude(5)
    circle(3, $fn = 50);
}
}

rotate([180,0,0])
translate([0,0,-2])
servoArm();
