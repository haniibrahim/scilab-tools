function [exitID] = writecsv_i(path)
    //
    // Write numerical data stored in a matrix in a CSV file interactively
    //
    // CALLING SEQUENCES
    // [exitID] = readcsv_i(path)
    // [exitID] = readcsv_i()
    //
    // PARAMETERS
    // path:    Path at which the file selector points to first (OPTIONAL)
    //          If not commited the HOME/USERPROFILE directory is used
    // exitID:  Exit#
    //           0: Everything is OK
    //          -1: Canceled file selection
    //          -2: Canceled parameter dialog box
    //          -3: Cannot write CSV file
    // 
    // DESCRIPTION
    // Write a given numerical matrix to an CSV-file interactively. 
    //
    // EXAMPLES
    // [exitID] = writecsv_i(pwd()) // Open the file selector in the currend directory
    // writecsv_i()
    //
    
    inarg = argn(2);
    if inarg > 1 then error(39); end
    
    // init values
    exitID = 0; // All OK
    
    // Platform-dependent HOME path if "path" was not commited
    if ~exists("path") then
        if getos() == "Windows" then
            path = getenv("USERPROFILE");
        else // Unix, GNU/Linux, macOS
            path = getenv("HOME");
        end
    end
    
    // Get filename incl. path of an CSV file
    fn=uiputfile(["*.csv","Comma Separated Value files (*.csv)"],path,"Choose a filename")
    if fn == "" then
        exitID = -1; // Canceled file selector
        return;
    end
    // Extension check
    [fnp, fnn, fne] = fileparts(fn);
    if fne == "" then
        fn = fullfile(fnp, fnn + ".csv"); // Add .csv-Extention to a filename if no extension specified
    end
    
    // Get some parameters for interpreting the csv file and the name of the output matrix
    labels=["Name of matrix"; "Field separator: , | ; | tab | space"; "Decimal separator: . | ,"];
    dat=list("str", 1, "str", 1, "str", 1);
    values=[""; ","; "."];

    [ok, mat_name, fld_sep, dec] = getvalue("CSV and Scilab parameters", labels, dat, values);
    
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
    
    // Write CSV file in mat_name
    try
        execstr("csvWrite(" + mat_name + ", fn, fld_sep, dec);");
    catch
        exitID = -3; // Error while writing CSV file
        return;
    end

endfunction

