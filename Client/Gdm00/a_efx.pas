unit a_efx;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls, Buttons, Mask, ExtCtrls, AppContainer, 

  DataManager,
  comCtrls,
  nxsdDataDictionary,
  AppForms, Menus, cxLookAndFeelPainters, cxButtons, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxDBEdit, cxGroupBox, cxRadioGroup,
  cxCheckBox, cxPC, cxGraphics, cxMaskEdit, cxDropDownEdit, DB, nxdb,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxIndexedComboBox, cxSpinEdit, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, cxMemo, cxLookAndFeels, cxLabel, cxPCdxBarPopupMenu,
  cxSplitter, dxmdaset, cxNavigator, dxBarBuiltInMenu,

  GridTableViewController, dxDateRanges,
  cxDataControllerConditionalFormattingRulesManagerDialog,
  dxScrollbarAnnotations, dxShellDialogs;

type
  TMntEfxForm = class(TgxForm)
    keyPanel: TgxEditPanel;
    NroRegistroCtrl: TcxDBTextEdit;
    dataPanel: TgxEditPanel;
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    OpenDialog: TdxOpenFileDialog;
    FicheroCtrl: TcxDBIndexedComboBox;
    PageControl1: TcxPageControl;
    TabSheet1: TcxTabSheet;
    TabSheet2: TcxTabSheet;
    DecimalImplicitoCtrl: TcxDBCheckBox;
    Panel1: TcxGroupBox;
    DescripcionCtrl: TcxDBTextEdit;
    ExaminarButton: TgBitBtn;
    FicheroExternoCtrl: TcxDBTextEdit;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    PruebaButton: TgBitBtn;
    ImportarButton: TgBitBtn;
    actualizarButton: TgBitBtn;
    EstructuraFicheroTable: TnxeTable;
    EstructuraFicheroTableFichero: TSmallintField;
    EstructuraFicheroTableNroRegistro: TSmallintField;
    EstructuraFicheroTableDescripcion: TWideStringField;
    EstructuraFicheroTableFicheroExterno: TWideStringField;
    EstructuraFicheroTableDecimalImplicito: TBooleanField;
    EstructuraFicheroTableFormato: TSmallintField;
    EstructuraFicheroTableSeparador: TWideStringField;
    EstructuraFicheroTableScript: TWideMemoField;
    DataSource: TDataSource;
    LineaEstructFicheroTable: TnxeTable;
    LineaDataSource: TDataSource;
    LineaEstructFicheroTableFichero: TSmallintField;
    LineaEstructFicheroTableNroRegistro: TSmallintField;
    LineaEstructFicheroTableNroLinea: TSmallintField;
    LineaEstructFicheroTableCampo: TWideStringField;
    LineaEstructFicheroTableInicio: TSmallintField;
    LineaEstructFicheroTableLongitud: TSmallintField;
    LineaEstructFicheroTableAutomatico: TBooleanField;
    LineaEstructFicheroTableDecimales: TSmallintField;
    LineaEstructFicheroTableIncluir: TBooleanField;
    LineaEstructFicheroTableTipo: TSmallintField;
    LineaEstructFicheroTableTextoTipo: TWideStringField;
    LineaEstructFicheroTableCampoClave: TBooleanField;
    LineaEstructFicheroTableLongitudCampo: TSmallintField;
    LineaEstructFicheroTablePrueba: TWideStringField;
    LineaEstructFichero1Table: TnxeTable;
    CurrentTable: TnxeTable;
    LineaEstructFicheroTableConstante: TWideStringField;
    LineaEstructFichero1TableFichero: TSmallintField;
    LineaEstructFichero1TableNroRegistro: TSmallintField;
    LineaEstructFichero1TableNroLinea: TSmallintField;
    LineaEstructFichero1TableCampo: TWideStringField;
    LineaEstructFichero1TableInicio: TSmallintField;
    LineaEstructFichero1TableLongitud: TSmallintField;
    LineaEstructFichero1TableConstante: TWideStringField;
    LineaEstructFichero1TableAutomatico: TBooleanField;
    LineaEstructFichero1TableDecimales: TSmallintField;
    LineaEstructFichero1TableIncluir: TBooleanField;
    LineaEstructFichero1TablePrueba: TWideStringField;
    ScriptCtrl: TcxDBMemo;
    codigoCtrlCaption: TcxLabel;
    Label2: TcxLabel;
    Label4: TcxLabel;
    Label3: TcxLabel;
    DescripcionCtrlCaption: TcxLabel;
    cxGroupBox1: TcxGroupBox;
    GridTableViewController: TGridTableViewController;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridViewCampo: TcxGridDBColumn;
    GridViewTipo: TcxGridDBColumn;
    GridViewTextoTipo: TcxGridDBColumn;
    GridViewLogitudCampo: TcxGridDBColumn;
    GridViewIncluir: TcxGridDBColumn;
    GridViewInicio: TcxGridDBColumn;
    GridViewLongitud: TcxGridDBColumn;
    GridViewDecimales: TcxGridDBColumn;
    GridViewConstante: TcxGridDBColumn;
    GridViewAutomatico: TcxGridDBColumn;
    GridViewPrueba: TcxGridDBColumn;
    GridViewCampoClave: TcxGridDBColumn;
    GridLevel: TcxGridLevel;
    RawTableView: TcxGridDBTableView;
    RawLevel: TcxGridLevel;
    RawGrid: TcxGrid;
    Splitter: TcxSplitter;
    RawTableViewCampo: TcxGridDBColumn;
    RawTableViewValor: TcxGridDBColumn;
    MemData: TgxMemData;
    MemDataSource: TDataSource;
    MemDataCampo: TSmallintField;
    MemDataValor: TWideStringField;
    Label1: TcxLabel;
    FormatoCtrl: TcxDBRadioGroup;
    SeparadorCtrl: TcxDBTextEdit;
    procedure EstructuraFicheroTableNewRecord(DataSet: TDataSet);
    procedure EstructuraFicheroTableGetRecord(DataSet: TDataSet);
    procedure FormatoCtrlPropertiesChange(Sender: TObject);
    procedure GridViewInicioPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GridViewLongitudPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure EstructuraFicheroTableUpdateState(DataSet: TDataSet);
    procedure GridViewDecimalesPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure DecimalImplicitoCtrlPropertiesChange(Sender: TObject);
    procedure GridViewCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure FicheroCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure LineaEstructFicheroTableCalcFields(DataSet: TDataSet);
    procedure NroRegistroCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure cxGridDBTableViewConstantePropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure FormManagerDestroyForm;
    procedure ExaminarButtonClick(Sender: TObject);
    procedure PruebaButtonClick(Sender: TObject);
    procedure ImportarButtonClick(Sender: TObject);
    procedure ActualizarButtonClick(Sender: TObject);
    procedure EstructuraFicheroTableAfterPost(DataSet: TDataSet);
    procedure FicheroExternoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormManagerInitializeForm;
  private

    ListaParametros : TStringList;
    LineaPrueba : string;
    CurrentField : TField;

    function CheckCurrentTable : Boolean;
    
    procedure CompletaEstructuraLineas;
    procedure ActualizaEstructuraLineas;
    procedure ExtraeParametrosFichero( PathFichero : String = '' );

  public
    PruebaList : TStringList;
    
  end;

var MntEfxForm: TMntEfxForm = nil;

procedure MntEstructuraFicherosExternos( KeyValues : array of const );

implementation

{$R *.DFM}

uses   Variants,
       nxsdTypes,
       LibUtils,
       DataAccess,
       EnterpriseDataAccess,
       AppManager,

       Gdm00Dm,
       Gdm00Frm,

       dm_efi,
       dm_iex,

       b_msg,
       b_ifx,

       cx_efi;


resourceString
        RsMsg1  = 'El fichero maestro ha sido modificado, y se perderán las definiciones de la plantilla.';
        RsMsg2  = '¿Desea realmente modificar el fichero maestro?.';
        RsMsg3  = 'Longitud del campo incorrecta.';
        RsMsg4  = 'Los campos de fecha solo admiten longitudes de 8 (DD/MM/AA) y 10 (DD/MM/AAAA) caracteres.';
        RsMsg5  = 'Posición de inicio de campo incorrecta.';
        RsMsg6  = 'Introduzca un valor en el campo "Inicio".';
        RsMsg7  = 'Se ha producido un error durante la lectura del fichero externo.';
        RsMsg8  = '(Automático)';
        RsMsg9  = 'Se ha producido un error al interpretar el script.';
        RsMsg10 = 'Esta tabla no existe en su aplicación.';
        RsMsg11 = 'El número de decimales no puede ser mayor que la longitud del campo.';
        RsMsg12 = 'Este campo es clave y no puede ser constante.';
        RsMsg13 = 'La estructura del fichero ha sido actualizada.';
        RsMsg14 = 'No hay cambios en la estructura del fichero.';
        RsMsg15 = 'Mensaje del sistema : %s.';
        RsMsg16 = 'No se ha podido crear la variable del campo %s.';
        RsMsg17 = 'El tipo de dato debe coincidir con el esperado.';

const   FieldTypes : set of TnxFieldType = [ nxtBoolean..nxtTime, nxtWideString, nxtBCD, nxtBoolean, nxtBlobWideMemo ];

procedure MntEstructuraFicherosExternos ( KeyValues : array of const );
begin
     CreateEditForm( TMntEfxForm, MntEfxForm, KeyValues );
end;

procedure TMntEfxForm.EstructuraFicheroTableAfterPost(DataSet: TDataSet);
begin
     CompletaEstructuraLineas;
end;

procedure TMntEfxForm.EstructuraFicheroTableGetRecord(DataSet: TDataSet);
begin
     CheckCurrentTable;
     LineaPrueba := '';
end;

procedure TMntEfxForm.EstructuraFicheroTableNewRecord(DataSet: TDataSet);
begin
     EstructuraFicheroTableFormato.Value := 0;
     EstructuraFicheroTableSeparador.Value := ',';
     EstructuraFicheroTableDecimalImplicito.Value := False;
end;

procedure TMntEfxForm.EstructuraFicheroTableUpdateState(DataSet: TDataSet);
begin
     If   not ( csDestroying in ComponentState )
     then With EstructuraFicheroTable do
            begin
            ImportarButton.Enabled := State=dsBrowse;
            PruebaButton.Enabled := State=dsEdit;
            ActualizarButton.Enabled := State=dsEdit;
            LineaDataSource.Enabled := State<>dsSetKey;

            {
            If   State in [ dsEdit, dsInsert ]
            then With MemData do
                   try
                     DisableControls;
                     DeleteAllRecords;
                   finally
                     EnableControls;
                     end;
            }
            end;
end;

procedure TMntEfxForm.ExaminarButtonClick(Sender: TObject);
begin
     With OpenDialog do
       If   Execute
       then If   Files.Count>0
            then begin
                 EstructuraFicheroTableFicheroExterno.Value := Files[ 0 ];
                 FicheroExternoCtrl.SetFocus;
                 end;
end;

procedure TMntEfxForm.CompletaEstructuraLineas;

var  Index : SmallInt;

begin

     With EstructuraFicheroTable do
       If   State=dsInsert
       then Update;

     With LineaEstructFicheroTable do
       If   RecordCount=0
       then begin

            DisableControls;

            try

              With LineaEstructFicheroTable do
                begin
                SetRange( [ EstructuraFicheroTableFichero.Value, EstructuraFicheroTableNroRegistro.Value, 1 ],
                          [ EstructuraFicheroTableFichero.Value, EstructuraFicheroTableNroRegistro.Value, MaxSmallint ] );
                DeleteRecords;
                end;

              With CurrentTable.DataDictionary.FieldsDescriptor do
                For Index := 0 to FieldCount - 1 do
                  If   FieldDescriptor[ Index ].fdType in FieldTypes
                  then try
                         Append;
                         LineaEstructFicheroTableFichero.Value := EstructuraFicheroTableFichero.Value;
                         LineaEstructFicheroTableNroRegistro.Value := EstructuraFicheroTablenroRegistro.Value;
                         LineaEstructFicheroTableNroLinea.Value := Index + 1;
                         LineaEstructFicheroTableCampo.Value := FieldDescriptor[ Index ].Name;
                         LineaEstructFicheroTableAutomatico.Value := False;
                         LineaEstructFicheroTableIncluir.Value := False;
                         Post;
                       except
                         Cancel;
                         Abort;
                         end;

            finally
              EnableControls;
              end;

            Refresh;
            end;
end;

procedure TMntEfxForm.cxGridDBTableViewConstantePropertiesValidate(     Sender       : TcxCustomEdit;
                                                                    var DisplayValue : Variant;
                                                                    var ErrorText    : TCaption;
                                                                    var Error        : Boolean );
begin
     DisplayValue := Trim( DisplayValue );
     If   not ValueIsEmpty( DisplayValue )
     then {
          If   VarToBoolean( GridViewCampoClave.EditValue, False )
          then begin
               Error := True;
               ErrorText := RsMsg12;
               end
          else }
          begin
          GridViewConstante.EditValue := DisplayValue;
          GridViewInicio.EditValue := 0;
          GridViewLongitud.EditValue := 0;
          end;
end;

procedure TMntEfxForm.GridViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     With AViewInfo do
       If   not Selected
       then If   VarToBoolean( GridRecord.Values[ GridViewCampoClave.Index ], False )
            then ACanvas.Brush.Color:= clRowHighlight
            else If   ( EstructuraFicheroTableFormato.Value=1 ) and not VarToBoolean( GridRecord.Values[ GridViewIncluir.Index ], False )
                 then ACanvas.Brush.Color := cl3DLight;
end;

procedure TMntEfxForm.GridViewDecimalesPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     try
       If   TnxFieldType( GridViewTipo.EditValue )<>nxtDouble
       then DisplayValue := 0
       else If   DisplayValue>=GridViewLongitud.EditValue
            then begin
                 Error := True;
                 ErrorText := RsMsg11;
                 end;
     except on E : Exception do
       begin
       Error := True;
       ErrorText := E.Message;
       end;
     end;

end;

procedure TMntEfxForm.GridViewInicioPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);

var  Inicio : SmallInt;

begin
     Inicio := VarToSmallInt( DisplayValue );
     If   Inicio=0
     then begin
          GridViewLongitud.EditValue := 0;
          GridViewDecimales.EditValue := 0;
          end
     else If   GridViewLongitud.EditValue>0
          then GridViewConstante.EditValue := '';
end;

procedure TMntEfxForm.GridViewLongitudPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

var  Longitud : SmallInt;

begin
     Longitud := VarToSmallInt( DisplayValue );
     If   Longitud>0
     then begin

          case TnxFieldType( GridViewTipo.EditValue ) of
            nxtDate  : If   ( Longitud<>8 ) and
                            ( Longitud<>10 )
                       then begin
                            Error := True;
                            ErrorText := JoinMessage( RsMsg3, RsMsg4 );
                            end;
            end;

         If   GridViewInicio.EditValue>=0
         then begin
              GridViewLongitud.EditValue := Longitud;
              GridViewConstante.EditValue := '';
              end
         else begin
              Error := True;
              ErrorText := JoinMessage( RsMsg5, RsMsg6 );
              end;

         end;
end;

procedure TMntEfxForm.ActualizaEstructuraLineas;

var  Index,
     NroLinea   : smallInt;
     Modificado : boolean;

begin
     With LineaEstructFichero1Table do
       begin

       DisableControls;

       try

         // Primero suprimo posibles campos desaparecidos

         NroLinea := 1;
         Modificado := False;


         SetRange( [ EstructuraFicheroTableFichero.Value, EstructuraFicheroTableNroRegistro.Value, '' ],
                   [ EstructuraFicheroTableFichero.Value, EstructuraFicheroTableNroRegistro.Value, HighStrCode ] );

         First;
         While not Eof do
           begin

           If   CurrentTable.DataDictionary.GetFieldFromName( LineaEstructFichero1TableCampo.Value )=-1
           then begin
                Delete;
                Modificado := True;
                end
           else If   LineaEstructFichero1TableNroLinea.Value>NroLinea
                then NroLinea := LineaEstructFichero1TableNroLinea.Value;

           Next;
           end;

         // Y luego inserto los nuevos

         Inc( NroLinea );

         With CurrentTable.DataDictionary.FieldsDescriptor do
           For Index := 0 to FieldCount - 1 do
             If   FieldDescriptor[ Index ].fdType in FieldTypes
             then If   not FindKey( [ EstructuraFicheroTableFichero.Value, EstructuraFicheroTableNroRegistro.Value, FieldDescriptor[ Index ].Name ] )
                   then begin

                        Modificado := True;

                        Append;

                        LineaEstructFichero1TableFichero.Value := EstructuraFicheroTableFichero.Value;
                        LineaEstructFichero1TableNroRegistro.Value := EstructuraFicheroTableNroRegistro.Value;
                        LineaEstructFichero1TableNroLinea.Value := NroLinea;
                        LineaEstructFichero1TableCampo.Value := FieldDescriptor[ Index ].Name;
                        LineaEstructFichero1TableAutomatico.Value := False;
                        LineaEstructFichero1TableIncluir.Value := True;
                        
                        Post;

                        Inc( NroLinea );
                        end;

       finally
         EnableControls;
         end;

       end;

     If   Modificado
     then ShowNotification( ntWarning, RsMsg13, '' )
     else ShowNotification( ntInformation, RsMsg14, '' );

     EstructuraFicheroTable.Cancel;
     GridView.DataController.UpdateItems( False );

     FormManager.SelectFirstKeyControl;
end;

procedure TMntEfxForm.PruebaButtonClick(Sender: TObject);

var  ExternalFieldIndex : SmallInt;

function CalculaValor( CalcularExpresiones : Boolean ) : Variant;

var  St : String;
     FieldIndex : SmallInt;

begin
     Result := '';
     If   LineaPrueba<>''
     then {
          If   LineaEstructFicheroTableAutomatico.Value
          then Result := RsMsg8
          else }
               If   ( LineaEstructFicheroTableConstante.Value<>'' ) and CalcularExpresiones
               then Result := EstructuraFichero.CalcularExpresion( LineaEstructFicheroTableConstante.Value )
               else If   EstructuraFicheroTableFormato.Value=0
                    then begin
                         If   ( LineaEstructFicheroTableInicio.Value>0 ) and ( LineaEstructFicheroTableLongitud.Value>0 )
                         then begin
                              St := Copy( LineaPrueba, LineaEstructFicheroTableInicio.Value, LineaEstructFicheroTableLongitud.Value );
                              If   EstructuraFicheroTableDecimalImplicito.Value and ( LineaEstructFicheroTableDecimales.Value<>0 )
                              then System.Insert( ',', St, LineaEstructFicheroTableLongitud.Value - LineaEstructFicheroTableDecimales.Value );
                              Result := St;
                              end
                         else Result := EstructuraFichero.TextToVariant( '', TFieldType( LineaEstructFicheroTableTipo.Value ) );
                         end
                    else begin
                         If   LineaEstructFicheroTableInicio.Value<>0
                         then FieldIndex := LineaEstructFicheroTableInicio.Value - 1  // Están numeradas a partir de 1
                         else FieldIndex := ExternalFieldIndex;
                         If   FieldIndex<ListaParametros.Count
                         then Result := EstructuraFichero.TextToVariant( ListaParametros.Strings[ FieldIndex ], TFieldType( LineaEstructFicheroTableTipo.Value ) );
                         end;
end;

procedure AsignaValores;

var  Index : SmallInt;

begin

     With LineaEstructFicheroTable do
       try

         DisableControls;

         EstructuraFichero.FsScript.Clear;

         // Paso 0. Los valores de las columnas (tal cual y solo para ficheros CSV)

         // EstructuraFichero.CreaVariable( 'Campo', ftArray, ListaParametros.ToStringArray );   // Da problemas

         If   EstructuraFicheroTableFormato.Value=1
         then With ListaParametros do
                For Index := 0 to Count - 1 do
                  EstructuraFichero.CreaVariable( 'Columna' + IntToStr( Index + 1 ), ftString, Strings[ Index ] );

         // Paso 1. Los valores directos

         ExternalFieldIndex := 0;
         First;
         While not Eof do
           begin
           CurrentField := CurrentTable.FieldByName( LineaEstructFicheroTableCampo.Value );
           If   Assigned( CurrentField )
           then If   ( ( EstructuraFicheroTableFormato.Value=0 ) and ( LineaEstructFicheroTableInicio.Value>0 ) ) or
                     ( ( EstructuraFicheroTableFormato.Value=1 ) and LineaEstructFicheroTableIncluir.Value )
                then begin
                     try
                       If   LineaEstructFicheroTableConstante.Value=''
                       then EstructuraFichero.CreaVariable( LineaEstructFicheroTableCampo.Value, CurrentField.DataType, CalculaValor( False ) );
                     except
                       ShowNotification( ntStop, Format( RsMsg16, [ LineaEstructFicheroTableCampo.Value ] ), RsMsg17 );
                       Abort;
                       end;
                     Inc( ExternalFieldIndex );
                     end;
           Next;
           end;

         // Paso 2. Los valores calculados

         ExternalFieldIndex := 0;
         First;
         While not Eof do
           begin
           Edit;
           If   ( ( EstructuraFicheroTableFormato.Value=0 ) and ( LineaEstructFicheroTableInicio.Value>0 ) ) or
                     ( ( EstructuraFicheroTableFormato.Value=1 ) and LineaEstructFicheroTableIncluir.Value )
           then begin
                LineaEstructFicheroTablePrueba.Value := CalculaValor( True );
                EstructuraFichero.FsScript.Variables[ LineaEstructFicheroTableCampo.Value ] := LineaEstructFicheroTablePrueba.Value;
                Inc( ExternalFieldIndex );
                end
           else LineaEstructFicheroTablePrueba.Value := '';

           Post;
           Next;
           end;

         // Paso 3. El Script.

         If   not EstructuraFichero.Ejecuta( EstructuraFicheroTableScript.AsString )
         then begin
              ShowNotification( ntStop, RsMsg9, EstructuraFichero.FsScript.ErrorMsg );
              Exit;
              end;

         // Paso 4. El resultado en las variables

         First;
         While not Eof do
           begin

           Edit;

           If   ( ( EstructuraFicheroTableFormato.Value=0 ) and ( LineaEstructFicheroTableInicio.Value>0 ) ) or
                ( ( EstructuraFicheroTableFormato.Value=1 ) and LineaEstructFicheroTableIncluir.Value )
           then LineaEstructFicheroTablePrueba.Value := EstructuraFichero.ObtenValorVariable( LineaEstructFicheroTableCampo.Value )
           else LineaEstructFicheroTablePrueba.Value := '';

           Post;
           Next;
           end;


       finally
         First;
         EnableControls;
         end;

end;

begin
     try
       try
          Screen.Cursor:= crHourGlass;
          ExtraeParametrosFichero;
          AsignaValores;
          LineaEstructFicheroTable.Refresh;
       except on E : Exception do If   not ( E is EAbort )
                                  then ShowNotification( ntInformation, RsMsg7, Format( RsMsg15, [ E.Message ] ) );
         end;
      finally
        Screen.Cursor:= crDefault;
        end;
end;

procedure TMntEfxForm.ExtraeParametrosFichero( PathFichero : String = '' );

var  F : TextFile;
     Cs : Char;

begin
     If   PathFichero=''
     then PathFichero := EstructuraFicheroTableFicheroExterno.Value;
     AssignFile( F, PathFichero );
     try
        Reset( F );
        Readln( F, LineaPrueba );
        If   EstructuraFicheroTableFormato.Value=1
        then begin
             If   Length( EstructuraFicheroTableSeparador.Value )=1
             then Cs := EstructuraFicheroTableSeparador.Value[ 1 ]
             else Cs := ',';
             ExportImport.ExtraeParametros( LineaPrueba, ListaParametros, Cs );
             end;
        finally
          CloseFile( F );
          end;
end;

procedure TMntEfxForm.ImportarButtonClick(Sender: TObject);
begin
     ImportacionFicherosExternos( EstructuraFicheroTableFichero.Value, EstructuraFicheroTableNroRegistro.Value );
end;

procedure TMntEfxForm.LineaEstructFicheroTableCalcFields(DataSet: TDataSet);
begin
     If   CurrentTable.Active
     then begin
          CurrentField := CurrentTable.FindField( LineaEstructFicheroTableCampo.Value );
          If   Assigned( CurrentField )
          then begin
               LineaEstructFicheroTableCampoClave.Value := CurrentTable.IsFieldIndexed( CurrentField );
               LineaEstructFicheroTableTipo.Value := Ord( CurrentField.DataType );
               LineaEstructFicheroTableTextoTipo.Value := GetDataTypeString( CurrentField.DataType );
               LineaEstructFicheroTableLongitudCampo.Value := FieldWidth( CurrentField );
               end;
          end;
end;

procedure TMntEfxForm.NroRegistroCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaEstructuraFicheros( TTipoFicheroEstructura( EstructuraFicheroTableFichero.Value ), Sender, qgsLinked );
end;

function TMntEfxForm.CheckCurrentTable : Boolean;

var  CurrentTableName : String;

begin
     Result := True;
     With CurrentTable do
       begin
       CurrentTableName := EstructuraFichero.ObtenNombreTabla( EstructuraFicheroTableFichero.Value );
       If   CurrentTableName<>TableName
       then begin
            Active := False;
            TableName := CurrentTableName;
            try
              IndexName := '';
              Active := True;
              IndexName := IndexDefs.Items[ 1 ].Name;  // El primer índice despues del secuencial
              LineaEstructFicheroTable.Refresh;
            except
              Result := False;
              end;
            end;
       end;
end;

procedure TMntEfxForm.FicheroCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   not CheckCurrentTable
     then begin
          Error := True;
          ErrorText := RsMsg10;
          end;
end;

procedure TMntEfxForm.FicheroExternoCtrlPropertiesValidate(     Sender        : TcxCustomEdit;
                                                            var DisplayValue  : Variant;
                                                            var ErrorText     : TCaption;
                                                            var Error         : Boolean);

var Index : SmallInt;

begin
     If   FileExists( DisplayValue ) and
          ( EstructuraFicheroTableFormato.Value=1 )
     then begin
          MemData.DisableControls;
          try
            MemData.DeleteAllRecords;
            ExtraeParametrosFichero( DisplayValue );
            With ListaParametros do
              For Index := 0 to ListaParametros.Count - 1 do
                begin
                MemData.Append;
                MemDataCampo.Value := Index + 1;
                MemDataValor.Value := ListaParametros.Strings[ Index ];
                MemData.Post;
                end;
          finally
            MemData.EnableControls;
            end;
          end;
end;

procedure TMntEfxForm.FormatoCtrlPropertiesChange(Sender: TObject);
begin
     If   FormatoCtrl.ItemIndex in [ 0, 1 ]  // Cuando el registro no está todavía cargado puede ser -1
     then begin

          GridViewIncluir.Visible := FormatoCtrl.ItemIndex=1;
          GridViewLongitud.Visible := FormatoCtrl.ItemIndex=0;
          // GridViewInicio.Visible := FormatoCtrl.ItemIndex=0;
          GridViewDecimales.Visible := FormatoCtrl.ItemIndex=0;

          If   FormatoCtrl.ItemIndex=0
          then GridViewInicio.Caption := 'Inicio'
          else GridViewInicio.Caption := 'Columna';

          SeparadorCtrl.Enabled := FormatoCtrl.ItemIndex=1;
          DecimalImplicitoCtrl.Enabled := FormatoCtrl.ItemIndex=0;

          With SeparadorCtrl do
            If   Enabled and ( EditValue='' )
            then EditValue := ',';

          Splitter.Visible := FormatoCtrl.ItemIndex=1;   // El orden es importante para evitar que el Splitter cambie de sitio
          RawGrid.Visible := FormatoCtrl.ItemIndex=1;
          end;
end;

procedure TMntEfxForm.FormManagerDestroyForm;
begin
     ListaParametros.Free;
end;

procedure TMntEfxForm.FormManagerInitializeForm;
begin
     LineaPrueba := '';
     ListaParametros := TStringList.Create;

     EstructuraFichero.ObtenListaFicheros( FicheroCtrl.Properties.Items );

end;

procedure TMntEfxForm.DecimalImplicitoCtrlPropertiesChange(Sender: TObject);
begin
     GridViewDecimales.Visible := DecimalImplicitoCtrl.Checked;
end;

procedure TMntEfxForm.ActualizarButtonClick(Sender: TObject);
begin
     ActualizaEstructuraLineas;
end;

end.
