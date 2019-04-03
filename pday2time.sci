function [time] = pday2time(part)
    //
    // Calculates the time (hours, minutes, seconds) from a part of a day
    //
    // CALLING SEQUENCES
    // time = pday2time(part)
    //
    // PARAMETERS
    // part: DBL part of a day
    // time: [hours minutes seconds] matrix of doubles
    //
    // EXAMPLES
    // pday2time(0.5)
    // ans = 12 0 0
    //
    [lhs,rhs]=argn()
    apifun_checkrhs("pday2time", rhs, 1); // Input args
    apifun_checklhs("pday2time", lhs, 1); // Output args
    apifun_checkrange("pday2time", part, "part", 1, 0, 1); // Output args
    
    h = 24 .* part;
    m = 60 .* (h - floor(h));
    s = 60 .* (m - floor(m));
    hr = floor(h);
    mi = floor(m);
    se = round(s);
    // if seconds are a full minute
    if se == 60 then
        mi = mi + 1;
        se = 0;
    end
    time = [hr mi se];
endfunction
