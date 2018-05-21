$fs=.1;

function flatten(l) = [ for (a = l) for (b = a) b ] ;

module female_latch (radius, length, thickness, width) {
    central_thickness = length-.5*thickness;
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
    translate([0,0,-thickness]) rotate([0,0,-30]) linear_extrude(height=thickness-1) circle($fn=3,r=2*length-thickness);
}

module hexagonal_paving(ii, jj, length) {
    paving_class = (ii+jj)%2 != 0;
    radius = 2*length;
    delta_ii = sqrt(3)/2*radius;
    delta_jj = 3*radius/2;
    translate([delta_ii*ii,delta_jj*jj+(paving_class ? radius/2 : 0),0])
    rotate([0,0,paving_class ? 60 : 0])
    color([paving_class ? 1 : 0, paving_class ? 0 : 1])
    children(paving_class ? 1 : 0);
}

for (ii=[-2:2]) for (jj=[-2:2])
    hexagonal_paving(ii, jj, 20) {
        female_triangle(4,20,2,4);
        female_triangle(4,20,2,2);
    }