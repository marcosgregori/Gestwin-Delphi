//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("GestwinWhiteSkin.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("dxCoreRS17.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dxGDIPlusRS17.bpi");
USEPACKAGE("cxLibraryRS17.bpi");
USEPACKAGE("dxSkinsCoreRS17.bpi");
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
