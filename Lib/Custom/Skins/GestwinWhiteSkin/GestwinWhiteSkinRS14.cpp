//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("GestwinWhiteSkin.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("dxCoreRS14.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dxGDIPlusRS14.bpi");
USEPACKAGE("cxLibraryRS14.bpi");
USEPACKAGE("dxSkinsCoreRS14.bpi");
USEUNIT("GestwinWhiteSkin.pas");
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
