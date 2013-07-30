function mdaq_ext_mode(curpath)
if isunix
    DSL_EXT = '-DSL_EXT_SO';
    DRTIOSTREAM_SHLIB_PATH = ['-DRTIOSTREAM_SHLIB_PATH=',fullfile(curpath,'MLink'),'/'];
else
    DSL_EXT = '-DSL_EXT_DLL';
    DRTIOSTREAM_SHLIB_PATH = strrep(['-DRTIOSTREAM_SHLIB_PATH=',fullfile(curpath,'MLink'),'\'],'\','\\');
end
mexcmd = [...
    '"',fullfile(matlabroot,'rtw','ext_mode','common','ext_comm.c'),'" '...
    '"',fullfile(matlabroot,'rtw','ext_mode','common','ext_convert.c'),'" '...
    '"',fullfile(curpath,'ext_mode','host','rtiostream_interface.c'),'" '...
    '"',fullfile(curpath,'ext_mode','host','ext_util.c'),'" '...
    '-I"',fullfile(matlabroot,'rtw','c','src'),'" '...
    '-I"',fullfile(matlabroot,'rtw','c','src','rtiostream','utils'),'" '...
    '-I"',fullfile(matlabroot,'rtw','c','src','ext_mode','common'),'" '...
    '-I"',fullfile(matlabroot,'rtw','ext_mode','common'),'" '...
    '-I"',fullfile(matlabroot,'rtw','ext_mode','common','include'),'" '...
    '-lmwrtiostreamutils '...
    '-DEXTMODE_MLINK_TRANSPORT '...
    DSL_EXT,' '...
    DRTIOSTREAM_SHLIB_PATH,' '...
    '-output ',fullfile(curpath,'ext_mode','ext_mdaq_mlink')];
eval(['mex ',mexcmd]);