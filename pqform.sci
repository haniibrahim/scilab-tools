function [x1,x2] = pqform(p, q)
    // Solve quadratic equations via p-q-formula.
    //
    // Syntax
    // [x1, x2] = pqform(p, q)
    //
    // Parameters
    // p: 1xN or Nx1 matrix od doubles: coefficient of x
    // q: 1xN or Nx1 matrix od doubles: constant
    // x1: 1xN or Nx1 matrix: Solution 1 of the quadratic equation(s)
    // x2: 1xN or Nx1 matrix: Solution 2 of the quadratic equation(s)
    //
    //<note>Row vectors recomended for p and q values, instead of column vectors.</note>
    //
    // Description
    // Quadratic equation has to be in the normal form as a monic
    // polynomial:
    //
    // f(x) = x^2 + p*x + q = 0
    // 
    // Both possible results will be calculated. It handles complex 
    // numbers in the results.
    //
    // Matrix-capable.
    //
    // Examples
    // [x1, x2] = pqform(6,9)
    // [x1, x2] = pqform([6 2] ,[9 5])
    //
    // See also
    //
    // Authors
    // Hani Ibrahim ; hani.ibrahim@gmx.de 
    
    [lhs,rhs]=argn()
    apifun_checkrhs("pqform", rhs, 2); // Input args
    apifun_checklhs("pqform", lhs, 2); // Output args
    apifun_checktype("pqform", p, "p", 1, "constant");
    apifun_checktype("pqform", q, "q", 2, "constant");
    apifun_checkvector("pqform", p, "p", 1);
    apifun_checkvector("pqform", q, "q", 1);
    
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
