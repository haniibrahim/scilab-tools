function [y] = interpolation(x1, x2, y1, y2, x)
    //
    // Linear interpolation between two pairs of values 
    //
    // Calling Sequences
    // y = interpolation(x1, x2, y1, y2, x)
    //
    // Parameters
    // x1: first x-value (x-axis)
    // x2: second x-value (x-axis)
    // y1: first y-value (y-axis)
    // y2: second y-value (y-axis)
    // x:  target value
    // y:  interpolated y-value of the target x-value
    //
    // Description
    // Linear interpolation between two pairs of values. E.g to 
    // interpolate values between two measurement of a data table. The
    // interpolation is always linear.
    //
    // It works pretty much the same as Scilab's internal "interpln()" 
    // function. But for the particular case for which this function 
    // was developed entering of data is faster and easier.
    //
    // Examples
    // yi = interpolation(1, 3, 5, 7, 2) // yi = 6
    //
    
    [lhs,rhs]=argn()
    apifun_checkrhs("interpolation", rhs, 5); // Input args
    apifun_checklhs("interpolation", lhs, 1); // Output args
    
    y=y1 + ((y2-y1) ./ (x2-x1)) .* (x-x1);
endfunction
