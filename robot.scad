diam=.8;
end_factor=1.75;

module arm_right_aa()
{ 
    difference()
    {   
        cube([8,4,4], true);
        union()
        {
            translate([-4,0,0]) cube([4+diam,diam,6], true);
            //translate([4,-2,0]) cube([4+diam,4+diam,diam], true);
            translate([4,0,0]) cube([4+diam,diam,6], true);
            cube([10,diam,diam], true);
        }
    }
}

module arm_right_bb()
{ 
    difference()
    {   
        cube([6,4,4], true);
        union()
        {
            translate([-3,0,0]) cube([2+diam,diam,6], true);
            translate([3,0,0]) cube([4+diam,diam,6], true);
            cube([8,diam,diam], true);
        }
    }
}
module hand_right()
{
    difference()
    {
        cube([3,4,2], true);
        union()
        {
            translate([-1.5,2,0]) cube([2,2,6], true);
            cube([5,diam,diam], true);
            translate([-1.5,0,0]) cube(end_factor*diam*[1,1,1], true);
        }
    }
}

module right_arm()
{
    translate([-11,0,2])
    {
        arm_right_aa();
        translate([-8,0,0])
        {
            arm_right_bb();
            translate([-5.5,0,-1]) hand_right();
        }
    }
}

module body()
{
    difference()
    {
        cube([12,8,4], true);
        union()
        {
            
            translate([-6,2,0]) cube([4+diam,diam,6], true);
            //translate([-6,4,0]) cube([4+diam,4+diam,diam], true);
            
            translate([6,2,0]) cube([4+diam,diam,6], true);
            //translate([6,4,0]) cube([4+diam,4+diam,diam], true);
            
            translate([0,4,0]) cube([diam,4+diam,6], true);

            translate([0,2,0]) cube([14,diam,diam], true);
            cube([diam,10,diam], true);
        }
    }
}

module hip()
{
    difference()
    {
        cube([12,4,4], true);
        union()
        {
            cube([diam,6,diam], true);
            translate([0,-2,0]) cube(end_factor*diam*[1,1,1], true);
            
            translate([-4,0,0])
            {
                cube([diam,6,diam], true);
                translate([0,2,0]) cube(end_factor*diam*[1,1,1], true);
                translate([0,-2,0]) cube([diam,4+diam,6], true);
            }
            translate([4,0,0])
            {
                cube([diam,6,diam], true);
                translate([0,2,0]) cube(end_factor*diam*[1,1,1], true);
                translate([0,-2,0]) cube([diam,4+diam,6], true);
            }
        }
    }
}

module head(depth=.5)
{
    difference()
    {
        cube([4,5,4], true);
        union()
        {
            translate([0,-.5,0])
            {
                translate([0,0,2]) cube([2+depth,depth,depth], true);
                translate([1,1,2]) cube(depth*[1,1,1], true);
                translate([-1,1,2]) cube(depth*[1,1,1], true);
                translate([0,2,2]) cube([6,depth,depth], true);
            }

            cube([diam,7,diam], true);
            translate([0,-2.5,-2]) cube([diam,4+diam,4+diam], true);
            translate([0,2.5,0]) cube(end_factor*diam*[1,1,1], true);
        }
        
    }
}

module right_leg_aa()
{
    difference()
    {
        cube([6,8,4], true);
        union()
        {
            translate([-1,0,0])
            {
                cube([diam,10,diam], true);
                translate([0,-4,0]) cube([diam,4+diam,6], true);
                translate([0,4,0]) cube([diam,4+diam,6], true);
            }

            translate([3,-3,0]) cube([4,6,6], true);
            translate([1,0,-3]) rotate([0,0,-45]) cube([4,4,6]);
        }
    }
}

module right_leg_bb()
{
    difference()
    {   
        cube([4,6,4], true);
        union()
        {
            translate([0,-3-diam/2,0]) cube([diam,4+diam,4+diam], true);
            translate([0,3,0]) cube([diam,4+diam,6], true);
            cube([diam,8,diam], true);
        }
    }
}

module right_foot()
{
    difference()
    {
        translate([0,0,1]) cube([4,2,6], true);
        union()
        {
            translate([-3,1,2]) rotate([45,0,0]) cube([6,4,4]);
            cube([diam,4,diam], true);
            translate([0,-1,0]) cube(end_factor*diam*[1,1,1], true);
            translate([0,1,-2]) cube([diam,2*diam,4+diam], true);
        }
    }
}

module right_leg()
{
    translate([11,-8,2]) rotate([0,0,90])
    {
        right_leg_aa();
        translate([-1,-8,0])
        {
            right_leg_bb();
            translate([0,-6,-1]) rotate([90,0,0]) right_foot();
        }
    }
}  

scale([3,3,3])
{
    translate([0,5.5,2]) head();
    translate([0,-2,2]) body();
    translate([0,-9,2]) hip();
    
    translate([-24,-5,0]) right_leg();
    translate([0,2,0]) scale([-1,1,1]) right_leg();
    
    right_arm();
    translate([-29,5,0]) scale([-1,1,1]) right_arm();
}

//translate([0,.95,6.1]) right_foot();
//translate([0,3,2]) right_leg_bb();
//translate([0,6.05,4.1]) rotate([90,0,0]) translate([0,4,2]) rotate([0,-90,0]) translate([1,0])  right_leg_aa();

//translate([0,2.4,2]) head();
//translate([-4.1,0,0]) rotate([0,0,-90]) translate([-4,0,2]) arm_right_aa();
//translate([-3,10.1,2]) rotate([0,0,180]) rotate([90,0,0]) arm_right_bb();
//translate([-1,6.5,2]) rotate([-90,0,0]) rotate([0,-90,0]) hand_right();
//
//translate([0,-.1,-4.1]) rotate([180,0,0]) translate([0,-4,-2]) body();