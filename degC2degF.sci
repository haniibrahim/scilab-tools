function [f]=degC2degF(c)
    // Convert degrees Celsius to degrees Fahrenheit.
    //
    // Syntax
    // [c] = degF2degC(f)
    //
    // Parameters
    // f: Nx1 matrix or vector of floating point integers, degrees Celsius
    // c: Nx1 matrix (row vector) of doubles, degrees Fahrenheit
    //
    // Description
    // Convert degrees Celsius to degrees Fahrenheit.
    //
    // Matrix-capable.
    //
    // Examples
    // f = degF2degC(100)
    // [f] = degF2degC([1.2 5.3 7.4])
    //
    // See also
    // degF2degC
    // mi2km
    // feet2meter
    // meter2feet
    // lb2kg
    // kg2lb
    //
    // Authors
    // Hani Ibrahim ; hani.ibrahim@gmx.de 
    
    [lhs,rhs]=argn()
    apifun_checkrhs("degF2degC", rhs, 1); // Input args
    apifun_checklhs("degF2degC", lhs, 1); // Output args
    apifun_checktype("degF2degC", c, "c", 1, ["constant"]);
    
    f = (c .* 9/5) + 32;
endfunction
