function [n_t] = radDecay(n_0, t_12, t)
    // Remaining number of atoms after radiactive decay.
    //
    // Calling Sequence
    //   [n_t] = radDecay(n_0, t_12, t)
    //
    // Parameters
    // n_0:  number of atoms of the element at start time
    // t_12: half-time of the element in years or any other time unit 
    // t:    period of time (end time) in the same unit as t_12
    // n_t:  number of atoms of the element at end time t 
    //
    // Description
    // Calculates the remaining number of atoms caused by radiactive decay 
    // after a commited period of time 
    //
    // radDecay can handle vectors
    //
    // Examples
    // [n] = radDecay(1000, 1.2e9, 2.4e9) // Remaining number of 40K (40 Potassium) after readioactive decay of 2.4 billion years
    //
    // See also
    //
    // Authors
    //  Hani Ibrahim ; hani.ibrahim@gmx.de
    //
    
    // Checking args
    [lhs,rhs]=argn();
    apifun_checkrhs("radDecay", rhs, 3); // Input args
    apifun_checklhs("radDecay", lhs, 1); // Output arg
    apifun_checkvector("radDecay", n_0, "n_0", 1);
    apifun_checkvector("radDecay", t_12, "t_12", 1);
    apifun_checkvector("radDecay", t, "t", 1);
    apifun_checktype("radDecay", n_0, "n_0", 1, "constant");
    apifun_checktype("radDecay", t_12, "t_12", 1, "constant");
    apifun_checktype("radDecay", t, "t", 1, "constant");    
    
    n_t=n_0 .* exp(-log(2) .* t ./ t_12)
    
endfunction
