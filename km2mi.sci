function [mi]=km2mi(km)
    // Convert kilometers to miles.
    //
    // Calling Sequence
    // [km] = km2mi(mi)
    //
    // Parameters
    // mi: Nx1 matrix or vector of floating point integers, distance in km
    // km: Nx1 matrix (row vector) of doubles, distance in miles
    //
    // Description
    // Convert distances of kilometers in miles.
    //
    // Matrix-capable.
    //
    // Examples
    // dist1   = km2mi(1)
    // [dist] = km2mi([1.2 5.3 7.4])
    //
    // See also
    // mi2km
    // feet2meter
    // meter2feet
    //
    // Authors
    // Hani Ibrahim ; hani.ibrahim@gmx.de 
    
    [lhs,rhs]=argn()
    apifun_checkrhs("km2mi", rhs, 1); // Input args
    apifun_checklhs("km2mi", lhs, 1); // Output args
    apifun_checktype("km2mi", km, "km", 1, ["constant"]);
    
    mi = km ./ 1.60934;
endfunction
