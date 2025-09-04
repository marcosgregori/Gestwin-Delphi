 unit b_gmr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, AppForms, StdCtrls, Buttons, Mask,

  AppManager,
  AppContainer,
  EnterpriseDataAccess,
  Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb, DataManager,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar, cxDBEdit, dxmdaset,

  dxSkinsCore, dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels,
  cxGroupBox, cxLabel,

  Gim30Fields,
  Gim40Fields,

  Gdm40Dm;

type
  TBoxGmrForm = class(TgxForm)
    FormManager: TgxFormManager;
    dataPanel: TgxEditPanel;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    RangoFechasPanel: TcxGroupBox;
    gxRangeBox1: TgxRangeBox;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    Label3: TcxLabel;
    MainPanel: TcxGroupBox;
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    Label1: TcxLabel;
    CodigoAlmacenCtrl: TcxDBTextEdit;
    DescAlmacenLabel: TcxLabel;
    Label10: TcxLabel;
    UbicacionCtrl: TcxDBTextEdit;
    Label11: TcxLabel;
    DataCodigoAlmacen: TWideStringField;
    DataUbicacion: TWideStringField;
    procedure FormManagerInitializeForm;
    procedure FormManagerOkButton;
    procedure CodigoAlmacenCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoAlmacenCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure CodigoAlmacenCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure UbicacionCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure UbicacionCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure UbicacionCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

  private

    procedure DoProcesoReubicacion;

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

var BoxGmrForm: TBoxGmrForm = nil;

procedure GeneracionMovimientosReubicacion( Ejercicio         : SmallInt = 0;
                                            NroHoja           : LongInt = 0;
                                            OnProcessFinished : TSimpleEvent = nil );

implementation

uses  Gdm30Frm,

      dm_alm,
      dm_ubi,
      dm_hdc,

      a_pde4,
      a_alm,
      a_ubi,

      cx_alm,
      cx_ubi,

      b_pro;

{$R *.DFM}

resourceString
       RsMsg1   = 'Reubicación de material.';

procedure GeneracionMovimientosReubicacion( Ejercicio         : SmallInt = 0;
                                            NroHoja           : LongInt = 0;
                                            OnProcessFinished : TSimpleEvent = nil );
begin
     TBoxGmrForm.Ejercicio := Ejercicio;
     TBoxGmrForm.NroHoja := NroHoja;
     TBoxGmrForm.OnProcessFinished := OnProcessFinished;
     CreateEditForm( TBoxGmrForm, BoxGmrForm );
end;

procedure TBoxGmrForm.CodigoAlmacenCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntAlmacenes( [ Sender.EditingValue ] );
end;

procedure TBoxGmrForm.CodigoAlmacenCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaAlmacenes( Sender );
end;

procedure TBoxGmrForm.CodigoAlmacenCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Almacen.Valida( scVentas, Sender, DisplayValue, ErrorTExt, Error );
end;

procedure TBoxGmrForm.FormManagerInitializeForm;
begin
     RangoFechasPanel.Visible := NroHoja=0;
     If   NroHoja<>0
     then Height := Height - RangoFechasPanel.Height;
     DataFechaInicial.Value := ApplicationContainer.TodayDate;
     DataFechaFinal.Value := ApplicationContainer.LastDayOfYearDate;
     DataCodigoAlmacen.Value := ParametrosAprovisionamientoRec.SerieAlbaranesSalida;
end;

procedure TBoxGmrForm.FormManagerOkButton;
begin
     CreateProcessForm( DoProcesoReubicacion, RsMsg1 );
end;

procedure TBoxGmrForm.DoProcesoReubicacion;
begin
     HojaCarga.ReubicarArticulos( Ejercicio, NroHoja, DataCodigoAlmacen.Value, DataUbicacion.Value, DataFechaInicial.Value, DataFechaFinal.Value );
     If   Assigned( OnProcessFinished )
     then OnProcessFinished;
end;

procedure TBoxGmrForm.UbicacionCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
      MntUbicaciones( [ DataCodigoAlmacen.Value, Sender.EditingValue ] );
end;

procedure TBoxGmrForm.UbicacionCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
      ConsultaUbicaciones( DataCodigoAlmacen.Value, ubCarga, Sender );
end;

procedure TBoxGmrForm.UbicacionCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
      Ubicacion.Valida( DataCodigoAlmacen.Value, True, Sender, DisplayValue, ErrorText, Error );
end;

initialization

end.
