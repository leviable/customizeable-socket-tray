include <BOSL2/std.scad>

// Cut out section to inspect magnet cavity
preview = true;

magnet_length = 59.8;
magnet_width = 9.9;
magnet_height = 2.8;

printing_tolerance = .1;

nozzle_width = 0.4;

/* [Hidden] */
margin = 1;
midplane = (magnet_height+margin*2)/2;

//if(print_preview) back_half();
difference() {
    main_body();
    magnet_body();
    triangular_cutout();
    screwdriver_cutout();
    if(preview) cube([100,100,100]);
}

module main_body () {
    cube([magnet_length+(margin*2),magnet_width+(margin*2),magnet_height+(margin*2)], anchor = BOTTOM);
}

module magnet_body() {
    c_len = magnet_length+(printing_tolerance*2);
    c_width = magnet_width+(printing_tolerance*2);
    c_height = magnet_height+(printing_tolerance*2);
    up(margin - printing_tolerance)
        #cube([c_len, c_width, c_height], anchor=BOTTOM);
}

module triangular_cutout() {
    cutout_width = magnet_length+printing_tolerance*2+margin*2;
    left(magnet_length/2+printing_tolerance+nozzle_width) 
        up(midplane) 
        rotate([90, 0, 0]) 
        down(cutout_width/2) 
        linear_extrude(cutout_width) 
        circle(10, $fn=3, anchor=RIGHT);
    right(magnet_length/2+printing_tolerance+nozzle_width) 
        up(midplane) 
        rotate([90, 0, 180]) 
        down(cutout_width/2) 
        linear_extrude(cutout_width) 
        circle(10, $fn=3, anchor=RIGHT);        
    back(magnet_width/2+printing_tolerance+nozzle_width) 
        up(midplane) 
        rotate([90, 0, 270]) 
        down(cutout_width/2) 
        linear_extrude(cutout_width) 
        circle(10, $fn=3, anchor=RIGHT);
    fwd(magnet_width/2+printing_tolerance+nozzle_width) 
        up(midplane) 
        rotate([90, 0, 90]) 
        down(cutout_width/2) 
        linear_extrude(cutout_width) 
        circle(10, $fn=3, anchor=RIGHT);        
}

module screwdriver_cutout() {
    up(margin+magnet_height/2) #cube([magnet_length+margin*2,5,1.5], anchor=CENTER);
    up(margin+magnet_height/2) #cube([5,magnet_width+margin*2,1.5], anchor=CENTER);
}