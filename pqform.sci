function [x1,x2] = pqform(p, q)
    //
    // Performs the p-q formula for solving quadratic equations
    //
    // CALLING SEQUENCES
    // [x1, x2] = pqform(p, q)
    //
    // PARAMETERS
    // p: coefficient of x as a double
    // q: constant as a double
    // x1: result 1
    // x2: result 2
    //
    // DESCRIPTION
    // Quadratic equation has to be in the normal form as a monic
    // polynomial:
    //
    // f(x) = x^2 + p*x + q = 0
    // 
    // Both possible results will be calculated. It handles complex 
    // numbers in the results.
    //
    // EXAMPLES:
    // [x1, x2] = pqform(6,9)
    // x1 = -3
    // x2 = -3
    //
    // [x1, x2] = pqform(2,5)
    // x1 = -1 - 2.i
    // x2 = -1 + 2.i
    // 
    
    [lhs,rhs]=argn()
    apifun_checkrhs("pqform", rhs, 2); // Input args
    apifun_checklhs("pqform", lhs, 2); // Output args
    
    
    t1 = p ./ 2;
    t2 = (t1) .^2 - q;

    if t2 >= 0 then
        x1 = -t1 + sqrt(t2);
        x2 = -t1 - sqrt(t2);
    else
        x1 = -t1 + sqrt(abs(t2)) .* %i;
        x2 = -t1 - sqrt(abs(t2)) .* %i;
    end
    return;
endfunction
