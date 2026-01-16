function [cm]=in2cm(in)
    // Convert inch to centimeter.
    //
    // Syntax
    // [cm] = in2cm(in)
    //
    // Parameters
    // in: Nx1 matrix or vector of floating point integers, distance in inch
    // cm: Nx1 matrix (row vector) of doubles, distance in centimeters
    //
    // Description
    // Convert distances of inch to cntimeters.
    //
    // Matrix-capable.
    //
    // Examples
    // dist1   = in2cm(1)
    // [dist]  = in2cm([1.2 5.3 7.4])
    //
    // See also
    // m2ft
    // mi2km
    // km2mi
    // ft2m
    // m2ft
    // cm2in
    //
    // Authors
    // Hani Ibrahim ; hani.ibrahim@gmx.de 
    
    [lhs,rhs]=argn()
    apifun_checkrhs("in2cm", rhs, 1); // Input args
    apifun_checklhs("in2cm", lhs, 1); // Output args
    apifun_checktype("in2cm", in, "in", 1, ["constant"]);
    
    cm = in .* 2.54;
endfunction
