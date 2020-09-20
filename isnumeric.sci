function [retval] = isnumeric(n)
    // Determine if input is a numeric array (Matlab-compatible)
    //
    // Calling Sequence
    // [retval] = isnumeric(n)
    //
    // Parameters
    // n:      NxN matrix of doubles
    // retval: Boolean
    //
    // Description
    // Returns true (T) if the committed value is a numeric value or array. 
    // tf = isnumeric(A) returns logical 1 (true) if A is a numeric array and 
    // logical 0 (false) otherwise. For example, sparse arrays and double arrays
    // are numeric, while strings, cell arrays, and structure arrays and logicals 
    // are not.
    // 
    // Matlab-compatible and matrix-capable.
    //
    // Examples
    // // isnumeric = true
    // r1 = isnumeric(12)
    // r2 = isnumeric(12.4e5)
    // r3 = isnumeric ([1 2.3 4; 5 9.7 2e-8])
    // // isnumeric = false
    // r4 = isnumeric("text")
    // r5 = isnumeric("12")
    // a  = cell([2, 3, 4]);
    // r6 = isnumeric(a)
    // r7 = ismumeric(%t)
    //
    // See also
    // isint
    // isreal
    // isnum
    //
    // Authors
    // Hani Ibrahim ; hani.ibrahim@gmx.de 
    
    // Checking args
    [lhs,rhs]=argn()
    apifun_checkrhs("isnumeric", rhs, 1); // Input args
    apifun_checklhs("isnumeric", lhs, 1); // Output args
    
    retval = or(type(n)==[1 5 8]);
    
endfunction
