// Read a LibreOffice/OpenDocument Spreadsheet (.ods) file 
//
// Syntax
//   data = odsRead(filename)
//   data = odsRead(filename, "sheet", sheet)
//   data = odsRead(filename, "range", range)
//   data = odsRead(filename, "conversion", conversion)
//   data = odsRead(filename, option1, value1, option2, value2, ...)
//
// Parameters
// filename: 
//    String contains the filename incl. full or relative path)
// sheet:
//    String or integer contains sheet name or positive sheet index. Default = 1
// options:
//    Strings, can be "sheet", "range" and/or "conversion"
// range:
//    String, Excel-style range
// conversion: 
//    String, "double" = numeric matrix; non-numeric values become NaN, "string" = string matrix, "cell" = cell array containing mixed data, (Default "double")
//
// data:
//    NxN matrix of doubles, cells or strings imported from tthe ODS-file
//
// Description
// Read a LibreOffice/OpenDocument Spreadsheet (.ods) file using an interface
// similar to xlsxRead() introduced in Scilab 2026.1.0 in a matrix variable.
//
// odsREad reads a whole sheet or a spreadsheet cell range, e.g. "A1:C10", "A:C", 
// "1:10", "B5". A 2x2 numeric matrix is also accepted [startRow startColumn ; endRow endColumn]
//
// If no conversion mode is committed - "double" (default), "string", "cell" - all 
// data is converted to doubles, non-numeric values become NaN. If 
// "string" is chosen data contains a matrix of strings, whn "cell"
// a cell array matrix with mixed data is replied.
//
// How odsRead works:
// The ODS file is temporarily converted to XLSX format using LibreOffice 
// in headless mode and then read using “xlsxRead” from Scilab 2026.1.0 or
//  later. When using Scilab versions 2025 or earlier, “xlread” from the
//  “xlreadwrite” toolbox is used, if it is installed.
//
// <note>The conversion from OpenDocument (*.ods) to OpenXML (*.xlsx) via 
// LibreOffice is time consuming. But it is a simple and reliable approach. 
// PLEASE BE PATIENT!</note>
//
// <important>
// <para>LibreOffice must be installed. For Scilab versions older 
// than 2026.1.0, the xlreadwrite ATOMS toolbox must be installed, too.
// It will not be installed with odsReadWrite automatically!</para>
// <para> </para>
// <para>OpenOffice is not supported (yet)</para>
// </important>
//
// Examples
// // Read a specific sheet
// A = odsRead( ..
//     "measurements.ods", ..
//     "sheet", "Raw Data" ..
//     );
// // Read a specific range as numeric data
// B = odsRead( ..
//    "measurements.ods", ..
//    "sheet", "Raw Data", ..
//    "range", "B2:F1000", ..
//    "conversion", "double" ..
//    );
// // Read numerical range definition
// C = odsRead( ..
//    "measurements.ods", ..
//    "sheet", 1, ..
//    "range", [2 2; 1000 6], .. // B2:F1000
//    "conversion", "double" ..
//    );
// // Mixed data
// D = odsRead( ..
//    "measurements.ods", ..
//    "sheet", "Results", ..
//    "conversion", "cell" ..
//    );
//
// Authors
//  Hani A. Ibtahim (hani.ibrahim@gmx.de)
// ============================================================================

function data = odsRead(filename, varargin)

    // ============================================================================
    // Quote a filename or executable path for the operating-system shell.
    // ============================================================================

    function quoted = odsShellQuote(value)

        if getos() == "Windows" then

            // Quote Windows paths using double quotes.
            quoted = """" + strsubst(value, """", """""") + """";

        else

            // Quote POSIX shell arguments using single quotes.
            // Embedded single quotes are escaped for the shell.
            singleQuote = ascii(39);
            replacement = singleQuote + "\" + singleQuote + singleQuote;

            quoted = singleQuote + ..
            strsubst(value, singleQuote, replacement) + ..
            singleQuote;

        end

    endfunction


    // ============================================================================
    // Convert a numeric xlsxRead-style 2x2 range matrix to Excel A1 notation.
    //
    // Example:
    //     [1 1 ; 10 3]  ->  "A1:C10"
    // ============================================================================

    function rangeString = odsRangeToA1(rangeMatrix)

        row1 = rangeMatrix(1, 1);
        col1 = rangeMatrix(1, 2);
        row2 = rangeMatrix(2, 1);
        col2 = rangeMatrix(2, 2);

        if row2 < row1 | col2 < col1 then
            error("odsRead: Invalid numeric range.");
        end

        rangeString = ..
        odsColumnName(col1) + string(row1) + ":" + ..
        odsColumnName(col2) + string(row2);

    endfunction


    // ============================================================================
    // Convert a positive Excel column number to an Excel column name.
    //
    // Examples:
    //     1  -> A
    //     26 -> Z
    //     27 -> AA
    // ============================================================================

    function name = odsColumnName(column)

        if column < 1 | column <> floor(column) then
            error("odsRead: Column index must be a positive integer.");
        end

        name = "";
        n = column;

        while n > 0

            r = modulo(n - 1, 26);

            name = ascii(65 + r) + name;

            n = floor((n - 1) / 26);

        end

    endfunction


    // ============================================================================
    // Convert xlread() raw cell output to a string matrix.
    // ============================================================================

    function output = odsRawToString(raw)

        nr = size(raw, 1);
        nc = size(raw, 2);

        output = emptystr(nr, nc);

        for r = 1:nr
            for c = 1:nc

                value = raw{r, c};

                if isempty(value) then

                    output(r, c) = "";

                elseif type(value) == 10 then

                    output(r, c) = value;

                elseif type(value) == 1 then

                    if size(value, "*") == 1 then

                        if isnan(value) then
                            output(r, c) = "NaN";
                        elseif isinf(value) then
                            if value > 0 then
                                output(r, c) = "Inf";
                            else
                                output(r, c) = "-Inf";
                            end
                        else
                            output(r, c) = string(value);
                        end

                    else
                        output(r, c) = string(value);
                    end

                elseif type(value) == 4 then

                    if value then
                        output(r, c) = "TRUE";
                    else
                        output(r, c) = "FALSE";
                    end

                elseif iscell(value) then

                    // xlread() stores Excel date cells internally as a cell
                    // containing the numeric serial value and formatted text.
                    if size(value, "*") >= 2 then
                        formatted = value{2};

                        if type(formatted) == 10 then
                            output(r, c) = formatted;
                        else
                            output(r, c) = string(value{1});
                        end
                    elseif size(value, "*") == 1 then
                        output(r, c) = string(value{1});
                    end

                else

                    // Use Scilab's generic string conversion as a final fallback.
                    try
                        output(r, c) = string(value);
                    catch
                        output(r, c) = "";
                    end

                end

            end
        end

    endfunction


    // ============================================================================
    // Remove the temporary conversion directory and all files created in it.
    // ============================================================================

    function odsCleanupDirectory(tempDir)

        if ~isdir(tempDir) then
            return;
        end

        files = findfiles(tempDir, "*");

        for k = 1:size(files, "*")

            currentFile = fullfile(tempDir, files(k));

            if isfile(currentFile) then
                mdelete(currentFile);
            end

        end

        rmdir(tempDir);

    endfunction

    // ------------------------------------------------------------------------
    // Validate input filename
    // ------------------------------------------------------------------------

    if argn(2) < 1 then
        error("odsRead: A filename must be specified.");
    end

    if type(filename) <> 10 | size(filename, "*") <> 1 then
        error("odsRead: filename must be a single string.");
    end

    if ~isfile(filename) then
        error(msprintf("odsRead: File not found: ''%s''.", filename));
    end

    [filePath, fileName, fileExt] = fileparts(filename);

    if convstr(fileExt, "l") <> ".ods" then
        error("odsRead: Input file must have the .ods extension.");
    end

    // ------------------------------------------------------------------------
    // Parse xlsxRead-compatible options
    // ------------------------------------------------------------------------

    sheet = 1;
    range = "";
    conversion = "double";

    nOptions = size(varargin);

    if modulo(nOptions, 2) <> 0 then
        error("odsRead: Optional arguments must be specified as option/value pairs.");
    end

    for k = 1:2:nOptions

        option = varargin(k);
        value  = varargin(k + 1);

        if type(option) <> 10 | size(option, "*") <> 1 then
            error("odsRead: Option names must be strings.");
        end

        option = convstr(option, "l");

        select option

        case "sheet" then

            if type(value) == 1 then
                if size(value, "*") <> 1 | value < 1 | value <> floor(value) then
                    error("odsRead: sheet index must be a positive integer.");
                end
            elseif type(value) == 10 then
                if size(value, "*") <> 1 | value == "" then
                    error("odsRead: sheet name must be a non-empty string.");
                end
            else
                error("odsRead: sheet must be a sheet name or a positive integer.");
            end

            sheet = value;

        case "range" then

            if type(value) == 10 then

                if size(value, "*") <> 1 then
                    error("odsRead: range must be a single string or a 2x2 numeric matrix.");
                end

                range = value;

            elseif type(value) == 1 then

                if ~isequal(size(value), [2 2]) then
                    error("odsRead: Numeric range must be a 2x2 matrix.");
                end

                if or(value < 1) | or(value <> floor(value)) then
                    error("odsRead: Numeric range indices must be positive integers.");
                end

                range = value;

            else
                error("odsRead: range must be a string or a 2x2 numeric matrix.");
            end

        case "conversion" then

            if type(value) <> 10 | size(value, "*") <> 1 then
                error("odsRead: conversion must be a string.");
            end

            value = convstr(value, "l");

            if ~or(value == ["double", "string", "cell"]) then
                error("odsRead: conversion must be ""double"", ""string"", or ""cell"".");
            end

            conversion = value;

        else

            error(msprintf("odsRead: Unknown option ''%s''.", option));

        end

    end

    // ------------------------------------------------------------------------
    // Determine the Scilab version
    // ------------------------------------------------------------------------

    sciVersion = getversion("scilab");

    sciMajor = sciVersion(1);
    sciMinor = sciVersion(2);
    sciPatch = sciVersion(3);

    useBuiltinXlsx = %f;

    if sciMajor > 2026 then
        useBuiltinXlsx = %t;
    elseif sciMajor == 2026 then
        if sciMinor >= 1 then
            useBuiltinXlsx = %t;
        end
    end

    // ------------------------------------------------------------------------
    // Check xlreadwrite before performing the conversion if required
    // ------------------------------------------------------------------------

    if ~useBuiltinXlsx then

        if ~atomsIsInstalled("xlreadwrite") then

            error(msprintf( ..
            "odsRead: Scilab %d.%d.%d does not provide the built-in xlsxRead() function." + ascii(10) + ..
            "The xlreadwrite ATOMS toolbox is required for Scilab versions older than 2026.1.0." + ascii(10) + ..
            "Install it with:" + ascii(10) + ..
            "    atomsInstall(""xlreadwrite"")", ..
            sciMajor, sciMinor, sciPatch));

        end

        // Load the toolbox if it is installed but not currently loaded.
        if ~atomsIsLoaded("xlreadwrite") then

            try
                atomsLoad("xlreadwrite");
            catch
                error( ..
                "odsRead: The xlreadwrite toolbox is installed but could not be loaded." + ..
                ascii(10) + ..
                lasterror());
            end

        end

        // Verify that the expected function is available after loading.
        if exists("xlread") == 0 then

            error( ..
            "odsRead: The xlreadwrite toolbox was loaded, but xlread() is not available.");
        end

    end

    // ------------------------------------------------------------------------
    // Locate LibreOffice
    // ------------------------------------------------------------------------

    soffice = odsFindOffice();

    if soffice == "" then
        error( ..
        "odsRead: LibreOffice could not be found." + ascii(10) + ..
        "LibreOffice is required to convert ODS files to XLSX." + ascii(10) + ..
        "=> https://www.libreoffice.org/");
    end

    // ------------------------------------------------------------------------
    // Create a temporary conversion directory
    // ------------------------------------------------------------------------

    tempDir = fullfile(TMPDIR, "odsRead_" + string(getdate("s")));

    suffix = 0;

    while isdir(tempDir)
        suffix = suffix + 1;
        tempDir = fullfile( ..
        TMPDIR, ..
        "odsRead_" + string(getdate("s")) + "_" + string(suffix));
    end

    mkdir(tempDir);

    // ------------------------------------------------------------------------
    // Convert the ODS file to XLSX using LibreOffice
    // ------------------------------------------------------------------------

    odsAbsolute = pathconvert(filename, %f, %t);

    cmd = odsShellQuote(soffice) + ..
    " --headless --convert-to xlsx --outdir " + ..
    odsShellQuote(tempDir) + " " + ..
    odsShellQuote(odsAbsolute);

    [status, stdout, stderr] = host(cmd);

    if status <> 0 then

        odsCleanupDirectory(tempDir);

        error( ..
        "odsRead: LibreOffice conversion failed." + ascii(10) + ..
        "Command output:" + ascii(10) + ..
        strcat(stdout, ascii(10)) + ascii(10) + ..
        "Error output:" + ascii(10) + ..
        strcat(stderr, ascii(10)));

    end

    // ------------------------------------------------------------------------
    // Determine the converted XLSX filename
    // ------------------------------------------------------------------------

    xlsxFile = fullfile(tempDir, fileName + ".xlsx");

    if ~isfile(xlsxFile) then

        // LibreOffice can normalize the output filename on some platforms.
        convertedFiles = findfiles(tempDir, "*.xlsx");

        if size(convertedFiles, "*") == 1 then
            xlsxFile = fullfile(tempDir, convertedFiles(1));
        else

            odsCleanupDirectory(tempDir);

            error( ..
            "odsRead: LibreOffice reported successful conversion, " + ..
            "but the XLSX output file could not be identified.");
        end

    end

    // ------------------------------------------------------------------------
    // Read the converted file
    // ------------------------------------------------------------------------

    try

        if useBuiltinXlsx then

            // ----------------------------------------------------------------
            // Scilab 2026.1.0 or newer
            // ----------------------------------------------------------------

            args = list();

            args($ + 1) = xlsxFile;
            args($ + 1) = "sheet";
            args($ + 1) = sheet;

            if ~isempty(range) then
                args($ + 1) = "range";
                args($ + 1) = range;
            end

            args($ + 1) = "conversion";
            args($ + 1) = conversion;

            data = xlsxRead(args(:));

        else

            // ----------------------------------------------------------------
            // Scilab older than 2026.1.0
            // Use xlread() from the xlreadwrite toolbox.
            // ----------------------------------------------------------------

            xlRange = "";

            if type(range) == 1 then
                xlRange = odsRangeToA1(range);
            else
                xlRange = range;
            end

            if xlRange == "" then
                [num, txt, raw] = xlread(xlsxFile, sheet);
            else
                [num, txt, raw] = xlread(xlsxFile, sheet, xlRange);
            end

            select conversion

            case "double" then

                // xlread() already returns numeric cells as a double matrix
                // and represents non-numeric cells with NaN.
                data = num;

            case "cell" then

                // The raw output from xlread() is the closest equivalent
                // to xlsxRead(..., "conversion", "cell").
                data = raw;

            case "string" then

                // Convert every raw cell to a string in order to emulate
                // xlsxRead(..., "conversion", "string").
                data = odsRawToString(raw);

            end

        end

    catch

        readError = lasterror();

        odsCleanupDirectory(tempDir);

        error( ..
        "odsRead: Error while reading the converted XLSX file." + ..
        ascii(10) + readError);

    end

    // ------------------------------------------------------------------------
    // Remove temporary files
    // ------------------------------------------------------------------------

    odsCleanupDirectory(tempDir);

endfunction




