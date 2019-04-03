function grid(sw)
    //
    // Switch grid on or off
    //
    // CALLING SEQUENCES
    // grid(sw)
    //
    // PARAMETERS
    // sw: 0, %F => Grid off
    //         1, %T => Grid on
    //
    // EXAMPLES:
    // grid(%T) // Grid on
    // grid(1)  // Grid on
    //
    
    // Checking args
    [lhs,rhs]=argn()
    apifun_checkrhs("grid", rhs, 1); // Input args    
    
    if sw == %T | sw == 1 then
        set(gca(),"grid",[1 1]); // Grid on
    elseif sw == %F | sw == 0 then
        set(gca(),"grid",[-1 -1]); // Grid off
    else
        error("Wrong type of argument");
    end
endfunction
