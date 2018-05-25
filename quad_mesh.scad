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

links_grid(3, 2, 10);
