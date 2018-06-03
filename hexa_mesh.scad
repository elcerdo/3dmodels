$fs=.1;



module circn (radius, thick, nn) {
    radius_ = radius;
    translate(radius_*[cos(nn*360/6),sin(nn*360/6)]) circle(r=thick);
};



module link(radius_, thick_, height) {
    radius = radius_;
    thick = thick_*(.869);
    color("blue")
    union() {
        linear_extrude(thick)
        for(kk=[0:2:5]) hull() {
            circn(radius, thick, kk+0);
            circn(radius, thick, kk+1);
        };
        linear_extrude(height)
        for(kk=[0:1:5]) hull() {
            #circn(radius, thick, kk);
        };        
        translate([0,0,height-thick])
        linear_extrude(thick)
        for(kk=[1:2:6]) hull() {
            circn(radius, thick, kk+0);
            circn(radius, thick, kk+1);
        };
    };
    color("red")
    translate([0,0,11])
    linear_extrude(10)
    difference() {
        circle(radius_+thick_, $fn=6);
        circle(radius_-thick_, $fn=6);
    };
}

module link_(radius, thick, height, sep) {
    radius_ = sep-radius +2*thick;
    rotate(30) link(radius_, thick, height);
}

separation=13;
radius=10;
thickness=2;
height=10;
translate([-separation,0,0]) {
 link(radius, thickness, height);
}

//link_(radius, thickness, height, separation);