function leapYear = is_leap_year(year)
    // Calculates whether the committed year is a leap year or not. 
    //
    // Syntax
    // leapYear = is_leap_year(year)
    //
    // Parameters
    // year:      Double of four-digit number of the year in question.
    // leapYear : Boolean which is TRUE if "year" is a leap year and FALSE if not.
    //
    // Description
    // Calculates whether the committed year is a leap year or not. 
    // (Same nomenclatur as in Matlab/Octave)
    //
    // Examples
    // ly1 = is_leap_year(2000) // ans = %T
    // ly2 = is_leap_year(1900) // ans = %F
    //
    // See also
    //
    // Authors
    //  Hani Ibrahim ; hani.ibrahim@gmx.de 
    
    // Check argument
    [lhs,rhs]=argn()
    apifun_checkrhs("is_leap_year", rhs, 0:1); // Input args
    apifun_checklhs("is_leap_year", lhs, 1); // Output args
    apifun_checkscalar ( "is_leap_year",year,"year",1 );
    apifun_checktype ( "is_leap_year",year,"year",1,"constant" )
    
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
