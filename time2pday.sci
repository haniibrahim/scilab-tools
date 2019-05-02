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
    
    [lhs,rhs]=argn()
    apifun_checkrhs("time2pday", rhs, 1); // Input args
    apifun_checklhs("time2pday", lhs, 1); // Output args
    apifun_checkvector("time2pday", time, "time", 1);
    apifun_checktype("tme2hour", time, "time", 1, ["constant"])
    
    // Extent time vecor, if needed
    if length(time) == 2 then time = [time 0]; end
    if length(time) == 1 then time = [time 0 0]; end
    
    h = time(:,1);
    m = time(:,2);
    s = time(:,3);
    
    part = h ./ 24 + m ./ (60 * 24) + s ./ (60 * 60 * 24);
    
endfunction
