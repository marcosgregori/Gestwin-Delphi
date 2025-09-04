//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("GestwinWhiteSkin.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("dxCoreRS25.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dxGDIPlusRS25.bpi");
USEPACKAGE("cxLibraryRS25.bpi");
USEPACKAGE("dxSkinsCoreRS25.bpi");
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
