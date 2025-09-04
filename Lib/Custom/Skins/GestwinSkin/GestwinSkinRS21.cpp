//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("GestwinSkin.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("dxCoreRS21.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dxGDIPlusRS21.bpi");
USEPACKAGE("cxLibraryRS21.bpi");
USEPACKAGE("dxSkinsCoreRS21.bpi");
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
