// Golden Ratio
function gr = goldenratio()
    // calculates the number of the golden ratio
    //
    // Syntax
    // gr = goldenratio()
    //
    // Parameters
    // gr: 1x1 scalar of an integer, golden ratio number
    //
    // Description
    // Calculates the number of a the bolden ratio (1.6180...) as accurate as
    // possible
    // 
    // Examples
    // gr = goldenratio()
    //
    // See also
    // fibonacci
    //
    // Authors
    // Hani Ibrahim ; hani.ibrahim@gmx.de 
    [lhs,rhs]=argn()
    apifun_checklhs("goldenratio", lhs, 0); // Input args
    apifun_checkrhs("goldenratio", rhs, 0); // Input args
    
    gr = ((1+sqrt(5))/2)
    
endfunction
