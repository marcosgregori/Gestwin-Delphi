unit b_iar;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Mask,

  AppContainer,

  Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb,
  DataManager, dxmdaset, cxGraphics, cxCheckBox, cxDBEdit, cxDropDownEdit,
  cxIndexedComboBox, cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxSpinEdit, AppForms,

  dxSkinsCore, cxLookAndFeels, dxSkinsDefaultPainters, cxLabel, cxGroupBox,
  cxPCdxBarPopupMenu, cxPC,

  Gim10Fields,
  Gim30Fields, dxBarBuiltInMenu, dxShellDialogs, dxUIAClasses;

type
  TBoxIarForm = class(TgxForm)
    FormManager: TgxFormManager;
    Panel2: TgxEditPanel;
    NroPlantillaCtrl: TcxDBSpinEdit;
    ClaveCtrl: TcxDBIndexedComboBox;
    IVAIncluidoCtrl: TcxDBCheckBox;
    ArticuloTable: TnxeTable;
    CodigoBarrasTable: TnxeTable;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataNroPlantilla: TSmallintField;
    DataClave: TSmallintField;
    DataIVAIncluido: TBooleanField;
    Label2: TcxLabel;
    DescPlantillaLabel: TcxLabel;
    Label1: TcxLabel;
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    ProcesoPC: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    cxTabSheet2: TcxTabSheet;
    cxGroupBox2: TcxGroupBox;
    cxLabel2: TcxLabel;
    Label3: TcxLabel;
    PathCtrl: TcxDBTextEdit;
    ExaminarButton: TgBitBtn;
    DataPathImagenes: TStringField;
    DataInsertar: TBooleanField;
    CrearRegistrosCtrl: TcxDBCheckBox;
    cxLabel13: TcxLabel;
    PathDatosCtrl: TcxDBTextEdit;
    ExaminarPathDatosBtn: TgBitBtn;
    cxLabel5: TcxLabel;
    Shape1: TShape;
    DataPathDatos: TStringField;
    OpenDialog: TdxOpenFileDialog;
    cxLabel3: TcxLabel;
    cxGroupBox3: TcxGroupBox;
    cxGroupBox4: TcxGroupBox;
    procedure FormManagerOkButton;
    procedure FormManagerInitializeForm;
    procedure NroPlantillaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure NroPlantillaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure NroPlantillaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ExaminarButtonClick(Sender: TObject);
    procedure PathDatosCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure PathCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure PathCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure ExaminarPathDatosBtnClick(Sender: TObject);
    procedure PathDatosCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
  private

    ArticuloFields : TArticuloFields;
    CodigoBarrasFields : TCodigoBarrasFields;
    TiposIVAFields : TTiposIVAFields;

    ReportTitleAdded,
    IncluyePrecioCompra,
    IncluyePrecioVenta : Boolean;
    CodigoBarrasOriginal : String;

    procedure DoBeforeMoveExternData;
    procedure DoBeforePostRecord;
    procedure LineProcessed( ValidRecord, Modified : Boolean; DataLine : string );
    procedure SeleccionaFicheroDatos;
    
  public
  
    procedure ExecuteProcess;
  end;

var  BoxIarForm: TBoxIarForm;

procedure ActualizacionDatosArticulos( NroPlantilla : SmallInt = 0 );

implementation

{$R *.DFM}

uses   LibUtils,
       AppManager,
       EnterpriseDataAccess,

       Gdm00Dm,
       Gdm30Frm,

       b_msg,
       b_pro,

       a_efx,

       dm_efi,
       dm_emp,
       dm_iva,
       dm_reg,

       cx_efi,

       b_dir,
       f_prg;

resourceString
       RsMsg1  = 'Las siguientes líneas de datos no han sido procesadas :';
       RsMsg2  = 'El artículo de código [%s] no existe. No se ha importado la imagen.';
       RsMsg3  = 'No se ha podido guardar la imagen [%s] en la ficha del artículo.';
       RsMsg4  = 'No se encontrado ningún fichero.';
       RsMsg5  = 'El fichero no existe.';
       RsMsg6  = 'Utilice el botón [Examinar] o pulse [F4] para seleccionar un fichero.';

const
       ncrPathDatosActualizacionArticulos = 'PathDatosActualizacionArticulos';
       ncrPathImagenesActualizacionArticulos = 'PathImagenesActualizacionArticulos';

procedure ActualizacionDatosArticulos( NroPlantilla : SmallInt = 0 );
begin
     CreateEditForm( TBoxIarForm, BoxIarForm, [ NroPlantilla ], TGds30Frm.AlmacenSection, True );
end;

procedure TBoxIarForm.FormManagerInitializeForm;
begin
     ArticuloFields := TArticuloFields.Create( ArticuloTable );
     CodigoBarrasFields := TCodigoBarrasFields.Create( CodigoBarrasTable );

     TiposIVAFields := TTiposIVAFields.Create( Self );

     DataNroPlantilla.Value := FormValues[ 0 ];
     DataClave.Value := 0;

     DataPathDatos.Value := Registro.ObtenValorUsuario( ncrPathDatosActualizacionArticulos );
     DataPathImagenes.Value := Registro.ObtenValorUsuario( ncrPathImagenesActualizacionArticulos );
end;

procedure TBoxIarForm.FormManagerOkButton;
begin
     CreateProcessForm( ExecuteProcess, Caption );
end;

procedure TBoxIarForm.ExaminarButtonClick(Sender: TObject);
begin
     SelectDirectory( DataPathImagenes );
end;

procedure TBoxIarForm.ExaminarPathDatosBtnClick(Sender: TObject);
begin
     SeleccionaFicheroDatos;
end;

procedure TBoxIarForm.SeleccionaFicheroDatos;
begin
     With OpenDialog do
       If   Execute
       then If   Files.Count>0
            then begin
                 DataPathDatos.Value := Files[ 0 ];
                 PathDatosCtrl.SetFocus;
                 end;
end;

procedure TBoxIarForm.ExecuteProcess;

Var  FilePath,
     FileName,
     FileExt : String;
     Fichero : File;
     FileInfo : TSearchRec;
     GraphicClass: TGraphicClass;
     Dp : SmallInt;
     ExternField : TExternField;

begin

     case ProcesoPC.ActivePageIndex of
       0 : With EstructuraFichero do
             try

              With ArticuloTable do
                begin
                If   DataClave.value=0
                then IndexFieldNames := 'Codigo'
                else IndexFieldNames := 'CodigoBarras';
                end;

              InicializaEstructuraDatos( ArticuloTable, nil, DataPathDatos.Value );

              IncluyePrecioCompra := FieldExists( 'Precio_Compra', ExternField );
              IncluyePrecioVenta  := FieldExists( 'Precio_Venta', ExternField );

              ImportaDatos( DataPathDatos.Value, ArticuloTable, False, DataInsertar.Value, True, nil, DoBeforeMoveExternData, DoBeforePostRecord, LineProcessed );

              ShowNotifications;

              Registro.GuardaValorUsuario( ncrPathDatosActualizacionArticulos, DataPathDatos.Value );

           finally
             DeactivateNotifications;
           end;

       1 :  begin
            FilePath := AddPathDelim( DataPathImagenes.Value );
            If   SysUtils.FindFirst( FilePath + '*.*', faArchive, FileInfo )=0
            then try
                   repeat
                     If   ( ( FileInfo.Attr and faDirectory )=0 ) and
                          ( FileInfo.Size>0 )
                     then begin
                          FileExt := ExtractFileExt( FileInfo.Name );
                          FileName := FileInfo.Name;
                          Dp := Pos( '.', FileName );
                          If   Dp>0
                          then FileName := Copy( FileInfo.Name, 1, Dp - 1 );
                          Delete( FileExt, 1, 1);
                          If    ArticuloTable.FindKey( [ FileName ] )
                          then try
                                  ArticuloTable.Edit;
                                  ArticuloFields.Imagen.LoadFromFile( FilePath + FileInfo.Name );
                                  ArticuloTable.Post;
                                  ProcessFrame.AddMsg( ntInformation, FileInfo.Name );
                               except
                                 ArticuloTable.Cancel;
                                 ProcessFrame.AddMsg( ntWarning, Format( RsMsg3, [ FileInfo.Name ] ) );
                                 end
                          else ProcessFrame.AddMsg( ntWarning, Format( RsMsg2, [ FileName ] ) );
                          end;
                   until SysUtils.FindNext( FileInfo )<>0;
                 finally
                   SysUtils.FindClose( FileInfo );
                   end
            else ProcessFrame.AddMsg( ntError, RsMsg4 );

            Registro.GuardaValorUsuario( ncrPathImagenesActualizacionArticulos, DataPathImagenes.Value );

            end;

       end;

end;

procedure TBoxIarForm.DoBeforeMoveExternData;
begin
     CodigoBarrasOriginal := ArticuloFields.CodigoBarras.Value;
end;

procedure TBoxIarForm.DoBeforePostRecord;
begin
     If   ProcesoPC.ActivePageIndex=0  // Solo en la importación desde plantillas
     then With ArticuloFields do
            begin

	       If   DataIVAIncluido.Value
	       then begin

	            // Los precios se guardan internamente sin redondear para obtener la máxima
	            // precision posible.

	            Tasa.TipoIVA( ApplicationContainer.TodayDate, TipoIVA.Value, TiposIVAFields );

	            If   IncluyePrecioCompra
	            then begin
	                 If   Precio_Compra.Value<>0.0
	                 then Precio_Compra.Value := Precio_Compra.Value / ( 1 + ( TiposIVAFields.IVASoportado.Value / 100.0 ) );
	                 end;
	            If   incluyePrecioVenta
	            then begin
	                 If   Precio_Venta.Value<>0.0
	                 then Precio_Venta.Value := Precio_Venta.Value / ( 1 + ( TiposIVAFields.IVARepercutido.Value / 100.0 ) );
	                 end;
                 
	            end;

	       //* 20.05.2002  Teniendo en cuenta el nuevo fichero de codigos de barras

	       If   ( CodigoBarrasOriginal<>'' ) and ( CodigoBarrasOriginal<>CodigoBarras.Value )
	       then begin

	            If   not CodigoBarrasTable.FindKey( [ CodigoBarras.Value ] )
	            then begin

	                 // E inserto un nuevo registro de codigo de barras

	                 CodigoBarrasTable.Append;

	                 CodigoBarrasFields.CodigoBarras.Value   := CodigoBarras.Value;
	                 CodigoBarrasFields.CodigoArticulo.Value := Codigo.Value;

	                 CodigoBarrasTable.Post;
	                 end;

	            // Dejo el campo CodigoBarras del artículo tal y como estaba

	            CodigoBarras.Value := CodigoBarrasOriginal;

	            end;
	       end;
end;

procedure TBoxIarForm.LineProcessed( ValidRecord,
                                     Modified     : Boolean;
                                     DataLine     : String );
begin
     If   ValidRecord
     then If   not Modified
          then begin
               If   not ReportTitleAdded
               then begin
                    ReportTitleAdded := True;
                    AddNotification( rgGroupInfo, RsMsg1 );
                    end;
               AddNotification( rgWarningInfo, DataLine );
               end;
end;

procedure TBoxIarForm.NroPlantillaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntEstructuraFicherosExternos( [ Ord( feArticulo ), Sender.EditingValue ] );
end;

procedure TBoxIarForm.NroPlantillaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaEstructuraFicheros( feArticulo, Sender );
end;

procedure TBoxIarForm.NroPlantillaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     EstructuraFichero.Valida( Sender, Ord( feArticulo ), DisplayValue, ErrorText, Error );
end;

procedure TBoxIarForm.PathCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     SelectDirectory( DataPathImagenes );
end;

procedure TBoxIarForm.PathDatosCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     SeleccionaFicheroDatos;
end;

procedure TBoxIarForm.PathDatosCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   not ValueIsEmpty( DisplayValue )
     then If   not FileExists( DisplayValue )
          then begin
               Error := True;
               ErrorText := JoinMessage( RsMsg6, RsMsg6 );
               end;
end;

procedure TBoxIarForm.PathCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   not ValueIsEmpty( DisplayValue )
     then If   not DirectoryExists( DisplayValue )
          then begin
               Error := True;
               ErrorText := JoinMessage( RsgMsg394, RsgMsg395 );
               end;
end;

end.
