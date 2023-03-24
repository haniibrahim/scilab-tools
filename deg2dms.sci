function [dms] = deg2dms(deg)
    // Convert angle from decimal degree to degree° arcmininute' arcsecond"  
    //
    // Syntax
    // [dms] = deg2dms(deg)
    //
    // Parameters
    // deg: angle as a scalar in decimal degree
    // dms: angle as a vector or matrix in the form [deg arcmin arcsec] 
    //
    // Description
    // Convert an angle from decimal degree, e.g. 12.553444 to dms-form, e.g. 
    // 12° 33' 12.4" ([12 33 12.4]) 
    //
    // Matrix-capable.
    //
    // Examples
    // [dms1] = deg2dms(12.55)
    // [dms2] = deg2dms([12.55; 25.5])
    //
    // See also
    // dms2deg  
    //
    // Authors
    // Hani Ibrahim ; hani.ibrahim@gmx.de
    //
    
    [lhs,rhs]=argn()
    apifun_checkrhs("deg2dms", rhs, 1); // Input args
    apifun_checklhs("deg2dms", lhs, 1); // Output args
    apifun_checkveccol("deg2dms", deg, "deg", 1) // only column vectors allowed
    
        
    g = int(deg);
    g_x = (deg - g) .* 60;
    m = int(g_x);
    s = (g_x - m) .* 60
    
    dms = [g m s];
endfunction
