unit a_alm;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask, Controls, Classes,
  ExtCtrls,

  AppContainer,

  Menus, cxLookAndFeelPainters, cxButtons, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxDBEdit, Datamanager, DB, nxdb,
  cxMaskEdit, cxDropDownEdit, cxCalendar, cxCheckBox, dxSkinsCore,
  dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels, cxLabel, cxGroupBox,
  dxUIAClasses;

type
  TMntAlmForm = class(TgxForm)
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    CodigoCtrl: TcxDBTextEdit;
    AlmacenTable: TnxeTable;
    DataSource: TDataSource;
    AlmacenTableCodigo: TWideStringField;
    AlmacenTableNombre: TWideStringField;
    AlmacenTableRoturaStock: TBooleanField;
    AlmacenTableFechaRotura: TDateField;
    DataPanel: TgxEditPanel;
    NombreCtrl: TcxDBTextEdit;
    RoturaStocksCtrl: TcxDBCheckBox;
    FechaRoturaCtrl: TcxDBDateEdit;
    codigoCtrlCaption: TcxLabel;
    Label1: TcxLabel;
    Label2: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormManagerReportRequest;
    function FormManagerGetAccessLevel: Smallint;
    procedure RoturaStocksCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure AlmacenTableSetKey(DataSet: TDataSet);
    procedure AlmacenTableNewRecord(DataSet: TDataSet);
    procedure FormManagerFocusedAreaChanged;
    procedure AlmacenTableBeforePost(DataSet: TDataSet);
    procedure FormManagerInitializeForm;
  private

  public

  end;

var  MntAlmForm: TMntAlmForm = nil;

procedure MntAlmacenes( KeyValues : array of const );

implementation

{$R *.dfm}

uses   SysUtils,
       AppManager,
       LibUtils,
       Variants,

       EnterpriseDataAccess,

       Gdm00Dm,
       Gim00Fields,
       Gdm30Frm,

       dm_alm,

       cx_alm,

       l_alm,

       b_msg;

resourceString
       RsMsg1  = 'Recuerde que debe realizar una reconstrucción de resultados.';
       RsMsg2  = 'Si fija una fecha de rotura de stocks en un ejercicio en el que ya existen movimientos de almacén, debe realizar una [B]reconstrucción de resultados[/B] para reajustar los valores acumulados de existencias.';

procedure MntAlmacenes( KeyValues : array of const );
begin
     CreateEditForm( TMntAlmForm, MntAlmForm, KeyValues, TGds30Frm.AlmacenSection );
end;

procedure TMntAlmForm.FormManagerReportRequest;
begin
     ListadoAlmacenes;
end;

procedure TMntAlmForm.RoturaStocksCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     FechaRoturaCtrl.Enabled := RoturaStocksCtrl.Checked;
end;

procedure TMntAlmForm.AlmacenTableBeforePost(DataSet: TDataSet);
begin
     If   AlmacenTableRoturaStock.Value and not AlmacenTableRoturaStock.OldValue
     then ShowNotification( ntWarning, RsMsg1, RsMsg2 );
end;

procedure TMntAlmForm.AlmacenTableNewRecord(DataSet: TDataSet);
begin
     With NombreCtrl do
        If   ValueIsEmpty( AlmacenTableCodigo.Value )
        then AlmacenTableNombre.Value := RsAlmacenGenerico;
     AlmacenTableRoturaStock.Value := False;
end;

procedure TMntAlmForm.AlmacenTableSetKey(DataSet: TDataSet);
begin
     SetFieldValueIfEmpty( AlmacenTableCodigo, '' );
end;

procedure TMntAlmForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaAlmacenes( Sender, qgsLinked );
end;

procedure TMntAlmForm.FormManagerFocusedAreaChanged;
begin
     NombreCtrl.Enabled := not ValueIsEmpty( AlmacenTableCodigo.Value ) or not FormManager.DataAreaFocused;
end;

function TMntAlmForm.FormManagerGetAccessLevel: Smallint;
begin
     With DataModule00.DmUsuarioFields do
       Result := CheckAccessLevel( [ AcALFicheros.Value, AcALAlmacenes.Value ] );
end;

procedure TMntAlmForm.FormManagerInitializeForm;
begin
     Almacen;  //  Para que se cree el almacén genérico si no existe
end;

end.
