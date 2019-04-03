function [retval] = rem(x, y)
    //
    // Remaining part of a division
    //
    // CALLING SEQUENCES
    // retval = tem(x,y)
    //
    // PARAMETERS
    // x:      numerator as a double
    // y:      denominator as a double
    // retval: remaining part of the devision of x and y
    //
    // EXAMPLES
    // rem(5,2) // 5/2=2, remaining 1
    // ans = 1
    //

    // Checking args
    [lhs,rhs]=argn()
    apifun_checkrhs("rem", rhs, 2); // Input args
    apifun_checklhs("rem", lhs, 1); // Output args

    if ~isnum(string(x)) | ~isnum(string(y)) then
        error("Commit numbers, only");
    end
    
    retval = x-fix(x./y).* y;

endfunction
