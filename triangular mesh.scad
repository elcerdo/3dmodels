$fs=.1;

function flatten(l) = [ for (a = l) for (b = a) b ] ;

module female_latch (radius, length, height) {
    difference() {
        linear_extrude(height=height, center=true) union() {
            square([length, 2*radius]);
            translate([length, radius]) circle(r=radius);
        }
        translate([-1,-1+radius,-1-height/2])
            cube([length+radius+2, radius+2, height+2]); 

    }
}

module female_latch_ (radius, length, thickness) {
    pts_round = flatten([
        for (angle=[0:-2:-90])
            let (
                ca = cos(angle), sa = sin(angle),
                radius_out = radius+thickness,
                pt_in = [length+radius*ca, radius*(1+sa)],
                pt_out = [length+radius_out*ca, radius+radius_out*sa]
            )
        [pt_in, pt_out]
        ]);
    pts = concat([
    [0,-thickness], [0, radius+thickness],
    [length+radius+thickness, radius+thickness],
    [thickness,0], [thickness, radius],
    ], pts_round);
    ind_out = concat([0,1,2],[ for(kk=[6:2:100]) kk]);
    ind_in = concat([3,4], [ for(kk=[5:2:99]) kk]);

    echo(ind_out);
    
    minkowski() {
    polygon(pts, [ind_out, ind_in], 10);
    circle(.8);
    }
}

female_latch_(10, 20, 2);