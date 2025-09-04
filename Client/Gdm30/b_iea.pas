
unit b_iea;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, AppForms, StdCtrls, Buttons, Mask,

  AppContainer,
  ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, DB, dxmdaset,
  DataManager, cxPC, cxControls, cxGraphics, nxdb, cxGroupBox,
  cxRadioGroup, cxDBEdit, cxMaskEdit, cxDropDownEdit, cxIndexedComboBox,
  cxContainer, cxEdit, cxTextEdit, cxCalendar,
  dxSkinsCore, dxSkinsDefaultPainters, cxLookAndFeels, cxLabel, cxCheckBox,

  Gim00Fields,
  Gim10Fields,
  Gim30Fields,

  dmi_iex,
  dmi_mov, dxUIAClasses;

type
  TBoxIeaForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    PathCtrl: TcxDBTextEdit;
    ExaminarButton: TgBitBtn;
    FormatoCtrl: TcxDBIndexedComboBox;
    ArticuloTable: TnxeTable;
    ExternArticuloTable: TnxeTable;
    DestinoOrigenCtrl: TcxDBRadioGroup;
    DireccionCorreoCtrl: TcxDBTextEdit;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataProceso: TSmallintField;
    DataPath: TWideStringField;
    DataFormato: TSmallintField;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataDestinoOrigen: TSmallintField;
    DataDireccionCorreo: TWideStringField;
    ProcesoCtrl: TcxDBIndexedComboBox;
    Shape1: TShape;
    Label2: TcxLabel;
    Label3: TcxLabel;
    Label8: TcxLabel;
    destinoOrigenLabel: TcxLabel;
    Label9: TcxLabel;
    Label10: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    SeleccionFechaPanel: TcxGroupBox;
    gxRangeBox1: TgxRangeBox;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    FechaLabel: TcxLabel;
    CampoLibre9Panel: TcxGroupBox;
    CampoLibre9Ctrl: TcxDBCheckBox;
    FamiliaCtrl: TcxDBTextEdit;
    Label25: TcxLabel;
    descFamiliaLabel: TcxLabel;
    gxRangeBox2: TgxRangeBox;
    CodigoArticuloInicialCtrl: TcxDBTextEdit;
    CodigoArticuloFinalCtrl: TcxDBTextEdit;
    Label1: TcxLabel;
    Label7: TcxLabel;
    cxLabel1: TcxLabel;
    DataCodigoArticuloInicial: TStringField;
    DataCodigoArticuloFinal: TStringField;
    DataCodigoFamilia: TStringField;
    DataCampoLibre9: TBooleanField;
    cxGroupBox2: TcxGroupBox;
    procedure FormManagerInitializeForm;
    procedure FormManagerOkButton;
    procedure ExaminarButtonClick(Sender: TObject);
    procedure PathCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure DestinoOrigenCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure DireccionCorreoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure DireccionCorreoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure DireccionCorreoCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure TipoExportacionValuePosted(Sender: TObject);
    procedure CodigoArticuloCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoArticuloCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure FamiliaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FamiliaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);

  private

    ArticuloFields : TArticuloFields;
    ExternArticuloFields : TArticuloFields;

    DsDireccionCorreoFields : TDireccionCorreoFields;

    ArticuloText : Text;

    StrDataPath  : string;
    SaveDecimalSeparator : Char;

    procedure ActualizaEstadoComponentes;

  protected

  public

    procedure ExecuteProcess;
    procedure AbreFicherosExternos( Exportar : Boolean );
    procedure CierraFicherosExternos( Exportar : Boolean );
    procedure ImportaDatos;
    procedure DoOnAcceptMessage;
  end;

var  BoxIeaForm: TBoxIeaForm = nil;

procedure ExportImportArticulos;

implementation

{$R *.DFM}

uses   Variants,
       Files,
       FileCtrl,
       DateUtils,
       LibUtils,
       AppManager,

       DataAccess,
       EnterpriseDataAccess,
       SessionDataAccess,

       Gdm00Dm,

       Gdm30Frm,

       dm_iex,
       dm_ddc,
       dm_art,
       dm_fam,

       a_ddc,

       b_msg,
       b_pro,
       b_dir,

       cx_art,
       cx_ddc,
       cx_fam,

       f_prg;

resourceString
  RsMsg1   = 'Error creando los ficheros de exportación.';
  RsMsg2   = 'Exportación de artículos';
  RsMsg3   = 'Grabando datos en los ficheros ...';
  RsMsg4   = 'Copiando datos en [%s].';
  RsMsg5   = 'Importación de artículos';
  RsMsg6   = 'Leyendo datos desde [%s].';
  RsMsg7   = 'Importando datos desde los ficheros ...';
  RsMsg8   = '¿Desea conservar los ficheros que acaba de importar?';

  RsMsg10  = 'Se cancela el proceso de importación.';
  RsMsg11  = 'Se ha interrumpido el proceso de exportacion/importación.';
  RsMsg12  = 'Es conveniente que revise el contenido de sus ficheros.';
  RsMsg13  = 'Suprimiendo ficheros ...';

  RsMsg15  = 'Indique si desea cancelar ahora el proceso de importación.' + #13 + 'Si finaliza el proceso no se registrará ningún cambio en sus ficheros.';

  RsMsg17  = 'Se cancela el proceso.';
  RsMsg22  = 'Destino';
  RsMsg23  = 'Origen';

  RsTodas  = '<Todas>';
  RsArticulos = 'Artículos';

const
  ListaFicherosTexto  : TStringArray = [ 'Articulo.txt' ];
  ListaFicherosDB : TStringArray = [ 'Articulo.nx1' ];

procedure ExportImportArticulos;
begin
     CreateEditForm( TBoxIeaForm, BoxIeaForm, TGds30Frm.AlmacenSection, True );
end;

procedure TBoxIeaForm.FamiliaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFamilias( Sender );
end;

procedure TBoxIeaForm.FamiliaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   ValueIsEmpty( DisplayValue )
     then FamiliaCtrl.Description := RsTodas
     else Familia.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TBoxIeaForm.FormManagerInitializeForm;
begin

     CloseWindowWhenFocusLost := True;

     ArticuloFields := TArticuloFields.Create( ArticuloTable );

     DsDireccionCorreoFields := TDireccionCorreoFields.Create( Self );

     DataFormato.Value := 0;
     DataProceso.Value := 0;
     DataDestinoOrigen.Value := 0;

     DataCodigoArticuloFinal.Value := HighStrCode;
     DataFechaInicial.Value := IncYear( ApplicationContainer.TodayDate, -30 );
     DataFechaFinal.Value := ApplicationContainer.LastDayOfYearDate;

     With DataModule00.DmEmpresaFields do
       begin
       CampoLibre9Panel.Visible :=  not ValueIsEmpty( Articulo_CampoLibre[ 9 ].Value );
       CampoLibre9Ctrl.Caption := Articulo_CampoLibre[ 9 ].Value;
       end;

     ActualizaEstadoComponentes;
end;

procedure TBoxIeaForm.FormManagerOkButton;

var  HeaderMsg : String;

begin
     case DataProceso.Value of
         0 : HeaderMsg := RsMsg2;
         1 : HeaderMsg := RsMsg5;
         end;
     CreateProcessForm( ExecuteProcess, HeaderMsg );
end;

procedure TBoxIeaForm.ExaminarButtonClick(Sender: TObject);
begin
     SelectDirectory( DataPath );
end;

procedure TBoxIeaForm.AbreFicherosExternos( Exportar : Boolean );
begin

     With ExportImport do
       case DataFormato.Value of
         0 : begin
             AbreFicherosExternos( [ ExternArticuloTable ], Exportar );
             ExternArticuloFields := TArticuloFields.Create( ExternArticuloTable );
             end;
         1 : AbreFicheroTextoExterno( ArticuloText, AddPathDelim( DataPath.Value ) + 'Articulo.txt', Exportar );
         end;
end;

procedure TBoxIeaForm.CierraFicherosExternos( Exportar : Boolean );
begin
     With ExportImport do
       case DataFormato.Value of
         0 : begin
             ExternArticuloTable.Close;
             DataAccessModule.CloseInactiveLocalSessionResources;
             end;
         1 : CloseFile( ArticuloText  );
         end;
end;

procedure TBoxIeaForm.ExecuteProcess;

procedure ExportarArticulos;

var  Procesar : Boolean;

procedure InsertaParametros;
begin
     With ExportImport do
       begin
       HeaderList.Values[ RsCodigoEmpresa ] := CodigoEmpresaActual;
       HeaderList.Values[ RsNombreEmpresa ] := ApplicationContainer.Empresa_Nombre;
       HeaderList.Values[ RsTipoDeDatos ] := RsArticulos;
       HeaderList.Values[ RsFechaInicial ] := StrFormatDate( DataFechaInicial.Value );
       HeaderList.Values[ RsFechaFinal ] := StrFormatDate( DataFechaFinal.Value );
       HeaderList.Values[ RsCodigoArticuloInicial ] := DataCodigoArticuloInicial.Value;
       HeaderList.Values[ RsCodigoArticuloFinal ] := DataCodigoArticuloFinal.Value;
       end;
end;

var  CompressedFile : String;

begin

     With ProcessFrame do
       try

         ExportImport.CleanExportDir;

         AbreFicherosExternos( True );

         try

           AddMsg( ntInformation, RsMsg3 );

           With ArticuloTable do
             begin

             SetRange( [ DataCodigoArticuloInicial.Value ], [ DataCodigoArticuloFinal.Value ] );
             First;
             While not Eof and not Canceled do
               begin

               If   ( ArticuloFields.FechaAlta.IsNull or ( ( ArticuloFields.FechaAlta.Value>=DataFechaInicial.Value ) and ( ArticuloFields.FechaAlta.Value<=DataFechaFinal.Value ) ) ) and
                    ( ( DataCodigoFamilia.Value='' ) or ( ArticuloFields.Familia.Value=DataCodigoFamilia.Value ) ) and
                    ( not CampoLibre9Panel.Visible or ( ArticuloFields.CampoLibre9.Value=DataCampoLibre9.Value ) )
               then begin
                    If   DataFormato.Value=0
                    then ExternArticuloTable.CopyAndAppendRecord( ArticuloTable )
                    else WriteLn( ArticuloText, ExportImport.ExportRecordToText( ArticuloTable ) );

                    ProcessFrame.AddRecordMsg( ArticuloFields.Codigo.Value + ' - ' + ArticuloFields.Descripcion.Value );

                    ExportImport.RecordProcessed := True;
                    end;

               Next;
               end;

             end;

         finally
           CierraFicherosExternos( True );
           end;

         If   not Canceled
         then With ExportImport do
                begin

                case DataDestinoOrigen.Value of
                  0 : If   DataFormato.Value=0
                      then begin
                           CompressAndCopyFiles( ListaFicherosDB, SessionDataModule.ExportsDatabase.Path, StrDataPath, True );
                           SetBackupInfo( StrDataPath, tdArticulo, True );
                           end;

                  1 : begin

                      InsertaParametros;

                      If   DataFormato.Value=0
                      then CompressedFile := SMTPCompressFiles( ListaFicherosDB, [], SessionDataModule.ExportsDatabase.Path )
                      else CompressedFile := SMTPCompressFiles( ListaFicherosTexto, [], DataPath.Value );

                      SMTPInitDataPacket( tdArticulo, DsDireccionCorreoFields, [ CompressedFile ], True );
                      SMTPSend;

                      end;
                  end;

                end;

       except on E : Exception do
         AddMsg( ntError, RsMsg11 + #13 + RsMsg12 );
         end;

end;

procedure ImportarArticulos;
begin

     With ProcessFrame, ExportImport do
       try

         ExportImport.CleanImportDir;

         case DataDestinoOrigen.Value of
           0 : begin
               If   DataFormato.Value=0
               then begin
                    CompruebaDisco( StrDataPath, 0, True );
                    If   SetBackupInfo( StrDataPath, tdArticulo, False )
                    then DeCompressAndCopyFiles( StrDataPath, ListaFicherosDB );
                    end;
               ImportaDatos;
               end;

           1 : POP3Init( tdArticulo, 0, DoOnAcceptMessage );
           end;

       except on E : Exception do
         AddMsg( ntError, RsMsg11 + #13 + RsMsg12 );
       end;

end;

begin

     StrDataPath := AddPathDelim( DataPath.Value );

     try

       SaveDecimalSeparator := FormatSettings.DecimalSeparator;
       If   DataFormato.Value=1
       then FormatSettings.DecimalSeparator := '.';

       case DataProceso.Value of
         0 : ExportarArticulos;
         1 : ImportarArticulos;
         end;

     finally
       FormatSettings.DecimalSeparator := SaveDecimalSeparator;
       end;

end;

procedure TBoxIeaForm.ImportaDatos;

var  AvisoCancelacion : Boolean;
     CheckRecordIRTProcedure : TCheckRecordIRTProcedure;

begin

     AbreFicherosExternos( False );

     With ProcessFrame, ExportImport do
       begin

       try

         EnterpriseDataModule.StartTransaction( [ ArticuloTable ] );

         AddMsg( ntInformation, RsMsg7 );

         AvisoCancelacion := False;

         If   DataFormato.Value=0
         then With ExternArticuloTable do
                begin
                First;
                If  not Eof
                then While not Eof and not Canceled do
                       begin
                       If   ArticuloTable.FindKey( [ ExternArticuloFields.Codigo.Value ] )
                       then ArticuloTable.Edit
                       else ArticuloTable.Append;
                       ArticuloTable.CopyFields( ExternArticuloTable );
                       ArticuloTable.Post;
                       ProcessFrame.AddRecordMsg( ArticuloFields.Codigo.Value + ' - ' + ArticuloFields.Descripcion.Value );
                       Next;
                       end;
                end
         else begin

              CheckRecordIRTProcedure := procedure( ListaParametros : TStringList )
              begin
                   If   ArticuloTable.FindKey( [ ListaParametros.Strings[ 0 ] ] )  // Codigo
                   then ArticuloTable.Edit
                   else ArticuloTable.Append;
              end;

              While not Eof( ArticuloText ) and not ProcessFrame.Canceled do
                begin
                If   ExportImport.ImportRecordFromText( ArticuloText, ArticuloTable, CheckRecordIRTProcedure )
                then begin
                     ArticuloTable.Post;
                     ProcessFrame.AddRecordMsg( ArticuloFields.Codigo.Value + ' - ' + ArticuloFields.Descripcion.Value );
                     end
                else ArticuloTable.Cancel;
                end;

              end;

         If   Canceled
         then Abort
         else EnterpriseDataModule.Commit;

       except on e : Exception do
         begin
         EnterpriseDataModule.RollBack;
         ShowException( E, Self );
         ProcessFrame.AddMsg( ntError, RsgMsg120 );
         end;
       end;

       CierraFicherosExternos( False );

       If   not Canceled and not Error
       then If   DataDestinoOrigen.Value=0
            then If   ShowNotification( ntQuestion, RsMsg8, '' )=mrNo
                 then begin
                      AddMsg( ntInformation, RsMsg13 );
                      case DataFormato.Value of
                        0 : EraseListOfFiles( StrDataPath, [ BackupFileName, BackupInfoFileName, ListaFicherosDB[ 0 ] ], False );
                        1 : EraseListOfFiles( StrDataPath, ListaFicherosTexto, False );
                        end;
                      end;
       end;

end;

procedure TBoxIeaForm.DoOnAcceptMessage;
begin
     ExportImport.DeCompressFiles( SessionDataModule.GetImportDirectory, ListaFicherosDB );
     ImportaDatos;
end;

procedure TBoxIeaForm.PathCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   not ValueIsEmpty( DisplayValue )
     then If   not DirectoryExists( DisplayValue )
          then begin
               Error := True;
               ErrorText := JoinMessage( RsgMsg394, RsgMsg395 );
               end;
end;

procedure TBoxIeaForm.TipoExportacionValuePosted(Sender: TObject);
begin
     ActualizaEstadoComponentes;
end;

procedure TBoxIeaForm.ActualizaEstadoComponentes;
begin

     CodigoArticuloInicialCtrl.Enabled := DataProceso.Value=0;
     CodigoArticuloFinalCtrl.Enabled := DataProceso.Value=0;
     FamiliaCtrl.Enabled := DataProceso.Value=0;
     FechaInicialCtrl.Enabled := DataProceso.Value=0;
     FechaFinalCtrl.Enabled := DataProceso.Value=0;

     If   DataFormato.Value=1
     then DataDestinoOrigen.Value := 0;  // Solo fichero
     DestinoOrigenCtrl.Enabled := DataFormato.Value=0;

     With DestinoOrigenLabel do
      case DataProceso.Value of
        0 : Caption := RsMsg22;
        1 : Caption := RsMsg23;
        end;

     DireccionCorreoCtrl.Enabled := ( DataProceso.Value=0 ) and ( DataDestinoOrigen.Value=1 );

end;

procedure TBoxIeaForm.CodigoArticuloCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scAmbas, True, Sender );
end;

procedure TBoxIeaForm.CodigoArticuloCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TBoxIeaForm.DestinoOrigenCtrlPropertiesEditValueChanged( Sender: TObject);
begin
     With DestinoOrigenCtrl do
       begin
       PathCtrl.Enabled := EditValue=0;
       ExaminarButton.Enabled := EditValue=0;
       DireccionCorreoCtrl.Enabled := ( DataProceso.Value=0 ) and ( EditValue=1 );
       end;
end;

procedure TBoxIeaForm.DireccionCorreoCtrlPropertiesEditRequest( Sender: TcxCustomEdit);
begin
     MntDireccionesCorreo( [ Sender.EditingValue ] );
end;

procedure TBoxIeaForm.DireccionCorreoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaDireccionesCorreo( Sender );
end;

procedure TBoxIeaForm.DireccionCorreoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     DireccionCorreo.Valida( Sender, tdAmbos, DisplayValue, ErrorText, Error, DsDireccionCorreoFields );
end;

end.
