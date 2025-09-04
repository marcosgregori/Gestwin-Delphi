
unit l_lmp1;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Mask, Menus, cxLookAndFeelPainters, cxButtons, cxCheckBox,
  cxDBEdit, cxControls, cxContainer, cxEdit, cxTextEdit, DB, ReportManager,
  dxmdaset, DataManager, cxGraphics, cxLookAndFeels, dxSkinsCore, cxLabel,
  cxGroupBox, dxSkinsDefaultPainters;


type
    TRptLmp1Form = class(TgxForm)
    DataPanel: TgxEditPanel;
    CodigoInicialCtrl: TcxDBTextEdit;
    CodigoFinalCtrl: TcxDBTextEdit;
    FormManager: TgxFormManager;
    Data: TgxMemData;
    DataSource: TDataSource;
    Report: TgxReportManager;
    DataCodigoInicial: TWideStringField;
    DataCodigoFinal: TWideStringField;
    DataPreciosCompra: TBooleanField;
    DataPreciosVenta: TBooleanField;
    gxRangeBox2: TgxRangeBox;
    Label1: TcxLabel;
    Label3: TcxLabel;
    Label4: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure CodigoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    private

    public

    end;

var
  RptLmp1Form: TRptLmp1Form;

procedure ListadoComponentesEnListas;


implementation

uses   Gim00Fields,
       Gim30Fields,

       a_pde7,
       
       dm_cls,
       dm_fdc,
       dm_fdv,
       dm_art,
       dm_lmp,

       cx_art;

{$R *.DFM}

procedure ListadoComponentesEnListas;
begin
     CreateReportForm( TRptLmp1Form, RptLmp1Form );
end;

procedure TRptLmp1Form.InitializeForm;
begin
     DataCodigoFinal.Value := HighStrCode;
     DataPreciosCompra.Value := True;
     DataPreciosVenta.Value := True;
end;

procedure TRptLmp1Form.CodigoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptLmp1Form.FormManagerOkButton;
begin
     With Report do
       try
         Load;
         SetNumberVarFormat( FmtDecComponentes, ParametrosProduccionRec.DecimalesComponentes );
         Clase.SetReportTitles( Report, 4 );
         Start;
       except on E : Exception do Cancel( E );
         end;
end;

procedure TRptLmp1Form.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scAmbas, False, Sender );
end;

end.
