function data = ods_read(filename, varargin)
    // Read a LibreOffice/OpenDocument Spreadsheet (.ods) file 
    //
    // Syntax
    //   data = ods_read(filename)
    //   data = ods_read(filename, "sheet", sheet)
    //   data = ods_read(filename, "range", range)
    //   data = ods_read(filename, "conversion", conversion)
    //   data = ods_read(filename, option1, value1, option2, value2, ...)
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
    // ods_read reads a whole sheet or a spreadsheet cell range, e.g. "A1:C10", "A:C", 
    // "1:10", "B5". A 2x2 numeric matrix is also accepted [startRow startColumn ; endRow endColumn]
    //
    // If no conversion mode is committed - "double" (default), "string", "cell" - all 
    // data is converted to doubles, non-numeric values become NaN. If 
    // "string" is chosen data contains a matrix of strings, whn "cell"
    // a cell array matrix with mixed data is replied.
    //
    // How ods_read works:
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
    // It will not be installed with ods_readWrite automatically!</para>
    // <para> </para>
    // <para>OpenOffice is not supported (yet)</para>
    // </important>
    //
    // Examples
    // // Read a specific sheet
    // A = ods_read( ..
    //     "measurements.ods", ..
    //     "sheet", "Raw Data" ..
    //     );
    // // Read a specific range as numeric data
    // B = ods_read( ..
    //    "measurements.ods", ..
    //    "sheet", "Raw Data", ..
    //    "range", "B2:F1000", ..
    //    "conversion", "double" ..
    //    );
    // // Read numerical range definition
    // C = ods_read( ..
    //    "measurements.ods", ..
    //    "sheet", 1, ..
    //    "range", [2 2; 1000 6], .. // B2:F1000
    //    "conversion", "double" ..
    //    );
    // // Mixed data
    // D = ods_read( ..
    //    "measurements.ods", ..
    //    "sheet", "Results", ..
    //    "conversion", "cell" ..
    //    );
    //
    // Authors
    //  Hani A. Ibtahim (hani.ibrahim@gmx.de)
    // ============================================================================

    function [soffice, officeType] = odsFindOffice()
        // ============================================================================
        // Locate the LibreOffice command-line executable.
        // ============================================================================

        soffice   = "";
        officeType = "";

        os = getos();


        // ------------------------------------------------------------------------
        // 1. Check the explicitly configured SOFFICE environment variable.
        //
        // This is useful for portable installations, custom installation
        // directories, development versions, or other non-standard locations.
        // ------------------------------------------------------------------------

        customSoffice = getenv("SOFFICE", "");

        if customSoffice <> "" then

            if isfile(customSoffice) then

                soffice = customSoffice;

                // Try to determine the office suite from the configured path.
                lowerPath = convstr(customSoffice, "l");

                if strindex(lowerPath, "libreoffice") <> [] then
                    officeType = "libreoffice";

                elseif strindex(lowerPath, "openoffice") <> [] then
                    officeType = "openoffice";

                else
                    // The executable was explicitly configured by the user.
                    // Assume LibreOffice-compatible command-line behavior.
                    officeType = "libreoffice";
                end

                return;

            else

                error( ..
                "odsFindOffice: The SOFFICE environment variable is defined, " + ..
                "but the specified file does not exist:" + ascii(10) + ..
                "    " + customSoffice);

            end

        end


        select os


            // ========================================================================
            // Windows
            // ========================================================================

        case "Windows" then


            // --------------------------------------------------------------------
            // 2a. Search standard LibreOffice installation locations first.
            // --------------------------------------------------------------------

            candidates = [
            "C:\Program Files\LibreOffice\program\soffice.exe";
            "C:\Program Files (x86)\LibreOffice\program\soffice.exe"
            ];

            for k = 1:size(candidates, "*")

                if isfile(candidates(k)) then
                    soffice = candidates(k);
                    officeType = "libreoffice";
                    return;
                end

            end


            // --------------------------------------------------------------------
            // 2b. Search PATH for LibreOffice.
            //
            // Multiple soffice.exe executables may exist in PATH. Only paths
            // containing "libreoffice" are accepted in this step so that an
            // OpenOffice installation cannot take precedence over LibreOffice.
            // --------------------------------------------------------------------

            [status, stdout, stderr] = host("where soffice.exe");

            if status == 0 & size(stdout, "*") >= 1 then

                for k = 1:size(stdout, "*")

                    candidate = stripblanks(stdout(k));

                    if candidate <> "" & isfile(candidate) then

                        lowerCandidate = convstr(candidate, "l");

                        if strindex(lowerCandidate, "libreoffice") <> [] then
                            soffice = candidate;
                            officeType = "libreoffice";
                            return;
                        end

                    end

                end

            end


            // --------------------------------------------------------------------
            // 3a. Search standard Apache OpenOffice installation locations.
            //
            // Apache OpenOffice 4 normally installs its executable inside the
            // "program" directory of the installation.
            // --------------------------------------------------------------------

            candidates = [
            "C:\Program Files\OpenOffice 4\program\soffice.exe";
            "C:\Program Files (x86)\OpenOffice 4\program\soffice.exe";
            "C:\Program Files\Apache OpenOffice 4\program\soffice.exe";
            "C:\Program Files (x86)\Apache OpenOffice 4\program\soffice.exe"
            ];

            for k = 1:size(candidates, "*")

                if isfile(candidates(k)) then
                    soffice = candidates(k);
                    officeType = "openoffice";
                    return;
                end

            end


            // --------------------------------------------------------------------
            // 3b. Search PATH for Apache OpenOffice.
            // --------------------------------------------------------------------

            if status == 0 & size(stdout, "*") >= 1 then

                for k = 1:size(stdout, "*")

                    candidate = stripblanks(stdout(k));

                    if candidate <> "" & isfile(candidate) then

                        lowerCandidate = convstr(candidate, "l");

                        if strindex(lowerCandidate, "openoffice") <> [] then
                            soffice = candidate;
                            officeType = "openoffice";
                            return;
                        end

                    end

                end

            end


            // ========================================================================
            // Linux
            // ========================================================================

        case "Linux" then


            // --------------------------------------------------------------------
            // 2a. Search standard LibreOffice locations.
            // --------------------------------------------------------------------

            candidates = [
            "/usr/bin/soffice";
            "/usr/local/bin/soffice";
            "/usr/bin/libreoffice";
            "/usr/local/bin/libreoffice";
            "/opt/libreoffice/program/soffice"
            ];

            for k = 1:size(candidates, "*")

                if isfile(candidates(k)) then
                    soffice = candidates(k);
                    officeType = "libreoffice";
                    return;
                end

            end


            // --------------------------------------------------------------------
            // 2b. Search PATH for LibreOffice.
            // --------------------------------------------------------------------

            [status, stdout, stderr] = host("command -v libreoffice");

            if status == 0 & size(stdout, "*") >= 1 then

                candidate = stripblanks(stdout(1));

                if candidate <> "" & isfile(candidate) then
                    soffice = candidate;
                    officeType = "libreoffice";
                    return;
                end

            end


            [status, stdout, stderr] = host("command -v soffice");

            if status == 0 & size(stdout, "*") >= 1 then

                candidate = stripblanks(stdout(1));

                if candidate <> "" & isfile(candidate) then

                    // A generic soffice executable is accepted here because
                    // standard LibreOffice locations have already been checked.
                    //
                    // OpenOffice-specific locations are checked separately below.
                    lowerCandidate = convstr(candidate, "l");

                    if strindex(lowerCandidate, "openoffice") == [] then
                        soffice = candidate;
                        officeType = "libreoffice";
                        return;
                    end

                end

            end


            // --------------------------------------------------------------------
            // 2c. Search standard Flatpak launcher locations.
            //
            // System-wide Flatpak installation:
            //   /var/lib/flatpak/exports/bin/
            //
            // Per-user Flatpak installation:
            //   ~/.local/share/flatpak/exports/bin/
            //
            // The exported launcher accepts command-line arguments and can
            // therefore be used in the same way as the native executable.
            // --------------------------------------------------------------------

            homeDir = getenv("HOME", "");

            flatpakCandidates = [
            "/var/lib/flatpak/exports/bin/org.libreoffice.LibreOffice"
            ];

            if homeDir <> "" then
                flatpakCandidates($ + 1) = ..
                fullfile( ..
                homeDir, ..
                ".local", ..
                "share", ..
                "flatpak", ..
                "exports", ..
                "bin", ..
                "org.libreoffice.LibreOffice" ..
                );
            end

            for k = 1:size(flatpakCandidates, "*")

                if isfile(flatpakCandidates(k)) then
                    soffice = flatpakCandidates(k);
                    officeType = "libreoffice-flatpak";
                    return;
                end

            end


            // --------------------------------------------------------------------
            // 3a. Search standard Apache OpenOffice locations.
            //
            // Official Apache OpenOffice packages normally install below /opt.
            // --------------------------------------------------------------------

            candidates = [
            "/opt/openoffice4/program/soffice";
            "/opt/OpenOffice4/program/soffice";
            "/opt/openoffice/program/soffice"
            ];

            for k = 1:size(candidates, "*")

                if isfile(candidates(k)) then
                    soffice = candidates(k);
                    officeType = "openoffice";
                    return;
                end

            end


            // --------------------------------------------------------------------
            // 3b. Check whether the soffice executable found through PATH belongs
            //     to Apache OpenOffice.
            // --------------------------------------------------------------------

            [status, stdout, stderr] = host("command -v soffice");

            if status == 0 & size(stdout, "*") >= 1 then

                candidate = stripblanks(stdout(1));

                if candidate <> "" & isfile(candidate) then

                    lowerCandidate = convstr(candidate, "l");

                    if strindex(lowerCandidate, "openoffice") <> [] then
                        soffice = candidate;
                        officeType = "openoffice";
                        return;
                    end

                end

            end


            // ========================================================================
            // macOS
            // ========================================================================

        case "Darwin" then


            // --------------------------------------------------------------------
            // 2. Search LibreOffice first.
            // --------------------------------------------------------------------

            candidates = [
            "/Applications/LibreOffice.app/Contents/MacOS/soffice";
            "/usr/local/bin/soffice";
            "/opt/homebrew/bin/soffice"
            ];

            for k = 1:size(candidates, "*")

                if isfile(candidates(k)) then
                    soffice = candidates(k);
                    officeType = "libreoffice";
                    return;
                end

            end


            // --------------------------------------------------------------------
            // 3. Search Apache OpenOffice.
            // --------------------------------------------------------------------

            candidates = [
            "/Applications/OpenOffice.app/Contents/MacOS/soffice";
            "/Applications/Apache OpenOffice.app/Contents/MacOS/soffice"
            ];

            for k = 1:size(candidates, "*")

                if isfile(candidates(k)) then
                    soffice = candidates(k);
                    officeType = "openoffice";
                    return;
                end

            end


            // ========================================================================
            // Other Unix-like operating systems
            // ========================================================================

        else


            // --------------------------------------------------------------------
            // Prefer LibreOffice.
            // --------------------------------------------------------------------

            [status, stdout, stderr] = host("command -v libreoffice");

            if status == 0 & size(stdout, "*") >= 1 then

                candidate = stripblanks(stdout(1));

                if candidate <> "" & isfile(candidate) then
                    soffice = candidate;
                    officeType = "libreoffice";
                    return;
                end

            end


            [status, stdout, stderr] = host("command -v soffice");

            if status == 0 & size(stdout, "*") >= 1 then

                candidate = stripblanks(stdout(1));

                if candidate <> "" & isfile(candidate) then
                    soffice = candidate;
                    officeType = "libreoffice";
                    return;
                end

            end

        end


        // ========================================================================
        // No compatible office suite was found.
        // ========================================================================

        error( ..
        "odsFindOffice: Neither LibreOffice nor Apache OpenOffice could be found." + ..
        ascii(10) + ascii(10) + ..
        "If you are sure that LibreOffice or Apache OpenOffice is installed, " + ..
        "create an environment variable named SOFFICE containing the full path " + ..
        "to the soffice executable." + ..
        ascii(10) + ascii(10) + ..
        "After creating or changing the SOFFICE environment variable, exit " + ..
        "Scilab and log out of your operating-system user account and log in " + ..
        "again before starting Scilab." ..
        );

    endfunction


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
            error("ods_read: Invalid numeric range.");
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
            error("ods_read: Column index must be a positive integer.");
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
        error("ods_read: A filename must be specified.");
    end

    if type(filename) <> 10 | size(filename, "*") <> 1 then
        error("ods_read: filename must be a single string.");
    end

    if ~isfile(filename) then
        error(msprintf("ods_read: File not found: ''%s''.", filename));
    end

    [filePath, fileName, fileExt] = fileparts(filename);

    if convstr(fileExt, "l") <> ".ods" then
        error("ods_read: Input file must have the .ods extension.");
    end

    // ------------------------------------------------------------------------
    // Parse xlsxRead-compatible options
    // ------------------------------------------------------------------------

    sheet = 1;
    range = "";
    conversion = "double";

    nOptions = size(varargin);

    if modulo(nOptions, 2) <> 0 then
        error("ods_read: Optional arguments must be specified as option/value pairs.");
    end

    for k = 1:2:nOptions

        option = varargin(k);
        value  = varargin(k + 1);

        if type(option) <> 10 | size(option, "*") <> 1 then
            error("ods_read: Option names must be strings.");
        end

        option = convstr(option, "l");

        select option

        case "sheet" then

            if type(value) == 1 then
                if size(value, "*") <> 1 | value < 1 | value <> floor(value) then
                    error("ods_read: sheet index must be a positive integer.");
                end
            elseif type(value) == 10 then
                if size(value, "*") <> 1 | value == "" then
                    error("ods_read: sheet name must be a non-empty string.");
                end
            else
                error("ods_read: sheet must be a sheet name or a positive integer.");
            end

            sheet = value;

        case "range" then

            if type(value) == 10 then

                if size(value, "*") <> 1 then
                    error("ods_read: range must be a single string or a 2x2 numeric matrix.");
                end

                range = value;

            elseif type(value) == 1 then

                if ~isequal(size(value), [2 2]) then
                    error("ods_read: Numeric range must be a 2x2 matrix.");
                end

                if or(value < 1) | or(value <> floor(value)) then
                    error("ods_read: Numeric range indices must be positive integers.");
                end

                range = value;

            else
                error("ods_read: range must be a string or a 2x2 numeric matrix.");
            end

        case "conversion" then

            if type(value) <> 10 | size(value, "*") <> 1 then
                error("ods_read: conversion must be a string.");
            end

            value = convstr(value, "l");

            if ~or(value == ["double", "string", "cell"]) then
                error("ods_read: conversion must be ""double"", ""string"", or ""cell"".");
            end

            conversion = value;

        else

            error(msprintf("ods_read: Unknown option ''%s''.", option));

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
            "ods_read: Scilab %d.%d.%d does not provide the built-in xlsxRead() function." + ascii(10) + ..
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
                "ods_read: The xlreadwrite toolbox is installed but could not be loaded." + ..
                ascii(10) + ..
                lasterror());
            end

        end

        // Verify that the expected function is available after loading.
        if exists("xlread") == 0 then

            error( ..
            "ods_read: The xlreadwrite toolbox was loaded, but xlread() is not available.");
        end

    end

    // ------------------------------------------------------------------------
    // Locate LibreOffice
    // ------------------------------------------------------------------------

    soffice = odsFindOffice();

    if soffice == "" then
        error( ..
        "ods_read: LibreOffice could not be found." + ascii(10) + ..
        "LibreOffice is required to convert ODS files to XLSX." + ascii(10) + ..
        "=> https://www.libreoffice.org/");
    end

    // ------------------------------------------------------------------------
    // Create a temporary conversion directory
    // ------------------------------------------------------------------------

    tempDir = fullfile(TMPDIR, "ods_read_" + string(getdate("s")));

    suffix = 0;

    while isdir(tempDir)
        suffix = suffix + 1;
        tempDir = fullfile( ..
        TMPDIR, ..
        "ods_read_" + string(getdate("s")) + "_" + string(suffix));
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
        "ods_read: LibreOffice conversion failed." + ascii(10) + ..
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
            "ods_read: LibreOffice reported successful conversion, " + ..
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
        "ods_read: Error while reading the converted XLSX file." + ..
        ascii(10) + readError);

    end

    // ------------------------------------------------------------------------
    // Remove temporary files
    // ------------------------------------------------------------------------

    odsCleanupDirectory(tempDir);

endfunction




