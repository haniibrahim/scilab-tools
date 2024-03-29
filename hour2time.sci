function [time] = hour2time(hour)
    // Returns the time (hours, minutes, seconds) from a floating point hour value.
    //
    // Syntax
    // [time] = hour2time(hour)
    //
    // Parameters
    // hour: Nx1 matrix (row vector) of doubles: hour
    // time: matrix or vector of floating point integers [hours minutes seconds]
    //
    // Description
    // Calculates the time (hours, minutes, seconds) from a floating point hour 
    // value.
    //
    // <note>Secons are displayes as floating point integers, no decimal places!</note>
    //
    // Matrix-capable.
    //
    // Examples
    // t1   = hour2time(0.5)
    // [t2] = hour2time([0.5; 0.25 ; 0.982; 0.556])
    //
    // See also
    // is_leap_year
    // time2pday
    // time2hour
    //
    // Authors
    // Hani Ibrahim ; hani.ibrahim@gmx.de 
    
    [lhs,rhs]=argn();
    apifun_checkrhs("hour2time", rhs, 1); // Input args
    apifun_checklhs("hour2time", lhs, 1); // Output args
    apifun_checkrange("hour2time", hour, "hour", 1, 0, 24);
    apifun_checkveccol( "hour2time", hour," hour",1); 
    
    
    h = floor(hour);
    m = floor(60 .* (hour - h));
    s = (((hour-h) .* 60) - m) .* 60;

    // if seconds are a full minute
    if s >= 60 then
        m = m + 1;
        s = s - floor(s);
    end
    time = [h m s];
endfunction
