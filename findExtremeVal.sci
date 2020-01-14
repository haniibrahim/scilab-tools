function [ev_x, ev_y] = findExtremeVal(x,y)
    // Returns extreme values (maxima/minima) of numerical data
    //
    // Calling Sequence
    // [ev_x, ev_y] = findExtremeVal(x,y)
    //
    // Parameters
    // x:    1xN or Nx1 vector of x-values
    // y:    1xN or Nx1 vector of y-values
    // ev_x: 1xN or Nx1 vector of x-Value(s) of the extreme value(s)
    // ev_y: 1xN or Nx1 vector of y-Value(s) of the extreme value(s)
    //
    // Description
    // Calculates all extreme values of committed data. 
    //
    // Examples
    // x=linspace(-%pi,%pi,100);
    // y=sin(x);
    // [e_x, e_y] = findExtremeVal(x,y);
    // disp(e_y, "Extreme value Y:", e_x,"Extreme value X:")
    // plot(x,y);          // Plot data
    // Plot(e_x,e_y,"rx"); // Plot extreme values in data plot
    //
    // See also
    // findInflecPts
    //
    // Authors
    //  Hani Ibrahim ; hani.ibrahim@gmx.de 
  
    [lhs,rhs]=argn()
    apifun_checkrhs("findExtremeVal", rhs, 2); // Input args
    apifun_checklhs("findExtremeVal", lhs, 2); // Output args
    apifun_checkvector("findExtremeVal", x, "x", 1);
    apifun_checkvector("findExtremeVal", y, "y", 1);
    apifun_checktype("findExtremeVal", x, "x", 1, "constant");
    apifun_checktype("findExtremeVal", y, "y", 2, "constant");
    
    // 1st numerical derivation
    deriv_y = diff(y)./diff(x); 
    xd = x(2:length(x));
    
    // find extreme values by looking for zero points of the 1st derivation
    delay_mult = deriv_y(1:length(deriv_y)-1).*deriv_y(2:length(deriv_y));
    ev_x = xd(find(delay_mult < 0))
    ev_y = y(find(delay_mult <0))
    
endfunction
