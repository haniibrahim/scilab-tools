function [csvMat, exitID] = readcsv_i(path)
    //
    // Reads a CSV file in a matrix variable interactively
    //
    // CALLING SEQUENCES
    // [csvMat, exitID] = readcsv_i(path)
    // [csvMat, exitID] = readcsv_i()
    //
    // PARAMETERS
    // path:    Path at which the file selector points to first (OPTIONAL)
    //          If not commited the HOME/USERPROFILE directory is used
    // csvMath: Matrix of read numbers from the CSV file (Strings are NaN)
    // exitID:  Exit#
    //           0: Everything is OK
    //          -1: Canceled file selection
    //          -2: Canceled parameter dialog box
    //          -3: Cannot read or interpret CSV file
    // 
    // DESCRIPTION
    // Read an comma-separated-value (CSV) file interactively. You can specify: 
    //  - number of the sheet in a worksheet file
    //  - row range you want to read
    //  - column range you want to read
    // in a GUI. You can commit a init path for the file selector as an 
    // argument as an option. Otherwise the HOME directory is used.
    //
    // The exitID give a feedback what happened inside the function. If 
    // something went wrog csvMat is always [] (empty).
    //
    // EXAMPLES
    // [csvMat, exitID] = readcsv_i(pwd()) // Open the file selector in the currend directory
    // csvMat = readcsv_i()
    //
    
    inarg = argn(2);
    if inarg > 1 then error(39); end
    
    // init values
    exitID = 0; // All OK
    csvMat = []; // Empty result matrix
    
    // Platform-dependent HOME path if "path" was not commited
    if ~exists("path") then
        if getos() == "Windows" then
            path = getenv("USERPROFILE");
        else // Unix, GNU/Linux, macOS
            path = getenv("HOME");
        end
    end
    
    // Get filename incl. path of an CSV file
    fn=uigetfile(["*.csv","Comma Separated Value files (*.csv)"],path,"Choose a csv-file")
    if fn == "" then
        exitID = -1; // Canceled file selector
        return;
    end
    
    // Get some parameters for interpreting the csv file and the name of the output matrix
    labels=["Field separator: , | ; | tab | space"; "Decimal separator: . | ,"; "Number of header lines to skip"; "Row Range, e.g. 2:5 (2nd to 5th row) or 2 (2nd row only) or : (all rows)"; "Column range, e.g. 1:3 (1st to 3rd col.) or 2 (2nd col. only) or : (all columns)"];
    dat=list("str", 1, "str", 1, "vec", 1, "str", 1, "str", 1);
    values=[","; "."; "0"; ":"; ":"];

    [ok, fld_sep, dec, headernum, rowRange, colRange] = getvalue("CSV and Scilab parameters", labels, dat, values);
    
    if ok == %F then  
        exitID = -2; // canceled parameter box
        return;
    end
    
    
    // Field separator
    if fld_sep == "tab" then 
        fld_sep = ascii(9); // tabulator as separator
    elseif fld_sep == "space" then
        fld_sep = ascii(32); // space as separator
    end
    
    // Read CSV file in mat_name
    substitute = ['""',''; '''','']; // Ignore quotes
    try
        execstr("csvMat = csvRead(fn, fld_sep, dec, [], substitute, [], [], headernum);");
        // Setup range
        execstr("csvMat = csvMat(" + rowRange + "," + colRange + ")");
    catch
        exitID = -3; // Error while interpreting CSV file
        return;
    end

endfunction

