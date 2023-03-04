function fn = putFn(path, filterset)
    // Opens a dialog box to enter an arbitrary file name and returns this 
    // file name including path.
    //
    // Syntax
    // fn = putFn()
    // fn = putFn(path)
    // fn = putFn(path, filterset)
    //
    // Parameters
    // path:      a character string which gives the initial directory used for file search. OPTIONAL, by default path is home profile/directory - OPTIONAL
    // filterset: a character string with a filterset name: "dat" or "xls" or "sod" or "dia") - OPTIONAL
    // fn:        a character string which gives the user selected file (path + file name) if user answers "Cancel" fn = ""
    //
    // Description
    // Opens a file selector dialog box to enter an arbitrary filename. It 
    // returns this filename (path and filename) as a string. If CANCEL is clicked
    // an empty string is returned.
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
    // putFn checks whether fn has an extension. If not and a filterset is used it 
    // sets an appropriate one:
    // dat => ".txt"
    // xls => ".xls"
    // sod => ".sod"
    // dia => ".diary.txt"
    //
    // If no filterset is used you can set a filename without an extension.
    //
    // Examples
    // // Initial directory is home directory, no extension filtering
    // fn = putFn();
    // 
    // // Initial directory is temporary directory
    // fn = putFn(TMPDIR)
    //
    // // Initial directory is home directory (default), one filter can be 
    // // applied (csv & txt & dat files are displayed)
    // fn = putFn("", "dat");
    //
    // // Initial directory is current directory and two filters can be applied
    // fn = putFn(pwd(), "sod");
    //
    // See also
    // getFn
    // uiputfile
    //
    // Authors
    // Hani Ibrahim ; hani.ibrahim@gmx.de

    // Check args
    [lhs, rhs] = argn()
    apifun_checkrhs("putFn",rhs, 0:2);
    apifun_checklhs("putFn",lhs, 1);
    
    // Filtersets
    dat = ["*.csv|*.txt|*.dat","Data text files (*.csv, *.txt, *.dat)"];
    xls = ["*.xls","Excel 95-2000 files (*.xls)"];
    sod = ["*.sod", "Scilab variable files (*.sod)"];
    dia = ["*.diary.txt", "Diary file (*.diary.txt)"];
    
    if rhs == 0 then
        path = home;
        filterset = """""";
    end
    if rhs == 1 then
        apifun_checkscalar("putFn", path, "path",1);
        apifun_checktype("putFn", path, "path",1 , "string" );
        if path == "" then path = home; end
        filterset = """""";
    end
    if rhs == 2 then
        apifun_checkoption("putFn", filterset, "filterset", 2, ["dat" "xls" "sod" "dia"])
        if path == "" then path = home; end
    end

    // Get filename incl. path of an CSV file
    execstr("fn=uiputfile(" + filterset + " , path,""Enter a filename"")");
    
    // Checks if fn has an extension. If not and a filterset is used it 
    // sets an appropriate one:
    // dat => ".txt"
    // xls => ".xls"
    // sod => ".sod"
    // dia => ".diary.txt"
    ext = "";
    if fileparts(fn, "extension") == "" then
        select filterset
        case "dat" then
            ext = ".txt";
        case "xls" then
            ext = ".xls";
        case "sod" then
            ext = ".sod";
        case "dia" then
            ext = ".diary.txt";
        else
            ext = ""; // no filterset chosen
        end
    end
    
    fn = fn + ext;
    
endfunction
