function [yp,a,b,r] = linreg(x,y,plt)
    // Performs a simple linear regression
    //
    // Syntax
    // [yp,a,b,r] = linreg(x,y,plt)
    // [yp,a,b,r] = linreg(x,y)
    // [yp,a,b]   = linreg(x,y)
    // [yp]       = linreg(x,y)
    // linreg(x,y,plt)
    //
    // Parameters
    // x:    1xN or Nx1 vector of doubles, x-values
    // y:    1xN or Nx1 vector of doubles, y-values
    // plt:  1x1 matrix of strings (optional), if plt="plt" then a draft plot is performed
    // yp:   1xN vector of doubls, fitted y-values of the best-fit line
    // a:    1x1 vector of doubles, slope of the best-fit line
    // b:    1x1 vector of doubles, intercept of the best-fit line
    // r:    1x1 vector of doubles, correlation coefficient of the linear regression
    //
    // Description
    // Performs a simple linear regression of a dataset of x- and y-values. On
    // default it returns the y-values of the best-fit line (yp). It can also
    // return the slope (a), the intercept (b) of the best-fit line and also
    // the correlation coefficient (r) of the linear regression.
    //
    // If the string "plt" is committed as a 3rd input value, LINREG plots the 
    // raw data points and the best-fit line. Furthermore LINREG prints the 
    // slope, intercept and correlation coefficient in the console.
    //
    // Examples
    // x = [57. 64. 69. 82. 92. 111. 114. 132. 144. 146.];
    // y = [121. 129. 140. 164. 188. 217. 231. 264. 289. 294.];
    //
    // // Just the parameters and the fitted y-values
    // [yp,a,b,r] = linreg(x,y)
    //
    // // Just the plot
    // scf();
    // plot(x,y,"x")
    // plot(x,linreg(x,y))
    //
    // // The printed parameters and the plot
    // linreg(x,y,"plt");
    // 
    // See also
    // reglin
    // nanreglin
    //
    // Authors
    // Hani Ibrahim ; hani.ibrahim@gmx.de 
    
    [lhs,rhs]=argn()
    apifun_checkrhs("linreg", rhs, 2:3); // Input args
    apifun_checklhs("linreg", lhs, 1:4); // Output args
    apifun_checkvector("linreg", x, "x", 1);
    apifun_checkvector("linreg", y, "y", 2);
    if rhs == 3 then
       apifun_checktype("linreg", plt, "plt", 3, "string");
    else
        plt = "";
    end
    
    if size(x)(1) ~= 1 then x=x'; end // transpose to row vector if necessary
    if size(y)(1) ~= 1 then y=y'; end // transpose to row vector if necessary
    [a,b] = reglin(x,y);   // a=slope, b=intercept
    yp    = a .* x + b;    // Y-values for best-fit line
    
    // Calculation correlation coefficient (r)
    n         = length(x);
    Sxy       = sum(x.*y)-sum(x)*sum(y)/n;
    Sxx       = sum(x^2)-sum(x)^2/n;
    Syy       = sum(y^2)-sum(y)^2/n;
    r         = Sxy/sqrt(Sxx*Syy);

    // draft plot
    if plt == "plt" then
        scf();         // new plot window
        plot(x,y,"o"); // raw data as points
        plot(x,yp);    // best-fit line
        // Console output
        mprintf( ..
        "Slope   :                %f\n" + ..
        "Intercept:               %f\n" + ..
        "Correlation Coefficient: %f\n", ..
        a, b, r);
    end
endfunction
