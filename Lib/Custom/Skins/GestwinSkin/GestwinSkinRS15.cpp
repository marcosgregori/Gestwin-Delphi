//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("GestwinSkin.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("dxCoreRS15.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dxGDIPlusRS15.bpi");
USEPACKAGE("cxLibraryRS15.bpi");
USEPACKAGE("dxSkinsCoreRS15.bpi");
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
