function [dms] = grad2gms(deg)
    // Convert angle from decimal degree to degree° arcmininute' arcsecond"  
    //
    // Calling Sequence
    //   [dms] = grad2gms(deg)
    //
    // Parameters
    // deg: angle as a scalar in decimal degree
    // dms: angle as a vector or matrix in the form [deg arcmin arcsec] 
    //
    // Description
    // Convert an angle from decimal degree, e.g. 12.553444 to dms-form, e.g. 
    // 12° 33' 12.4" ([12 33 12.4]) 
    //
    // grad2gms can handle matrices of deg' (see examples).
    //
    // Examples
    // [dms1] = grad2gms(12,55)
    // [dms2] = grad2gms([12.55; 25.5])
    //
    // See also
    // gms2grad  
    //
    // Authors
    //  Hani Ibrahim ; hani.ibrahim@gmx.de
    //
    
    [lhs,rhs]=argn()
    apifun_checkrhs("grad2gms", rhs, 1); // Input args
    apifun_checklhs("grad2gms", lhs, 1); // Output args
    apifun_checkveccol("grad2gms", deg, "deg", 1) // only column vectors allowed
    
        
    g = int(deg);
    g_x = (deg - g) .* 60;
    m = int(g_x);
    s = (g_x - m) .* 60
    
    dms = [g m s];
endfunction
