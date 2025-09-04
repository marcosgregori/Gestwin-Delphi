unit b_ear;

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
  Gim30Fields, dxBarBuiltInMenu, cxCalendar, cxImage, dxUIAClasses;

type
  TBoxEarForm = class(TgxForm)
    FormManager: TgxFormManager;
    Panel2: TgxEditPanel;
    ArticuloTable: TnxeTable;
    CodigoBarrasTable: TnxeTable;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataNroPlantilla: TSmallintField;
    DataClave: TSmallintField;
    DataIVAIncluido: TBooleanField;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataCodigoArticuloInicial: TStringField;
    DataCodigoArticuloFinal: TStringField;
    DataCodigoFamilia: TStringField;
    DataCampoLibre9: TBooleanField;
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
    PathImagenesCtrl: TcxDBTextEdit;
    ExaminarButton: TgBitBtn;
    DataPathDatos: TStringField;
    SeleccionFechaPanel: TcxGroupBox;
    gxRangeBox1: TgxRangeBox;
    gxRangeBox2: TgxRangeBox;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    FechaLabel: TcxLabel;
    FamiliaCtrl: TcxDBTextEdit;
    Label25: TcxLabel;
    descFamiliaLabel: TcxLabel;
    CodigoArticuloInicialCtrl: TcxDBTextEdit;
    CodigoArticuloFinalCtrl: TcxDBTextEdit;
    cxLabel3: TcxLabel;
    Label7: TcxLabel;
    cxLabel4: TcxLabel;
    DescPlantillaLabel: TcxLabel;
    Label2: TcxLabel;
    NroPlantillaCtrl: TcxDBSpinEdit;
    CampoLibre9Panel: TcxGroupBox;
    CampoLibre9Ctrl: TcxDBCheckBox;
    Shape1: TShape;
    cxLabel5: TcxLabel;
    DataTarifa: TStringField;
    gxRangeBox3: TgxRangeBox;
    CodigoArticuloInicialImagenCtrl: TcxDBTextEdit;
    CodigoArticuloFinalImagenCtrl: TcxDBTextEdit;
    cxLabel8: TcxLabel;
    cxLabel9: TcxLabel;
    cxLabel10: TcxLabel;
    Shape2: TShape;
    cxLabel11: TcxLabel;
    cxGroupBox3: TcxGroupBox;
    TarifaCtrl: TcxDBTextEdit;
    Label1: TcxLabel;
    cxLabel6: TcxLabel;
    cxLabel12: TcxLabel;
    Shape3: TShape;
    cxLabel13: TcxLabel;
    PathDatosCtrl: TcxDBTextEdit;
    gBitBtn1: TgBitBtn;
    DataPathImagenes: TStringField;
    ArticuloImage: TcxImage;
    cxGroupBox4: TcxGroupBox;
    procedure FormManagerOkButton;
    procedure FormManagerInitializeForm;
    procedure NroPlantillaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure NroPlantillaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure NroPlantillaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure TarifaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure TarifaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoArticuloCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoArticuloCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure FamiliaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FamiliaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure PathCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure gBitBtn1Click(Sender: TObject);
    procedure PathDatosCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure ExaminarButtonClick(Sender: TObject);
    procedure PathImagenesCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
  private

    ArticuloFields,
    DsArticuloFields : TArticuloFields;

    ReportTitleAdded : Boolean;

    function DoOnValidRecord : Boolean;
    procedure DoBeforeMoveRecordData;

  public

    procedure ExecuteProcess;
  end;

var  BoxEarForm: TBoxEarForm;

procedure ExportacionDatosArticulos( NroPlantilla : SmallInt = 0 );

implementation

{$R *.DFM}

uses   DateUtils,
       LibUtils,

       SBStreams,
       Vcl.Imaging.Jpeg,
       dxGDIPlusClasses,
       
       AppManager,
       EnterpriseDataAccess,

       Gdm00Dm,
       Gdm30Frm,

       dmi_mov,

       b_msg,
       b_pro,

       a_efx,

       dm_efi,
       dm_emp,
       dm_iva,
       dm_reg,
       dm_art,
       dm_fam,
       dm_cdt,

       cx_efi,
       cx_fam,
       cx_art,
       cx_cdt,

       b_dir,
       f_prg;

resourceString
       RsMsg1  = 'Las siguientes líneas de datos no han sido procesadas :';

       RsMsg5  = 'Los datos han sido exportados a [Color=Navy]%s[/Color].';

const
       ncrPathImagenesExportacionArticulos = 'PathImagenesExportacionArticulos';
       ncrPathDatosExportacionArticulos = 'PathDatosExportacionArticulos';

procedure ExportacionDatosArticulos( NroPlantilla : SmallInt = 0 );
begin
     CreateEditForm( TBoxEarForm, BoxEarForm, [ NroPlantilla ], TGds30Frm.AlmacenSection, True );
end;

procedure TBoxEarForm.FamiliaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFamilias( Sender );
end;

procedure TBoxEarForm.FamiliaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Familia.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TBoxEarForm.FormManagerInitializeForm;
begin
     ArticuloFields := TArticuloFields.Create( ArticuloTable );

     DsArticuloFields := TArticuloFields.Create( Self );

     DataNroPlantilla.Value := FormValues[ 0 ];
     DataClave.Value := 0;

     DataFechaInicial.Value := IncYear( ApplicationContainer.TodayDate, -30 );
     DataFechaFinal.Value := ApplicationContainer.LastDayOfYearDate;

     DataPathDatos.Value := Registro.ObtenValorUsuario( ncrPathDatosExportacionArticulos );
     DataPathImagenes.Value := Registro.ObtenValorUsuario( ncrPathImagenesExportacionArticulos );
     DataCodigoArticuloFinal.Value := HighStrCode;

     With DataModule00.DmEmpresaFields do
       begin
       CampoLibre9Panel.Visible :=  not ValueIsEmpty( Articulo_CampoLibre[ 9 ].Value );
       CampoLibre9Ctrl.Caption := Articulo_CampoLibre[ 9 ].Value;
       end;
end;

procedure TBoxEarForm.FormManagerOkButton;
begin
     CreateProcessForm( ExecuteProcess, Caption );
end;

procedure TBoxEarForm.gBitBtn1Click(Sender: TObject);
begin
     SelectDirectory( DataPathDatos );
end;

procedure TBoxEarForm.ExaminarButtonClick(Sender: TObject);
begin
     SelectDirectory( DataPathImagenes );
end;

procedure TBoxEarForm.ExecuteProcess;

Var  PathFichero,
     NombreFichero,
     ExtensionFichero : String;

     Fichero : File;
     FileInfo : TSearchRec;
     GraphicClass: TGraphicClass;
     Dp : SmallInt;

     ImageStream : TElMemoryStream;
     JpegImage : TJpegImage;
     ImageBitmap : TBitmap;
     SmartImage : TdxSmartImage;

function GetImageDataFormatExtension( AImageDataFormat : TdxImageDataFormat ) : string;

// En la versión original al formato ImageMemoryBitmap no se le asigna extensión

const Map: array[TdxImageDataFormat] of string = ('', '.bmp', '.jpg', '.png', '.tif', '.gif', '.emf', '', '.ico', '.bmp', '.wmf');

begin
     Result := Map[ AImageDataFormat ];
end;

begin

     case ProcesoPC.ActivePageIndex of
       0 : With EstructuraFichero do
             try
              ArticuloTable.SetRange( [ DataCodigoArticuloInicial.Value ], [ DataCodigoArticuloFinal.Value ] );

              PathFichero := AddPathDelim( DataPathDatos.Value ) + 'Articulos.csv';

              ExportaDatos(  PathFichero,
                             ArticuloTable,
                             DsArticuloFields,
                             DoOnValidRecord,
                             DoBeforeMoveRecordData );

              ProcessFrame.AddMsg( ntInformation, Format( RsMsg5, [ PathFichero ] ) );
              Registro.GuardaValorUsuario( ncrPathDatosExportacionArticulos, DataPathDatos.Value );
           finally
             DeactivateNotifications;
           end;

       1 :  begin
            PathFichero := AddPathDelim( DataPathImagenes.Value );
            With ArticuloTable do
              begin
              SetRange( [ DataCodigoArticuloInicial.Value ], [ DataCodigoArticuloFinal.Value ] );
              First;
              While not Eof and not ProcessFrame.Canceled do
                begin
                If   not ArticuloFields.Imagen.IsNull
                then begin
                     {
                     ArticuloImage.EditValue := ArticuloFields.Imagen.Value;
                     ExtensionFichero := GraphicExtension( TGraphicClass( ArticuloImage.Picture.Graphic.ClassType ) );
                     NombreFichero := ArticuloFields.Codigo.Value + '.' + ExtensionFichero;
                     ProcessFrame.AddMsg( ntRecordInformation, NombreFichero + ' , ' + ArticuloFields.Descripcion.Value );
                     ArticuloImage.Picture.SaveToFile( PathFichero + NombreFichero );
                     }
                     ImageStream := TElMemoryStream.Create;
                     try
                       SmartImage := TdxSmartImage.Create;
                       try
                         SmartImage.LoadFromFieldValue( ArticuloFields.Imagen.Value );                                                          
                         ProcessFrame.AddMsg( ntRecordInformation, NombreFichero + ' , ' + ArticuloFields.Descripcion.Value );
                         ExtensionFichero := GetImageDataFormatExtension( SmartImage.ImageDataFormat );
                         NombreFichero := ArticuloFields.Codigo.Value + ExtensionFichero;
                         SmartImage.SaveToFile( PathFichero + NombreFichero );
                       finally
                         SmartImage.Free;
                         end;
                           
                     finally
                       ImageStream.Free;
                       end;
                     end;
                Next;
                end;
              end;
            ProcessFrame.AddMsg( ntInformation, Format( RsMsg5, [ PathFichero ] ) );
            Registro.GuardaValorUsuario( ncrPathImagenesExportacionArticulos, DataPathImagenes.Value );
            end;

       end;

end;

procedure TBoxEarForm.CodigoArticuloCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scAmbas, False { IncluirObsoletos }, Sender );
end;

procedure TBoxEarForm.CodigoArticuloCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TBoxEarForm.DoBeforeMoveRecordData;

var  PrecioVenta : Double;
     PuntoVerde,
     RecargoVenta,
     Descuento : Decimal;
     EsUnaOferta : Boolean;

begin
     If   DataTarifa.Value<>''
     then begin
          
          PrecioVenta := 0.0;
          PuntoVerde := 0.0;
          RecargoVenta := 0.0;
          Descuento := 0.0;
          EsUnaOferta := False;

          Articulo.ObtenPrecioyDtoVenta( tmNodefinido,
                                         '',
                                         ArticuloFields.Codigo.Value,
                                         '',
                                         '',
                                         '',
                                         1.0,  // Cantidad
                                         PrecioVenta,
                                         PuntoVerde,
                                         RecargoVenta,
                                         Descuento,
                                         EsUnaOferta,
                                         DataTarifa.Value,
                                         True );

          DsArticuloFields.Precio_Venta.Value:= PrecioVenta;
          DsArticuloFields.Dto_Venta.Value:= Descuento;
          end;
end;

function TBoxEarForm.DoOnValidRecord: Boolean;
begin
     Result := ( DsArticuloFields.FechaAlta.IsNull or ( ( DsArticuloFields.FechaAlta.Value>=DataFechaInicial.Value ) and ( DsArticuloFields.FechaAlta.Value<=DataFechaFinal.Value ) ) ) and
               ( ( DataCodigoFamilia.Value='' ) or ( DsArticuloFields.Familia.Value=DataCodigoFamilia.Value ) ) and
               ( not CampoLibre9Panel.Visible or ( DsArticuloFields.CampoLibre9.Value=DataCampoLibre9.Value ) );
end;

procedure TBoxEarForm.NroPlantillaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntEstructuraFicherosExternos( [ Ord( feArticulo ), Sender.EditingValue ] );
end;

procedure TBoxEarForm.NroPlantillaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaEstructuraFicheros( feArticulo, Sender );
end;

procedure TBoxEarForm.NroPlantillaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     EstructuraFichero.Valida( Sender, Ord( feArticulo ), DisplayValue, ErrorText, Error, False, True { SoloCSV } );
end;

procedure TBoxEarForm.PathCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   not ValueIsEmpty( DisplayValue )
     then If   not DirectoryExists( DisplayValue )
          then begin
               Error := True;
               ErrorText := JoinMessage( RsgMsg394, RsgMsg395 );
               end;
end;

procedure TBoxEarForm.PathDatosCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     SelectDirectory( DataPathDatos );
end;

procedure TBoxEarForm.PathImagenesCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     SelectDirectory( DataPathImagenes );
end;

procedure TBoxEarForm.TarifaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCodigosTarifa( Sender );
end;

procedure TBoxEarForm.TarifaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     CodigoTarifa.Valida( Sender, DisplayValue, ErrorText, Error );
end;

end.



