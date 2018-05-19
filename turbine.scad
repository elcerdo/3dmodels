$fs=.25;

module disk(rout, rin, rholeout, rholein, nn, eair, eturb) {
    difference() {
        rholedrill = (rout+rin)/2;
        union() {
            cylinder(r=rout,h=eturb);
            for (kk=[0:nn-1])
            {
                angle = 360*kk/nn;
                translate([rholedrill*cos(angle),rholedrill*sin(angle),0])
                    cylinder(r=rholein,h=eturb+eair+.4);
            }
        }
        union() {
            translate([0,0,-1]) cylinder(h=eturb+2,r=rin);
            translate([0,0,-1]) for (kk=[0:nn-1])
            {
                angle = 360*kk/nn;
                translate([rholedrill*cos(angle), rholedrill*sin(angle), 0]) union() {
                    cylinder(r=rholeout,h=1.4);
                    //translate([0,0,2+1e-2]) cylinder(r2=0,r1=rholeout,h=rholeout);
                }
            }
        }
    }
}

module coupler(rout, rin, rholeout, rholein, nn, eair, eturb, raxe) {
    rholedrill = (rout+rin)/2;
    union() {
        difference() {
            cylinder(r=rout,h=eturb);
            union() {
                translate([0,0,-1]) cylinder(r=rin,h=2+eturb);
                translate([0,0,-1]) for (kk=[0:nn-1]) {
                    angle = 360*kk/nn;
                    translate([rholedrill*cos(angle), rholedrill*sin(angle), 0]) union() {
                        cylinder(r=rholeout,h=1.4);
                        //translate([0,0,2+1e-2]) cylinder(r2=0,r1=rholeout,h=rholeout);
                    }
                }
            }
        }
        cylinder(r=raxe+1,h=eair+eturb);
        cylinder(r=raxe,h=20);
        for (kk=[0:nn-1]) {
            angle = 360*kk/nn;
            rotate([0,0,angle]) translate([0,-2,0]) cube([rin,4,eturb]);
        }
    }
}

module support(hh, rout, edge, margin, nn, eair, eturb, ein) {
    difference() {
        union() {
            translate([-edge,-edge,0]) cube([2*edge,2*edge,hh-margin+.5]);
            cylinder(r=rout+.5+2,h=hh);
        }
        union() {
            translate([0,0,-1]) cylinder(r=rout+.5, h=hh+2);
            translate([rout+.5-ein,0,margin+eturb]) cube([ein,edge+1,nn*(eair+eturb)-eturb]);
            //translate([rout+.5-ein/2,edge-13,margin+eturb+(nn*(eair+eturb)-eturb)/2]) rotate([-90,0,0]) cylinder(r=4,h=14);
            translate([edge-4,edge-4,-1]) cylinder(r=2.1,h=hh+2);
            translate([-edge+4,edge-4,-1]) cylinder(r=2.1,h=hh+2);
            translate([edge-4,-edge+4,-1]) cylinder(r=2.1,h=hh+2);
            translate([-edge+4,-edge+4,-1]) cylinder(r=2.1,h=hh+2);
        }
    }
}

module frontlatch(edge, hh, margin) {
    difference() {
        union() {
            translate([-edge,-edge,0]) cube([2*edge,2*edge, hh]);
            cylinder(r=20.4,h=hh+margin-.5);
        }
        union() {
            translate([0,0,-1]) cylinder(r=10,h=hh+margin-.5+2);
            translate([edge-4,edge-4,-1]) cylinder(r=2.1,h=hh+2);
            translate([-edge+4,edge-4,-1]) cylinder(r=2.1,h=hh+2);
            translate([edge-4,-edge+4,-1]) cylinder(r=2.1,h=hh+2);
            translate([-edge+4,-edge+4,-1]) cylinder(r=2.1,h=hh+2);
        }
    }
}

module backlatch(edge,hh,ebearing,rout,margin) {
    difference() {
        union() {
            translate([-edge,-edge,0]) cube([2*edge,2*edge, hh]);
            cylinder(d=30, h=ebearing);
        }
        union() {
            translate([0,0,-1]) cylinder(d=20,h=ebearing+2);
            translate([0,0,-1]) difference() {
                cylinder(r=rout+.5+2+.1,h=margin-.5+1);
                translate([0,0,-1]) cylinder(r=rout+.5-.1,h=margin-.5+3);
            }
            translate([0,0,ebearing-7]) cylinder(d=22,h=8);
            translate([0,0,-1]) cylinder(d=22,h=8);
            translate([edge-4,edge-4,-1]) cylinder(r=2.1,h=hh+2);
            translate([-edge+4,edge-4,-1]) cylinder(r=2.1,h=hh+2);
            translate([edge-4,-edge+4,-1]) cylinder(r=2.1,h=hh+2);
            translate([-edge+4,-edge+4,-1]) cylinder(r=2.1,h=hh+2);
            
        }
    }
}

module bearing()
{
    difference() {
        translate([0,0,-1e-2]) cylinder(d=22-1e-1, h=7+2e-2);
        translate([0,0,-1]) cylinder(d=8+1e-1, h=9);
    }
}

module stack(nn, etotal, ntub, margin, sep) {

    color("Lime") support((nn+1)*etotal+2*margin, 20, 30, margin, nn, etotal*(1-ntub), etotal*ntub, 4);
    color("Yellow") translate([0,0,-4]) translate([0,0,-sep-1e-3]) frontlatch(30, 4, margin);
    translate([0,0,sep]) {
    for (kk=[0:nn-1])
        color("Blue") translate([0,0,etotal*kk+margin]) disk(20, 8, 1.1, 1., 3, etotal*(1-ntub), etotal*ntub, .25);
    color("Red") translate([0,0,nn*etotal+margin]) coupler(20, 8, 1.1, 1., 3, .5, etotal, .25, 4);
    color("Aquamarine") translate([0,0,(nn+1)*etotal+margin+.5]) bearing();
    color("Aquamarine") translate([0,0,(nn+1)*etotal+margin+.5+20+1e-2]) bearing();
    color("Gold") translate([0,0,(nn+1)*etotal+margin+.5+1e-3]) backlatch(30,4, 27,20, margin);
    }
}

module flat(nn, etotal, ntub, margin, sep) {
    for (ii=[0:nn/2-1])
        for (jj=[0:1])
        color("Blue") translate([ii*sep,jj*sep,0]) disk(24, 8, 2.2, 2, 5, etotal*(1-ntub), etotal*ntub);
    //color("Red") translate([0,2*sep,0]) coupler(24, 8, 2, 1.8, 5, .6, etotal, 2);

}

flat(2, 2, .5, 2, 49);