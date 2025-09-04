
unit b_export;

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
  cxIndexedComboBox, dxSkinsCore, dxSkinsDefaultPainters,
  cxLookAndFeels, cxGroupBox, cxRadioGroup, cxLabel, dxmdaset;


type

    TKeyExportStringFunc = reference to procedure( TableName, KeyFieldName : String );

    TBoxExportForm = class(TgxForm)
    dataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    TablaCtrl: TcxDBComboBox;
    NombreFicheroCtrl: TcxDBTextEdit;
    DirectorioCtrl: TcxDBTextEdit;
    gBitBtn3: TgBitBtn;
    TodasCtrl: TcxDBCheckBox;
    ExportTable: TnxeTable;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataTodasLasTablas: TBooleanField;
    DataDirectorio: TWideStringField;
    DataNombreFichero: TWideStringField;
    DataTabla: TWideStringField;
    EstructuraCtrl: TcxDBCheckBox;
    DataEstructura: TBooleanField;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    FormatoCtrl: TcxRadioGroup;
    Label1: TcxLabel;
    Label2: TcxLabel;
    Label4: TcxLabel;
    Label3: TcxLabel;
    Label5: TcxLabel;
    DataSeparador: TSmallintField;
    SeparadorCtrl: TcxDBIndexedComboBox;
    DataCabecera: TBooleanField;
    CabeceraCtrl: TcxDBCheckBox;
    procedure FormManagerOkButton;
    procedure gBitBtn3Click(Sender: TObject);
    procedure InitializeForm;
    procedure DirectorioCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure TodasCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure TablaCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure FormatoCtrlPropertiesChange(Sender: TObject);
    private
      procedure executeProcess;
      procedure AjustaExtensionFichero;
    protected
    class procedure ExportacionCSV( Sender : TObject );
    public

    end;

var
  BoxExportForm: TBoxExportForm  = nil;

implementation

uses   IOUtils,

       dxBar,

       Files,
       StrUtils,
       LibUtils,
       Generics.Collections,

       AppManager,
       nxsdTypes,
       nxsdDataDictionary,

       DataAccess,
       EnterpriseDataAccess,

       Gdm10Frm,
       Gdm90Frm,

       dm_iex,

       b_msg,
       b_pro,
       b_dir, f_prg;

{$R *.DFM}

resourceString

       rsMsg1  = 'Copiando los registros.';
       rsMsg2  = 'Tabla    : %s.'#13'Fichero : %s';
       rsMsg3  = 'Proceso cancelado por el usuario.';
       rsMsg4  = 'El contenido del fichero destino puede estar incompleto.';

class procedure TBoxExportForm.ExportacionCSV( Sender : TObject );
begin
     CreateEditForm( TBoxExportForm, BoxExportForm, Gds10Frm.ContableSection, True );
end;

procedure TBoxExportForm.InitializeForm;
begin
     GetTableNames( TablaCtrl.Properties.Items, { AddDictionaryName } True );

     // EnterpriseDataModule.UserDatabase.GetTableNames( TablaCtrl.Properties.Items );
     
     TablaCtrl.ItemIndex := 0;
     DataSeparador.Value := 0;
     DataDirectorio.Value := ApplicationPath + 'exports';
end;

procedure TBoxExportForm.TablaCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     DataNombreFichero.Value := TablaCtrl.Text;
     AjustaExtensionFichero;
end;

procedure TBoxExportForm.TodasCtrlPropertiesEditValueChanged( Sender: TObject);
begin
     TablaCtrl.Enabled:= not DataTodasLasTablas.Value;
     NombreFicheroCtrl.Enabled := not DataTodasLasTablas.Value;
end;

procedure SetupExportSection;

var  MenuItem : TmenuItem;

begin
     If   Assigned( Gds90Frm )
     then Gds90Frm.ExportacionFicherosItem.OnClick := TBoxExportForm.ExportacionCSV          
     else If   Assigned( Gds10Frm )
          then With Gds10Frm do
                 begin
                 ExportacionFicherosItem.Visible := ivAlways;
                 ExportacionFicherosItem.OnClick := TBoxExportForm.ExportacionCSV;
                 end;

end;

procedure TBoxExportForm.gBitBtn3Click(Sender: TObject);
begin
     SelectDirectory( DataDirectorio );
end;

procedure TBoxExportForm.FormatoCtrlPropertiesChange(Sender: TObject);
begin

     SeparadorCtrl.Enabled := FormatoCtrl.ItemIndex=0;
     CabeceraCtrl.Enabled := SeparadorCtrl.Enabled;

     If   FormatoCtrl.ItemIndex=2
     then DataEstructura.Value := True;

     AjustaExtensionFichero;

end;

procedure TBoxExportForm.AjustaExtensionFichero;

var FileExt,
    FileSuffix : String;

begin
     FileSuffix := '';
     case FormatoCtrl.ItemIndex of
           0 : FileExt := 'csv';
           1 : FileExt := 'xml';
           2 : begin
               FileExt := 'pas';
               FileSuffix := 'Intf';
               end;
           end;

     If   DataNombreFichero.Value<>''
     then DataNombreFichero.Value := ExtractFileNameWithoutExtension( DataNombreFichero.Value ) + FileSuffix + '.' + FileExt;
end;

procedure TBoxExportForm.FormManagerOkButton;
begin
     CreateProcessForm( ExecuteProcess, Caption );
end;

procedure TBoxExportForm.ExecuteProcess;

type TFieldData = record
       FieldName : String;
       FieldType : TnxFieldType;
       ArrayLow,
       ArrayHigh : SmallInt;
       IsArray,
       IsKey : Boolean;
       end;

var  DictionaryName,
     TableName,
     FileName,
     FileExt,
     FileSuffix,
     // FieldName,
     FieldNames,
     ExportText,
     NameText,
     Suffix  : string;
     ExportStringList : TStringList;
     Index,
     TableIndex : SmallInt;
     TableDatabase : TnxDatabase;
     I : SmallInt;
     CharSeparator : Char;
     ClassGUID : TGuid;
     InxDesc : TnxIndexDescriptor;
     RefKeyDesc : TnxRefKeyDescriptor;
     CompKeyDesc : TnxCompKeyDescriptor;
     {
     KeyFieldName : String;
     KeyFieldNames : TStringArray;
     }
     FieldDataList : TList< TFieldData >;
     FieldData : TFieldData;

function GetFieldTypeString( FieldDescriptor : TnxFieldDescriptor ) : String;
begin
     case FieldDescriptor.fdType of
       nxtBoolean     : Result := 'Boolean' ;
       nxtInt16       : Result := 'SmallInt' ;
       nxtInt32       : Result := 'Integer' ;
       nxtInt64       : Result := 'LargeInt' ;
       nxtAutoInc     : Result := 'AutoInc';
       nxtDouble      : Result := 'Float' ;
       nxtBCD         : Result := 'Decimal';
       nxtDate        : Result := 'Date' ;
       nxtTime        : Result := 'Time' ;
       nxtDateTime    : Result := 'DateTime' ;
       nxtBlob,
       nxtBlobMemo,
       nxtBlobWideMemo: Result := 'Memo';
       nxtBlobGraphic : Result := 'Graphic';
       nxtShortString,
       nxtWideString  : Result := 'String';
       nxtGuid        : Result := 'Guid';
       end;
end;

function GetDataTypeString( FieldDescriptor : TnxFieldDescriptor ) : String;
begin
     case FieldDescriptor.fdType of
       nxtBoolean     : Result := 'Boolean' ;
       nxtInt16       : Result := 'SmallInt' ;
       nxtInt32       : Result := 'Integer' ;
       nxtInt64       : Result := 'LargeInt' ;
       nxtAutoInc     : Result := 'Integer';
       nxtDouble      : Result := 'Double';
       nxtBCD         : Result := 'Decimal';
       nxtDate        : Result := 'Date' ;
       nxtTime        : Result := 'Time' ;
       nxtDateTime    : Result := 'DateTime' ;
       nxtBlob,
       nxtBlobMemo,
       nxtBlobWideMemo: Result := 'WideMemo';
       nxtBlobGraphic : Result := 'Graphic';
       nxtShortString,
       nxtWideString  : Result := 'WideString';
       nxtGuid        : Result := 'Guid';
       end;
end;

function GetReadWriteTypeString( FieldType : TnxFieldType ) : String;
begin
     case FieldType of
       nxtBoolean     : Result := 'Boolean' ;
       nxtInt16       : Result := 'SmallInt' ;
       nxtInt32       : Result := 'Integer' ;
       nxtInt64       : Result := 'LargeInt' ;
       nxtAutoInc     : Result := 'Integer';
       nxtDouble      : Result := 'Double';
       nxtBCD         : Result := 'Decimal';
       nxtDate        : Result := 'TDate' ;
       nxtTime        : Result := 'TTime' ;
       nxtDateTime    : Result := 'TDateTime' ;
       nxtBlob,
       nxtBlobMemo,
       nxtBlobWideMemo: Result := 'TnxMemo';
       nxtBlobGraphic : Result := 'TGraphic';
       nxtShortString,
       nxtWideString  : Result := 'String';
       nxtGuid        : Result := 'Variant';    // Los Guids es conveniente que sean Variant, no TGuid
       end;
end;

function GetFieldTypeName( IsKey : Boolean; FieldType : TnxFieldType ) : String;
begin
     If   IsKey
     then Result := GetReadWriteTypeString( FieldType )
     else Result := 'Variant';
end;

procedure CheckFieldInKey(     AFieldName   : String;
                           out IsKey        : Boolean );
begin
     IsKey := False;
     With ExportTable do
       begin
       InxDesc := TnxIndexDescriptor( _Dictionary.IndicesDescriptor.IndexDescriptor[ _Dictionary.IndicesDescriptor.DefaultIndex ] );
       If   Assigned( InxDesc )
       then If   InxDesc.KeyDescriptor is TnxCompKeyDescriptor
            then begin
                 CompKeyDesc := TnxCompKeyDescriptor( InxDesc.KeyDescriptor );
                 For var Index := 0 to CompKeyDesc.KeyFieldCount - 1 do
                   If   AFieldName=CompKeyDesc.KeyFields[ Index ].Field.Name
                   then begin
                        IsKey := True;
                        Exit;
                        end;
                 end;
       end;
end;

(*

procedure ExportKeyFields( ExportStringFunc : TKeyExportStringFunc );
begin

     With ExportTable do
       begin

       KeyFieldNames := [];

       InxDesc := TnxIndexDescriptor( _Dictionary.IndicesDescriptor.IndexDescriptor[ _Dictionary.IndicesDescriptor.DefaultIndex ] );
       If   Assigned( InxDesc )
       then begin
            If   InxDesc.KeyDescriptor is TnxCompKeyDescriptor
            then begin
                 CompKeyDesc := TnxCompKeyDescriptor( InxDesc.KeyDescriptor );
                 For var Index := 0 to CompKeyDesc.KeyFieldCount - 1 do
                   begin
                   KeyFieldName := CompKeyDesc.KeyFields[ Index ].Field.Name;
                   KeyFieldNames := KeyFieldNames + [ KeyFieldName ];
                   ExportStringFunc( TableName, KeyFieldName );
                   // ExportStringList.Add( '             ' + TableName + 'Fields.' + KeyFieldName + '.Value := F' + KeyFieldName + ';' );
                   end;
                 end
            else If   InxDesc.KeyDescriptor is TnxRefKeyDescriptor
                 then begin
                      {
                      RefKeyDesc := TnxRefKeyDescriptor( InxDesc.KeyDescriptor );
                      KeyFieldName := RefKeyDesc.KeyFields[ Index ].Field.Name;
                      KeyFieldNames := KeyFieldNames + [ KeyFieldName ];
                      ExportStringList.Add( '          ' + TableName + 'Fields.' + KeyFieldName + '.Value := F' + KeyFieldName + ';' );
                      }
                      end;
            end;

       end;

end;

*)

function ExtractAlphaSegment( Value : String  ) : String;
begin
     var StrInx := Value.Length;
     While ( StrInx>0 ) and ( Value[ StrInx ] in [ '0'..'9' ] ) do
       Dec( StrInx );
     Result := Copy( Value, 1, StrInx );
end;

procedure AddSimpleDataField( FieldName : String; FieldType : TnxFieldType );
begin
     FieldData.FieldName := FieldName;
     FieldData.FieldType := FieldType;
     FieldData.ArrayLow := 0;
     FieldData.ArrayHigh := 0;
     FieldData.IsArray := False;
     CheckFieldInKey( FieldName, FieldData.IsKey );
     FieldDataList.Add( FieldData );
end;

begin

     With ProcessFrame do
       try

         AddMsg( ntHeader, RsMsg1 );

         TableIndex := 0;
         FileSuffix := '';

         case FormatoCtrl.ItemIndex of
            0 : FileExt := 'csv';
            1 : FileExt := 'xml';
            2 : begin
                FileExt := 'pas';
                FileSuffix := 'Intf';
                end;
            end;

         repeat

           If   DataTodasLastablas.Value
           then begin

                DictionaryName := StringReplace( TablaCtrl.Properties.Items.Names[ TableIndex ], 'dm', 'Gim', [ rfReplaceAll, rfIgnoreCase] );
                TableName := TablaCtrl.Properties.Items.ValueFromIndex[ TableIndex ];

                If   FormatoCtrl.ItemIndex=2 // Interface
                then begin
                     var DirectoryPath := AddPathDelim( DataDirectorio.Value ) + DictionaryName;
                     CheckDirectory( DirectoryPath, True );
                     FileName  := DirectoryPath + '\' + TableName + FileSuffix + '.' + FileExt;
                     end
                else FileName  := AddPathDelim( DataDirectorio.Value ) + TableName + FileSuffix + '.' + FileExt;

                Inc( TableIndex );
                end
           else begin
                TableName := TablaCtrl.Text;
                FileName  := AddPathDelim( DataDirectorio.Value ) + DataNombreFichero.Value;
                end;

           AddMsg( ntInformation, Format( RsMsg2, [ TableName, FileName ] ) );

           ExportStringList := TStringList.Create;

           try

             TableDatabase := GetTableDatabase( TableName );
             If   Assigned( TableDatabase )
             then begin

                  ExportTable.Database := TableDatabase;
                  ExportTable.TableName := TableName;
                  ExportTable.Open;

                  With ExportTable do
                    If   DataEstructura.Value
                    then begin
                         case FormatoCtrl.ItemIndex of
                           0 : With _Dictionary.FieldsDescriptor do
                                 begin

                                 For Index := 0 to FieldCount - 1 do
                                   begin
                                   NameText := FieldDescriptor[ Index ].Name;
                                   ExportText := NameText + ' : T' + GetFieldTypeString( FieldDescriptor[ Index ] ) + 'Field;';
                                   ExportStringList.Add( ExportText );
                                   end;

                                 ExportStringList.Add( '' );
                                 ExportStringList.Add( '------------------------------------------------------------' );
                                 ExportStringList.Add( '' );

                                 For Index := 0 to FieldCount - 1 do
                                   begin
                                   NameText := FieldDescriptor[ Index ].Name;
                                   ExportText := NameText + ' := ' + GetFieldTypeString( FieldDescriptor[ Index ] ) + 'Field(''' + NameText + ''');';
                                   ExportStringList.Add( ExportText );
                                   end;

                                 end;

                           2 : begin

                               FieldDataList := TList< TFieldData >.Create;

                               try

                                 // Intentado detectar los array de campos a partir de sus nombres

                                 With _Dictionary.FieldsDescriptor do
                                   begin
                                   var FldInx := 0;
                                   While FldInx<FieldCount do
                                     begin

                                     var FieldName := FieldDescriptor[ FldInx ].Name;

                                     If   FieldName[ FieldName.Length ] in [ '0', '1' ]   // Puede ser un array
                                     then begin
                                          var AlphaSegment := ExtractAlphaSegment( FieldName );
                                          If   FldInx<FieldCount
                                          then begin
                                               var ArrayLow := StrToInt( FieldName[ FieldName.Length ] );
                                               var ArrayHigh := 0;
                                               var ArraySize := 0;
                                               var SameType := True;
                                               While SameType and
                                                     ( FldInx + ArraySize + 1<FieldCount ) and
                                                     ( ExtractAlphaSegment( FieldDescriptor[ FldInx + ArraySize + 1 ].Name )=AlphaSegment ) do
                                                 begin
                                                 SameType := SameType and ( FieldDescriptor[ FldInx + ArraySize + 1 ].fdType=FieldDescriptor[ FldInx ].fdType );
                                                 Inc( ArraySize );
                                                 end;
                                               If   SameType and ( ArraySize>1 )                           // Lo es
                                               then begin
                                                    ArrayHigh := ArrayLow + ArraySize;
                                                    FieldData.FieldName := AlphaSegment;
                                                    FieldData.FieldType := FieldDescriptor[ FldInx ].fdType;
                                                    FieldData.ArrayLow := ArrayLow;
                                                    FieldData.ArrayHigh := ArrayHigh;
                                                    FieldData.IsArray := True;
                                                    FieldData.IsKey := False;
                                                    FieldDataList.Add( FieldData );
                                                    FldInx := FldInx + ArraySize;                          // Nos situamos en el campo siguiente
                                                    end
                                               else AddSimpleDataField( FieldName, FieldDescriptor[ FldInx ].fdType );
                                               end;
                                          end
                                     else AddSimpleDataField( FieldName, FieldDescriptor[ FldInx ].fdType );

                                     Inc( FldInx );
                                     end;

                                   end;

                                 ExportStringList.Add( '{$ALIGN OFF}' );
                                 ExportStringList.Add( '{$OPTIMIZATION OFF}' );
                                 ExportStringList.Add( '' );
                                 ExportStringList.Add( 'unit ' + TableName + 'Intf;' );

                                 ExportStringList.Add( '' );

                                 ExportStringList.Add( '{ Este fichero ha sido generado automáticamente desde la utilidad de creación de interfaces' );
                                 ExportStringList.Add( '  de Gestwin (Gestión de tareas->Procesos->Exportacion a ficheros). }' );

                                 ExportStringList.Add( '' );

                                 ExportStringList.Add( 'interface' );
                                 ExportStringList.Add( '' );
                                 ExportStringList.Add( 'uses  SysUtils,' );
                                 ExportStringList.Add( '      Classes,' );
                                 ExportStringList.Add( '' );
                                 ExportStringList.Add( '      LibUtils,' );
                                 ExportStringList.Add( '      DataManager,' );
                                 ExportStringList.Add( '' );
                                 ExportStringList.Add( '      nxllComponent,' );
                                 ExportStringList.Add( '      nxllTypes,' );
                                 ExportStringList.Add( '      nxivTypes,' );
                                 ExportStringList.Add( '      nxrdClass,' );
                                 ExportStringList.Add( '      nxrbTypes,' );
                                 ExportStringList.Add( '      nxsdTypes,' );
                                 ExportStringList.Add( '      nxrbVariantFiler,' );
                                 ExportStringList.Add( '' );
                                 ExportStringList.Add( '      DB,' );
                                 ExportStringList.Add( '      SessionIntf,' );
                                 ExportStringList.Add( '' );
                                 ExportStringList.Add( '      ' + DictionaryName + 'Fields;' );
                                 ExportStringList.Add( '' );
                                 ExportStringList.Add( 'const' );

                                 CreateGuid( ClassGUID );

                                 ExportStringList.Add( '  CLSID_' + TableName + ' : TnxGuid = ''' +  ClassGUID.ToString +  ''';' );
                                 ExportStringList.Add( '' );
                                 ExportStringList.Add( 'type' );
                                 ExportStringList.Add( '' );
                                 ExportStringList.Add( '  I' + TableName + ' = interface( IInvokableRecord )' );

                                 CreateGuid( ClassGUID );

                                 ExportStringList.Add( '    [ ''' + ClassGUID.ToString  + ''' ] ' );
                                 ExportStringList.Add( '' );
                                 ExportStringList.Add( '    procedure ToDataset( ' + TableName + 'Fields : T' + TableName + 'Fields; PreserveState : Boolean = False; ReadBlobs : Boolean = True );' );

                                 ExportStringList.Add( '    function GetRemoteCursorID : TnxCursorID;' );
                                 ExportStringList.Add( '    procedure SetRemoteCursorID( const Value : TnxCursorID );' );

                                 ExportStringList.Add( '    function GetState : TDataSetState;' );
                                 ExportStringList.Add( '    procedure SetState( const Value : TDataSetState );' );

                                 ExportStringList.Add( '' );
                                 ExportStringList.Add( '    // Los campos que forman parte de un índice es conveniente que no sean Variants.' );
                                 ExportStringList.Add( '    // El resto, sin embargo, pueden ser valores nulos, o el campo no estar definido en el dataset.' );
                                 ExportStringList.Add( '' );

                                  For Index := 0 to FieldDataList.Count - 1 do
                                    With FieldDataList[ Index ] do
                                      ExportStringList.Add( '    function Get' + FieldName + IfThen( IsArray, '( Index : SmallInt )', '' ) + ' : ' + GetFieldTypeName( IsKey, FieldType ) + ';' );

                                 ExportStringList.Add( '' );

                                 For Index := 0 to FieldDataList.Count - 1 do
                                   With FieldDataList[ Index ] do
                                     ExportStringList.Add( '    procedure Set' + FieldName + '( ' + IfThen( IsArray, 'Index : SmallInt; ', '' ) + 'const Value  : ' + GetFieldTypeName( IsKey, FieldType ) + ' );' );

                                 ExportStringList.Add( '    property RemoteCursorID : TnxCursorID read GetRemoteCursorID write SetRemoteCursorID;' );
                                 ExportStringList.Add( '    property State : TDatasetState read GetState write SetState;' );

                                 ExportStringList.Add( '' );

                                 For Index := 0 to FieldDataList.Count - 1 do
                                   With FieldDataList[ Index ] do
                                     ExportStringList.Add( '    property ' + FieldName + IfThen( IsArray, '[ Index : SmallInt ]', '' ) + ' : ' + GetFieldTypeName( IsKey, FieldType ) + ' read Get' + FieldName + ' write Set' + FieldName + ';' );

                                 ExportStringList.Add( '' );
                                 ExportStringList.Add( '    end;' );
                                 ExportStringList.Add( '' );

                                 ExportStringList.Add( '   T' + TableName + ' = class( TnxClass, InxRemoteableClass, I' + TableName +')' );
                                 ExportStringList.Add( '     private' );
                                 ExportStringList.Add( '' );
                                 ExportStringList.Add( '     FRemoteCursorID,' );
                                 ExportStringList.Add( '     FState : Variant;' );
                                 ExportStringList.Add( '' );

                                 For Index := 0 to FieldDataList.Count - 1 do
                                   With FieldDataList[ Index ] do
                                     begin
                                     If   ( Index=FieldDataList.Count - 1 ) or ( FieldDataList[ Index + 1 ].IsArray )
                                     then Suffix := ' : Variant;'
                                     else Suffix := ',';
                                     If   IsArray
                                     then ExportStringList.Add( '     F' + FieldName + ' : Array[ ' + IntToStr( ArrayLow ) + '..' + IntToStr( ArrayHigh ) + ' ] of Variant;' )
                                     else ExportStringList.Add( '     F' + FieldName + Suffix );
                                     end;

                                 ExportStringList.Add( '' );

                                 For Index := 0 to FieldDataList.Count - 1 do
                                   With FieldDataList[ Index ] do
                                     ExportStringList.Add( '     function Get' + FieldName + IfThen( IsArray, '( Index : SmallInt )', '' ) + ' : ' + GetFieldTypeName( IsKey, FieldType ) + ';' );

                                 ExportStringList.Add( '' );

                                 For Index := 0 to FieldDataList.Count - 1 do
                                   With FieldDataList[ Index ] do
                                     ExportStringList.Add( '     procedure Set' + FieldName + '( ' + IfThen( IsArray, 'Index : SmallInt; ', '' ) + 'const Value  : ' + GetFieldTypeName( IsKey, FieldType ) + ' );' );

                                 ExportStringList.Add( '' );
                                 ExportStringList.Add( '     function LoadFromReader( AReader : InxReader ) : HRESULT;' );
                                 ExportStringList.Add( '     function SaveToWriter( AWriter : InxWriter ) : HRESULT;' );
                                 ExportStringList.Add( '' );
                                 ExportStringList.Add( '     function GetRemoteCursorID : TnxCursorID;' );
                                 ExportStringList.Add( '     procedure SetRemoteCursorID( const Value : TnxCursorID );' );
                                 ExportStringList.Add( '     function GetState : TDataSetState;' );
                                 ExportStringList.Add( '     procedure SetState( const Value : TDataSetState );' );
                                 ExportStringList.Add( '     function GetClassID : TnxGuid;' );
                                 ExportStringList.Add( '' );
                                  //

                                 ExportStringList.Add( '     public' );
                                 ExportStringList.Add( '' );
                                 ExportStringList.Add( '     constructor Create; reintroduce;' );
                                 ExportStringList.Add( '' );
                                 ExportStringList.Add( '     class function FromDataset( ' + TableName + 'Fields  : T' + TableName + 'Fields; ReadBlobs : Boolean = True; OldValues : Boolean = False ) : I' + TableName + ';' );
                                 ExportStringList.Add( '     procedure ToDataset( ' + TableName + 'Fields : T' + TableName + 'Fields; PreserveState : Boolean = False; ReadBlobs : Boolean = True );' );
                                 ExportStringList.Add( '' );
                                 ExportStringList.Add( '     end;' );
                                 ExportStringList.Add( '' );
                                 ExportStringList.Add( 'implementation' );
                                 ExportStringList.Add( '' );
                                 ExportStringList.Add( 'uses  Variants;' );
                                 ExportStringList.Add( '' );
                                 ExportStringList.Add( '{ T' + TableName + ' }' );
                                 ExportStringList.Add( '' );

                                 {constructor}

                                 ExportStringList.Add( 'constructor T' + TableName + '.Create;' );
                                 ExportStringList.Add( 'begin' );
                                 ExportStringList.Add( '     inherited Create( @CLSID_' + TableName + ', nil, nil, False);' );
                                 ExportStringList.Add( '     FState := dsInsert;' );
                                 ExportStringList.Add( 'end;' );
                                 ExportStringList.Add( '' );

                                 {FromDataset}

                                 ExportStringList.Add( 'class function T' + TableName + '.FromDataset( ' + TableName + 'Fields : T' + TableName + 'Fields; ReadBlobs : Boolean = True; OldValues : Boolean = False ) : I' + TableName + ';' );
                                 ExportStringList.Add( '' );
                                 ExportStringList.Add( 'var   SaveState : TDataSetState;' );
                                 ExportStringList.Add( '      ApplyOldValues : Boolean;' );
                                 ExportStringList.Add( '' );
                                 ExportStringList.Add( 'begin' );
                                 ExportStringList.Add( '      Result := T' + TableName + '.Create;' );
                                 ExportStringList.Add( '' );
                                 ExportStringList.Add( '      With Result do' );
                                 ExportStringList.Add( '        begin' );
                                 ExportStringList.Add( '' );
                                 ExportStringList.Add( '        RemoteCursorID := ' + TableName + 'Fields.GetRemoteCursorID;' );
                                 ExportStringList.Add( '        State := ' + TableName + 'Fields.Dataset.State;' );
                                 ExportStringList.Add( '        SaveState := State;' );
                                 ExportStringList.Add( '' );
                                 ExportStringList.Add( '        ApplyOldValues := OldValues and not ( State in [ dsInsert, dsSetKey ] );' );
                                 ExportStringList.Add( '        If   ApplyOldValues' );
                                 ExportStringList.Add( '        then ' + TableName + 'Fields.IDataset.SetTempState( dsOldValue );' );
                                 ExportStringList.Add( '' );
                                 ExportStringList.Add( '        try' );
                                 ExportStringList.Add( '' );

                                 For Index := 0 to FieldDataList.Count - 1 do
                                   With FieldDataList[ Index ] do
                                     If   IsArray
                                     then begin
                                          ExportStringList.Add( '          For var Inx := ' + IntToStr( ArrayLow ) + ' to ' + IntToStr( ArrayHigh ) + ' do ' );
                                          ExportStringList.Add( '            ' + FieldName + '[ Inx ] := GetFieldAsVariant( ' + TableName + 'Fields.' + FieldName + '[ Inx ] );' );
                                          end
                                     else If   not ( FieldDataList[ Index ].FieldType in [ nxtBlob, nxtBlobMemo, nxtBlobGraphic, nxtBlobWideMemo ] )
                                          then ExportStringList.Add( '          ' + FieldName + ' := GetFieldAsVariant( ' + TableName + 'Fields.' + FieldName + ' );' );

                                 var BlobdsFound := False;

                                 For Index := 0 to FieldDataList.Count - 1 do
                                   With FieldDataList[ Index ] do
                                     If   FieldDataList[ Index ].FieldType in [ nxtBlob, nxtBlobMemo, nxtBlobGraphic, nxtBlobWideMemo ]
                                     then begin
                                          If   not BlobdsFound
                                          then begin
                                               BlobdsFound := True;
                                               ExportStringList.Add( '' );
                                               ExportStringList.Add( '          If   ReadBlobs' );
                                               ExportStringList.Add( '          then begin' );
                                               end;
                                          ExportStringList.Add( '               ' + FieldName + ' := GetFieldAsVariant( ' + TableName + 'Fields.' + FieldName + ' );' );
                                          end;

                                 If   BlobdsFound
                                 then ExportStringList.Add( '               end;' );

                                 ExportStringList.Add( '' );
                                 ExportStringList.Add( '        finally' );
                                 ExportStringList.Add( '          If   ApplyOldValues' );
                                 ExportStringList.Add( '          then ' + TableName + 'Fields.IDataset.RestoreState( SaveState );' );
                                 ExportStringList.Add( '        end;' );
                                 ExportStringList.Add( '      end;' );
                                 ExportStringList.Add( '' );
                                 ExportStringList.Add( 'end;' );
                                 ExportStringList.Add( '' );

                                 {ToDataset}

                                 ExportStringList.Add( 'procedure T' + TableName + '.ToDataset( ' + TableName + 'Fields : T' + TableName + 'Fields; PreserveState : Boolean = False; ReadBlobs : Boolean = True );' );
                                 ExportStringList.Add( 'begin' );
                                 ExportStringList.Add( '     try' );
                                 ExportStringList.Add( '' );
                                 ExportStringList.Add( '       If   not PreserveState' );
                                 ExportStringList.Add( '       then ' + TableName + 'Fields.SetStateFromInterface( FState );' );
                                 ExportStringList.Add( '' );

                                 For Index := 0 to FieldDataList.Count - 1 do
                                   With FieldDataList[ Index ] do
                                     If   IsKey
                                     then ExportStringList.Add( '       ' + TableName + 'Fields.' + FieldName + '.Value := F' + FieldName + ';' );

                                 ExportStringList.Add( '' );

                                 // Fijando los posibles Guids nulos

                                 var FoundGuid := False;

                                 For Index := 0 to FieldDataList.Count - 1 do
                                   With FieldDataList[ Index ] do
                                     If   not IsKey and ( FieldType=nxtGuid )
                                     then begin
                                          FoundGuid := true;
                                          ExportStringList.Add( '       If   VarToStr( F' + FieldName + ' )=''''' );
                                          ExportStringList.Add( '       then F' + FieldName + ' := GetGuid.ToString;' );
                                          end;

                                 If   FoundGuid
                                 then ExportStringList.Add( '' );

                                 For Index := 0 to FieldDataList.Count - 1 do
                                   With FieldDataList[ Index ] do
                                     If   not IsKey
                                     then If   IsArray
                                          then begin
                                               ExportStringList.Add( '       For var Inx := ' + IntToStr( ArrayLow ) + ' to ' + IntToStr( ArrayHigh ) + ' do ' );
                                               ExportStringList.Add( '         SetFieldAsVariant( ' + TableName + 'Fields.' + FieldName + '[ Inx ], F' + FieldName + '[ Inx ] );' );
                                               end
                                          else If   not ( FieldDataList[ Index ].FieldType in [ nxtBlob, nxtBlobMemo, nxtBlobGraphic, nxtBlobWideMemo ] )
                                               then ExportStringList.Add( '       SetFieldAsVariant( ' + TableName + 'Fields.' + FieldName + ', F' + FieldName + ' );' );

                                 BlobdsFound := False;

                                 For Index := 0 to FieldDataList.Count - 1 do
                                   With FieldDataList[ Index ] do
                                     If   not IsKey and ( FieldType in [ nxtBlob, nxtBlobMemo, nxtBlobGraphic, nxtBlobWideMemo ] )
                                     then begin
                                          If   not BlobdsFound
                                          then begin
                                               BlobdsFound := True;
                                               ExportStringList.Add( '' );
                                               ExportStringList.Add( '       If   ReadBlobs' );
                                               ExportStringList.Add( '       then begin' );
                                               end;
                                          ExportStringList.Add( '            SetFieldAsVariant( ' + TableName + 'Fields.' + FieldName + ', F' + FieldName + ' );' );
                                          end;


                                 If   BlobdsFound
                                 then ExportStringList.Add( '            end;' );

                                 ExportStringList.Add( '' );
                                 ExportStringList.Add( '     except' );
                                 ExportStringList.Add( '       ' + TableName + 'Fields.Dataset.Cancel;' );
                                 ExportStringList.Add( '       raise;' );
                                 ExportStringList.Add( '       end;' );
                                 ExportStringList.Add( '' );
                                 ExportStringList.Add( 'end;' );
                                 ExportStringList.Add( '' );

                                 {Reader}

                                 ExportStringList.Add( 'function T' + TableName + '.LoadFromReader( AReader : InxReader ) : HRESULT;' );
                                 ExportStringList.Add( '' );
                                 ExportStringList.Add( 'var VarFlags : TnxVarFlags;' );
                                 ExportStringList.Add( '' );
                                 ExportStringList.Add( 'begin' );

                                 ExportStringList.Add( '     nxReadVariant( VarFlags, FRemoteCursorID, AReader );' );
                                 ExportStringList.Add( '     nxReadVariant( VarFlags, FState, AReader );' );
                                 ExportStringList.Add( '' );

                                 For Index := 0 to FieldDataList.Count - 1 do
                                   With FieldDataList[ Index ] do
                                     If   IsArray
                                     then begin
                                          ExportStringList.Add( '     For var Inx := ' + IntToStr( ArrayLow ) + ' to ' + IntToStr( ArrayHigh ) + ' do ' );
                                          ExportStringList.Add( '       nxReadVariant( VarFlags, F' + FieldName + '[ Inx ], AReader );' );
                                          end
                                     else ExportStringList.Add( '     nxReadVariant( VarFlags, F' + FieldName + ', AReader );' );

                                 ExportStringList.Add( '' );
                                 ExportStringList.Add( '     Result := S_OK;' );
                                 ExportStringList.Add( 'end;' );
                                 ExportStringList.Add( '' );

                                 {Writer}

                                 ExportStringList.Add( 'function T' + TableName + '.SaveToWriter( AWriter : InxWriter) : HRESULT;' );
                                 ExportStringList.Add( 'begin' );

                                 ExportStringList.Add( '     nxWriteVariant( FRemoteCursorID, AWriter );' );
                                 ExportStringList.Add( '     nxWriteVariant( FState, AWriter );' );

                                 ExportStringList.Add( '' );
                                 For Index := 0 to FieldDataList.Count - 1 do
                                   With FieldDataList[ Index ] do
                                     If   IsArray
                                     then begin
                                          ExportStringList.Add( '     For var Inx := ' + IntToStr( ArrayLow ) + ' to ' + IntToStr( ArrayHigh ) + ' do ' );
                                          ExportStringList.Add( '       nxWriteVariant( F' + FieldName + '[ Inx ], AWriter );' );
                                          end
                                     else ExportStringList.Add( '     nxWriteVariant( F' + FieldName + ', AWriter );' );

                                 ExportStringList.Add( '     Result := S_OK;' );
                                 ExportStringList.Add( 'end;' );

                                 {Getters}

                                 ExportStringList.Add( '' );
                                 ExportStringList.Add( '{ Getters}' );
                                 ExportStringList.Add( '' );

                                 ExportStringList.Add( 'function T' + TableName + '.GetClassID: TnxGuid;' );
                                 ExportStringList.Add( 'begin' );
                                 ExportStringList.Add( '     Result := CLSID_' + TableName + ';' );
                                 ExportStringList.Add( 'end;' );
                                 ExportStringList.Add( '' );

                                 ExportStringList.Add( 'function T' + TableName + '.GetRemoteCursorID: TnxCursorID;' );
                                 ExportStringList.Add( 'begin' );
                                 ExportStringList.Add( '     Result := FRemoteCursorID;' );
                                 ExportStringList.Add( 'end;' );
                                 ExportStringList.Add( '' );

                                 ExportStringList.Add( 'function T' + TableName + '.GetState: TDataSetState;' );
                                 ExportStringList.Add( 'begin' );
                                 ExportStringList.Add( '     Result := FState;' );
                                 ExportStringList.Add( 'end;' );
                                 ExportStringList.Add( '' );

                                 For Index := 0 to FieldDataList.Count - 1 do
                                   With FieldDataList[ Index ] do
                                     begin
                                     ExportStringList.Add( '' );
                                     ExportStringList.Add( 'function T' + TableName + '.Get' + FieldName + IfThen( IsArray, '( Index : SmallInt )', '' ) + ' : ' + GetFieldTypeName( IsKey, FieldType ) + ';' );
                                     ExportStringList.Add( 'begin' );
                                     ExportStringList.Add( '     Result := F' + FieldName + IfThen( IsArray, '[ Index ]', '' ) + ';' );
                                     ExportStringList.Add( 'end;' );
                                     end;

                                 {Setters}

                                 ExportStringList.Add( '' );
                                 ExportStringList.Add( '{ Setters}' );
                                 ExportStringList.Add( '' );

                                 ExportStringList.Add( 'procedure T' + TableName + '.SetRemoteCursorID( const Value : TnxCursorID );' );
                                 ExportStringList.Add( 'begin' );
                                 ExportStringList.Add( '     FRemoteCursorID := Value;' );
                                 ExportStringList.Add( 'end;' );
                                 ExportStringList.Add( '' );

                                 ExportStringList.Add( 'procedure T' + TableName + '.SetState( const Value : TDataSetState );' );
                                 ExportStringList.Add( 'begin' );
                                 ExportStringList.Add( '     FState := Value;' );
                                 ExportStringList.Add( 'end;' );
                                 ExportStringList.Add( '' );

                                 For Index := 0 to FieldDataList.Count - 1 do
                                   With FieldDataList[ Index ] do
                                     begin
                                     ExportStringList.Add( '' );
                                     ExportStringList.Add( 'procedure T' + TableName + '.Set' + FieldName + '( ' + IfThen( IsArray, 'Index : SmallInt;', '' ) + ' const Value : ' + GetFieldTypeName( IsKey, FieldType ) + ' );' );
                                     ExportStringList.Add( 'begin' );
                                     ExportStringList.Add( '     F' + FieldName + IfThen( IsArray, '[ Index ]', '' ) + ' := Value;' );
                                     ExportStringList.Add( 'end;' );
                                     end;

                                 ExportStringList.Add( '' );
                                 ExportStringList.Add( 'var ' + TableName + 'Control : InxClassFactoryControl;' );
                                 ExportStringList.Add( '' );
                                 ExportStringList.Add( 'initialization' );
                                 ExportStringList.Add( '   nxInvokeRegistry.RegisterInterface( TypeInfo( I' + TableName + ' ) );' );
                                 ExportStringList.Add( '' );
                                 ExportStringList.Add( '   TnxClassFactory.RegisterClass( CLSID_' + TableName + ', T' + TableName + ', ' + TableName + 'Control );' );
                                 ExportStringList.Add( '' );
                                 ExportStringList.Add( 'end.' );



                               finally
                                 FieldDataList.Free;
                                 end;

                               end;

                           end;

                         end
                    else begin

                         ProgressBar.Properties.Max := RecordCount;

                         case FormatoCtrl.ItemIndex of
                           0 : If   DataCabecera.Value
                               then begin
                                    FieldNames := '';
                                    For I := 0 to FieldCount - 1 do
                                       begin
                                       If   Fields[ I ].DataType<>ftGraphic  // No exporto las imágenes
                                       then begin
                                            If   FieldNames<>''
                                            then FieldNames := FieldNames + ',';
                                            FieldNames := FieldNames + Fields[ I ].FieldName;
                                            end;
                                       end;
                                    ExportStringList.Add( FieldNames );
                                    end;
                           1 : begin
                                ExportStringList.Add( '<?xml version="1.0" standalone="yes"?>' );
                                ExportStringList.Add( '<' + TableName + 's>' );
                               end;

                           end;

                         First;
                         While not Eof and not Canceled do
                           begin
                           case FormatoCtrl.ItemIndex of
                             0 : begin
                                 If   SeparadorCtrl.ItemIndex=2
                                 then CharSeparator := #9
                                 else CharSeparator := SeparadorCtrl.Text[ 1 ];
                                 ExportStringList.Add( ExportImport.ExportRecordToText( ExportTable, CharSeparator, True { PlainText } ) );
                                 end;
                             1 : begin
                                  ExportStringList.Add( '<' + TableName + '>' );
                                 For I := 0 to FieldCount - 1 do
                                    ExportStringList.Add( '<' + Fields[ I ].FieldName + '>' + Fields[ I ].AsString + '</' + Fields[ I ].FieldName + '>' );
                                  ExportStringList.Add( '</' + TableName + '>' );
                                 end;

                             end;
                           With ProgressBar do
                             Position := Position + 1;
                           Application.ProcessMessages;
                           Next;
                           end;

                         If   FormatoCtrl.ItemIndex=1
                         then ExportStringList.Add( '</' + TableName + 's>' );

                         end;
                  end;

             ExportStringList.SaveToFile( FileName, TEncoding.UTF8 );

           finally
             ExportStringList.Free;
             ExportTable.Close;
             end;

         until ( not DataTodasLastablas.Value ) or ( TableIndex>=TablaCtrl.Properties.Items.Count );

       finally
         Enabled := True;

         If   Canceled
         then begin
              AddMsg( ntError, RsMsg3 );
              AddMsg( ntError, RsMsg4 );
              end;

         end;

end;

procedure TBoxExportForm.DirectorioCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   not DirectoryExists( DisplayValue )
     then begin
          Error := True;
          ErrorText := JoinMessage( rsgMsg394, rsgMsg395 );
          end;
end;

initialization
  AddProcedure( imOnEnterpriseAccess, 0, SetupExportSection );

end.
