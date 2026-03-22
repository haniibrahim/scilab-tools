function [lb]=kg2lb(kg)
    // Convert kilograms to pounds.
    //
    // Syntax
    // [lb] = kg2mi(lb)
    //
    // Parameters
    // kg: Nx1 matrix or vector of floating point integers, mass in kilograms
    // lb: Nx1 matrix (row vector) of doubles, mass in pounds
    //
    // Description
    // Convert masses from kilograms in pounds.
    //
    // Matrix-capable.
    //
    // Examples
    // m1   = kg2lb(1)
    // [m]  = kg2lb([1.2 5.3 7.4])
    //
    // See also
    // lb2kg
    //
    // Authors
    // Hani Ibrahim ; hani.ibrahim@gmx.de 
    
    [lhs,rhs]=argn()
    apifun_checkrhs("kg2lb", rhs, 1); // Input args
    apifun_checklhs("kg2lb", lhs, 1); // Output args
    apifun_checktype("kg2lb", kg, "kg", 1, ["constant"]);
    
    lb = kg .* 2.20462262;
endfunction
