// Quickstarter for SCE scripts
function exe(path)
    // Quickstarter for SCE scripts (*.sce)
    //
    // Calling Sequence
    // exec(path)
    //
    // Parameters
    // path: a string, the path of the script file.
    //
    // Description
    // Executes sequentially the Scilab instructions contained in the file given 
    // by path. exe is the brief version of <link linkend="exec">exec(path, -1))</link>.
    //
    // Examples
    // //create a script file
    // mputl('a=1;b=2',TMPDIR+'/myscript.sce')
    // // execute it w/o printing code
    // exe(TMPDIR+'/myscript.sce')
    // whos -name "a "
    //
    // See also
    // exec
    //
    // Authors
    // Hani Ibrahim ; hani.ibrahim@gmx.de 
    
    [lhs,rhs]=argn();
    apifun_checkrhs("exe", rhs, 1); // Input args
    apifun_checklhs("exe", lhs, 0); // Output args
    //apifun_checktype ( "exe",path,"path",1,["string" "constant"] )
    
    exec(path,-1);
endfunction
