function [m]=ft2m(ft)
    // Convert feet to meters.
    //
    // Syntax
    // [m] = ft2m(ft)
    //
    // Parameters
    // mi: Nx1 matrix or vector of floating point integers, distance in feet
    // km: Nx1 matrix (row vector) of doubles, distance in m
    //
    // Description
    // Convert distances of feet in meters.
    //
    // Matrix-capable.
    //
    // Examples
    // dist1   = ft2m(1)
    // [dist] = ft2m([1.2 5.3 7.4])
    //
    // See also
    // m2ft
    // mi2km
    // km2mi
    // feet2meter
    // meter2feet
    //
    // Authors
    // Hani Ibrahim ; hani.ibrahim@gmx.de 
    
    [lhs,rhs]=argn()
    apifun_checkrhs("ft2m", rhs, 1); // Input args
    apifun_checklhs("ft2m", lhs, 1); // Output args
    apifun_checktype("ft2m", ft, "ft", 1, ["constant"]);
    
    m = ft ./ 3.28084;
endfunction
