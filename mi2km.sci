function [km]=mi2km(mi)
    // Convert miles to kilometers.
    //
    // Syntax
    // [km] = mi2km(mi)
    //
    // Parameters
    // mi: Nx1 matrix or vector of floating point integers, distance in miles
    // km: Nx1 matrix (row vector) of doubles, distance in km
    //
    // Description
    // Convert distances of miles in kilometer
    //
    // Matrix-capable.
    //
    // Examples
    // dist1   = mi2km(1)
    // [dist] = mi2km([1.2 5.3 7.4])
    //
    // See also
    // km2mi
    // feet2meter
    // meter2feet
    //
    // Authors
    // Hani Ibrahim ; hani.ibrahim@gmx.de 
    
    [lhs,rhs]=argn()
    apifun_checkrhs("mi2km", rhs, 1); // Input args
    apifun_checklhs("mi2km", lhs, 1); // Output args
    apifun_checktype("mi2km", mi, "mi", 1, ["constant"]);
    
    km = mi ./ 0.621371
endfunction
