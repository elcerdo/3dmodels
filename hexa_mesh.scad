$fs=1;



module circn (radius, thick, nn) {
    radius_ = radius;
    translate(radius_*[cos(nn*360/6),sin(nn*360/6)]) circle(r=thick/2);
};


// .869 is sqrt(3)/2
module link(radius_, thick_, height) {
    radius = radius_;
    thick = thick_*(.869);
    color("blue")
    union() {
        linear_extrude(thick)
         hull() for(kk=[0:1:5]) {
            circn(radius, thick, kk+0);
            circn(radius, thick, kk+1);
        };
        linear_extrude(height)
        for(kk=[0:1:5]) hull() {
            circn(radius, thick, kk);
        };        
        translate([0,0,height-thick])
        linear_extrude(thick)
        for(kk=[1:1:6]) hull() {
            circn(radius, thick, kk+0);
            circn(radius, thick, kk+1);
        };
    };
//    color("red")
//    translate([0,0,-11])
//    linear_extrude(10)
//    difference() {
//        circle(radius_+thick_/2, $fn=6);
//        circle(radius_-thick_/2, $fn=6);
//    };
}

module link_(radius, thick, height, margin) {
    radius_ = 2*margin+thick/2;
    thick_ = thick*.869;
    margin_ = margin*.869;
    radius__ = margin_+thick_/2;
    height_ = height-2*thick_-2*margin;
    radius_mid = radius_+radius__+
    thick_/2;
    thick_mid = thick_*.8;
    translate([0,0,thick_+margin]) {
        union() {
            linear_extrude(height-thick_-margin)
            for(kk=[0:2:5]) hull() {
                circn(radius_mid, thick_mid, kk);
            };
            difference() {
                linear_extrude(height_)
                hull() for(kk=[0:2:5]) 
                circn(radius_, 2*radius__+2*thick_, kk);

                translate([0,0,-.01])
                linear_extrude(height_+.02)
                hull() for(kk=[0:2:5]) 
                circn(radius_, 2*radius__, kk);    
            };
        }
    }
}


module hexagonal_paving(ii, jj, length) {
    paving_class = (jj)%2 != 0;
    translate([length*(3*ii+1.5*(paving_class ? 1 :0)),length*sqrt(3)/2*jj,0])
//    rotate([0,0,paving_class ? 60 : 0])
//    color([paving_class ? 1 : 0, paving_class ? 0 : 1])
    children(paving_class ? 1 : 0);
}

module main(radius, thickness, height, margin, nn) {
    spacing = radius+thickness/2+margin;
    for (ii=[-nn:nn]) for (jj=[-2*nn:2*nn])
        hexagonal_paving(ii, jj, spacing) {
            link(radius, thickness, height);
            link(radius, thickness, height);
        };
    color("green")
    translate([spacing,0,0])
    for (ii=[-nn:nn]) for (jj=[-nn:nn])
        hexagonal_paving(ii, jj, spacing) {
            rotate(60) link_(radius, thickness, height, margin);
            rotate(60) link_(radius, thickness, height, margin);
        };
    color("yellow")
    translate([-spacing,0,0])
    for (ii=[-nn:nn]) for (jj=[-nn:nn])
        hexagonal_paving(ii, jj, spacing) {
            rotate(0) link_(radius, thickness, height, margin);
            rotate(0) link_(radius, thickness, height, margin);
        };
}

margin=1;
radius=20;
thickness=5;
height=20;
main(radius, thickness, height, margin, 1);

//hex_grid(1, radius+thickness/2)
//color("green") link_(radius, thickness, height, margin);