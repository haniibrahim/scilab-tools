function fn = getFn(path, filterset)
    // Opens a dialog window to select an arbitrary filename. 
    // and returns this filename including path.
    //
    // Syntax
    // fn = getFn()
    // fn = getCsvFn(path)
    // fn = getCsvFn(path, filterset)
    //
    // Parameters
    // path:      a character string which gives the initial directory used for file search. OPTIONAL, by default path is home profile/directory - OPTIONAL
    // filterset: a character string with a filterset name: "dat" or "xls" or "sod" or "dia") - OPTIONAL
    // fn:        a character string which gives the user selected file (path + file name) if user answers "Cancel" fn = ""
    //
    // Description
    // Opens a file selector dialog box to choose a filename. It returns the 
    // filename (path and filename) of the selected file as a string.
    //
    // An initial path can be committed as a string or function , 
    // eg. pwd()=current directory. If no path is specified the home directory
    // is used.If CANCEL is clicked an empty string is returned.
    //
    // A file extension filtersets can be committed. If no filter is 
    // specified, all files will be displayed. The following filtersets are available:
    //
    // <itemizedlist>
    // <listitem><para>dat = *.csv, *.txt, *.dat</para></listitem>
    // <listitem><para>xls = *.xls</para></listitem>
    // <listitem><para>hdf = *.h5, *.hdf, *.hdf5</para></listitem>
    // <listitem><para>sod = *.sod</para></listitem>
    // <listitem><para>dia = *.diary.txt</para></listitem>
    // </itemizedlist>
    // 
    // The "All Files" filter is always selectable.
    //
    // Examples
    // // Initial directory is home directory, no extension filtering
    // fn = getFn();
    // 
    // // Initial directory is temporary directory
    // fn = getFn(TMPDIR)
    //
    // // Initial directory is home directory (default), one filter can be 
    // // applied (csv & txt & dat files are displayed)
    // fn = getFn("", "dat");
    //
    // // Initial directory is current directory and two filters can be applied
    // fn = getFn(pwd(), "sod");
    //
    // See also
    // putFn
    // uigetfile
    //
    // Authors
    // Hani Ibrahim ; hani.ibrahim@gmx.de

    // Check args
    [lhs, rhs] = argn()
    apifun_checkrhs("getFn",rhs, 0:2);
    apifun_checklhs("getFn",lhs, 1);
    
    // Filtersets
    dat = ["*.csv|*.txt|*.dat","Data text files (*.csv, *.txt, *.dat)"];
    xls = ["*.xls","Excel 95-2000 files (*.xls)"];
    sod = ["*.sod", "Scilab variable files (*.sod)"];
    dia = ["*.diary.txt", "Diary file (*.diary.txt)"];
    hdf = ["*.h5|hdf|hdf5|sod", "HDF5-files (*.h5, *.hdf, *.hdf5, *.sod)"];
    
    if rhs == 0 then
        path = home;
        filterset = """""";
    end
    if rhs == 1 then
        apifun_checkscalar("getFn", path, "path",1);
        apifun_checktype("getFn", path, "path",1 , "string" );
        if path == "" then path = home; end
        filterset = """""";
    end
    if rhs == 2 then
        apifun_checkoption("getFn", filterset, "filterset", 2, ["dat" "xls" "sod" "dia" "hdf"])
        if path == "" then path = home; end
    end

    // Get filename incl. path of an CSV file
    execstr("fn=uigetfile(" + filterset + " , path,""Choose a file"")");
endfunction
