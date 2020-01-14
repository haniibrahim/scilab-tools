function [y] = interpolation(x1, x2, y1, y2, x)
    // Linear interpolation between two pairs of values
    //
    // Calling Sequence
    // y = interpolation(x1, x2, y1, y2, x)
    //
    // Parameters
    // x1: Nx1 or 1xN double vector -> first x-value (x-axis)
    // x2: Nx1 or 1xN double vector -> second x-value (x-axis)
    // y1: Nx1 or 1xN double vector -> first y-value (y-axis)
    // y2: Nx1 or 1xN double vector -> second y-value (y-axis)
    // x:  Nx1 or 1xN double vector -> target value
    // y:  Nx1 or 1xN double vector -> interpolated y-value of the target x-value
    //
    // Description
    // Linear interpolation between two pairs of values. E.g to 
    // interpolate values between two measurement of a data table. The
    // interpolation is always linear.
    //
    // Vector-capable.
    //
    // It works pretty much the same as Scilab's internal "interpln()" 
    // function. But for the particular case for which this function 
    // was developed entering of data is faster and easier.
    //
    // Examples
    // y1 = interpolation(1, 3, 5, 7, 2) // yi = 6
    // y2 = interpolation([1;2],[3;3],[5;6],[7;8],[2;3]) // column-vectors
    // y3 = interpolation([1 2],[3 3],[5 6],[7 8],[2 3]) // row-vectors
    //
    // See also
    // interpln
    //
    // Authors
    //  Hani Ibrahim ; hani.ibrahim@gmx.de 
      
    [lhs,rhs]=argn()
    apifun_checkrhs("interpolation", rhs, 5); // Input args
    apifun_checklhs("interpolation", lhs, 1); // Output args
    apifun_checktype("interpolation", x1, "x1", 1, "constant");
    apifun_checktype("interpolation", x2, "x2", 2, "constant");
    apifun_checktype("interpolation", y1, "y1", 3, "constant");
    apifun_checktype("interpolation", y2, "y2", 4, "constant");
    apifun_checktype("interpolation", x, "x", 5, "constant");
    apifun_checkvector("interpolation", x1, "x1", 1);
    apifun_checkvector("interpolation", x2, "x2", 2);
    apifun_checkvector("interpolation", y1, "y1", 3);
    apifun_checkvector("interpolation", y2, "y2", 4);
    apifun_checkvector("interpolation", x, "x", 5);
    
    y=y1 + ((y2-y1) ./ (x2-x1)) .* (x-x1);
endfunction
