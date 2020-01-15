function fn = getFn(path, filterset)
    // Creates a dialog window for text-data, xls-data, sod and diary file 
    // selection and return the full path including file name.
    //
    // Calling Sequence
    // fn = getFn()
    // fn = getCsvFn(path)
    // fn = getCsvFn(path, filterset)
    //
    // Parameters
    // path: a character string which gives the initial directory used for file search. OPTIONAL, by default path is home profile/directory - OPTIONAL
    // fltr: a character string with a filterset name: "dat" or "xls" or "sod" or "dia") - OPTIONAL
    // fn:   a character string which gives the user selected file (path + file name) if user answers "Cancel" fn = ""
    //
    // Description
    // Displays a file selector dialog box to choose filenames. It return the 
    // filename (path and filename) of the selected file as a string.
    //
    // An initial path can be committed as a string or function , 
    // eg. pwd()=current directory. If no path is specified the home directory
    // is used.
    //
    // A file extension filtersets can be committed. If no filter is 
    // specified, all files will be displayed. The following filtersets are available:
    //
    // <itemizedlist>
    // <listitem><para>dat = *.csv, *.txt, *.dat</para></listitem>
    // <listitem><para>xls = *.xls</para></listitem>
    // <listitem><para>sod = *.sod</para></listitem>
    // <listitem><para>dia = *.diary.txt</para></listitem>
    // </itemizedlist>
    // 
    // The "All Files" filter is always selectable.
    //
    // Examples
    // Initial directory is home directory, no extension filtering
    // fn = getFn();
    // 
    // Initial directory is temporary directory
    // fn = getFn(TMPDIR) // Initial directory is temporary directory
    //
    // Initial directory is home directory (default), one filter can be applied (csv & txt & dat files are displayed)
    // fn = getFn("", "dat");
    //
    // Initial directory is current directory and two filters can be applied
    // fn = getFn(pwd(), "sod");
    //
    // See also
    //
    // Authors
    //  Hani Ibrahim ; hani.ibrahim@gmx.de
    
    // path = platform-dependent HOME path
    function home_path = getPath()
        if getos() == "Windows" then
            home_path = getenv("USERPROFILE");
        else
            home_path = getenv("HOME");
        end
     endfunction

    // Check args
    [lhs, rhs] = argn()
    apifun_checkrhs("getCsvFn",rhs, 0:2);
    apifun_checklhs("getCsvFn",lhs, 1);
    
    // Filtersets
    dat = ["*.csv|*.txt|*.dat","Data text files (*.csv, *.txt, *.dat)"];
    xls = ["*.xls","Excel 97-2000 files (*.xls)"];
    sod = ["*.sod", "Scilab variable files (*.sod)"];
    dia = ["*.diary.txt", "Diary file (*.diary.txt)"];
    
    if rhs == 0 then
        path = getPath();
        filterset = """""";
    end
    if rhs == 1 then
        apifun_checkscalar("getFn", path, "path",1);
        apifun_checktype("getFn", path, "path",1 , "string" );
        if path == "" then path = getPath(); end
        filterset = """""";
    end
    if rhs == 2 then
        apifun_checkoption("getFn", filterset, "filterset", 2, ["dat" "xls" "sod" "dia"])
        if path == "" then path = getPath(); end
    end

    // Get filename incl. path of an CSV file
    execstr("fn=uigetfile(" + filterset + " , path,""Choose a file"")");
endfunction
