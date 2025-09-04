//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("GestwinSkin.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("dxCoreRS22.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dxGDIPlusRS22.bpi");
USEPACKAGE("cxLibraryRS22.bpi");
USEPACKAGE("dxSkinsCoreRS22.bpi");
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
