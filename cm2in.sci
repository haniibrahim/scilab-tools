function [in]=cm2in(cm)
    // Convert cm to in
    //
    // Syntax
    // [in] = cm2in(cm)
    //
    // Parameters
    // cm: Nx1 matrix or vector of floating point integers, distance in centimeters
    // in: Nx1 matrix (row vector) of doubles, distance in inch
    //
    // Description
    // Convert distances of centimeters to inches.
    //
    // Matrix-capable.
    //
    // Examples
    // dist1   = cm2in(1)
    // [dist]  = cm2in([1.2 5.3 7.4])
    //
    // See also
    // m2ft
    // mi2km
    // km2mi
    // ft2m
    // m2ft
    // in2cm
    //
    // Authors
    // Hani Ibrahim ; hani.ibrahim@gmx.de 
    
    [lhs,rhs]=argn()
    apifun_checkrhs("m2ft", rhs, 1); // Input args
    apifun_checklhs("m2ft", lhs, 1); // Output args
    apifun_checktype("m2ft", cm, "cm", 1, ["constant"]);
    
    in = cm .* 0.393700787402;
endfunction
