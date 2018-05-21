$fs=.1;

function flatten(l) = [ for (a = l) for (b = a) b ] ;

module female_latch (radius, length, thickness, width) {
    central_thickness = length-thickness;
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
        [central_thickness,0], [central_thickness, radius],
        ], pts_round);
    ind_out = concat([0,1,2],[ for(kk=[6:2:100]) kk]);
    ind_in = concat([3,4], [ for(kk=[5:2:99]) kk]);

    rotate([90,0,0])
        linear_extrude(height=width, center=true)
        polygon(pts, [ind_out, ind_in], 4);
}

module female_triangle(radius, length, thickness, width ) {
    for (angle=[30:120:270])
        rotate([0,0,angle])
        female_latch(radius, length, thickness, width);
    translate([0,0,-thickness]) rotate([0,0,-30]) linear_extrude(height=thickness-1) circle($fn=3,2*length);
}

female_triangle(4,20,2,4);
