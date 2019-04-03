function y0 = newtonpoly(x, y, x0)
    //
    // Newton's devided difference polynomial method for interpolation
    //
    // CALLING SEQUENCES
    // IP = newtonpoly(x, f, x0)
    //
    // PARAMETERS
    // x:  Vector of x-axis data
    // y:  Vector of y-axis data
    // x0: x-value to interpolate
    // y0: Interpolated f-value
    //
    // DESCRIPTION
    // Newton’s divided difference interpolation formula is a 
    // interpolation technique used when the interval difference is 
    // not same for all sequence of values.
    //
    // EXAMPLES
    // y0 = newtonpoly([1 2 7 15], [100 101 106 109], 8)
    // 
    
    // Check input arguments
    [lhs,rhs]=argn()
    apifun_checkrhs("newtonpoly", rhs, 3); // Input args
    apifun_checklhs("newtonpoly", lhs, 1); // Output args
    apifun_checkvector("newtonpoly", x, "x", 1);
    apifun_checkvector("newtonpoly", y, "y", 1);
    apifun_checkscalar("newtonpoly", x0, "x0", 1);
    
    n=length(x);
    a(1) = y(1);
    for k=1:n-1
        D(k,1) = (y(k+1) - y(k))/(x(k+1) - x(k));
    end
    for j=2:n-1
        for k=1:n-j
            D(k,j) = (D(k+1, j-1) - D(k, j-1))/(x(k+j) - x(k));
        end
    end
    
    for j=2:n 
         a(j) = D(1, j-1);
    end
    
    Df(1) = 1;
    c(1) = a(1);
    
    for j=2:n
        Df(j) = (x0 - x(j-1)) .* Df(j-1);
        c(j) = a(j) .* Df(j);
    end
    
    y0 = sum(c);
endfunction
