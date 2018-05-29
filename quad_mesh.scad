$fn = 128;

module link(width, margin) {
    total_length = 4*width+3*margin;
    total_height = 2*width+margin;
    shift_length = 3*width+3*margin;
    shift_height = width+margin;
    union() {
        for (yy=[0,shift_length])
        translate([0,yy,0]) cube([total_length, width, width]);
        
        for (xx=[0,shift_length]) 
        translate([xx,0,shift_height]) cube([width, total_length, width]);
        
        for (xx=[0,shift_length]) for (yy=[0,shift_length])
        translate([xx,yy,0]) cube([width, width, total_height]);
    }
}

module links_grid(width, margin, nn) {
    foo = 4*width+4*margin;
    bar = 2*width+1.5*margin;
    translate([-bar,-bar,0])
    color([1,0,0]) for (ii=[-nn:nn]) for (jj=[-nn:nn])
    {
        translate([foo*ii,foo*jj,0])
        link(width, margin);
    }
    translate([.5*margin,.5*margin,0])
    color([0,0,1]) for (ii=[-nn:nn-1]) for (jj=[-nn:nn-1])
    {
        translate([foo*ii,foo*jj,0])
        link(width, margin);
    }
}

module round_grid(width, margin, nn, ring) {
    radius = nn*4*(width+margin);
    radius_ = radius+ring;
    height = 2*width+margin;
    difference() {
        union() {
            color([1,1,0]) difference() {
                translate([-radius_-1,-radius_-1,0])
                cube([2*radius_+2,2*radius_+2,height]);
                translate([0,0,-1])
                cylinder(h=height+2, r=radius);
            }
            links_grid(width, margin, nn);
        }
        color([1,0,1]) difference() {
            translate([-radius_-2,-radius_-2,-1])
            cube([2*radius_+4,2*radius_+4,height+2]);
            translate([0,0,-1])
            cylinder(h=height+4, r=radius_);
        }
    }
}

//round_grid(3,2,5,15);
round_grid(4,2,3,10);

