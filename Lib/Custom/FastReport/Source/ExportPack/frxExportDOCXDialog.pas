
{******************************************}
{                                          }
{             FastReport VCL               }
{            DOCX export dialog            }
{                                          }
{         Copyright (c) 1998-2021          }
{                                          }
{******************************************}

unit frxExportDOCXDialog;

interface

{$I frx.inc}

uses
{$IFNDEF FPC}
  Windows, Messages,
{$ELSE}
  LCLType, LCLIntf,
{$ENDIF}
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, frxExportBaseDialog, dxBarBuiltInMenu,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, Vcl.Menus, cxTextEdit, cxRadioGroup, cxLabel,
  cxButtons, cxCheckBox, cxMaskEdit, cxDropDownEdit, cxGroupBox, cxPC
{$IFDEF DELPHI16}
, System.UITypes
{$ENDIF}
;

type
  TfrxDOCXExportDialog = class(TfrxBaseExportDialog)
  end;
  
implementation

{$R *.dfm}

end.
