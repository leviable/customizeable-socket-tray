$fn=50;

include <gridfinity-rebuilt-openscad/src/core/gridfinity-rebuilt-utility.scad>;

// Gridfinity defaults
gf_len = 42;
gf_height = 7;


base_thickness = 5.59;
socket_depth = 12.5;

socket_diameter_offset = 1.5;
socket_1_diameter = 11;
socket_diameters = [7.4, 7.4, 7.4, 7.4, 7.4, 7.4, 7.8, 8.4, 9.2, 9.7, 10.3, 10.9];
min_socket_gap = 1;

function add2(v) = [for(p=v) 1]*v;

// Calculate length of bin needed
total_gap = len(socket_diameters)+1;
// Add all the socket diameters + double the offset gap
total_socket_len = add2(concat(socket_diameters, [ for(i=socket_diameters) socket_diameter_offset * 2]));
echo(total_socket_len);
min_bin_len = total_gap + total_socket_len;
echo(min_bin_len);
gf_units = floor(min_bin_len / gf_len) + 1;
echo(gf_units);
actual_bin_len = gf_units * gf_len;
echo(actual_bin_len);
actual_gap = (actual_bin_len - min_bin_len) / (len(socket_diameters) + 1);
echo(actual_gap);

// Calculate Height
tier_height = floor((socket_depth + base_thickness) / gf_height) + 1;

hole_options = bundle_hole_options(magnet_hole=true, supportless=true);
gridfinityBase([1, gf_units], grid_dimensions=[gf_len, gf_len], hole_options=hole_options, only_corners=true); 

difference() {
    gridfinityInit(1, gf_units, height(tier_height), 0, gf_len, sl=1);
    for (i=[0:1:len(socket_diameters)-1])  
        translate([0,i*10,tier_height*7])
        rotate([180,0,0])
        #cylinder(socket_depth, d = socket_diameters[i]+ socket_diameter_offset*2, center = false);
};