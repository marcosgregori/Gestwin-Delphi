
unit l_lmp;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Mask, Menus, cxLookAndFeelPainters, cxButtons, cxCheckBox,
  cxDBEdit, cxControls, cxContainer, cxEdit, cxTextEdit, DB, ReportManager,
  dxmdaset, DataManager, cxGraphics, cxLookAndFeels, dxSkinsCore, cxLabel,
  cxGroupBox, dxSkinsDefaultPainters,

  Gim30Fields;


type
    TRptLmpForm = class(TgxForm)
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
      ArticuloFields : TArticuloFields;
    public

    end;

var
  RptLmpForm: TRptLmpForm;

procedure ListadoListasMaterialesProcesos;


implementation

uses   Gim00Fields,

       dm_cls,
       dm_fdc,
       dm_fdv,
       dm_lmp,

       a_pde7,
       
       cx_lmp;

{$R *.DFM}

procedure ListadoListasMaterialesProcesos;
begin
     CreateReportForm( TRptLmpForm, RptLmpForm );
end;

procedure TRptLmpForm.InitializeForm;
begin

     ArticuloFields := TArticuloFields.Create( Self );

     DataCodigoFinal.Value := HighStrCode;
     DataPreciosCompra.Value := True;
     DataPreciosVenta.Value := True;
end;

procedure TRptLmpForm.CodigoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ListaMaterialesProcesos.Valida( Sender, DisplayValue, ErrorText, Error, ArticuloFields, True );
end;

procedure TRptLmpForm.FormManagerOkButton;
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

procedure TRptLmpForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaRelacionMateriales( Sender );
end;

end.
