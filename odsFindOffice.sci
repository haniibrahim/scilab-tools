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
        "If you are sure that LibreOffice or Apache OpenOffice is installed, " + ascii(10) + ..
        "create an environment variable named SOFFICE containing the full path " + ascii(10) + ..
        "to the soffice executable. E.g. in Windows Powershell for the current user:" +ascii(10) + ..
        "[System.Environment]::SetEnvironmentVariable(""SOFFICE"",""D:\LibreOffice\program\soffice.exe"",[System.EnvironmentVariableTarget]::User)" + ..
        ascii(10) + ascii(10) + ..
        "After creating or changing the SOFFICE environment variable, exit " + ascii(10) + ..
        "Scilab and log out of your operating-system user account and log in " + ascii(10) + ..
        "again before starting Scilab."  + ascii(10) ..
    );

endfunction
