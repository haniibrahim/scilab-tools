function [retval] = rem(x, y)
    // Returns the remaining part of a division (Matlab-compatible)
    //
    // Syntax
    // [retval] = rem(x, y)
    //
    // Parameters
    // x:      1xN or Nx1 matrix of doubles: numerator
    // y:      1xN or Nx1 matrix of doubles: denominator
    // retval: 1xN or Nx1 matrix of doubles: remaining part of the devision of x / y
    //
    // Description
    // Returns the remaining part of a division. 
    //
    // If y is greater than x, x is returned. If y is 0 "nan" is returned.  
    // This behaviour is Matlab/Octave compatible.
    //
    // Matrix capable.
    //
    // Examples
    // r1   = rem(5,2) // 5/2=2, remaining 1
    // [r2] = rem([3 6],[2 2])
    //
    // See also
    //
    // Authors
    // Hani Ibrahim ; hani.ibrahim@gmx.de 
    
    // Checking args
    [lhs,rhs]=argn()
    apifun_checkrhs("rem", rhs, 2); // Input args
    apifun_checklhs("rem", lhs, 1); // Output args
    apifun_checktype("rem", x, "x", 1, "constant");
    apifun_checktype("rem", y, "y", 2, "constant");
    
//    // Check y for 0
//    if [y] == 0 then
//        error(msprintf(_("%s: Division by 0...\n"),"rem"));
//    end
    
    if y > x then // Check whether x is bigger than y
        retval = x;
    else
        retval = x-fix(x./y).* y;
    end

endfunction
