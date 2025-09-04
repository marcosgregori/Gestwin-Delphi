
unit b_import;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  mask,
  ComCtrls,
  XMLDoc,
  menus,
  xmldom,                                              
  XMLIntf,
  msxmldom, cxLookAndFeelPainters, cxButtons,
  DataManager, DB, nxdb, cxGraphics, cxCheckBox, cxDBEdit, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxIndexedComboBox, dxmdaset, dxSkinsCore, cxLookAndFeels,
  dxSkinsDefaultPainters, cxGroupBox, cxLabel, dxShellDialogs;


type
    TBoxImportForm = class(TgxForm)
    dataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    Label1: TcxLabel;
    TablaCtrl: TcxDBComboBox;
    Label2: TcxLabel;
    NombreFicheroCtrl: TcxDBTextEdit;
    gBitBtn3: TgBitBtn;
    ImportTable: TnxeTable;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataNombreFichero: TWideStringField;
    DataTabla: TWideStringField;
    OpenDialog: TdxOpenFileDialog;
    CuentaTable: TnxeTable;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    gBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    procedure FormManagerOkButton;
    procedure gBitBtn3Click(Sender: TObject);
    procedure InitializeForm;
    procedure NombreFicheroCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    private
      procedure ExecuteProcess;
    protected
    class procedure ImportacionCSV( Sender : TObject );
    public

    end;

var
  BoxImportForm: TBoxImportForm = nil;

implementation

uses   Files,
       LibUtils,
       AppManager,
       DataAccess,
       EnterpriseDataAccess,

       Gdm10Dm,
       Gim10Fields,
       Gdm10Frm,

       dm_iex,

       b_msg,
       b_mpr,
       b_dir;

{$R *.DFM}

resourceString

       rsMsg1  = 'Copiando los registros.';
       rsMsg2  = 'Tabla    : %s.'#13'Fichero : %s';
       rsMsg3  = 'Proceso cancelado por el usuario.';
       rsMsg4  = 'El contenido del fichero destino puede estar incompleto.';
       RsMsg5  = 'Fichero inexistente.';

class procedure TBoxImportForm.ImportacionCSV( Sender : TObject );
begin
     CreateEditForm( TBoxImportForm, BoxImportForm, TGds10Frm.ContableSection, True );
end;

procedure TBoxImportForm.InitializeForm;
begin
     GetTableNames( TablaCtrl.Properties.Items );
     TablaCtrl.ItemIndex := 0;
end;

procedure TBoxImportForm.NombreFicheroCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   ( DisplayValue<>'' ) and not FileExists( DisplayValue )
     then begin
          Error := True;
          ErrorText := JoinMessage( RsMsg5, rsgMsg395 );
          end;

end;

procedure SetupImportSection;
begin
     If   Assigned( Gds10Frm )
     then With Gds10Frm do
            begin

            // La opción

            With AddBarButtonItem( ProcesosContableItem, 'Importación de ficheros CSV' ) do
              OnClick := TBoxImportForm.ImportacionCSV;

            end;

end;

procedure TBoxImportForm.gBitBtn3Click(Sender: TObject);
begin
     If   OpenDialog.Execute
     then begin
          DataNombreFichero.Value := OpenDialog.FileName;
          NombreFicheroCtrl.SetFocus;
          end;
end;

procedure TBoxImportForm.FormManagerOkButton;
begin
     CreateModalProcessForm( ExecuteProcess, True );
end;

procedure TBoxImportForm.executeProcess;

var  TableName,
     FileName  : string;
     ImportFile : system.text;
     TableIndex : SmallInt;
     RecordString,
     ValueCuenta,
     ValueDescripcion : String;
     ValueNivel,
     PP : SmallInt;

     CuentaFields : TCuentaFields;

begin

     CuentaFields := TCuentaFields.Create( CuentaTable );

     With ModalProcessForm do
       try

         ProgressBar.visible := True;
         HeaderLabel.Caption := RsMsg1;

         TableIndex := 0;

         TableName := DataTabla.text;
         FileName  := DataNombreFichero.Value;

         ProcessLabel.caption := Format( rsMsg2, [ TableName, FileName ] );

         CuentaTable.DeleteRecords;

         AssignFile( ImportFile, FileName );
         Reset( ImportFile );

         try

           ProgressBar.Properties.Max := 100;
           While not Eof( ImportFile ) and not Cancelled do
             begin

             Readln( ImportFile, RecordString );
             PP := Pos( '.', RecordString );
             If   PP<>0
             then begin
                  ValueCuenta := Trim( Copy( RecordString, 1, PP - 1 ) );
                  ValueNivel := Length( ValueCuenta );
                  If   ValueNivel=9
                  then ValueNivel := 6;
                  ValueDescripcion := Trim( Copy( RecordString, PP + 1, Length( RecordString ) ) );

                  With CuentaTable, CuentaFields do
                    begin
                    Append;

                    Codigo.Value := ValueCuenta;
                    Nivel.Value := ValueNivel;
                    Descripcion.Value := ValueDescripcion;

                    Post;
                    end;

                  end;

             With ProgressBar do
               begin
               Position := Position + 1;
               If   Position>100
               then Position := 0;
               end;

             Application.ProcessMessages;
             end;

         finally
           CloseFile( ImportFile );
           end;

       finally

         Enabled := True;

         If   Cancelled
         then ShowNotification( ntWarning, rsMsg3, rsMsg4 );

         end;
     {
     With modalProcessForm do
       try

         ProgressBar.visible := true;
         headerLabel.caption := rsMsg1;

         TableIndex := 0;

         TableName := DataTabla.text;
         FileName  := DataNombreFichero.Value;

         ProcessLabel.caption := format( rsMsg2, [ TableName, FileName ] );

         AssignFile( ImportFile, FileName );
         Reset( ImportFile );

         try

           ImportTable.Database := DataAccessModule.GetTableDatabase( TableName );
           ImportTable.TableName := TableName;
           ImportTable.EmptyTable;
           ImportTable.Open;

           ProgressBar.Max := 100;
           While not Eof( ImportFile ) and not Cancelled do
             begin
             ExportImport.ImportRecordFromText( ImportFile, ImportTable );
             With ProgressBar do
               begin
               Position := Position + 1;
               If   Position>100
               then Position := 0;
               end;
             Application.ProcessMessages;
             end;

         finally
           CloseFile( ImportFile );
           ImportTable.Close;
           end;

       finally

         Enabled := True;

         If   Cancelled
         then ShowNotification( mbWarning, rsMsg3, rsMsg4 );

         end;
     }
end;

initialization
  AddProcedure( imStartUp, 0, SetupImportSection );

end.
