function [in]=m2ft(cm)
    // Convert cm to in
    //
    // Syntax
    // [in] = m2ft(cm)
    //
    // Parameters
    // mi: Nx1 matrix or vector of floating point integers, distance in m
    // km: Nx1 matrix (row vector) of doubles, distance in feet
    //
    // Description
    // Convert distances of centimeters to inches.
    //
    // Matrix-capable.
    //
    // Examples
    // dist1   = m2ft(1)
    // [dist] = m2ft([1.2 5.3 7.4])
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
    apifun_checkrhs("m2ft", rhs, 1); // Input args
    apifun_checklhs("m2ft", lhs, 1); // Output args
    apifun_checktype("m2ft", m, "m", 1, ["constant"]);
    
    ft = m ./ 0.393700787402;
endfunction
