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
         #hull() for(kk=[0:1:5]) {
            circn(radius, thick, kk+0);
            circn(radius, thick, kk+1);
        };
        linear_extrude(height)
        for(kk=[0:1:5]) hull() {
            #circn(radius, thick, kk);
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
    //link(radius_, thick, height);
    translate([0,0,thick_+margin]) {
        difference() {
            linear_extrude(height_)
            hull() for(kk=[0:2:5]) 
            circn(radius_, 2*radius__+2*thick_, kk);
            translate([0,0,-.01])
            linear_extrude(height_+.02)
            hull() for(kk=[0:2:5]) 
            circn(radius_, 2*radius__, kk);
        }
    }
}

margin=1;
radius=10;
thickness=3;
height=10;
for (angle=[0,120,240]) rotate(angle) translate([radius+thickness/2+margin,0,0])
link(radius, thickness, height);

color("green") link_(radius, thickness, height, margin);