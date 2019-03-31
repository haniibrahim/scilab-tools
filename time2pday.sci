function [part] = time2pday(time)
    //
    // Calculates the part of a day from a vector of time [hr min sec]
    //
    // CALLING SEQUENCES
    // pday = time2pday(time)
    //
    // PARAMETERS
    // time: [h m s] matrix
    // h: hour as int
    // m: minute as int
    // s: second as double
    // part: part of a day as doubletime
    //
    // EXAMPLES
    // time2pday([12 0 0])
    // ans = 0.5
    //
    inarg = argn(2);
    if inarg < 1 then error("Commit a vector [hours minutes seconds]"); end
    // Extent time vecor, if needed
    if length(time) == 2 then time = [time 0]; end
    if length(time) == 1 then time = [time 0 0]; end
    
    h = time(:,1);
    m = time(:,2);
    s = time(:,3);
    
    part = h ./ 24 + m ./ (60 * 24) + s ./ (60 * 60 * 24);
    
endfunction
