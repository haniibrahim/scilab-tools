// Generate or rebuild Hani's tools library
// ========================================
// You can execute this file to generate the library. It is not protected
// against "clear". Use "predef" for protection.
// In general you just have to execute the genlib command once and put the
// lib-command-line into your startfile as ".scilab" or "scilab.ini".
 
path=(get_absolute_file_path("make_lib.sce")); // platform idependend path to this script
unix("ls -1 *.sci >names")
mdelete(path +'lib'); // delete old library files
mdelete(path + '*.bin'); // delete old library files
genlib("HI_tools",path); // compiles sci- to bin-files and create lib file
HI_tools=lib(path); // load lib to Scilab
clear path // tidy up

//if getos()=="Linux" then
//    mdelete('/home/hi/Dropbox/Entwicklung/Scilab/tools/lib');
//    mdelete('/home/hi/Dropbox/Entwicklung/Scilab/tools/names');
//    mdelete('/home/hi/Dropbox/Entwicklung/Scilab/tools/*.bin');
//    genlib("HI_tools","/home/hi/Dropbox/Entwicklung/Scilab/tools"+"/");
//    HI_tools=lib("/home/hi/Dropbox/Entwicklung/Scilab/tools"+"/");
//elseif getos()=="Windows" then
//    mdelete('C:\Users\hi\Dropbox\Entwicklung\Scilab\tools\lib');
//    mdelete('C:\Users\hi\Dropbox\Entwicklung\Scilab\tools\names');
//    mdelete('C:\Users\hi\Dropbox\Entwicklung\Scilab\tools\*.bin');
//    genlib("HI_tools","C:\Users\hi\Dropbox\Entwicklung\Scilab\tools"+"\");
//    HI_tools=lib("C:\Users\hi\Dropbox\Entwicklung\Scilab\tools"+"/");
//elseif getos()=="Darwin" then
//    mdelete('/Users/hi/Dropbox/Entwicklung/Scilab/tools/lib');
//    mdelete('/Users/hi/Dropbox/Entwicklung/Scilab/tools/names');
//    mdelete('/Users/hi/Dropbox/Entwicklung/Scilab/tools/*.bin');
//    genlib("HI_tools","/Users/hi/Dropbox/Entwicklung/Scilab/tools"+"/");
//    HI_tools=lib("/Users/hi/Dropbox/Entwicklung/Scilab/tools"+"/");
//end


