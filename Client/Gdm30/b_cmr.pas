
unit b_cmr;

interface

uses AppForms, StdCtrls, Buttons, Mask, Controls,
     ExtCtrls, Classes, Forms, Grids, Graphics,

     AppManager,
     Dialogs,

     Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb,
  DataManager, cxCurrencyEdit, cxDBEdit, cxSpinEdit, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
  cxGroupBox, cxRadioGroup, cxGraphics, cxIndexedComboBox, dxmdaset,

  AppContainer,

  Gim00Fields,
  Gim10Fields,
  Gim30Fields, dxSkinsCore, dxSkinsDefaultPainters, cxLookAndFeels, cxLabel,
  dxUIAClasses;

type

  TBoxCmrForm = class(TgxForm)
    FormManager: TgxFormManager;
    DataPanel: TgxEditPanel;
    LineaMovimientoTable: TnxeTable;
    MovimientoTable: TnxeTable;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    gxRangeBox2: TgxRangeBox;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    Label7: TcxLabel;
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    AlmacenCtrl: TcxDBTextEdit;
    Label1: TcxLabel;
    DescAlmacenLabel: TcxLabel;
    DataAlmacen: TStringField;
    cxLabel2: TcxLabel;
    RelacionMovimientosQuery: TnxeQuery;
    RelacionMovimientosQueryCodigo: TWideStringField;
    RelacionMovimientosQueryDescripcion: TWideStringField;
    RelacionMovimientosQueryTipo: TSmallintField;
    RelacionMovimientosQueryCodigoTarifa: TWideStringField;
    RelacionMovimientosQueryCodigoArticulo: TWideStringField;
    RelacionMovimientosQueryReferencia: TWideStringField;
    RelacionMovimientosQueryCantidadMinima: TBCDField;
    RelacionMovimientosQueryPrecio: TFloatField;
    RelacionMovimientosQueryRecargo: TBCDField;
    RelacionMovimientosQueryDescuento: TBCDField;
    procedure FormManagerOkButton;
    procedure FormManagerInitializeForm;
  private

    MovimientoFields : TMovimientoFields;
    LineaMovimientoFields : TLineaMovimientoFields;

  public

    procedure ExecuteProcess;
  end;

var
  BoxCmrForm: TBoxCmrForm = nil;


procedure ConsolidacionMovimientosRegularizacion;

implementation

{$R *.DFM}

uses   Variants,
       SysUtils,
       LibUtils,

       EnterpriseDataAccess,
       SessionDataAccess,

       Gdm00Dm,
       Gdm30Dm,

       dmi_mov,

       dm_mov,
       dm_tma,

       b_msg,
       b_pro,

       f_prg;

procedure ConsolidacionMovimientosRegularizacion;
begin
     CreateEditForm( TBoxCmrForm, BoxCmrForm );
end;

procedure TBoxCmrForm.FormManagerOkButton;
begin
     CreateProcessForm( ExecuteProcess, Caption );
end;

procedure TBoxCmrForm.ExecuteProcess;
begin

     EnterpriseDataModule.StartTransaction;

     try

       EnterpriseDataModule.Commit;

     except on e : Exception do
       begin
       EnterpriseDataModule.RollBack;
       {
       If   not ProcessFrame.Canceled
       then ProcessFrame.AddMsg( ntError, E.Message );
       }
       end;
     end;

end;

procedure TBoxCmrForm.FormManagerInitializeForm;
begin
     MovimientoFields := TMovimientoFields.Create( MovimientoTable );
     LineaMovimientoFields := TLineaMovimientoFields.Create( LineaMovimientoTable );

     DataFechaInicial.Value := IncMonth( ApplicationContainer.TodayDate, -1 );
     DataFechaFinal.Value := ApplicationContainer.TodayDate;
end;

end.

