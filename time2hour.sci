function [hour] = time2hour(time)
    // Convert time to a number of hour.
    //
    // Syntax
    // [hour] = time2hour([h m s])
    //
    // Parameters
    // time: Nx3 matrix or vector of floating point integers [hours minutes seconds]
    // hour: Nx1 matrix (row vector) of doubles which specifies the part of a day
    //
    // Description
    // Convert time commitet as a column vector or Nx3 matrix to floating point 
    // number of hour(s).
    //
    // Matrix-capable.
    //
    // Examples
    // h1   = time2hour([12 0 0])
    // [h2] = time2hour([12 0 0; 7 30 15.5; 22 15 0])
    //
    // See also
    // pday2time
    // is_leap_year
    // 
    //
    // Authors
    // Hani Ibrahim ; hani.ibrahim@gmx.de 

    [lhs,rhs]=argn()
    apifun_checkrhs("time2hour", rhs, 1); // Input args
    apifun_checklhs("time2hour", lhs, 1); // Output args
    apifun_checktype("time2hour", time, "time", 1, ["constant"]);
    
    // Check for Nx3 matrix
    if size(time)(2) ~= 3 then
        error(msprintf(_("%s: Argument #%d: Matrix with %d columns expected.\n"), "time2hour", 1, 3 ));
    end
    
//    // Check fpr floating point integers at hours and minute
//    if ~isint(time(:1)) then // hour
//        error(msprintf("%s: Argument #%d ""hour"": Decimal integer expected.\n", "time2hour", 1));
//    end
//     if ~isint(time(:2)) then // minute
//        error(msprintf("%s: Argument #%d ""minute"": Decimal integer expected.\n", "time2hour", 1));
//    end
    
    // Check for the correct range of hours, minutes, seconds
    if time(:,1) >= 24 | time (:,1) < 0 then
        error(msprintf(_("%s: Argument #%d: Hour must be in the interval [%d, %s].\n"), "time2hour", 1, 0, "<24" ));
    end
    if time(:,2) >= 60 | time (:,2) < 0 then
        error(msprintf(_("%s: Argument #%d: Minute must be in the interval [%d, %s].\n"), "time2hour", 1, 0, "<60" ));
    end
    if time(:,3) >= 60 | time (:,3) < 0 then
        error(msprintf(_("%s: Argument #%d: Second must be in the interval [%d, %s].\n"), "time2hour", 1, 0, "<60" ));
    end
    
    h = time(:,1);
    m = time(:,2);
    s = time(:,3);
    
    hour = h + m ./ 60 + s ./ (60 * 60);
    
endfunction
