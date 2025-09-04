
..\frcc.exe frxrcClass.xml
..\frcc.exe frxrcDesgn.xml
..\frcc.exe frxrcExports.xml
..\frcc.exe frxrcInsp.xml
copy frxrcClass.pas ..\Source
copy frxrcDesgn.pas ..\Source
copy frxrcExports.pas ..\Source
copy frxrcInsp.pas ..\Source
del *.pas

pause
