function [kg]=lb2kg(lb)
    // Convert pounds to kilograms.
    //
    // Syntax
    // [kg] = lb2kg(lb)
    //
    // Parameters
    // kg: Nx1 matrix or vector of floating point integers, mass in pounds
    // lb: Nx1 matrix (row vector) of doubles, mass in kilogram
    //
    // Description
    // Convert masses from pounds in kilograms.
    //
    // Matrix-capable.
    //
    // Examples
    // m1   = lb2kg(1)
    // [m]  = lb2kg([1.2 5.3 7.4])
    //
    // See also
    // kg2lb
    //
    // Authors
    // Hani Ibrahim ; hani.ibrahim@gmx.de 
    
    [lhs,rhs]=argn()
    apifun_checkrhs("lb2kg", rhs, 1); // Input args
    apifun_checklhs("lb2kg", lhs, 1); // Output args
    apifun_checktype("lb2kg", lb, "lb", 1, ["constant"]);
    
    kg = lb ./ 2.20462262;
endfunction
