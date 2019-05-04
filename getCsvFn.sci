function fn = getCsvFn(path)
    // Creates a dialog window for CSV-file selection.
    //
    // Calling Sequence
    //   fn = getCsvFn()
    //   fn = getCsvFn(path)
    //
    // Parameters
    // path: a character string which gives the initial directory used for file search. OPTIONAL, by default path is home profile/directory
    // fn:   a character string which gives the user selected file (path + file name) if user answers "Cancel" fn = ""
    //
    // Description
    // Displays a file selector dialog box to choose one CSV-file. It return the 
    // filename (path and filename) of the selected file. 
    //
    // Examples
    // fn = getCsvFn() // Initial directory is home directory
    //
    // fn = getCsvFn(TMPDIR) // Initial directory is temporary directory
    //
    // See also
    //  readcvs_i
    //  readxls_i
    //
    // Authors
    //  Hani Ibrahim

    // Check args
    [lhs, rhs] = argn()
    apifun_checkrhs("getCsvFn",rhs, 0:1);
    apifun_checklhs("getCsvFn",lhs, 1);
    if rhs == 1 then
        apifun_checkscalar("getCsvFn", path, "path",1);
        apifun_checktype("getCsvFn", path, "path",1 , "string" );
    else
        // Platform-dependent HOME path
        if getos() == "Windows" then
            home_path = getenv("USERPROFILE");
        else
            home_path = getenv("HOME");
            path = home_path;
        end
        path = home_path;
    end

    // Get filename incl. path of an CSV file
    fn=uigetfile(["*.csv|*.txt|*.dat","Data text files (*.csv, *.txt, *.dat)"], path,"Choose a csv-file");
endfunction
