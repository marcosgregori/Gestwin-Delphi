
unit a_ubi;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask, Controls, Classes,
     ExtCtrls,

     AppContainer,
     Menus, cxLookAndFeelPainters, cxButtons, cxControls,
     cxContainer, cxEdit, cxTextEdit, cxDBEdit, DB, nxdb, DataManager,
  cxGraphics, cxLookAndFeels, dxSkinsCore, dxSkinsDefaultPainters, cxLabel,
  cxGroupBox, cxCheckBox, dxUIAClasses;

type
  TmntUbiForm = class(TgxForm)
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    CodigoAlmacenCtrl: TcxDBTextEdit;
    dataPanel: TgxEditPanel;
    DescripcionCtrl: TcxDBTextEdit;
    CodigoCtrl: TcxDBTextEdit;
    UbicacionTable: TnxeTable;
    UbicacionDataSource: TDataSource;
    UbicacionTableCodigoAlmacen: TWideStringField;
    UbicacionTableCodigo: TWideStringField;
    UbicacionTableDescripcion: TWideStringField;
    codigoCtrlCaption: TcxLabel;
    Label2: TcxLabel;
    Label3: TcxLabel;
    Label1: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    UbicacionDeCargaCtrl: TcxDBCheckBox;
    UbicacionTableUbicacionDeCarga: TBooleanField;
    procedure FormManagerReportRequest;
    function FormManagerGetAccessLevel: Smallint;
    procedure CodigoAlmacenCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure CodigoAlmacenCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoAlmacenCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
  private

  public

  end;

var  mntUbiForm: TmntUbiForm = nil;

procedure MntUbicaciones( keyValues : array of const );

implementation

{$R *.DFM}

uses   EnterpriseDataAccess,

       Gim00Fields,
       Gim30Fields,

       Gdm00Dm,
       Gdm30Frm,

       dm_alm,
       dm_ubi,

       a_alm,

       cx_alm,
       cx_ubi,

       l_ubi;

procedure MntUbicaciones( keyValues : array of const );
begin
     CreateEditForm( TmntUbiForm, MntUbiForm, KeyValues, TGds30Frm.AlmacenSection );
end;

procedure TmntUbiForm.CodigoAlmacenCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntAlmacenes( [ Sender.EditingValue ] );
end;

procedure TmntUbiForm.CodigoAlmacenCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaAlmacenes( Sender );
end;

procedure TmntUbiForm.CodigoAlmacenCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Almacen.Valida( scAmbas, Sender, DisplayValue, ErrorText, Error );
end;

procedure TmntUbiForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaUbicaciones( UbicacionTableCodigoAlmacen.Value, ubTodas, Sender, qgsLinked );
end;

procedure TmntUbiForm.FormManagerReportRequest;
begin
     ListadoUbicaciones;
end;

function TmntUbiForm.FormManagerGetAccessLevel: Smallint;
begin
     Result := DataModule00.DmUsuarioFields.acALFicheros.Value;
end;

end.


