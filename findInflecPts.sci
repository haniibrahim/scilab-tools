function [ip_x, ip_y] = findInflecPts(x,y)
    // Returns points of inflection of a numerical data
    //
    // Calling Sequence
    // ip_x, ip_y] = findInflecPts(x,y)
    //
    // Parameters
    // x:    1xN or Nx1 vector of x-values
    // y:    1xN or Nx1 vector of y-values
    // ip_x: 1xN or Nx1 vector of x-Value(s) of point(s) of inflection
    // ip_y: 1xN or Nx1 vector of y-Value(s) of point(s) of inflection
    //
    // Description
    // Calculates all inflection points of committed data. 
    //
    // Examples
    // x=linspace(-%pi,%pi,100);
    // y=sin(x);
    // [ip_x, ip_y] = findInflecPts(x,y);
    // disp(ip_y, "Inflection points Y:", ip_x,"Inflection points X:")
    // plot(x,y);          // Plot data
    // Plot(ip_x,ip_y,"rx"); // Plot Inflection points in data plot
    //
    // See also
    // findExtremeVal
    //
    // Authors
    //  Hani Ibrahim ; hani.ibrahim@gmx.de 
    
    [lhs,rhs]=argn()
    apifun_checkrhs("findInflecPts", rhs, 2); // Input args
    apifun_checklhs("findInflecPts", lhs, 2); // Output args
    apifun_checkvector("findInflecPts", x, "x", 1);
    apifun_checkvector("findInflecPts", y, "y", 1);
    apifun_checktype("findInflecPts", x, "x", 1, "constant");
    apifun_checktype("findInflecPts", y, "y", 2, "constant");
    
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
