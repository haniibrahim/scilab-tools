function [deg] = gms2grad(dms)
    // Convert angle from degree° arcmininute' arcsecond" to decimal degree
    //
    // Calling Sequence
    // [deg] = gms2grad(dms)
    //
    // Parameters
    // dms: angle as a vector or matrix in the form [deg arcmin arcsec]
    // deg: angle as a scalar in decimal degree 
    //
    // Description
    // Convert an angle from dms-form, e.g. 12° 33' 12.4" ([12 33 12.4]) 
    // to decimal degree, e.g. 12.553444.
    //
    // Matrix-capable.
    //
    // Examples
    // [deg1] = gms2grad([12 33 12.4]) // 12° 33' 12.4"
    // [deg2] = gms2grad([12 33 12.4; 32 43 54])
    //
    // See also
    // grad2gms  
    //
    // Authors
    // Hani Ibrahim ; hani.ibrahim@gmx.de
    //
   
    [lhs,rhs]=argn();
    apifun_checkrhs("gms2grad", rhs, 1); // Input args
    apifun_checklhs("gms2grad", lhs, 1); // Output args
    apifun_checktype("gms2grad", dms, "dms", 1, ["constant"]);
    
    // Dimension of dms, for later vector or matrix checking?
    d = size(dms);
    
    if d(2) > 3 then error("Wrong dimension of matrix or vector, max. 3 columns vector/matrix"); end
        
    // Extent dms vecor/matrix, if needed
    if d(1) == 1 then // is col vector
        if d(2) == 2 then dms = [dms 0]; end // only ° and ' comitted, "= 0
        if d(2) == 1 then dms = [dms 0 0]; end // only ° comitted, ' = 0, " = 0
    elseif d(1) > 1 then // is matrix
        if d(2) == 2 then dms = [dms zeros(d(1),1)]; end // only ° and ' comitted, "= 0
        if d(2) == 1 then dms = [dms zeros(d(1),2)]; end // only ° comitted, ' = 0, " = 0
    end
    
    
    g = dms(:,1);
    m = dms(:,2);
    s = dms(:,3);
    deg = (((s ./ 60 ) + m) ./ 60) + g;
endfunction
