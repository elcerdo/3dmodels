$fs=.2;

module link(rout=9,rint=2.4,bis=1,nn=64)
{
    function squicle(theta) = pow(pow(cos(theta),4)+pow(sin(theta),4),-1/4);
    function prout(kk) = [
        rout*squicle(360*kk/nn)*cos(360*kk/nn),
        rout*squicle(360*kk/nn)*sin(360*kk/nn)*2/3,
        1.2*rint*cos(2*(360*kk/nn-45))*pow(abs(cos(2*(360*kk/nn-45))),1/10)];
    intersection() 
    {
        intersection()
        {
            cube([2*rout+2*rint,4/3*rout+2*rint,2*rint], center=true);
            rotate([45,0,0]) cube([2*rout+2*rint,(4/3*rout+2*rint+bis)/sqrt(2),(4/3*rout+2*rint+bis)/sqrt(2)],center=true);
        }
        //rotate([0,90,0]) scale([1,1,2*rout+2*rint]) polygon([[-rint,-2/3*rout-rint+bis],[0,-2/3*rout-2*rint+bis],[rint,-2/3*rout-rint+bis],[rint,2/3*rout+rint-bis],[0,2/3*rout+2*rint-bis],[-rint,2/3*rout+rint-bis]], center=true);
        union()
        {
            for (kk=[0:nn-1]) hull()
            {
                    translate(prout(kk)) sphere(r=rint);
                    translate(prout(kk+1)) sphere(r=rint);
            }
        }
    }
}

for (kk=[-3:3]) translate([13*kk,0,0]) link();