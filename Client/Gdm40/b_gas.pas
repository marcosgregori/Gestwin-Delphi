unit b_gas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, AppForms, StdCtrls, Buttons, Mask,

  AppManager,
  LibUtils,
  AppContainer,
  EnterpriseDataAccess,
  Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb, DataManager,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar, cxDBEdit, dxmdaset,

  dxSkinsCore, dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels,
  cxGroupBox, cxLabel,

  Gim30Fields,
  Gim40Fields,

  Gdm40Dm, dxUIAClasses;

type
  TBoxGasForm = class(TgxForm)
    FormManager: TgxFormManager;
    dataPanel: TgxEditPanel;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataSerie: TStringField;
    RangoFechasPanel: TcxGroupBox;
    gxRangeBox1: TgxRangeBox;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    Label3: TcxLabel;
    MainPanel: TcxGroupBox;
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    SerieCtrl: TcxDBTextEdit;
    Label6: TcxLabel;
    Label8: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    cxGroupBox2: TcxGroupBox;
    procedure FormManagerInitializeForm;
    procedure FormManagerOkButton;
    procedure SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure SerieCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);

  private
    EjercicioNroHojaActual : SmallInt;
    NroHojaActual : Integer;
    NroRegistroActual : SmallInt;
    ClienteActual : String;
    FechaActual : TDateTime;
    procedure DoProcesoGeneracionAlbaranes;

  protected
   class var
    Ejercicio : SmallInt;
    NroHoja : LongInt;
    OnProcessFinished : TSimpleEvent;

  public
    MovimientoFields,
    MovimientoActualFields : TMovimientoFields;
    LineaMovimientoFields : TLineaMovimientoFields;
    HojaCargaFields : THojaCargaFields;
    LineaHojaCargaFields : TLineaHojaCargaFields;


  end;

var BoxGasForm: TBoxGasForm = nil;

procedure GeneracionAlbaranesSalida( Ejercicio         : SmallInt = 0;
                                     NroHoja           : LongInt = 0;
                                     OnProcessFinished : TSimpleEvent = nil );

implementation

uses  Gdm30Frm,

      dm_sdf,
      dm_hdc,

      a_pde4,

      cx_sdf,

      b_pro;

{$R *.DFM}

resourcestring
       RsMsg1   = 'Generación de albaranes de salida';

procedure GeneracionAlbaranesSalida( Ejercicio         : SmallInt = 0;
                                     NroHoja           : LongInt = 0;
                                     OnProcessFinished : TSimpleEvent = nil );
begin
     TBoxGasForm.Ejercicio := Ejercicio;
     TBoxGasForm.NroHoja := NroHoja;
     TBoxGasForm.OnProcessFinished := OnProcessFinished;
     CreateEditForm( TBoxGasForm, BoxGasForm );
end;

procedure TBoxGasForm.SerieCtrlPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TBoxGasForm.SerieCtrlPropertiesValidate(     Sender       : TcxCustomEdit;
                                                   var DisplayValue : Variant;
                                                   var ErrorText    : TCaption;
                                                   var Error        : Boolean );
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TBoxGasForm.FormManagerInitializeForm;
begin
     RangoFechasPanel.Visible := NroHoja=0;
     If   NroHoja<>0
     then Height := Height - RangoFechasPanel.Height;
     DataFechaInicial.Value := ApplicationContainer.TodayDate;
     DataFechaFinal.Value := ApplicationContainer.LastDayOfYearDate;
     DataSerie.Value := ParametrosAprovisionamientoRec.SerieAlbaranesSalida;
end;

procedure TBoxGasForm.FormManagerOkButton;
begin
     CreateProcessForm( DoProcesoGeneracionAlbaranes, RsMsg1 );
end;

procedure TBoxGasForm.DoProcesoGeneracionAlbaranes;
begin
     HojaCarga.GenerarAlbaranes( Ejercicio, NroHoja, DataSerie.Value, DataFechaInicial.Value, DataFechaFinal.Value );
     If   Assigned( OnProcessFinished )
     then OnProcessFinished;
end;

initialization

end.
