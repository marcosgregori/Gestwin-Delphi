
unit Main;

interface

uses
  WinAPI.Windows,

  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  System.IniFiles,
  Data.DB,

  nxdb, DataManager, SxBase, SxMain, ScroogeXHTML,
  nxsdServerEngine, nxsrServerEngine, nxllComponent, Vcl.Dialogs, Vcl.Forms,
  Vcl.Controls, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,

  Gim00Fields, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.PG, FireDAC.Phys.PGDef,
  FireDAC.VCLUI.Wait, FireDAC.Comp.Client, dxGDIPlusClasses,

  FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxMaskEdit, cxDropDownEdit, cxLabel, cxTextEdit, cxProgressBar,
  cxGroupBox, Vcl.Menus, cxCheckBox, cxButtons, dxSkinsCore, dxUIAClasses,
  FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef, cxSpinEdit, nxlgEventLog,
  FireDAC.Comp.BatchMove.DataSet, FireDAC.Comp.BatchMove;

type

  TExportRecordProc = reference to procedure;

  TMainForm = class(TForm)
    ApplicationPanel: TcxGroupBox;
    DesktopPanel: TcxGroupBox;
    SourceTable: TnxeTable;
    BTScroogeXHTML: TBTScroogeXHTML;
    LocalSession: TnxSession;
    LocalServerEngine: TnxServerEngine;
    AppDatabase: TnxeDatabase;
    EnterpriseDatabase: TnxeDatabase;
    CaptionPanel: TcxGroupBox;
    Shape4: TShape;
    Image1: TImage;
    OpenDialog: TFileOpenDialog;
    ProgressBarPanel: TcxGroupBox;
    FDConnection: TFDConnection;
    MySQLTable: TFDTable;
    MySQLAuxTable: TFDTable;
    MySQLAux1Table: TFDTable;
    MySQLAux2Table: TFDTable;
    CodigoClienteCtrl: TcxTextEdit;
    MessageLabel: TcxLabel;
    Label1: TcxLabel;
    DirectorioEmpresaLabel: TcxLabel;
    TablasLabel: TcxLabel;
    PercentLabel: TcxLabel;
    cxLabel1: TcxLabel;
    DirectorioEmpresaCtrl: TcxComboBox;
    TablasCtrl: TcxComboBox;
    ProgressBar: TcxProgressBar;
    ExportarButton: TcxButton;
    CancelarButton: TcxButton;
    AplicacionCtrl: TcxCheckBox;
    EmpresasCtrl: TcxCheckBox;
    cxLabel2: TcxLabel;
    IdEmpresaCtrl: TcxSpinEdit;
    EventLog: TnxEventLog;
    FDQuery: TFDQuery;
    procedure CancelarButtonClick(Sender: TObject);
    procedure ExportarButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CaptionPanelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure EmpresasCtrlClick(Sender: TObject);
    procedure FDBatchMoveWriteRecord(ASender: TObject;
      var AAction: TFDBatchMoveAction);
    procedure FDBatchMoveProgress(ASender: TObject;
      APhase: TFDBatchMovePhase);
    procedure FDBatchMoveError(ASender: TObject; AException: Exception;
      var AAction: TFDErrorAction);
    procedure FDBatchMoveWriteValue(ASender: TObject;
      AItem: TFDBatchMoveMappingItem; var AValue: Variant);
    procedure FDQueryExecuteError(ASender: TObject; ATimes,
      AOffset: LongInt; AError: EFDDBEngineException;
      var AAction: TFDErrorAction);
  private

    procedure GetTableArray( Directorio : String; TableArray : TStrings; ToLowerCase : Boolean = False );

  public

    Working,
    ProcessCanceled : Boolean;
    BatchSize,
    NumOfRecords,
    RecordNumber : LongInt;
    StartTime : TDateTime;
    CodigoCliente,

    MainDatabaseName,
    CurrentDatabaseName,
    CurrentTableName : String;

    EjercicioActual : SmallInt;

    EmpresaFields : TEmpresaFields;

    constructor Create( aOwner : TComponent ); override;
    destructor  Destroy;                       override;

    procedure ExecuteProcess;
  end;

var MainForm: TMainForm = nil;

implementation

{$R *.DFM}

uses  WinAPI.Messages,
      DateUtils,
      StrUtils,
      Files,
      LibUtils,

      nxsdTypes,
      nxsdDataDictionary,
      nxseAllEngines,

      AppManager,

      MessageBox;

resourceString

      RsMsg7  = 'Proceso cancelado por el usuario.';
      RsMsg8  = 'El proceso no ha finalizado satisfactoriamente.'#13'Si desea utilizar los datos, debe realizarlo de nuevo.';
      RsMsg9  = 'Copia realizada satisfactoriamente.';
      RsMsg10 = '¿Esta seguro de que desea cancelar el proceso?';

      // He optado por utilizar una lista de tablas para poder determinar el orden de exportación, que es muy importante
      // por los claves externas ...

type  TStringsArray = array of string;
      TMappingArray = array of TStringsArray;

const ApplicationTableArray : TMappingArray =  [ [ 'Pais', 'paises' ],
                                                 [ 'Provincia', 'provincias' ],
                                                 [ 'CodigoPostal', 'zonas_postales' ],
                                                 [ 'Empresa', 'empresas' ],
                                                 [ 'Divisa', 'divisas' ],
                                                 [ 'EntidadFinanciera', 'entidades_financieras' ],
                                                 [ 'Usuario', 'user_' ]
                                               ];

      EnterpriseTableArray : TMappingArray =   [ [ 'Cuenta', 'cuentas' ],
                                                 [ 'CentroCoste', 'centros_coste' ],
                                                 [ 'TipoAsiento', 'tipos_asiento' ],
                                                 [ 'TiposIVA', 'tipos_iva' ],
                                                 [ 'ConceptoApte', 'conceptos_apunte' ],
                                                 [ 'Asiento', 'asientos' ],
                                                 [ 'Apunte', 'apuntes' ]
                                               ];

      // Mappings

       TiposIVAMappingArray : TMappingArray = [ [ 'CtaSoportado', 'cta_soportado' ],
                                                [ 'CtaRepercutido', 'cta_repercutido' ]
                                              ];

constructor TMainForm.Create( aOwner : TComponent );
begin
     inherited Create( aOwner );
end;

destructor TMainForm.Destroy;
begin
     inherited Destroy;
end;

procedure TMainForm.GetTableArray( Directorio : String; TableArray : TStrings; ToLowerCase : Boolean = False );

var   Index : SmallInt;

begin
     GetFileList( AddPathDelim( Directorio ), '*.nx1', TableArray );
     Index := 0;
     While  Index < TableArray.Count do
       If   not ( Upcase( TableArray[ Index ][ 1 ] ) in [ 'A'..'Z' ] )
       then TableArray.Delete( Index )
       else begin
            TableArray[ Index ] := ExtractFileNameWithoutExtension( TableArray[ Index ] );
            If   ToLowerCase
            then TableArray[ Index ] := LowerCase( TableArray[ Index ] );
            Inc( Index );
            end;
     TableArray.Insert( 0, '<Todas>' );
end;

procedure TMainForm.FDBatchMoveError(ASender: TObject;AException: Exception; var AAction: TFDErrorAction);
begin
     EventLog.WriteString( AException.Message, { aMsgNumber } 0, TnxLogPriority.lpError );
     AAction := TFDErrorAction.eaSkip;
end;

procedure TMainForm.FDBatchMoveProgress(ASender: TObject;APhase: TFDBatchMovePhase);
begin
     case APhase of
       psStarting :
         begin
         NumOfRecords := SourceTable.RecordCount;

         ProgressBar.Position := 0;
         ProgressBar.Properties.Max := NumOfRecords;
         PercentLabel.Caption := '';

         MessageLabel.Caption := 'Tabla : ' + SourceTable.TableName;
         end;

       psProgress :
         begin
         Inc( RecordNumber );
         ProgressBar.Position := RecordNumber;
         MessageLabel.Caption := 'Tabla : ' + SourceTable.TableName + '(' + IntToStr( RecordNumber ) + ')';
         PercentLabel.Caption := Format( '%d%%', [ ( RecordNumber * 100 ) div NumOfRecords ] );
         Application.ProcessMessages;
         end;
       end;
end;

procedure TMainForm.FDBatchMoveWriteRecord( ASender: TObject; var AAction: TFDBatchMoveAction);
begin
     var EjercicioSourceField := SourceTable.Fields.FindField( 'Ejercicio' );
     var NroAsientoSourceField := SourceTable.Fields.FindField( 'NroAsiento' );

     If   Assigned( EjercicioSourceField ) and Assigned( NroAsientoSourceField )
     then begin
          var  Ejercicio : SmallInt := EjercicioSourceField.Value;
          var  NroAsiento : LongInt := NroAsientoSourceField.Value;
          If   MySQLAuxTable.Locate( 'ejercicio;nro_asiento', VarArrayOf([ Ejercicio, NroAsiento ] ), [] )
          then begin
               var TargetField := MySQLTable.Fields.FindField( 'asiento_id' );
               var IdField := MySQLAuxTable.Fields.FindField( 'id' );
               If   Assigned( TargetField ) and Assigned( IdField )
               then TargetField.Value := IdField.Value;
               end;
          end;
end;

procedure TMainForm.FDBatchMoveWriteValue(ASender: TObject;AItem: TFDBatchMoveMappingItem; var AValue: Variant);
begin
     //..
     var Item := AItem;
     var Value := AValue;
end;

procedure TMainForm.FDQueryExecuteError(     ASender : TObject;
                                             ATimes,
                                             AOffset : LongInt;
                                             AError  : EFDDBEngineException;
                                         var AAction : TFDErrorAction );
begin
     var Offset := AOffset;
     EventLog.WriteString( AError.Message + ' DB : ' + CurrentDatabaseName + ', Table : ' + CurrentTableName, { aMsgNumber } 0, TnxLogPriority.lpError );
     AAction := eaSkip;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin

     EventLog.FileName := 'GwMigrateEvent.log';

     CodigoClienteCtrl.Text := '00000';

     AppDatabase.AliasPath := ApplicationPath + 'data';
     AppDatabase.Open;

     GetFileList( ApplicationPath, 'data_???', DirectorioEmpresaCtrl.Properties.Items, { Recursive } False, { RemoveExtension } False, { AddFileInfo } False,  faDirectory );
     DirectorioEmpresaCtrl.Properties.Items.Insert( 0, '<Todos>' );
     DirectorioEmpresaCtrl.ItemIndex := 0;

     TablasCtrl.Properties.Items.Add( '<Todas>' );
     For var Index := 0 to Length( EnterpriseTableArray ) - 1 do
       TablasCtrl.Properties.Items.Add( EnterpriseTableArray[ Index ][ 0 ] );

     TablasCtrl.ItemIndex := 0;

     EjercicioActual := YearOf( Now );
end;

procedure TMainForm.CancelarButtonClick(Sender: TObject);
begin
     If   Working
     then begin
          If   ShowNotification( ntQuestion, RsMsg10, '' )=mrYes
          then ProcessCanceled := True;
          end
     else Application.Terminate;
end;

procedure TMainForm.CaptionPanelMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

const sc_DragMove = $F012;

begin
     ReleaseCapture;
     Perform( wm_SysCommand, sc_DragMove, 0 );
end;

procedure TMainForm.ExportarButtonClick(Sender: TObject);

var  Index : SmallInt;

begin

     try

       CancelarButton.SetFocus;
       ExportarButton.Enabled := False;
       EmpresasCtrl.Enabled := False;

       ProcessCanceled := False;

       ExecuteProcess;

       If   ProcessCanceled
       then ShowNotification( ntStop, RsMsg7, RsMsg8 )
       else ShowNotification( ntInformation, RsMsg9, '' );

     finally
       EmpresasCtrl.Enabled := True;
       ExportarButton.Enabled := True;
       end;
end;

procedure TMainForm.EmpresasCtrlClick(Sender: TObject);
begin
     DirectorioEmpresaCtrl.Enabled := EmpresasCtrl.Checked;
     DirectorioEmpresaLabel.Enabled := DirectorioEmpresaCtrl.Enabled;
     TablasCtrl.Enabled := EmpresasCtrl.Checked;
     TablasLabel.Enabled := TablasCtrl.Enabled;
     IdEmpresaCtrl.Enabled := TablasCtrl.Enabled;
end;

procedure TMainForm.ExecuteProcess;

var  DatabaseDirectory,
     FieldName,
     FieldNames : String;
     EnterpriseIndex,
     TableIndex : Integer;

     PhysCommand : IFDPhysCommand;
     ConnIntf: IFDPhysConnection;

procedure  ExportTables( Database          : TnxeDatabase;
                         TableArray        : TMappingArray;
                         TodasLasTablas    : Boolean = False;
                         TableIndex        : SmallInt = 0 );

var  TargetTableName : String;
     TargetTableArray : TStringList;

procedure TruncateTable( TableName : String );
begin
     FDConnection.ExecSQL( 'DELETE FROM ' + CurrentDatabaseName + '.' + TableName );
     FDConnection.ExecSQL( 'ALTER TABLE ' + CurrentDatabaseName + '.' + TableName + ' AUTO_INCREMENT = 1;' );
end;

procedure StartProgress;
begin
     StartTime := Now;
     RecordNumber := 0;
     ProgressBar.Position := 0;
     ProgressBar.Properties.Max := NumOfRecords;
     PercentLabel.Caption := '';
     ProgressBar.Visible := True;
end;

procedure ShowProgress;
begin
     ProgressBar.Position := RecordNumber;
     MessageLabel.Caption := 'Tabla : ' + CurrentTableName + ' (' + IntToStr( RecordNumber ) + ')';
     PercentLabel.Caption := Format( '%d%%', [ ( RecordNumber * 100 ) div NumOfRecords ] );
     Application.ProcessMessages;
end;

procedure EndProgress;
begin
     ProgressBar.Position := 0;
     MessageLabel.Caption := '';
     PercentLabel.Caption := '';
     ProgressBar.Visible := False;
end;

procedure ProcessCuentas;
begin

     TruncateTable( 'cuentas' );

     SourceTable.Close;
     SourceTable.Database := Database;
     SourceTable.TableName := CurrentTableName;
     SourceTable.Open;
     SourceTable.IndexFieldNames := 'Codigo';

     NumOfRecords := SourceTable.RecordCount;
     BatchSize := 1000;

     StartProgress;

     RecordNumber := 0;

     With FDQuery do
       begin

       SQL.Text := 'INSERT INTO cuentas (codigo, nivel, descripcion) ' +
                   ' values (:codigo, :nivel, :descripcion)';

       // Set up parameter types

       Params[0].DataType := ftString;    // codigo
       Params[1].DataType := ftInteger;   // nivel
       Params[2].DataType := ftString;   // descripcion

       // Set up parameters' array size

       Params.ArraySize := BatchSize;

       // Set parameter values

       var Rc := 0;

       SourceTable.First;
       While not SourceTable.Eof do
         begin

         try

           Params[0].AsStrings[Rc] := SourceTable.FieldValues[ 'Codigo' ];
           Params[1].AsIntegers[Rc] := SourceTable.FieldValues[ 'Nivel' ];
           Params[2].AsStrings[Rc] := SourceTable.FieldValues[ 'Descripcion' ];

           Inc( Rc );
           Inc( RecordNumber );

           Application.ProcessMessages;

         except on E : Exception do
            EventLog.WriteString( E.Message + ' DB : ' + CurrentDatabaseName + ', Table : ' + CurrentTableName, { aMsgNumber } 0, TnxLogPriority.lpError );
          end;

         // Execute batch

         If   Rc=BatchSize
         then begin
              Execute(BatchSize, 0);
              Rc := 0;

              ShowProgress;
              end;

         SourceTable.Next;
         end;

       If   Rc<>0
       then Execute( Rc, 0 );

       end;

     EndProgress;
end;

procedure ProcessAsientos;

function ObtenUltimoIdTipoAsiento : LongInt;
begin
     Result := FDConnection.ExecSQLScalar( 'SELECT id FROM tipos_asiento ORDER BY id DESC LIMIT 1' );
end;

begin

     SourceTable.Close;
     SourceTable.Database := Database;
     SourceTable.TableName := CurrentTableName;
     SourceTable.Open;
     SourceTable.IndexFieldNames := 'Ejercicio;NroAsiento';
     SourceTable.SetRange( [ EjercicioActual - 5, 1 ], [ EjercicioActual, MaxInt ] );

     NumOfRecords := SourceTable.RecordCount;

     StartProgress;

     RecordNumber := 0;
     BatchSize := 1000;

     With FDQuery do
       begin

       SQL.Text := 'INSERT INTO asientos ( ejercicio, nro_asiento, fecha, tipo_asiento_id, serie, nro_factura, nro_efecto, fecha_documento, propietario, nro_registro, nombre, origen, creado, bloqueado, motivo_bloqueo, anotacion ) ' +
                   ' values ( :ejercicio, :nro_asiento, :fecha, :tipo_asiento, :serie, :nro_factura, :nro_efecto, :fecha_documento, :propietario, :nro_registro, :nombre, :origen, :creado, :bloqueado, :motivo_bloqueo, :anotacion )';

       // Set up parameter types

       Params[0].DataType := ftSmallint;  // ejercicio
       Params[1].DataType := ftInteger;   // nro_asiento
       Params[2].DataType := ftDate;      // fecha
       Params[3].DataType := ftLongWord;  // tipo_asiento_id
       Params[4].DataType := ftString;    // serie
       Params[4].Size := 40;
       Params[5].DataType := ftLongWord;  // nro_factura
       Params[6].DataType := ftSmallInt;  // nro_efecto
       Params[7].DataType := ftDate;      // fecha_documento
       Params[8].DataType := ftString;    // propietario
       Params[8].Size := 9;
       Params[9].DataType := ftLongWord;  // nro_registro
       Params[10].DataType := ftString;   // nombre
       Params[10].Size := 40;
       Params[11].DataType := ftSmallInt; // origen
       Params[12].DataType := ftDateTime; // creado
       Params[13].DataType := ftBoolean;  // bloqueado
       Params[14].DataType := ftString;   // motivo_bloqueo
       Params[14].Size := 80;
       Params[15].DataType := ftWideMemo; // anotacion

       // Set up parameters' array size

       Params.ArraySize := BatchSize;

       // Set parameter values

       var Rc := 0;
       var UltimoIdTipoAsiento := ObtenUltimoIdTipoAsiento;

       SourceTable.First;
       While not SourceTable.Eof do
         begin

         try

           Params[0].AsSmallInts[Rc] := SourceTable.FieldValues[ 'Ejercicio' ];
           Params[1].AsIntegers[Rc] := SourceTable.FieldValues[ 'NroAsiento' ];
           Params[2].AsDates[Rc] := SourceTable.FieldValues[ 'Fecha' ];

           var TipoAsiento := SourceTable.FieldValues[ 'TipoAsiento' ];
           If   TipoAsiento>UltimoIdTipoAsiento
           then TipoAsiento := 2; // Ordinario
           Params[3].AsLongWords[Rc] := TipoAsiento;
           Params[4].AsStrings[Rc] := SourceTable.FieldValues[ 'Serie' ];

           var NroFactura := SourceTable.FieldValues[ 'NroFactura' ];
           If   not VarIsNull( NroFactura )
           then begin
                Params[5].AsLongwords[Rc] := NroFactura;
                Params[6].AsSmallInts[Rc] := SourceTable.FieldValues[ 'NroEfecto' ];
                end;

           var FechaDocumento := SourceTable.FieldValues[ 'FechaDocumento' ];
           If   VarIsNull( FechaDocumento )
           then FechaDocumento := Params[2].AsDates[Rc];
           Params[7].AsDates[Rc] := FechaDocumento;

           Params[8].AsStrings[Rc] := SourceTable.FieldValues[ 'Propietario' ];

           var NroRegistro := SourceTable.FieldValues[ 'NroRegistro' ];
           If   not VarIsNull( NroRegistro )
           then Params[9].AsLongwords[Rc] := SourceTable.FieldValues[ 'NroRegistro' ];

           var Nombre := SourceTable.FieldValues[ 'Nombre' ];
           If   not VarIsNull( Nombre )
           then Params[10].AsStrings[Rc] := Nombre;

           Params[11].AsSmallInts[Rc] := SourceTable.FieldValues[ 'Origen' ];
           Params[12].AsDateTimes[Rc] := SourceTable.FieldValues[ 'Creado' ];

           var Bloqueado := SourceTable.FieldValues[ 'Bloqueado' ];
           If   VarIsNull( Bloqueado )
           then Bloqueado := False;
           Params[13].AsBooleans[Rc] := Bloqueado;

           var MotivoBloqueo := SourceTable.FieldValues[ 'MotivoBloqueo' ];
           If  not VarIsNull( MotivoBloqueo )
           then Params[14].AsStrings[Rc] := MotivoBloqueo;

           var Anotacion := SourceTable.FieldValues[ 'Anotacion' ];
           If   not VarIsNull( Anotacion )
           then Params[15].AsWideMemos[Rc] := Anotacion;

           Inc( Rc );
           Inc( RecordNumber );

           Application.ProcessMessages;

         except on E : Exception do
          end;

         // Execute batch

         If   Rc=BatchSize
         then begin
              Execute( BatchSize, 0);
              Rc := 0;

              ShowProgress;
              end;

         SourceTable.Next;
         end;

       If   Rc<>0
       then Execute( Rc, 0 );

       end;

     EndProgress;
end;

procedure ProcessApuntes;

function ObtenIdAsientoPorNumeroAsiento( Ejercicio : SmallInt; NroAsiento : LongInt ) : LongInt;
begin
     Result := FDConnection.ExecSQLScalar( 'SELECT id FROM asientos WHERE ejercicio=' + IntToStr( Ejercicio ) + ' AND nro_asiento=' + IntToStr( NroAsiento ) );
end;

var  IdContrapartida,
     IdCentroCoste,
     IdPropietario : Variant;

begin

     TruncateTable( 'saldos' );

     SourceTable.Close;
     SourceTable.Database := Database;
     SourceTable.TableName := CurrentTableName;
     SourceTable.Open;
     SourceTable.IndexFieldNames := 'Ejercicio;NroAsiento;NroApunte';
     SourceTable.SetRange( [ EjercicioActual - 5, 1, 1 ], [ EjercicioActual, MaxInt, MaxSmallint ] );

     NumOfRecords := SourceTable.RecordCount;
     BatchSize := 1000;

     StartProgress;

     RecordNumber := 0;

     With FDQuery do
       begin

       SQL.Text := 'INSERT INTO apuntes (asiento_id, nro_apunte, fecha, subcuenta, centro_coste, contrapartida, concepto, debe, haber, tipo_apunte, punteo, ejercicio_factura, serie, propietario, nro_factura, nro_efecto, base_imponible, tipo, cuota_iva, cuota_re, importe_total) ' +
                   ' values (:asiento_id, :nro_apunte, :fecha, :subcuenta, :centro_coste, :contrapartida, :concepto, :debe, :haber, :tipo_apunte, :punteo, :ejercicio_factura, :serie, :propietario, :nro_factura, :nro_efecto, :base_imponible, :tipo, :cuota_iva, :cuota_re, :importe_total)';

       // Set up parameter types

       Params[0].DataType := ftLargeint;  // asiento_id
       Params[1].DataType := ftInteger;   // nro_apunte
       Params[2].DataType := ftDate;      // fecha
       Params[3].DataType := ftString;    // subcuenta
       Params[3].Size := 9;
       Params[4].DataType := ftString;    // centro_coste
       Params[4].Size := 4;
       Params[5].DataType := ftString;    // contrapartida
       Params[5].Size := 9;
       Params[6].DataType := ftString;    // concepto
       Params[6].Size := 80;
       Params[7].DataType := ftCurrency;  // debe
       Params[8].DataType := ftCurrency;  // haber
       Params[9].DataType := ftSmallInt;  // tipo_apunte
       Params[10].DataType := ftBoolean;  // punteo
       Params[11].DataType := ftSmallInt; // ejercicio_factura
       Params[12].DataType := ftString;   // serie
       Params[12].Size := 40;
       Params[13].DataType := ftString;   // propietario
       Params[14].DataType := ftLongWord; // nro_factura
       Params[15].DataType := ftSmallInt; // nro_efecto
       Params[16].DataType := ftCurrency; // base_imponible
       Params[17].DataType := ftSmallInt; // tipo
       Params[18].DataType := ftCurrency; // cuota_iva
       Params[19].DataType := ftCurrency; // cuota_re
       Params[20].DataType := ftCurrency; // importe_total

       // Set up parameters' array size

       Params.ArraySize := BatchSize;

       // Set parameter values

       var Rc := 0;

       SourceTable.First;
       While not SourceTable.Eof do
         begin

         try

           var Ejercicio := SourceTable.FieldValues[ 'Ejercicio' ];
           var NroAsiento := SourceTable.FieldValues[ 'NroAsiento' ] ;

           var IdAsiento := ObtenIdAsientoPorNumeroAsiento( Ejercicio, NroAsiento );


           Params[0].AsLargeInts[Rc] := IdAsiento;
           Params[1].AsIntegers[Rc] := SourceTable.FieldValues[ 'NroApunte' ];
           Params[2].AsDates[Rc] := SourceTable.FieldValues[ 'Fecha' ];
           Params[3].AsStrings[Rc] := SourceTable.FieldValues[ 'Subcuenta' ];
           Params[4].AsStrings[Rc] := SourceTable.FieldValues[ 'CentroCoste' ];
           Params[5].AsStrings[Rc] := SourceTable.FieldValues[ 'Contrapartida' ];
           Params[6].AsStrings[Rc] := SourceTable.FieldValues[ 'Concepto' ];

           var Debe := SourceTable.FieldValues[ 'Debe' ];
           If   not VarIsNull( Debe )
           then Params[7].AsCurrencys[Rc] := Debe;

           var Haber:= SourceTable.FieldValues[ 'Haber' ];
           If   not VarIsNull( Haber )
           then Params[8].AsCurrencys[Rc] := Haber;

           Params[9].AsSmallInts[Rc] := SourceTable.FieldValues[ 'TipoApunte' ];
           Params[10].AsBooleans[Rc] := SourceTable.FieldValues[ 'Punteo' ];

           var EjercicioFactura := SourceTable.FieldValues[ 'EjercicioFactura' ];

           If   not VarIsNull(EjercicioFactura )
           then begin

                Params[11].AsSmallInts[Rc] := EjercicioFactura;
                Params[12].AsStrings[Rc] := SourceTable.FieldValues[ 'Serie' ];
                Params[13].AsStrings[Rc] := SourceTable.FieldValues[ 'Propietario' ];
                Params[14].AsLongwords[Rc] := SourceTable.FieldValues[ 'NroFactura' ];
                Params[15].AsSmallInts[Rc] := SourceTable.FieldValues[ 'NroEfecto' ];

                Params[16].AsCurrencys[Rc] := SourceTable.FieldValues[ 'BaseImponible' ];
                Params[17].AsSmallInts[Rc] := SourceTable.FieldValues[ 'Tipo' ];
                Params[18].AsCurrencys[Rc] := SourceTable.FieldValues[ 'CuotaIVA' ];
                Params[29].AsCurrencys[Rc] := SourceTable.FieldValues[ 'CuotaRE' ];
                Params[20].AsCurrencys[Rc] := SourceTable.FieldValues[ 'ImporteTotal' ];
                end;

           Inc( Rc );
           Inc( RecordNumber );

           Application.ProcessMessages;

         except on E : Exception do
            EventLog.WriteString( E.Message + ' DB : ' + CurrentDatabaseName + ', Table : ' + CurrentTableName, { aMsgNumber } 0, TnxLogPriority.lpError );
          end;

         // Execute batch

         If   Rc=BatchSize
         then begin
              Execute(BatchSize, 0);
              Rc := 0;

              ShowProgress;
              end;

         SourceTable.Next;
         end;

       If   Rc<>0
       then Execute( Rc, 0 );

       end;

     EndProgress;
end;

procedure ProcessTable( TableNames        : TStringsArray;
                        FieldMappingArray : TMappingArray;
                        OnExportRecord    : TExportRecordProc = nil );

procedure ExportRecord( SourceTable : TnxeTable );

var  Index : SmallInt;
     SourceField : TField;
     TargetField : TField;
     SourceFieldName : String;
     Guid : TGUID;
     ProcessField : Boolean;

begin
     MySQLTable.Append;
     try
       For Index:= 0 to MySQLTable.Fields.Count - 1 do
          begin

          TargetField := MySQLTable.Fields[ Index ];

          If   TargetField.FieldName<>'id'
          then begin

               SourceFieldName := '';

               For var FieldIndex := 0 to Length( FieldMappingArray ) - 1 do
                 If   FieldMappingArray[ FieldIndex ][ 1 ]=TargetField.FieldName
                 then begin
                      SourceFieldName := FieldMappingArray[ FieldIndex ][ 0 ];
                      Break;
                      end;

               If   SourceFieldName=''
               then SourceFieldName := StringReplace( TargetField.FieldName, '_', '', [ rfReplaceAll ] );

               If   Assigned( TargetField )
               then begin
                    SourceField := SourceTable.Fields.FindField( SourceFieldName );
                    If   Assigned( SourceField )
                    then case SourceField.DataType of
                           ftTime :
                             TargetField.Value := SourceField.AsString;    // Asumo que el campo destino es de tipo TimeSpan

                           ftBoolean :
                             TargetField.Value := SourceField.AsBoolean;   // Evitando nulos

                           else
                             TargetField.Value := SourceField.Value;
                             end;
                    end;
               end;
          end;

       If   Assigned( OnExportRecord )
       then OnExportRecord;

       MySQLTable.Post;

     except on E : Exception do
       begin
       MySQLTable.Cancel;
       EventLog.WriteString( E.Message, { aMsgNumber } 0, TnxLogPriority.lpError );
       end;
     end;
end;

begin

     SourceTable.Close;
     SourceTable.Database := Database;
     SourceTable.TableName := CurrentTableName;
     SourceTable.IndexFieldNames := '';
     SourceTable.Open;

     MySQLTable.Close;
     MySQLTable.Connection := FDConnection;
     MySQLTable.TableName := TableNames[ 1 ];

     MySQLTable.Open;

     try

        try

          With SourceTable do
            begin

            var NumOfRecords : Integer := RecordCount;

            StartTime := Now;
            RecordNumber := 1;
            ProgressBar.Position := 0;
            ProgressBar.Properties.Max := NumOfRecords;
            PercentLabel.Caption := '';

            MessageLabel.Caption := 'Tabla : ' + CurrentTableName;

            First;
            While not Eof and not ProcessCanceled do
              begin

              ExportRecord( SourceTable );

              Next;

              Inc( RecordNumber );
              ProgressBar.Position := RecordNumber;
              MessageLabel.Caption := 'Tabla : ' + CurrentTableName + ' (' + IntToStr( RecordNumber ) + ')';
              PercentLabel.Caption := Format( '%d%%', [ ( RecordNumber * 100 ) div NumOfRecords ] );
              Application.ProcessMessages;

              If   ( ( RecordNumber mod 1000 ) = 0 )
              then If   MySQLTable.CachedUpdates
                   then MySQLTable.ApplyUpdates;

              end;

            end;

          If   not ProcessCanceled
          then begin

               If   MySQLTable.CachedUpdates
               then MySQLTable.ApplyUpdates;

               FDConnection.Commit;
               end;

        except
          FDConnection.RollBack;
          raise;
          end;

     finally
       SourceTable.Close;
       MySQLTable.Close;
       MessageLabel.Caption := 'Tabla : ' + SourceTable.TableName + ' (' + IntToStr( RecordNumber ) + ') - Duración : ' + StrFormatTime( Now - StartTime );
       end;

end;

begin

     ProgressBar.Visible := True;
     TargetTableArray := TStringList.Create;
     TargetTableArray.Sorted := True;  // Para poder usar Find necesita estar ordenada

     try

       try

         FDConnection.GetTableNames( '', 'data', '', TargetTableArray, [ osMy, osSystem, osOther ], [ tkTable ] );

         // Primero borro todos los datos en orden inverso

         For var Index : SmallInt := Length( TableArray ) - 1 downto 0 do
           If   ( TodasLasTablas or ( TableIndex=Index ) )
           then TruncateTable( TableArray[ Index ][ 1 ] );

         For var Index : SmallInt := 0 to Length( TableArray ) - 1  do
           begin
           CurrentTableName := TableArray[ Index ][ 0 ];
           If   ( TodasLasTablas or ( TableIndex=Index ) )
           then begin

                // Asignando los mapping cuando ha cambiado el nombre de algun campo

                var MappingArray :TMappingArray := [];
                If   CurrentTableName='TiposIVA'
                then MappingArray := TiposIVAMappingArray;

                //...

                If   CurrentTableName='Cuenta'
                then ProcessCuentas
                else If   CurrentTableName='Asiento'
                     then ProcessAsientos
                     else If   CurrentTableName='Apunte'
                          then ProcessApuntes
                          else ProcessTable( TableArray[ Index ], MappingArray );

           {  Lo dejo como ejemplo

           else If   CurrentTableName='provincias'
                then begin

                     MySQLAuxTable.TableName := CurrentDatabaseName + '.data.paises';
                     MySQLAuxTable.IndexFieldNames := 'codigo';
                     MySQLAuxTable.Open;

                     PgAux2Table.TableName := CurrentDatabaseName + '.data.provincias';
                     PgAux2Table.IndexFieldNames := 'pais;codigo';
                     PgAux2Table.Open;

                     try
                       ProcessTable( TableName,
                                     procedure
                                     begin
                                     var SourcePaisField := SourceTable.Fields.FindField( 'codigo_pais' );
                                     var SourceProvinciaField := SourceTable.Fields.FindField( 'codigo_provincia' );
                                     var TargetField := MySQLTable.Fields.FindField( 'provincia' );
                                     If   Assigned( SourcePaisField ) and Assigned( SourceProvinciaField ) and Assigned( TargetField )
                                     then begin
                                          var  CodigoPais : String := SourcePaisField.Value;
                                          If   MySQLAuxTable.Locate( 'codigo', CodigoPais, [] )
                                          then begin
                                               var IdField := MySQLAuxTable.Fields.FindField( 'id' );
                                               If   Assigned( IdField )
                                               then begin
                                                    var  CodigoProvincia : String := SourceProvinciaField.Value;
                                                    If   PgAux2Table.Locate( 'pais;codigo', VarArrayOf( [ IdField.Value, CodigoProvincia ] ), [] )
                                                    then begin
                                                         IdField := PgAux2Table.Fields.FindField( 'id' );
                                                         If   Assigned( IdField )
                                                         then TargetField.Value := IdField.Value;
                                                         end;
                                                    end;
                                               end;
                                          end;
                                     end );
                     finally
                       PgAux2Table.Close;
                       MySQLAuxTable.Close;
                       end;
                     end
                else ProcessTable( TableName, nil );
                }
                end;

           end;

       except
         end;

     finally
       TargetTableArray.Free;
       EndProgress;
       Application.ProcessMessages;
       end;

end;

begin

     Working := True;

     try

       CodigoCliente := CodigoClienteCtrl.Text;
       MainDatabaseName := 'gc_' + CodigoCliente;

       If   AplicacionCtrl.Checked
       then begin
            CurrentDatabaseName := MainDatabaseName;
            FDConnection.Close;
            FDConnection.ConnectionString := 'User Id=root;Host=localhost;Database=' + CurrentDatabaseName + ';Character Set=compatibility';
            FDConnection.DriverName := 'MySQL';
            FDConnection.Params.Database := MainDatabaseName;
            FDConnection.Params.UserName := 'root';
            FDConnection.Params.Password := 'Hagj5633';
            FDConnection.Open;
            ExportTables( AppDatabase, ApplicationTableArray );
            end;

       If   EmpresasCtrl.Checked and not ProcessCanceled
       then try

              For EnterpriseIndex := 1 to DirectorioEmpresaCtrl.Properties.Items.Count - 1 do
                If   ( DirectorioEmpresaCtrl.ItemIndex=0 ) or
                     ( DirectorioEmpresaCtrl.ItemIndex=EnterpriseIndex )
                then begin

                     try

                       DatabaseDirectory := DirectorioEmpresaCtrl.Properties.Items[ EnterpriseIndex ];

                       EnterpriseDatabase.Close;
                       EnterpriseDatabase.AliasPath := ApplicationPath + DatabaseDirectory;
                       EnterpriseDatabase.Open;

                       CurrentDatabaseName := 'gc_' + CodigoCliente + '_data_' + IntToStr( IdEmpresaCtrl.Value );
                       FDConnection.Close;

                       FDConnection.ConnectionString := 'User Id=root;Host=localhost;Database=' + CurrentDatabaseName + ';Character Set=compatibility';
                       FDConnection.DriverName := 'MySQL';
                       FDConnection.Params.Database := CurrentDatabaseName;
                       FDConnection.Params.UserName := 'root';
                       FDConnection.Params.Password := 'Hagj5633';

                       FDConnection.Open;

                       ExportTables( EnterpriseDatabase, EnterpriseTableArray, { TodasLastablas } TablasCtrl.ItemIndex=0, TablasCtrl.ItemIndex - 1 );

                       If   ProcessCanceled
                       then Exit;

                     finally

                       end;

                     end;

            finally
              EnterpriseDatabase.Close;
              end;

     finally
       Working := False;
       end;

end;

end.
