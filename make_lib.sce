// Generate Hani's tools library
path=(get_absolute_file_path("make_lib.sce"));
mdelete(path +'lib');
mdelete(path +'names');
mdelete(path + '*.bin');
genlib("HI_tools",path);
HI_tools=lib(path);

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


