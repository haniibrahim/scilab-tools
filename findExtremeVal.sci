function [ev_x, ev_y] = findExtremeVal(x,y)
    //
    // Find extreme values (maxima/minima) of numerical data
    //
    // CALLING SEQUENCES
    // [ev_x, ev_y] = findExtremeVal(x,y)
    //
    // PARAMETERS
    // x:    x-values as a numerical vector
    // y:    y-values as a numerical vector
    //
    // ev_x: x-Value(s) of the extreme value(s)
    // ev_y: y-Value(s) of the extreme value(s)
    // 
    // EXAMPLES
    // [ev_x, ev_y] = findExtremeVal(x,y)
    //
    inarg = argn(2); // number of parameters/arguments
    if inarg < 2 | inarg > 2 then error(39); end
    
    // 1st numerical derivation
    deriv_y = diff(y)./diff(x); 
    xd = x(2:length(x));
    
    // find extreme values by looking for zero points of the 1st derivation
    delay_mult = deriv_y(1:length(deriv_y)-1).*deriv_y(2:length(deriv_y));
    ev_x = xd(find(delay_mult < 0))
    ev_y = y(find(delay_mult <0))
    
endfunction
