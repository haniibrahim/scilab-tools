// Generate or rebuild Hani's tools library
// ========================================
// You can execute this file to generate the library. It is not protected
// against "clear". Use "predef" for protection.
//
// In general you just have to execute the genlib command once and put the
// lib-command-line into your startfile ".scilab" or "scilab.ini" in SCIHOME.

path=(get_absolute_file_path("make_lib.sce")); // platform idependend path to this script

// Delete old lib files
mdelete(path + 'names'); 
mdelete(path + 'lib'); 
mdelete(path + '*.bin'); 

// Create names-file, contains list of all SCI file names for Scilab versions < 6.0
// This block is optional for Sclilab 6 and higher
if getos() == "Windows" then
    dos("dir /b " + """" + fullfile(path,"*.sci") + """" + " > " + """" + fullfile(path, "names") + """" ); // """" means " around path for blamks
else // *nix incl. macOS
    unix_s("cd " + """" + path + """" + " && " + "ls -1 *.sci > names"); 
end

// Create and load Lib
genlib("HI_tools",path); // compiles sci- to bin-files and create lib file
HI_tools=lib(path); // load lib to Scilab

clear path // tidy up

