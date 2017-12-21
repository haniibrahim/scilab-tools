function grid(switch)
    //
    // Switch grid on or off
    //
    // CALLING SEQUENCES
    // grid(switch)
    //
    // PARAMETERS
    // switch: 0, %F => Grid off
    //         1, %T => Grid on
    //
    // EXAMPLES:
    // grid(%T) // Grid on
    // grid(1)  // Grid on
    //
    
    // Checking args
    inarg = argn(2);
    if inarg < 1 | inarg > 1 then error("Commit just one argument, only"); end
    if switch == %T | switch == 1 then
        set(gca(),"grid",[1 1]); // Grid on
    elseif switch == %F | switch == 0 then
        set(gca(),"grid",[-1 -1]); // Grid off
    else
        error("Wrong type of argument");
    end
endfunction