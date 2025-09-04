
unit b_gvp;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Mask,
  ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb, DataManager,
  cxMaskEdit, cxDropDownEdit, cxCalendar, cxDBEdit, cxControls,
  cxContainer, cxEdit, cxTextEdit, dxmdaset,

  dxSkinsCore, dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels,
  cxLabel, cxGroupBox,

  Gim10Fields,
  Gim30Fields, cxSpinEdit, dxUIAClasses;


type
    TBoxGvpForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    SerieCtrl: TcxDBTextEdit;
    ClienteInicialCtrl: TcxDBTextEdit;
    ClienteFinalCtrl: TcxDBTextEdit;
    FechaCtrl: TcxDBDateEdit;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataSerie: TWideStringField;
    DataClienteInicial: TWideStringField;
    DataClienteFinal: TWideStringField;
    DataFecha: TDateField;
    gxRangeBox1: TgxRangeBox;
    Label6: TcxLabel;
    Label8: TcxLabel;
    Label7: TcxLabel;
    Label2: TcxLabel;
    Label3: TcxLabel;
    Label4: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    cxLabel1: TcxLabel;
    TipoCtrl: TcxDBSpinEdit;
    DescTipoLabel: TcxLabel;
    DataTipo: TSmallintField;
    procedure FormManagerOkButton;
    procedure FormManagerInitializeForm;
    procedure SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure SerieCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ClienteInicialCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ClienteInicialCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure TipoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure TipoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    private

    public
      procedure DoProcess;
    end;

var  BoxGvpForm : TBoxGvpForm = nil;

procedure GeneracionVentasPeriodicas;


implementation

uses   DateUtils,
       LibUtils,
       AppManager,
       EnterpriseDataAccess,

       Gdm30Frm,

       dm_sdf,
       dm_cli,
       dm_vpe,
       dm_tvp,

       b_msg,
       b_pro,

       cx_sdf,
       cx_cli,
       cx_tvp,

       f_prg;

{$R *.DFM}

resourceString
       RsMsg2 = 'Generado el albarán %s %d del cliente %s. Ficha nº %d.';
       RsMsg3 = 'El cliente %s consta como obsoleto en su ficha. No se ha generado el albarán de venta correspondiente.';

procedure GeneracionVentasPeriodicas;
begin
     CreateEditForm( TBoxGvpForm, boxGvpForm, TGds30Frm.VentasSection, True );
end;

procedure TBoxGvpForm.FormManagerInitializeForm;
begin
     DataClienteFinal.Value := HighStrCode;
     DataFecha.Value := ApplicationContainer.TodayDate;
end;

procedure TBoxGvpForm.SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TBoxGvpForm.SerieCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TBoxGvpForm.TipoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTiposVentasPeriodicas( Sender );
end;

procedure TBoxGvpForm.TipoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     TipoVentaPeriodica.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TBoxGvpForm.FormManagerOkButton;
begin
     CreateProcessForm( DoProcess, Caption );
end;

procedure TBoxGvpForm.ClienteInicialCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TBoxGvpForm.ClienteInicialCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TBoxGvpForm.DoProcess;
begin
     VentasPeriodicas.GeneraVentasPeriodicas( DataTipo.Value, DataSerie.Value, DataClienteInicial.Value, DataClienteFinal.Value, DataFecha.Value );
end;

end.

