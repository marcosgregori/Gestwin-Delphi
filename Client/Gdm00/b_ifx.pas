unit b_ifx;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Mask,

  AppContainer,
  AppForms,

  Menus, cxLookAndFeelPainters, cxButtons, cxGraphics,
  cxCheckBox, cxDBEdit, cxMaskEdit, cxDropDownEdit, cxControls,
  cxContainer, cxEdit, cxTextEdit, DB, dxmdaset, DataManager, 
  nxdb, cxIndexedComboBox, dxSkinsCore, dxSkinsDefaultPainters,
  cxLookAndFeels, cxLabel, cxGroupBox;

type
  TBoxIfxForm = class(TgxForm)
    FormManager: TgxFormManager;
    ButtonsPanel: TgxEditPanel;
    DataPanel: TgxEditPanel;
    NroPlantillaCtrl: TcxDBTextEdit;
    FicheroCtrl: TcxDBIndexedComboBox;
    SobreescribirCtrl: TcxDBCheckBox;
    InsertarCtrl: TcxDBCheckBox;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataFichero: TSmallintField;
    DataNroPlantilla: TSmallintField;
    DataActualizar: TBooleanField;
    DataInsertar: TBooleanField;
    ImportFileTable: TnxeTable;
    cxGroupBox1: TcxGroupBox;
    Label3: TcxLabel;
    cxLabel1: TcxLabel;
    Label2: TcxLabel;
    descPlantillaLabel: TcxLabel;
    Label5: TcxLabel;
    procedure FicheroCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure NroPlantillaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure NroPlantillaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure FormManagerOkButton;
    procedure FormManagerInitializeForm;
    procedure NroPlantillaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
  private

    CurrentTableName : string;

  public

    procedure executeProcess;
  end;

var
  BoxIfxForm: TBoxIfxForm;

procedure ImportacionFicherosExternos( fichero, nroPlantilla : smallInt );

implementation

{$R *.DFM}

uses   AppManager,
       DataAccess,

       Gdm00Dm,
       Gdm00Frm,

       b_msg,
       b_pro,

       a_efx,

       dm_efi,
       dm_emp,

       cx_emp,
       cx_efi;

resourceString
       RsMsg1  = 'Esta tabla no existe en su aplicación.';

procedure ImportacionFicherosExternos( Fichero, NroPlantilla : SmallInt );
begin
     CreateEditForm( TBoxIfxForm, BoxIfxForm, [ Fichero, NroPlantilla ] );
end;

procedure TBoxIfxForm.FicheroCtrlPropertiesValidate(Sender: TcxCustomEdit;var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     CurrentTableName := EstructuraFichero.ObtenNombreTabla( FicheroCtrl.ItemIndex );
     If   CurrentTableName=''
     then begin
          Error := True;
          ErrorText := RsMsg1;
          end;
end;

procedure TBoxIfxForm.FormManagerInitializeForm;
begin
     EstructuraFichero.ObtenListaFicheros( FicheroCtrl.Properties.Items );

     DataFichero.Value := FormValues[ 0 ];
     DataNroPlantilla.Value := FormValues[ 1 ];
     DataActualizar.Value := True;
     DataInsertar.Value := True;
end;

procedure TBoxIfxForm.FormManagerOkButton;
begin
     CreateProcessForm( ExecuteProcess, Caption );
end;

procedure TBoxIfxForm.NroPlantillaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntEstructuraFicherosExternos( [ DataFichero.Value, DataNroPlantilla.Value ] );
end;

procedure TBoxIfxForm.NroPlantillaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaEstructuraFicheros( TTipoFicheroEstructura( DataFichero.Value ), Sender );
end;

procedure TBoxIfxForm.NroPlantillaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     EstructuraFichero.Valida( Sender, DataFichero.Value, DisplayValue, ErrorText, Error );
end;

procedure TBoxIfxForm.ExecuteProcess;
begin
     With EstructuraFichero do

       try

          If   DmEstructuraFicheroTable.FindKey( [ DataFichero.Value, DataNroPlantilla.Value ] )
          then begin

               With ImportFileTable do
                 begin
                 TableName := CurrentTableName;
                 Active := True;
                 IndexName := IndexDefs.Items[ 1 ].Name;  // El primer índice despues del secuencial
                 end;

               ImportaDatos( '', ImportFileTable, True, DataInsertar.Value, DataActualizar.Value, nil, nil, nil, nil );

               end
          else ShowNotification( ntError, RsMsg2 );
     finally
       importFileTable.Active := False;
     end;

end;

end.
