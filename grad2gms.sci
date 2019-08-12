function dms = grad2gms(deg)
    
    [lhs,rhs]=argn()
    apifun_checkrhs("deg2dms", rhs, 1); // Input args
    apifun_checklhs("deg2dms", lhs, 1); // Output args

    g = int(deg);
    g_x = (deg - g) .* 60;
    m = int(g_x);
    s = (g_x - m) .* 60
    
    dms = [g m s];
endfunction
