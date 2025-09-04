//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("GestwinWhiteSkin.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("dxCoreRS28.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("vclwinx.bpi");
USEPACKAGE("dxGDIPlusRS28.bpi");
USEPACKAGE("cxLibraryRS28.bpi");
USEPACKAGE("dxSkinsCoreRS28.bpi");
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
