function [c]=degF2degC(f)
    // Convert degrees Fahrenheit to degrees Celsius.
    //
    // Syntax
    // [c] = degF2degC(f)
    //
    // Parameters
    // f: Nx1 matrix or vector of floating point integers, degrees Fahrenheit
    // c: Nx1 matrix (row vector) of doubles,degrees Celsius
    //
    // Description
    // Convert degrees Fahrenheit to degrees Celsius.
    //
    // Matrix-capable.
    //
    // Examples
    // c = degF2degC(100)
    // [c] = degF2degC([1.2 5.3 7.4])
    //
    // See also
    // degC2degF
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
    apifun_checktype("degF2degC", f, "f", 1, ["constant"]);
    
    c = (f - 32) .* 5/9;
endfunction
