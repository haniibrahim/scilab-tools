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
    inarg = argn(2);
    if inarg < 1 then error("Commit a number between 0 and 1"); end
    
    h = time(:,1);
    m = time(:,2);
    s = time(:,3);
    
    hour = h + m ./ 60 + s ./ (60 * 60);
    
endfunction
