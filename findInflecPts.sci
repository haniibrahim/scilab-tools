function [ip_x, ip_y] = findInflecPts(x,y)
    //
    // Find points of inflection of a numerical data
    //
    // CALLING SEQUENCES
    // [ip_x, ip_y] = findInflecPts(x,y)
    //
    // PARAMETERS
    // x:    x-values as a numerical vector
    // y:    y-values as a numerical vector
    //
    // ip_x: x-Value(s) of the point(s) of inflection
    // ip_y: y-Value(s) of the point(s) of inflection
    // 
    // EXAMPLES
    // [ip_x, ip_y] = findInflecPts(x,y)
    //
    inarg = argn(2); // number of parameters/arguments
    if inarg < 2 | inarg > 2 then error(39); end
    
    // 1st numerical derivation
    deriv_y = diff(y)./diff(x); 
    xd = x(2:length(x));
    
    // 2nd numerical derivation
    deriv_y2 = diff(deriv_y)./diff(xd); 
    xd2 = x(2:length(xd));
    
    // find points of inflection by looking for zero points of the 2nd derivation
    delay_mult = deriv_y2(1:length(deriv_y2)-1).*deriv_y2(2:length(deriv_y2));
    ip_x = xd2(find(delay_mult < 0))
    ip_y = y(find(delay_mult <0))
    
endfunction
