function [g]=gcd(a, b)
    //
    // Determine the greates common divisor GCD
    //
    // CALLING SEQUENCES
    // [g] = gcd(a,b)
    //
    // PARAMETERS
    // a: values as a numerical vector
    // b: values as a numerical vector
    //
    // g: Greates common divisor GCD of a and b
    // 
    // EXAMPLES
    // [g] = gcd(1920,1080)
    //
    
    [lhs,rhs]=argn()
    apifun_checkrhs("gcd", rhs, 2); // Input args
    apifun_checklhs("gcd", lhs, 1); // Output args
    
    if a == 0 then 
        g = b;
        return; 
    end
    if b == 0 then 
        g = a;
        return;
    end
    
    while %t do
        h = modulo(a,b);
        a = b;
        b = h;
        if b==0 then break; end
    end
    
    g = a;
    return;
endfunction
