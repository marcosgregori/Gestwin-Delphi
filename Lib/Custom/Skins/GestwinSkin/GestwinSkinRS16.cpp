//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("GestwinSkin.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("dxCoreRS16.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dxGDIPlusRS16.bpi");
USEPACKAGE("cxLibraryRS16.bpi");
USEPACKAGE("dxSkinsCoreRS16.bpi");
USEUNIT("GestwinSkin.pas");
//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------
//   Package source.
//---------------------------------------------------------------------------
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
        return 1;
}
//---------------------------------------------------------------------------
