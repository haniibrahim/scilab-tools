function [part] = time2pday(time)
    // Convert the part of a day from time.
    //
    // Calling Sequence
    // part = time2pday(time)
    //
    // Parameters
    // time: Nx3 matrix or vector of floating point integers [hours minutes seconds]
    // part: Nx1 matrix (row vector) of doubles which specifies the part of a day
    //
    // Description
    // Convert the time, e.g. [12 0 0] to parts of the day, e.g. 0.5.
    //
    // Matrix-capable.
    //
    // Examples
    // part1   = time2Pday([18 30 15.7])
    // [part2] = time2pday([12 0 0; 15 12 20; 12 00 30])
    //
    // See also
    // pday2time
    // is_leap_year
    // time2hour
    //
    // Authors
    // Hani Ibrahim ; hani.ibrahim@gmx.de 
    
    
    [lhs,rhs]=argn()
    apifun_checkrhs("time2pday", rhs, 1); // Input args
    apifun_checklhs("time2pday", lhs, 1); // Output args
    apifun_checktype("tme2hour", time, "time", 1, ["constant"])
    
    // Check for Nx3 matrix
    if size(time)(2) ~= 3 then
        error(msprintf(_("%s: Argument #%d: Matrix with %d columns expected.\n"), "time2pday", 1, 3 ));
    end
    
    // Check for the correct range of hours, minutes, seconds
    if time(:,1) >= 24 | time (:,1) < 0 then
        error(msprintf(_("%s: Argument #%d: Hour must be in the interval [%d, %s].\n"), "time2pday", 1, 0, "<24"));
    end
    if time(:,2) >= 60 | time (:,2) < 0 then
        error(msprintf(_("%s: Argument #%d: Minute must be in the interval [%d, %s].\n"), "time2pday", 1, 0, "<60"));
    end
    if time(:,3) >= 60 | time (:,3) < 0 then
        error(msprintf(_("%s: Argument #%d: Second must be in the interval [%d, %s].\n"), "time2pday", 1, 0, "<60"));
    end
    
    h = time(:,1);
    m = time(:,2);
    s = time(:,3);
    
    part = h ./ 24 + m ./ (60 * 24) + s ./ (60 * 60 * 24);
    
endfunction
