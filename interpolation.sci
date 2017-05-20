function [y] = interpolation(x1, x2, y1, y2, x)
    //
    // Linear interpolation between two pairs of values 
    //
    // CALLING SEQUENCES
    // y = interpolation(x1, x2, y1, y2, x)
    //
    // PARAMETERS
    // x1: first x-value (x-axis)
    // x2: second x-value (x-axis)
    // y1: first y-value (y-axis)
    // y2: second y-value (y-axis)
    // x:  target value
    // y:  interpolated y-value of the target x-value
    //
    // DESCRIPTION
    // Linear interpolation between two pairs of values. E.g to 
    // interpolate values between two measurement of a data table. The
    // interpolation is always linear.
    //
    // It works pretty much the same as Scilab's internal "interpl()" 
    // function. But for the particular case for which this function 
    // was developed entering of data is faster and easier.
    //
    // EXAMPLE
    // Interplate the y-value for the x-value = 2 linearly. Data:
    // x | y
    // --+--
    // 1 | 5
    // 3 | 7
    //
    // y = interpolation(1, 3, 5, 7, 2)
    //
    y=y1 + ((y2-y1) ./ (x2-x1)) .* (x-x1);
endfunction
