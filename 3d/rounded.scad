//height = 104;


module roundedRectangle(w, h, r = 0) {
    
    square([w-2*r, h], true);
    square([w, h-2*r], true);
    
    translate([(w-2*r)/2, (h-2*r)/2, 0])
    circle(r, $fn = 50);
    translate([(w-2*r)/2, -(h-2*r)/2, 0])
    circle(r, $fn = 50);
    translate([-(w-2*r)/2, (h-2*r)/2, 0])
    circle(r, $fn = 50);
    translate([-(w-2*r)/2, -(h-2*r)/2, 0])
    circle(r, $fn = 50);
    }
    

module hollowRoundedRectangle(w, h, r, t) {    
    difference() {
        roundedRectangle(w, h, r);
        roundedRectangle(w-2*t, h-2*t, r-t);
    }
}

module roundedTube(l, w, h, r, t) {
linear_extrude(l, convexity = 20)
hollowRoundedRectangle(w, h, r, t);
}

color([1, 0, 0, 1])
roundedTube(104, 65, 68, 6, 2);

/*difference() {
translate([0, (68 - 8)/2, 0])
linear_extrude(2)
square([65, 8], center = true);
translate([0,0,-1])
roundedTube(height + 2, 75, 78, 11, 5);
color("blue")
translate([10, 34 - 4, -1])
cylinder(4, 1.5, 1.5, $fn=50);
color("blue")
translate([-10, 34 - 4, -1])
cylinder(4, 1.5, 1.5, $fn=50);
        
}*/

// To extract
//inside
//roundedTube(height + 2, 71, 74, 9, 5);
//outside
//roundedTube(height + 2, 75, 78, 11, 5);




