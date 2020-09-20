function chkToolbox(tb,sci)
    // Displays an error message if a specified ATOMS toolbox is not installed
    //
    // Calling Sequence
    // chkToolbox(tb)
    // chkToolbox(tb,sci)
    //
    // Parameters
    // tb:   scalar of string, name of the requested toolbox (case sensitive)
    // sci: scalar of string, name of the calling script - OPTIONAL
    //
    // Description
    // Checks if a toolbox is installed via ATOMS. If yes, nothing will happen,
    // if no, an error message is displayed, like:
    //
    // Toolbox "[tb]" is not installed
    //
    // or if a scriptname "sci" is committed:
    //
    // [sci]: Toolbox "[tb]" is nit installed
    //
    // <important>The committed name of the toolbox is case sensitive. When 
    // "Apifun" is committed an error is displayed because the name is in 
    // lowercase "apifun"</important>
    //
    // <note>This function can only recognize toolboxes which are installed via
    // ATOMS. It cannot recognize manually installed toolboxes via "loader.sce".
    // </note>
    //
    // Examples
    // chkToolbox("123")
    // chkToolbox("123", "myScript")
    // 
    // See also
    // atomsIsInstalled
    //
    // Authors
    // Hani Ibrahim ; hani.ibrahim@gmx.de
    
    // Check args
    [lhs,rhs]=argn();
    apifun_checkrhs("chkToolbox",rhs,1:2);             // Check if RHS is min. 1 , max. 2
    apifun_checktype("chkToolbox",tb,"tb",1,"string"); // Check if tb is string
    apifun_checkscalar ("chkToolbox",tb,"tb",1);       // Check if sci is a scalar
    if exists("sci") then
        apifun_checktype("chkToolbox",sci,"sci",2,"string");  // Check if sci is string
        apifun_checkscalar ("chkToolbox",sci,"sci",2);        // Check if sci is a scalar
    end
    
    isTbIn = atomsIsInstalled(tb); // Check if tb is installed via ATOMS
    
    if ~isTbIn & exists("sci") then
        error(msprintf(_("%s: Toolbox ""%s"" is not installed.\n"),sci,tb));
    elseif ~isTbIn & ~exists("sci") then
        error(msprintf(_("Toolbox ""%s"" is not installed.\n"),tb));
    end  
endfunction
