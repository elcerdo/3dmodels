$fn=100;
mbira_size=90;
radius_butt=22;
radius_ext=40;
thickness=15;
angle_step=2;
alpha_margin=10;

alpha=asin(
    (2*radius_ext*radius_butt-mbira_size*(mbira_size-2*radius_ext))/
    (2*radius_butt*(mbira_size-radius_ext))
    );
echo(alpha);

point_aa = [0,-radius_butt];
point_bb = (mbira_size-radius_ext)*[cos(alpha), sin(alpha)];
bb_aa = point_bb-point_aa;
beta = atan2(bb_aa[1],bb_aa[0]);

function reverse(v) =
    let(max=len(v) -1)
    [ for (i = [0:max])  v[max-i] ];

first_in = [
    for (angle=[90: -angle_step: beta])
    point_aa+radius_butt*[cos(angle),sin(angle)]
    ];
first_out = reverse([
    for (angle=[90: -angle_step: beta])
    point_aa+(radius_butt-thickness)*[cos(angle),sin(angle)]
    ]);
 second_in = [
    for (angle=[beta-180:angle_step:alpha+alpha_margin])
    point_bb+radius_ext*[cos(angle),sin(angle)]
    ];
 second_out = reverse([
    for (angle=[beta-180:angle_step:alpha+alpha_margin])
    point_bb+(radius_ext+thickness)*[cos(angle),sin(angle)]
    ]);

color([1,0,0])
rotate_extrude()
polygon( concat(first_in,second_in,second_out,first_out) );

