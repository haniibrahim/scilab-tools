function fi = fibonacci(n)
    // calculates the Fibonacci number
    //
    // Syntax
    // fi = fibonacci(n)
    //
    // Parameters
    // n: 1x1 scalar of an integer, term of the fibonacci sequence
    // fi: 1x1 scalar of an integer, fibonacci number
    //
    // Description
    // Calculates the fibonacci number of a given term. The term needs to be an 
    // whole number (floating point integer), e.g. 4, 6., 15.0 but not a 
    // double (e.g. 6.2)
    // 
    // Examples
    // fi = fibonacci(6)
    // fi = fibonacci(6.0)
    //
    // // fibonacci sequence up to 6
    // for i = 1:6
    //    seq(i) = fibonacci(i);
    // end
    // disp(seq)
    //
    // See also
    // goldenratio
    //
    // Authors
    // Hani Ibrahim ; hani.ibrahim@gmx.de 
    
    [lhs,rhs]=argn()
    apifun_checkrhs("fibonacci", rhs, 1); // Input args
    apifun_checklhs("fibonacci", lhs, 1); // Output args
    apifun_checkscalar("fibonacci", n,"n",1)
    apifun_checktype("fibonacci", n, "n", 1, ["constant"]);
    
    // Check for integer input
    if ~isint(n) then
        msg = gettext("%s: Wrong type of input arguments: Floating point integers (whole number) expected.\n")
        error(msprintf(msg, "fibonacci"))
    end
    
    fi = round((goldenratio().^n - (1-goldenratio()).^n) ./ sqrt(5)) // fibonacci number (always integer)
    
endfunction
