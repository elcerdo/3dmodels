$fs=.1;



module circn (radius, thick, nn) {
    radius_ = radius;
    translate(radius_*[cos(nn*360/6),sin(nn*360/6)]) circle(r=thick/2);
};



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
    color("red")
    translate([0,0,-11])
    linear_extrude(10)
    difference() {
        circle(radius_+thick_/2, $fn=6);
        circle(radius_-thick_/2, $fn=6);
    };
}

module link_(radius, thick, height, margin) {
    radius_ = margin+thick/2;
    thick_ = thick*.869;
    margin_ = margin*.869;
    radius__ = margin_+thick_/2;
    height_ = height-2*thick_-2*margin;
    radius_mid = radius_+radius__+
    thick_/2;
    thick_mid = thick_;
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

module hex_grid(nn, separation) {
    for (ii=[-nn:nn]) {
        parity = ii%2;
        angle = 60*ii;
        translate([ii*2*separation,0,0])
        rotate(parity ? angle : angle)
        children();
    }
}

margin=2;
radius=25;
thickness=5;
height=20;
separation = radius+thickness/2;
//translate([separation,0,0])
hex_grid(1, 2*radius+thickness)
    link(radius, thickness, height);

hex_grid(1, radius+thickness/2)
color("green") link_(radius, thickness, height, margin);