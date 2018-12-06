use <rounded.scad>;


module LED(color) {
    color(color)
        cylinder(4, 1.5, 1.5, $fn=50);
}

module LEDs() {
    translate([10, 34 - 4, -1])
        LED("red");
    translate([-10, 34 - 4, -1])
        LED("green");
    translate([0, 34 - 4, -1])
        LED("blue");
}


module ledPanel() {
    difference() {
        translate([0, (68 - 8)/2, 0])
            linear_extrude(2)
            square([61, 4], center = true);

        LEDs();
    }
}


module innerTube() {
    // The shape of the chute sides
    xs =         
        concat(
            [ for ( x = [0:0.1:8]) [x, sin(90 * x/8)*4 +2]], 
            [[104,6], [104,4]], 
            [ for ( x = [8:-0.1:0]) [x+1, max(sin(90 * x/8)*5-1, 0)]], 
            [[0,0]]);

    // The shape below the chute, to cut away the protrusions from nighbour walls
    below = concat([ for ( x = [0:0.1:8]) [x+1, sin(90 * x/8)*5-1]], [[105,4], [105, -2]]);

    // The simple flat roof, could be a cube() instead, but defined as the other sides for simplicity
    roof = [[0,6], [104,6], [104,4], [0,4]];

    difference() {
        union() {
            translate([61/2, -32, 0])
                rotate([0, 270,0])
                linear_extrude(49+6+6)
                polygon(xs);

            translate([49/2 + 6, 58/2 - 3 + 1, 0])
                rotate([0, 270,90])
                linear_extrude(59)
                polygon(xs);

            mirror([1,0,0])
                translate([49/2 + 6, 58/2 - 3 + 1, 0])
                rotate([0, 270,90])
                linear_extrude(59)
                polygon(xs);
                    
            translate([61/2, 22, 0])
                rotate([0, 270,0])
                linear_extrude(49+6+6)
                polygon(roof);
       }


        translate([61/2, -32, 0])
            rotate([0, 270,0])
            linear_extrude(49+6+6)
            polygon(below);

        translate([49/2 + 6, 58/2 - 0, 0])
            rotate([0, 270,90])
            linear_extrude(65)
            polygon(below);

        mirror([1,0,0])
            translate([49/2 + 6, 58/2 - 0, 0])
            rotate([0, 270,90])
            linear_extrude(65)
            polygon(below);
    }

    for ( s = [0:1] ) 
        for ( h = [0:1] ) {
            translate([-15 + s*30,-31,20 + h*60])
            rotate([90,0,180])
            translate([0,0,-1])

            difference() {
                cylinder(6, 4, 10, $fn = 50);
                translate([0,0,-1])
                    cylinder(7, 1.25, 1.25, $fn = 50);
            }
        }
}

module innerShell() {
    difference() {
        union() {
        innerTube();
        ledPanel();
        }

color("black")
    translate([0,0,-1])
roundedTube(104+2, 65, 68, 6, 2.2);
    }
}

intersection() {
innerShell();
//cube([80,80,50], center= true);
}
//LEDs();
//color("black", 0.5) roundedTube(height+50, 65, 68, 6, 2);
