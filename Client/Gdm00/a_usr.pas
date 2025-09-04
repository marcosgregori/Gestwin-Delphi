unit a_usr;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, AppForms, StdCtrls, Buttons, ExtCtrls, Mask,

  AppContainer,
  ComCtrls,
  cxControls,
  cxContainer,
  cxEdit,
  cxTextEdit,
  cxDBEdit,
  DB,
  nxdb,
  DataAccess,
  DataManager,
  dxmdaset,
  Menus,
  cxLookAndFeelPainters,
  cxButtons, dxSkinsCore, dxSkinsDefaultPainters, cxGraphics, cxMaskEdit,
  cxDropDownEdit, cxCheckBox, dxSkinscxPCPainter, cxPC, cxIndexedComboBox,

  cxLookAndFeels, cxLabel, cxGroupBox, dxGDIPlusClasses,
  cxSpinEdit, cxRadioGroup, cxImage, cxMemo, cxPCdxBarPopupMenu,

  dxBarBuiltInMenu, cxScrollBox, cxFontNameComboBox,
  cxDBFontNameComboBox, System.ImageList, Vcl.ImgList, cxImageList,
  cxImageComboBox, cxTrackBar, cxDBTrackBar, cxButtonEdit,

  Gim00Fields, dxUIAClasses;

type

  TOnCheckStoreUser = procedure ( NombreUsuario, Password : String ) of object;

  TMntUsrForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    KeyPanel: TgxEditPanel;
    CodigoCtrl: TcxDBTextEdit;
    DataPanel: TgxEditPanel;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    UsuarioTable: TnxeTable;
    DataSource: TDataSource;
    Data: TgxMemData;
    MemDataSource: TDataSource;
    DataUserPassword: TWideStringField;
    PageControl: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    Panel1: TcxGroupBox;
    NombreCtrl: TcxDBTextEdit;
    codigoCtrlCaption: TcxLabel;
    Label1: TcxLabel;
    cxGroupBox2: TcxGroupBox;
    Image5: TcxImage;
    EstiloPersonalizadoCtrl: TcxDBCheckBox;
    DecoracionCtrl: TcxDBIndexedComboBox;
    UsarPielesCtrl: TcxDBCheckBox;
    PielCtrl: TcxComboBox;
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    cxGroupBox3: TcxGroupBox;
    cxGroupBox4: TcxGroupBox;
    CodigoEmpresaCtrl: TcxDBTextEdit;
    Label6: TcxLabel;
    Label2: TcxLabel;
    DescEmpresaLabel: TcxLabel;
    VentanaInicioCtrl: TcxDBRadioGroup;
    cxImage1: TcxImage;
    cxScrollBox1: TcxScrollBox;
    cxLabel2: TcxLabel;
    cxLabel4: TcxLabel;
    cxTabSheet2: TcxTabSheet;
    cxGroupBox5: TcxGroupBox;
    Image8: TcxImage;
    SimularTabCtrl: TcxDBCheckBox;
    ConsultasIzquierdaCtrl: TcxDBCheckBox;
    TecladoNumericoCtrl: TcxDBCheckBox;
    PlanificadorCtrl: TcxDBCheckBox;
    BuzonesCorreoCtrl: TcxDBCheckBox;
    FuenteLabel: TcxLabel;
    FuenteAnotacionesCtrl: TcxDBFontNameComboBox;
    TamanoFuenteAnotacionesCtrl: TcxDBComboBox;
    MaximizarVentanasEdicionCtrl: TcxDBCheckBox;
    DesactivarNotificacionesCtrl: TcxDBCheckBox;
    ModoTactilCtrl: TcxDBCheckBox;
    cxLabel13: TcxLabel;
    TamañoModoTactilCtrl: TcxDBSpinEdit;
    AlertasPermanentesCtrl: TcxDBCheckBox;
    cxLabel16: TcxLabel;
    PosicionAlertasCtrl: TcxDBIndexedComboBox;
    cxImage2: TcxImage;
    GestorVentanasTDICtrl: TcxDBCheckBox;
    cxScrollBox3: TcxScrollBox;
    cxDBCheckBox1: TcxDBCheckBox;
    cxLabel5: TcxLabel;
    DisposicionVentanasCtrl: TcxDBImageComboBox;
    ImageList: TcxImageList;
    PaletaCtrl: TcxImageComboBox;
    PaletteImageList: TcxImageList;
    UserPasswordCtrl: TgxDBPasswordEdit;
    TiendaVirtualTabSheet: TcxTabSheet;
    cxGroupBox7: TcxGroupBox;
    cxLabel7: TcxLabel;
    Tienda_NombreUsuarioCtrl: TcxDBTextEdit;
    Tienda_PasswordCtrl: TcxDBTextEdit;
    ComprobarAccesoButton: TgBitBtn;
    cxLabel12: TcxLabel;
    Tienda_AdministradorCtrl: TcxDBCheckBox;
    cxLabel17: TcxLabel;
    ModoRenderizadoCtrl: TcxDBIndexedComboBox;
    ActivarPanelCtrl: TcxDBCheckBox;
    Image1: TcxImage;
    procedure CodigoEmpresaCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure CodigoEmpresaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormManagerInitializeForm;
    procedure UsuarioTableAfterInsert(DataSet: TDataSet);
    procedure UsuarioTableBeforePost(DataSet: TDataSet);
    procedure UsuarioTableAfterEdit(DataSet: TDataSet);
    procedure FormManagerReportRequest;
    function FormManagerDeleteButton: Boolean;
    procedure UsuarioTableCheckUser(DataSet: TDataSet);
    procedure UsuarioTableNewRecord(DataSet: TDataSet);
    procedure UsarPielesCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure UsuarioTableGetRecord(DataSet: TDataSet);
    procedure DecoracionCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure GestorVentanasCtrlClick(Sender: TObject);
    procedure PlanificadorCtrlPropertiesChange(Sender: TObject);
    procedure ModoTactilCtrlPropertiesChange(Sender: TObject);
    procedure GestorVentanasTDICtrlPropertiesChange(Sender: TObject);
    procedure PielCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure ConfigurarCorreoCtrlPropertiesEditValueChanged(
      Sender: TObject);
    procedure ComprobarAccesoButtonClick(Sender: TObject);
    procedure Tienda_AdministradorCtrlPropertiesEditValueChanged(
      Sender: TObject);
    procedure CodigoEmpresaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
  private
    // Password : string;
    FOnCheckStoreUser : TOnCheckStoreUser;
    procedure SetupRecord;
    procedure CheckUser;
    procedure ActualizaEstadoControles;
  public
    UsuarioFields : TUsuarioFields;
    ResetApplication : Boolean;
    function TraduccionPiel( Nombre : String; Original : Boolean ) : String;

    property OnCheckStoreUser : TOnCheckStoreUser read FOnCheckStoreUser write FOnCheckStoreUser;
  end;

var MntUsrForm : TMntUsrForm = nil;

procedure MntUsuarios; overload;
procedure MntUsuarios( KeyValues : array of const ); overload;

const  UltimoNroPiel = 11;
       ListaPieles : array[ 0..UltimoNroPiel, 0..1 ] of String = ( ( DefaultSkinName, DefaultSkinName ),
                                                                   ( 'GestwinWhiteSkin', 'Gestwin blanco' ),
                                                                   ( 'DevExpressDarkStyle', 'Limpio oscuro' ),
                                                                   ( 'DevExpressStyle', 'Limpio claro' ),
                                                                   ( 'Foggy', 'Bruma' ),
                                                                   ( 'Seven', 'Siete' ),
                                                                   ( 'Pumpkin', 'Halloween' ),
                                                                   ( 'Springtime', 'Primavera' ),
                                                                   ( 'Summer2008', 'Verano' ),
                                                                   ( 'Valentine', 'San Valentín' ),
                                                                   ( 'Xmas2008Blue', 'Navidad' ),
                                                                   ( 'Basic', 'Básico' ) );

implementation

{$R *.DFM}

uses   nxllUtils,

       LibUtils,

       AppManager,

       Gdm00Dm,
       Gdm00Frm,

       dmi_pga,

       dm_reg,
       dm_pga,
       dm_emp,
       dm_usr,
       dm_iex,

       a_emp,

       cx_usr,
       cx_emp,

       b_uee,
       b_cda,
       b_msg,

       l_usr;

resourceString
     RsMsg1  = '<Cualquiera>';

     RsMsg4  = 'Solo el usuario maestro puede crear nuevos usuarios o suprimirlos.';
     RsMsg5  = 'Solo puede editar su propia ficha de usuario.';
     RsMsg6  =' Solo el usuario maestro (codigo "00") tiene acceso a las fichas de todos los usuarios.';
     RsMsg7  = 'No puede suprimir el registro del usuario maestro.';
     
var  CodigoUsuarioActivo : String;

procedure MntUsuarios;
begin
     MntUsuarios( [] );
end;

procedure MntUsuarios( KeyValues : array of const );

var  PalabraPaso : String;

begin

     If   Assigned( BoxUeeForm )  // Se está llamando desde b_uee
     then begin
          Usuario.CompruebaPalabraPaso( '00', PalabraPaso );
          CodigoUsuarioActivo := BoxUeeForm.DataCodigoUsuario.Value;
          end
     else CodigoUsuarioActivo := CodigoUsuarioActual;

     CreateEditForm( TMntUsrForm, MntUsrForm, KeyValues );
end;

procedure TMntUsrForm.CodigoEmpresaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntEmpresas( [ Sender.EditingValue ] );
end;

procedure TMntUsrForm.CodigoEmpresaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaEmpresas( Sender );
end;

procedure TMntUsrForm.CodigoEmpresaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
    With Sender do
       If   DisplayValue=''
       then Description := RsMsg1
       else Empresa.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntUsrForm.ComprobarAccesoButtonClick(Sender: TObject);
begin
     If   Assigned( FOnCheckStoreUser )
     then FOnCheckStoreUser( Tienda_NombreUsuarioCtrl.Text, Tienda_PasswordCtrl.Text );
end;

procedure TMntUsrForm.ConfigurarCorreoCtrlPropertiesEditValueChanged( Sender: TObject);
begin

     ActualizaEstadoControles;
end;

procedure TMntUsrForm.ActualizaEstadoControles;

var  ControlsEnabled : Boolean;

begin
     ControlsEnabled := Tienda_AdministradorCtrl.Checked;
     Tienda_NombreUsuarioCtrl.Enabled := ControlsEnabled;
     Tienda_PasswordCtrl.Enabled := ControlsEnabled;
     ComprobarAccesoButton.Enabled := ControlsEnabled;
end;

procedure TMntUsrForm.DecoracionCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     DecoracionCtrl.Enabled := EstiloPersonalizadoCtrl.Checked;
     If   Assigned( UsuarioFields )
     then With UsuarioFields do
            begin
            If   UsuarioTable.Editing
            then If   UsuarioFields.EstiloPersonalizado.Value
                 then SetFieldValue( UsarPieles, False );
            UsarPielesCtrl.Enabled := not EstiloPersonalizado.Value;
            end;
end;

function TMntUsrForm.FormManagerDeleteButton: Boolean;
begin
     CheckUser;
     If   UsuarioFields.Codigo.Value='00'
     then begin
          ShowNotification( ntStop, RsMsg7 );
          Abort;
          end;
     Result := True;
end;

procedure TMntUsrForm.Tienda_AdministradorCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     ActualizaEstadoControles;
end;

function TMntUsrForm.TraduccionPiel( Nombre : String; Original : Boolean ) : String;

var  Index : SmallInt;

begin
     Result := '';
     For Index := 0 to UltimoNroPiel do
       If   Nombre=ListaPieles[ Index, Ord( not Original ) ]
       then begin
            Result := ListaPieles[ Index, Ord( Original ) ];
            Exit;
            end;
end;

procedure TMntUsrForm.FormManagerInitializeForm;

var Index : SmallInt;
    // ExtendedStylePainters : TcxExtendedStylePainters;

begin

     ID := idMntUsrForm;

     UsuarioFields := TUsuarioFields.Create( UsuarioTable );
     Data.Append;

     {
     ExtendedStylePainters := GetExtendedStylePainters;
     If   Assigned( ExtendedStylePainters )
     then With ExtendedStylePainters do
            For Index := 0 to Count - 1 do
              PielCtrl.Properties.Items.Add( TraduccionPiel( Names[ Index ], True ) );
     }

     For Index := 0 to UltimoNroPiel do
       PielCtrl.Properties.Items.Add( ListaPieles[ Index, 1 ] );

     // El número de la sección es el tag del ConfigurationSection situado en cada módulo GdmXXFrm de la aplicación

     With VentanaInicioCtrl.Properties, ApplicationContainer do
       begin
       Items[ 1 ].Enabled := SectionExists( 1 );    // Asientos
       Items[ 2 ].Enabled := SectionExists( 2 );    // Facturas emitidas
       Items[ 3 ].Enabled := Items[ 2 ].Enabled;    // Facturas recibidas
       Items[ 4 ].Enabled := SectionExists( 3 );    // Efectos a cobrar
       Items[ 5 ].Enabled := Items[ 4 ].Enabled;    // Efectos a pagar
       Items[ 6 ].Enabled := Items[ 4 ].Enabled;    // Remesas
       Items[ 7 ].Enabled := SectionExists( 6 );    // Pedido de compra
       Items[ 8 ].Enabled := Items[ 7 ].Enabled;    // Albarán de compra
       Items[ 9 ].Enabled := SectionExists( 7 );    // Presupuestos
       Items[ 10 ].Enabled := Items[ 9 ].Enabled;   // Pedido de venta
       Items[ 11 ].Enabled := Items[ 10 ].Enabled;  // Albarán de venta
       Items[ 12 ].Enabled := SectionExists( 9 );   // Movimiento de almacén
       Items[ 13 ].Enabled := SectionExists( 5 );   // Tickets
       end;

     TiendaVirtualTabSheet.TabVisible := DataModule00.TiendaVirtual;

     ActivarPanelCtrl.Enabled := ProgramNumber in [ pnDesarrollo, pnContable, pnContableComercial, pnProduccion ];

end;

procedure TMntUsrForm.FormManagerReportRequest;
begin
     ListadoUsuarios;
end;

procedure TMntUsrForm.GestorVentanasCtrlClick(Sender: TObject);
begin
     MaximizarVentanasEdicionCtrl.Enabled := GestorVentanasTDICtrl.Checked;
end;

procedure TMntUsrForm.GestorVentanasTDICtrlPropertiesChange(Sender: TObject);
begin
     MaximizarVentanasEdicionCtrl.Enabled := not GestorVentanasTDICtrl.Checked;
     DisposicionVentanasCtrl.Enabled := not GestorVentanasTDICtrl.Checked;
end;

procedure TMntUsrForm.ModoTactilCtrlPropertiesChange(Sender: TObject);
begin
     TamañoModoTactilCtrl.Enabled := ModoTactilCtrl.Checked;
end;

procedure TMntUsrForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaUsuarios( Sender, qgsLinked );
end;

procedure TMntUsrForm.PielCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     PaletaCtrl.Enabled := PielCtrl.Enabled and ( PielCtrl.Text=DefaultSkinName );
end;

procedure TMntUsrForm.PlanificadorCtrlPropertiesChange(Sender: TObject);
begin
     With DesactivarNotificacionesCtrl do
       begin
       Enabled := PlanificadorCtrl.Checked;
       If   not Enabled
       then Checked := False;
       end;
end;

procedure TMntUsrForm.UsarPielesCtrlPropertiesEditValueChanged(Sender: TObject);
begin

     PielCtrl.Enabled := UsarPielesCtrl.Checked;

     PielCtrlPropertiesEditValueChanged( nil );

     If   PielCtrl.Enabled and UsarPielesCtrl.Editing
     then begin
          PielCtrl.Text := UsuarioFields.NombrePiel.Value;
          If   PielCtrl.ItemIndex=-1
          then PielCtrl.Text := DefaultSkinName;
          end;

     If   Assigned( UsuarioFields )
     then With UsuarioFields do
            begin
            If   UsuarioTable.Editing
            then If   UsarPieles.Value
                 then SetFieldValue( EstiloPersonalizado, False );  // Solo si es diferente
            EstiloPersonalizadoCtrl.Enabled := not UsarPieles.Value;
            end;
end;

procedure TMntUsrForm.UsuarioTableAfterEdit(DataSet: TDataSet);

var  PalabraPaso : String;

begin
     If   ( CodigoUsuarioActivo<>'00' ) and ( CodigoUsuarioActivo<>UsuarioFields.Codigo.Value )
     then begin
          ShowNotification( ntStop, RsMsg5, RsMsg6 );
          Abort;
          end;

     If   ( UsuarioFields.Password.Value<>0 ) and ( CodigoUsuarioActivo<>'00' )
     then If   not CheckPassword( UsuarioFields, PalabraPaso )
          then Abort;

     SetupRecord;
end;

procedure TMntUsrForm.UsuarioTableAfterInsert(DataSet: TDataSet);

var   Index  : SmallInt;

begin

     For Index := UsuarioFields.AcGC.Index to UsuarioFields.AcEdicionInformes.Index do
       UsuarioTable.Fields[ index ].Value := 1;

     UsuarioFields.AcGCProcesos.Value  := 0;
     UsuarioFields.AcCOProcesos.Value  := 0;
     UsuarioFields.AcVEProcesos.Value  := 0;
     UsuarioFields.AcALProcesos.Value  := 0;
     UsuarioFields.AcGPProcesos.Value  := 0;

     //* 04.06.2002  Añadidos los procesos críticos

     UsuarioFields.AcProcesosCriticos.Value := 0;

     SetupRecord;
end;

procedure TMntUsrForm.SetupRecord;
begin
     CodigoEmpresaCtrl.Enabled := UsuarioFields.Codigo.Value<>'00';
     // La clave no se puede leer y modificar desde el registro. Solo se puede cambiar
     If   UsuarioFields.Password.Value=0
     then DataUserPassword.Value := ''
     else DataUserPassword.Value := StrConst( 10 );
     UserPasswordCtrl.Reset;
end;

procedure TMntUsrForm.CheckUser;
begin
     If   CodigoUsuarioActivo<>'00'
     then begin
          ShowNotification( ntStop, RsMsg4 );
          Abort;
          end;
end;

procedure TMntUsrForm.UsuarioTableCheckUser(DataSet: TDataSet);
begin
     CheckUser;
end;

procedure TMntUsrForm.UsuarioTableGetRecord(DataSet: TDataSet);

var  PuertoSMTP,
     PuertoPOP3IMAP : SmallInt;

function GetImageComboBoxIndex( Value : String ) : SmallInt;
begin
     Result := -1;
     For var Inx : SmallInt := 0 to PaletaCtrl.Properties.Items.Count - 1 do
       If   PaletaCtrl.Properties.Items[ Inx ].Value=Value
       then begin
            Result := Inx;
            Exit;
            end
end;

begin
     If   Assigned( UsuarioFields )
     then With UsuarioFields do
            begin

            SetupRecord;

            If   NombrePiel.Value=''
            then PielCtrl.ItemIndex := 0
            else PielCtrl.Text := TraduccionPiel( NombrePiel.Value, True );  // Se guarda el nombre original del Skin en Inglés

            If   NombrePaleta.Value=''
            then PaletaCtrl.ItemIndex := 0
            else PaletaCtrl.ItemIndex := GetImageComboBoxIndex( NombrePaleta.Value );

            ActualizaEstadoControles;
            end;
end;

procedure TMntUsrForm.UsuarioTableNewRecord(DataSet: TDataSet);
begin
     With UsuarioFields do
       begin
       EstiloPersonalizado.Value := False;
       BordesRectos.Value := False;
       Decoracion.Value := Ord( cxDefaultLookAndFeelKind );
       UsarPieles.Value := True;
       NombrePiel.Value := DefaultSkinName;
       NombrePaleta.Value := DefaultSkinPaletteName;
       VentanaInicio.Value := 0;
       SimularTab.Value := False;
       GestorVentanasTDI.Value := ProgramNumber=6;  // Preventa
       Planificador.Value := True;
       MaximizarVentanasEdicion.Value := True;
       TamanoModoTactil.Value := 28;
       FuenteAnotaciones.Value := AppManager.FuenteAnotaciones;
       TamanoFuenteAnotaciones.Value := AppManager.TamañoFuenteAnotaciones;
       end;
end;

procedure TMntUsrForm.UsuarioTableBeforePost(DataSet: TDataSet);
begin

     UsuarioFields.NombrePiel.Value := TraduccionPiel( PielCtrl.Text, False );
     If   ( PielCtrl.Text=DefaultSkinName ) and ( PaletaCtrl.ItemIndex>=0 )
     then UsuarioFields.NombrePaleta.Value := PaletaCtrl.Properties.Items[ PaletaCtrl.ItemIndex ].Value
     else UsuarioFields.NombrePaleta.Value := '';

     If   UserPasswordCtrl.EditModified
     then If   Trim( DataUserPassword.Value )=''
          then UsuarioFields.Password.Value := 0
          else UsuarioFields.Password.Value := nxCalcShStrELFHash( DataUserPassword.Value );
end;

procedure Initialize;
begin
     ApplicationContainer.OnEdicionUsuarios := MntUsuarios;
end;

initialization
   AddProcedure( imInitialize, 0, Initialize );

end.
