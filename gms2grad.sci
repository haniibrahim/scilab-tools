function [deg] = gms2grad(dms)
    // Convert degree, minute, second to decimal degree
    [lhs,rhs]=argn()
    apifun_checkrhs("dms2grad", rhs, 1); // Input args
    apifun_checklhs("dms2grad", lhs, 1); // Output args
    apifun_checkvector("dms2grad", dms, "dms", 1);
    apifun_checktype("dms2grad", dms, "dms", 1, ["constant"])
    
    // Extent dms vecor, if needed
    if length(dms) == 2 then dms = [dms 0]; end
    if length(dms) == 1 then dms = [dms 0 0]; end
    
    g = dms(:,1);
    m = dms(:,2);
    s = dms(:,3);
    deg = (((s ./ 60 ) + m) ./ 60) + g;
endfunction
