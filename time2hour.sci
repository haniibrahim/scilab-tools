function [hour] = time2hour(time)
    //
    // Convert time to a number of hour
    //
    // CALLING SEQUENCES
    // hour = time2hour(time)
    // hour = time2hour([h m s])
    //
    // PARAMETERS
    // time: [h m s] matrix
    // h: hour as int
    // m: minute as int
    // s: second as double
    // hour: number of hour
    //
    // EXAMPLES
    // time2hour([12 0 0])
    //
    
    [lhs,rhs]=argn()
    apifun_checkrhs("time2hour", rhs, 1); // Input args
    apifun_checklhs("time2hour", lhs, 1); // Output args
    apifun_checkvector("time2hour", time, "time", 1);
    
    // Extent time vecor, if needed
    if length(time) == 2 then time = [time 0]; end
    if length(time) == 1 then time = [time 0 0]; end
    
    h = time(:,1);
    m = time(:,2);
    s = time(:,3);
    
    hour = h + m ./ 60 + s ./ (60 * 60);
    
endfunction
