function [leapYear] = is_leap_year(year)
    //
    // Calculates whether the committed year is a leap year or not. 
    // (Same nomenclatur as in Matlab/Octave)
    // 
    // CALLING SEQUENCES
    // leapYear = is_leap_year(year)
    //
    // PARAMETERS
    // year:      is the four-digit number of the year in question.
    // leapYear : is a boolean which is TRUE if "year" is a leap year 
    //            and FALSE if not.
    // 
    // EXAMPLES
    // is_leap_year(2000) // ans = T
    // is_leap_year(1900) // ans = F
    
    // Check committed argument
    [lhs,rhs]=argn()
    apifun_checkrhs("is_leap_year", rhs, 0:1); // Input args
    apifun_checklhs("is_leap_year", lhs, 1); // Output args
    
    if rhs == 0 then
        curDate = clock;
        year = curDate(1); 
    end

    // Leap year
    // - Every 4th year is a leap year
    // - But every 100th year is not a leap year
    // - But every 400th year is a leap year  
    fourth        = pmodulo(year,4);
    hundredth     = pmodulo(year,100);
    fourhundredth = pmodulo(year, 400);

    if ( fourth == 0 & hundredth ~= 0 | fourhundredth == 0 )
        leapYear = %T;
    else
        leapYear = %F;
    end  
endfunction
