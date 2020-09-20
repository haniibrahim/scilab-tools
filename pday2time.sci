function [time] = pday2time(part)
    // Returns the time (hours, minutes, seconds) from a part of a day.
    //
    // Calling Sequence
    // [time] = pday2time(part)
    //
    // Parameters
    // part: Nx1 matrix (row vector) of doubles which specifies the part of a day
    // time: matrix or vector of floating point integers [hours minutes seconds]
    //
    // Description
    // Calculates the time (hours, minutes, seconds) from a double which 
    // specifies a part of the day, e.g. 0.5 => [12 0 0].
    //
    // Matrix-capable.
    //
    // Examples
    // t1   = pday2time(0.5)
    // [t2] = pday2time([0.5; 0.25 ; 0.982; 0.556])
    //
    // See also
    // is_leap_year
    // time2pday
    // time2hour
    //
    // Authors
    // Hani Ibrahim ; hani.ibrahim@gmx.de 
    
    [lhs,rhs]=argn()
    apifun_checkrhs("pday2time", rhs, 1); // Input args
    apifun_checklhs("pday2time", lhs, 1); // Output args
    apifun_checkrange("pday2time", part, "part", 1, 0, 1); // Output args
    apifun_checkveccol( "pday2time", part," part",1); 
    
    
    h = 24 .* part;
    m = 60 .* (h - floor(h));
    s = 60 .* (m - floor(m));
    hr = floor(h);
    mi = floor(m);
    
    // if seconds are a full minute or more
    if s >= 60 then
        mi = mi + 1;
        s = s - floor(s);
    end
    time = [hr mi s];
endfunction
