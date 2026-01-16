function [m]=ft2m(ft)
    // Convert inch to centimeter.
    //
    // Syntax
    // [cm] = in2cm(in)
    //
    // Parameters
    // mi: Nx1 matrix or vector of floating point integers, distance in feet
    // km: Nx1 matrix (row vector) of doubles, distance in m
    //
    // Description
    // Convert distances of inch to cntimeters.
    //
    // Matrix-capable.
    //
    // Examples
    // dist1   = in2cm(1)
    // [dist] = ft2m([1.2 5.3 7.4])
    //
    // See also
    // m2ft
    // mi2km
    // km2mi
    // ft2m
    // m2ft
    //
    // Authors
    // Hani Ibrahim ; hani.ibrahim@gmx.de 
    
    [lhs,rhs]=argn()
    apifun_checkrhs("in2cm", rhs, 1); // Input args
    apifun_checklhs("in2cm", lhs, 1); // Output args
    apifun_checktype("in2cm", ft, "in", 1, ["constant"]);
    
    m = in ./ 2.54;
endfunction
