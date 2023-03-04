function grid(swit)
    // Turns on grid ON or OFF on plots
    //
    // Syntax
    // grid(swit)
    //
    // Parameters
    // swit: Boolean or 0/1 (0/%F => Grid off 1/%T => Grid on)
    //
    // Description
    // Turns on grid ON or OFF on plots 
    //
    // Examples
    // grid(%T) // Grid on
    // grid(1)  // Grid on
    //
    // See also
    //
    // Authors
    //  Hani Ibrahim ; hani.ibrahim@gmx.de 
    
    // Checking args
    [lhs,rhs]=argn()
    apifun_checkrhs("grid", rhs, 1); // Input args
//    apifun_checklhs("grid", lhs, 0); // Output args
    apifun_checktype("grid", swit, "swit", 1, ["boolean" "constant"])
        
    if swit == %T | swit == 1 then
        set(gca(),"grid",[1 1]); // Grid on
    elseif swit == %F | swit == 0 then
        set(gca(),"grid",[-1 -1]); // Grid off
    else
        error("Wrong type of argument => %t, %f, 0, 1");
    end
endfunction
