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
    inarg = argn(2);
    if inarg > 1 | inarg == 0 then error("Commit a number between 0 and 1"); end
    if type(part) ~= 1 | (part > 1 & part < 0)  then
        error("Committed argument has to be a number and >=0 and <=1");
    end
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
