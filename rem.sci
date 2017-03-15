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
    inarg = argn(2);
    if inarg < 2 then error("Need 2 arguments"); end
    if ~isnum(string(x)) | ~isnum(string(y)) then
        error("Commit numbers, only");
    end
    
    retval = x-fix(x./y).* y;

endfunction
