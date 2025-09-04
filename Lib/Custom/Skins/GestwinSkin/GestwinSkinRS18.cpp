//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("GestwinSkin.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("dxCoreRS18.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dxGDIPlusRS18.bpi");
USEPACKAGE("cxLibraryRS18.bpi");
USEPACKAGE("dxSkinsCoreRS18.bpi");
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
