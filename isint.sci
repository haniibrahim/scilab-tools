function [retval] = isint(n, neg, z)
    // Determine if committed number is a floating point integer.
    //
    // Calling Sequence
    // [retval] = isint(n, neg, z)
    //
    // Parameters
    // n:      NxM matrix of doubles: numbers for testing
    // neg:    Scalar of boolean: %T: Positive and negative floating point integers are true (default), %F: Only positive floating point integers are true,
    // z:      Scalar of boolean: %T: Including zero (default), %F: Excluding zero
    // retval: NxM matrix of booleans
    //
    // Description
    // Returns true (T) if the committed value "n" is a floating point integer, means 
    // a double without decimal places. 
    //
    // By default positive and negative doubles without decimal places are included
    // => retval=T. If "neg" is committed as %F ONLY positive doubles without 
    // decimal places are included. Negative ones return then => retval=F
    //
    // By default a zero (0) is included as integer => retval=T. If "z" is 
    // committed as %F, zero is not included => retval=F.
    //
    // <note>Matrix-capable.</note>
    //
    // Examples
    // // isint = true
    // r1 = isint(12.0)
    // r2 = isint(-12e5)
    // r3 = isint(0)
    // r4 = isint([2 5 6 ; 8.0 9 -10])
    // // isint = false
    // r5 = isint(1.02)
    // r6 = isint(-1,%F) // only positive integers
    // r7 = isint(0,,%F) // without zero
    // // isint = mixed
    // r8 = isint([12 2.3 6 ; 5.3 5 9.0])
    // r9 = isint([-1 5 0 7 ; 8 -2 0 9], %f, %f)
    //
    // See also
    // isnumeric
    // isreal
    // isnum
    //
    // Authors
    // Hani Ibrahim ; hani.ibrahim@gmx.de 
    
    // Checking args
    [lhs,rhs]=argn()
    apifun_checkrhs("isint", rhs, 1:3); // Input args
    apifun_checklhs("isint", lhs, 1); // Output args
    apifun_checktype("isint", n, "n", 1, "constant");  
    // Default values if not committed
    if ~exists("neg") then neg = %t; end
    if ~exists("z")   then z   = %t; end
    // ---
    apifun_checkscalar("isint", neg, "neg", 2);
    apifun_checkscalar("isint", z, "z", 3);
    apifun_checktype("isint", neg, "neg", 2, "boolean");
    apifun_checktype("isint", z, "z", 3, "boolean");
    
    retval = [];
    for i=1:size(n)(1)
        for j=1:size(n)(2)
            if isnumeric(n(i,j)) & (n(i,j)-floor(n(i,j)) == 0) & neg == %t & z == %t then
                retval(i,j) = %t;
            elseif isnumeric(n(i,j)) & (n(i,j)-floor(n(i,j)) == 0) & neg == %t & z == %f & n(i,j) ~= 0 then
                retval(i,j) = %t;
            elseif isnumeric(n(i,j)) & (n(i,j)-floor(n(i,j)) == 0) & neg == %f & n(i,j) > 0 & z == %f then
                retval(i,j) = %t;
            elseif isnumeric(n(i,j)) & (n(i,j)-floor(n(i,j)) == 0) & neg == %f & z == %t & n(i,j) >= 0 then
                retval(i,j) = %t;
            else
                retval(i,j) = %f;
            end 
        end
    end
endfunction
