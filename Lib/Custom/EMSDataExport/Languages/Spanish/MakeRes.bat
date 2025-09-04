@if NOT DEFINED BRCC (Set BRCC=brcc32)
@%BRCC% -i..\..\source -m -foQEResStr.res QEResStr.rc
@xcopy *.res ..\..\source
PAUSE
