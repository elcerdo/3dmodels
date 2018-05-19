$fs=.1;

module strips(kk_max, width, height) {
for (kk=[1:kk_max])
    translate([kk,0,0])
    rotate(45)
    translate([-width/2,0,0])
    cube([width,sqrt(2)*kk,height]);
}

module side(stripes_count, repeat, width, height, height_side)
{
    difference() {
        translate([-width/2,-width/2,0])
        cube([stripes_count*repeat+width,width,height+height_side]);
        for (kk=[0:stripes_count-1])
        translate([stripes_count*(kk+1/2),0,height+height_side/2])
        rotate(90,[1,0,0])
        cylinder(d=.5, h=3*width, center=true);
    }
}

module shelf(stripes_count=6, repeat=3, width=.2, height=.6, height_side=.8) {

for (ii=[0:repeat-1])
for (jj=[0:repeat-1])
if (ii<repeat-jj)
    translate([stripes_count*jj,stripes_count*ii,0])
    strips(stripes_count, width, height);

for (ii=[1:repeat-1])
    translate([stripes_count*ii-width/2,0,0])
    cube([width,(repeat-ii)*stripes_count,height]);

for (jj=[1:repeat-1])
    translate([0,stripes_count*jj-width/2,0])
    cube([(repeat-jj)*stripes_count,width,height]);

side(stripes_count, repeat, width, height, height_side);

scale([1,-1,1])
rotate(-90)
side(stripes_count, repeat, width, height, height_side);

}


rotate(90,[1,0,0])
scale([1,1,1]) shelf();