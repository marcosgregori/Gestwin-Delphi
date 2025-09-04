
unit dm_cls;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, StdCtrls,
  ExtCtrls, Controls, Forms, Dialogs, cxEdit,
  AppContainer,
  cxGridTableView,

  AppForms,
  DB,
  nxdb,

  DataManager,
  ReportManager,

  Gim30Fields;

type  TTarifaClase = ( ttcCompras, ttcVentas );

const tcClaseA = 1;
      tcClaseB = 2;
      tcClaseC = 3;

      // Tipos de recipientes

      trpEnvase     = 0;
      trpContenedor = 1;

      // Tipos de envases

      tenReutilizable = 0;
      tenDesechable   = 1;

type  TNroClase = tcClaseA..tcClaseC;
      TTipoRecipiente = trpEnvase..trpContenedor;
      TTipoEnvase = tenReutilizable..tenDesechable;

      TClaseModule = class(TDataModule)
        DmTarifaClaseTable: TnxeTable;
        DmClaseTable: TnxeTable;
        DmClasesArticuloTable: TnxeTable;
        procedure ClaseModuleCreate(Sender: TObject);
        procedure ClaseModuleDestroy(Sender: TObject);

      private

        DmClaseFields  : TClaseFields;
        DmTarifaClaseFields : TTarifaClaseFields;

        procedure DescripcionClaseVacia( TodasLasClases : Boolean; ClaseCtrl : TcxCustomEdit );

      public

        function ExisteClase( NroClase : TNroClase ) : Boolean; virtual;
        function NombreClase( NroClase : TNroClase; Plural : Boolean = False; Capital  : Boolean = False ) : String;
        function Descripcion( NroClase : TNroClase; Codigo : String; NotificaSiNoExiste : Boolean = True ) : String;
        function Obten( NroClase : TNroClase; Codigo : String; NotificaSiNoExiste : Boolean = False; DatasetFields : TnxeDatasetFields = nil ) : Boolean;
        function ProximoCodigo( NroClase : TNroClase; Codigo : String ) : String;

        procedure SetupEditControls( EditControlClaseA, EditControlClaseB, EditControlClaseC : TcxCustomEdit;LabelLenght : ShortInt = 0; PanelableControl : Boolean = False );
        procedure EnableEditControls( EditControlClaseA, EditControlClaseB, EditControlClaseC : TcxCustomEdit; Enabled : Boolean = True );
        procedure SetupGridColumns( GridColumnClaseA, GridColumnClaseB, GridColumnClaseC : TcxGridColumn; LabelLenght : ShortInt = 0 );

        procedure SetupEditControl( EditControl : TcxCustomEdit; NroClase : TNroClase; LabelLenght : ShortInt = 0; PanelableControl  : Boolean = False );
        procedure SetupGridColumn( GridColumn : TcxGridColumn; NroClase : TNroClase; LabelLenght : ShortInt );

        procedure SetupLabel( ALabel : TLabel; NroClase : TNroClase; LabelLenght : ShortInt );
        procedure SetupLabels( LabelClaseA, LabelClaseB, LabelClaseC : TLabel; LabelLenght : ShortInt );
        procedure Valida( NroClase : TNroClase; TodasLasClases : Boolean; EditControl : TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean; ClaseFields : TClaseFields = nil; IsInfoControl : Boolean = False  );
        procedure ValidaClase( NroClase : TNroClase; TodasLasClases : Boolean; ClaseACtrl, ClaseBCtrl, ClaseCCtrl : TcxCustomEdit; var DisplayValue : Variant; var ErrorText : TCaption; var Error : Boolean; IsInfoControl : Boolean = False );

        function  Selecciona( NroClase : TNroClase; CodigoClaseA, CodigoClaseB, CodigoClaseC  : String ) : String; overload;
        function  Selecciona( NroClase : TNroClase; LineaMovimientoFields : TLineaMovimientoFields ) : String; overload;

        procedure SetReportTitles( Report : TgxReportManager; len : SmallInt = 4 ); overload;
        procedure AddSQLSelect( var SQLSelect : String; DataCodigoClaseA, DataCodigoClaseB, DataCodigoClaseC  : TWideStringField; TodasLasClases : Boolean );

        function CombinacionesClasesArticulo( CodigoArticulo : String ) : Integer;  // De momento solo clases A y B

      end;

var ClaseModule: TClaseModule = nil;

function  Clase : TClaseModule;

procedure ConsultaClases( NroClase        : TNroClase;
                          CodigoArticulo,
                          CodigoClaseA,
                          CodigoClaseB,
                          CodigoClaseC,
                          Propietario     : String;
                          EditControl     : TcxCustomEdit;
                          InitialState    : TQueryGridInitialState = qgsNormal ); overload;

// function  NombreClase( NroClase : TNroClase; Plural, Capital : Boolean ) : String;
function  TextoCortado( St : String; Longitud : SmallInt ) : String;

implementation

uses LibUtils,
     EnterpriseDataAccess,
     AppManager,

     Gdm00Dm,
     Gim00Fields,

     cx_cls1,
     cx_cls2;

{$R *.DFM}

resourceString
  RsTituloClase = 'TituloClase';
  RsClase = 'Clase';
  RsTodas = '<Todas las clases>';
  RsVacia = '<Sin clase asignada>';
  RsMsg1 = 'Debe introducir el c�digo de las clases de articulos previas.';

function Clase : TClaseModule;
begin
     CreateDataModule( TClaseModule, ClaseModule );
     Result := ClaseModule;
end;

procedure TClaseModule.ClaseModuleCreate(Sender: TObject);
begin
     DmClaseFields := TClaseFields.Create( DmClaseTable );
     DmTarifaClaseFields := TTarifaClaseFields.Create( DmTarifaClaseTable );
end;

procedure TClaseModule.ClaseModuleDestroy(Sender: TObject);
begin
     ClaseModule := nil;
end;

{  Solo se tienen en cuenta la clase A y la B }

function TClaseModule.CombinacionesClasesArticulo( CodigoArticulo : String ) : Integer;
begin
     Result := 0;
     If   ExisteClase( tcClaseA )
     then With DmClasesArticuloTable do
            try
              // CodigoArticulo;NroClase;CodigoClase
              SetRange( [ CodigoArticulo, tcClaseA ] );
              Result := RecordCount;
              If   ExisteClase( tcClaseB )
              then begin
                   SetRange( [ CodigoArticulo, tcClaseB ] );
                   Result := Result * RecordCount;
                   end;
            finally
              CancelRange;
              end;
end;

procedure TClaseModule.SetupEditControl( EditControl       : TcxCustomEdit;
                                         NroClase          : TNroClase;
                                         LabelLenght       : ShortInt = 0;
                                         PanelableControl  : Boolean = False );
var PanelContainer : TPanel;

begin
     EditControl.Enabled := ExisteClase( NroClase );

     If   PanelableControl
     then SetupPanelableCtrl( EditControl, EditControl.Enabled );

     If   LabelLenght<>-1
     then If   EditControl.Enabled and Assigned( EditControl.CaptionLabel )
          then If   LabelLenght=0
               then EditControl.CaptionLabel.EditValue := NombreClase( NroClase, False, True )
               else EditControl.CaptionLabel.EditValue := TextoCortado( NombreClase( NroClase, False, True ), LabelLenght );
end;

procedure TClaseModule.SetupGridColumn( GridColumn  : TcxGridColumn;
                                        NroClase    : TNroClase;
                                        LabelLenght : ShortInt );
begin
     With GridColumn do
       begin
       Visible := ExisteClase( NroClase );
       VisibleForCustomization := Visible;
       HeaderHint := NombreClase( NroClase, False, True );
       If   LabelLenght<>-1
       then If   Visible
            then If   LabelLenght=0
                 then Caption := NombreClase( NroClase, False, True )
                 else Caption := TextoCortado( NombreClase( NroClase, False, True ), LabelLenght );
       end;
end;

procedure TClaseModule.EnableEditControls( EditControlClaseA,
                                           EditControlClaseB,
                                           EditControlClaseC : TcxCustomEdit;
                                           Enabled           : Boolean = True );
begin
     EditControlClaseA.Enabled := ExisteClase( tcClaseA ) and Enabled;
     ValidateEditControl( EditControlClaseA );  // Esto sirve para actualizar el contenido y la descripci�n
     EditControlClaseB.Enabled := ExisteClase( tcClaseB ) and Enabled;
     ValidateEditControl( EditControlClaseB );
     EditControlClaseC.Enabled := ExisteClase( tcClaseC ) and Enabled;
     ValidateEditControl( EditControlClaseC );
end;

procedure TClaseModule.SetupEditControls( EditControlClaseA,
                                          EditControlClaseB,
                                          EditControlClaseC : TcxCustomEdit;
                                          LabelLenght       : ShortInt = 0;
                                          PanelableControl  : Boolean = False );
begin
     SetupEditControl( EditControlClaseA, tcClaseA, LabelLenght, PanelableControl );
     SetupEditControl( EditControlClaseB, tcClaseB, LabelLenght, PanelableControl );
     SetupEditControl( EditControlClaseC, tcClaseC, LabelLenght, PanelableControl );
end;

procedure TClaseModule.SetupGridColumns( GridColumnClaseA,
                                         GridColumnClaseB,
                                         GridColumnClaseC  : TcxGridColumn;
                                         LabelLenght       : ShortInt = 0 );
begin
     SetupGridColumn( GridColumnClaseA, tcClaseA, LabelLenght );
     SetupGridColumn( GridColumnClaseB, tcClaseB, LabelLenght );
     SetupGridColumn( GridColumnClaseC, tcClaseC, LabelLenght );
end;

procedure TClaseModule.SetupLabel( ALabel      : TLabel;
                                   NroClase    : TNroClase;
                                   LabelLenght : ShortInt );
begin
     With ALabel do
       begin
       Enabled := ExisteClase( NroClase );
       If   LabelLenght<>-1
       then If   enabled
            then If   LabelLenght=0
                 then caption := NombreClase( NroClase, False, True )
                 else caption := TextoCortado( NombreClase( NroClase, False, True ), LabelLenght );
       end;
end;

procedure TClaseModule.SetupLabels( LabelClaseA,
                                    LabelClaseB,
                                    LabelClaseC   : TLabel;
                                    LabelLenght   : ShortInt );
begin
     SetupLabel( LabelClaseA, tcClaseA, LabelLenght );
     SetupLabel( LabelClaseB, tcClaseB, LabelLenght );
     SetupLabel( LabelClaseC, tcClaseC, LabelLenght );
end;

procedure TClaseModule.SetReportTitles( Report : TgxReportManager;
                                        Len    : SmallInt = 4 );

procedure AjustaMemosClase( NroClase : TNroClase );
begin
     With Report, DataModule00.DmEmpresaFields do
       begin
       SetMemoVisible( RsTituloClase + AnsiChar( 64 + NroClase ), ExisteClase( NroClase ) );
       SetMemoVisible( RsClase + AnsiChar( 64 + NroClase ), ExisteClase( NroClase ) );
       end;
end;

begin
     With Report, DataModule00.DmEmpresaFields do
       begin
       If   Articulo_ExisteClase[ tcClaseA ].Value
       then SetValue( RsTituloClase + 'A', TextoCortado( NombreClase( tcClaseA, False, True ), Len ) );
       AjustaMemosClase( tcClaseA );
       If   Articulo_ExisteClase[ tcClaseB ].Value
       then SetValue( RsTituloClase + 'B', TextoCortado( NombreClase( tcClaseB, False, True ), Len ) );
       AjustaMemosClase( tcClaseB );
       If   Articulo_ExisteClase[ tcClaseC ].Value
       then SetValue( RsTituloClase + 'C', TextoCortado( NombreClase( tcClaseC, False, True ), Len ) );
       AjustaMemosClase( tcClaseC );
       end;
end;

procedure TClaseModule.DescripcionClaseVacia( TodasLasClases : Boolean;
                                              ClaseCtrl      : TcxCustomEdit );
begin
     If   Assigned( ClaseCtrl )
     then With ClaseCtrl do
            If   TodasLasClases
            then Description := RsTodas
            else Description := RsVacia;
end;

procedure TClaseModule.Valida(     NroClase       : TNroClase;
                                   TodasLasClases : Boolean;
                                   EditControl    : TcxCustomEdit;
                               var DisplayValue   : Variant;
                               var ErrorText      : TCaption;
                               var Error          : Boolean;
                                   ClaseFields    : TClaseFields = nil;
                                   IsInfoControl  : Boolean = False );
begin
     If   ValueIsEmpty( DisplayValue )
     then begin
          DescripcionClaseVacia( TodasLasClases, EditControl );
          If   Assigned( ClaseFields )
          then ClaseFields.Clear( DmClaseTable );
          end
     else ValidateRelationEx( EditControl, DmClaseTable, [ NroClase, DisplayValue ], DisplayValue, ErrorText, Error, ClaseFields, RsDescripcion, IsInfoControl );
end;

procedure TClaseModule.ValidaClase(     NroClase       : TNroClase;
                                        TodasLasClases : Boolean;
                                        ClaseACtrl,
                                        ClaseBCtrl,
                                        ClaseCCtrl     : TcxCustomEdit;
                                    var DisplayValue   : Variant;
                                    var ErrorText      : TCaption;
                                    var Error          : Boolean;
                                        IsInfoControl  : Boolean = False );

begin

     If   not ValueIsEmpty( DisplayValue ) and
          ( ( ( NroClase=tcClaseB ) and ValueIsEmpty( ClaseACtrl.EditValue ) ) or
            ( ( NroClase=tcClaseC ) and ValueIsEmpty( ClaseBCtrl.EditValue ) ) )
     then begin
          Error := True;
          ErrorText := RsMsg1;
          end
     else If   ValueIsEmpty( DisplayValue )
          then begin

               Case NroClase of
                 tcClaseA : DescripcionClaseVacia( TodasLasClases, ClaseACtrl );
                 tcClaseB : DescripcionClaseVacia( TodasLasClases, ClaseBCtrl );
                 tcClaseC : DescripcionClaseVacia( TodasLasClases, ClaseCCtrl );
                 end;

               If   NroClase=tcClaseA
               then With ClaseBCtrl do
                      begin
                      PostEditValue( '' );
                      Enabled := False;
                      end;

               If   NroClase in [ tcClaseA, tcClaseB ]
               then With ClaseCCtrl do
                      begin
                      PostEditValue( '' );
                      Enabled := False;
                      end;
               end
          else begin
               Valida( NroClase, TodasLasClases, ClaseACtrl, DisplayValue, ErrorText, Error, nil, IsInfoControl );
               If   NroClase=tcClaseA
               then ClaseBCtrl.Enabled := ExisteClase( tcClaseB )
               else If   NroClase=tcClaseB
                    then ClaseCCtrl.Enabled := ExisteClase( tcClaseC );
               end;
end;

function TClaseModule.Descripcion( NroClase           : TNroClase;
                                   Codigo             : String;
                                   NotificaSiNoExiste : Boolean = True ) : String;
begin
     GetRelationDescription( DmClaseTable, [ Ord( NroClase ), Codigo ], Result, NotificaSiNoExiste, RsDescripcion );
end;

function  TClaseModule.Obten( NroClase : TNroClase; Codigo : String; NotificaSiNoExiste : Boolean = False; DatasetFields : TnxeDatasetFields = nil ) : Boolean;
begin
     Result := DmClaseTable.FindKey( [ Ord( NroClase ), Codigo ] );

     If   NotificaSiNoExiste and not Result
     then begin
          ShowNotification( ntStop, Format( RsMsg1, [ Codigo ] ), '' );
          Abort;
          end;

     If   Assigned( DatasetFields )
     then DatasetFields.Update( DmClaseTable );
end;

procedure TClaseModule.AddSQLSelect( var SQLSelect         : String;
                                         DataCodigoClaseA,
                                         DataCodigoClaseB,
                                         DataCodigoClaseC  : TWideStringField;
                                         TodasLasClases    : Boolean );
begin
     With DataModule00.DmEmpresaFields do
       If   Articulo_ExisteClase[ tcClaseA ].Value
       then begin
            If   not TodasLasClases or ( DataCodigoClaseA.Value<>'' )
            then StrAdd( SQLSelect, ' AND CodigoClaseA=' + QuotedStr( DataCodigoClaseA.Value ) );
            If   Articulo_ExisteClase[ tcClaseB ].Value
            then begin
                 If   not TodasLasClases or ( DataCodigoClaseB.Value<>'' )
                 then StrAdd( SQLSelect, ' AND CodigoClaseB=' + QuotedStr( DataCodigoClaseB.Value ) );
                 If   Articulo_ExisteClase[ tcClaseC ].Value
                 then If   not TodasLasClases or ( DataCodigoClaseC.Value<>'' )
                      then StrAdd( SQLSelect, ' AND CodigoClaseC=' + QuotedStr( DataCodigoClaseC.Value ) );
                 end;
            end;
end;

function TClaseModule.Selecciona( NroClase      : TNroClase;
                                  CodigoClaseA,
                                  CodigoClaseB,
                                  CodigoClaseC  : String ) : String;
begin
     case NroClase of
       tcClaseA : Result := CodigoClaseA;
       tcClaseB : Result := CodigoClaseB;
       tcClaseC : Result := CodigoClaseC;
       else       Result := '';
     end;
end;

function TClaseModule.Selecciona( NroClase              : TNroClase;
                                  LineaMovimientoFields : TLineaMovimientoFields ) : String;
begin
     With LineaMovimientoFields do
       case NroClase of
         tcClaseA : Result := CodigoClaseA.Value;
         tcClaseB : Result := CodigoClaseB.Value;
         tcClaseC : Result := CodigoClaseC.Value;
         else       Result := '';
     end;
end;

function TClaseModule.ProximoCodigo( NroClase : TNroClase;
                                     Codigo   : String ) : String;

procedure CheckRecord;
begin
     If   DmClaseFields.NroClase.Value=NroClase
     then Result := DmClaseFields.Codigo.Value;
end;

procedure SelectFirst;
begin
     With DmClaseTable do
       begin
       FindGreaterOrEqual( [ Ord( NroClase ) ] );
       If   not Eof
       then CheckRecord;
       end;
end;

begin
     With DmClaseTable do
       If   FindKey( [ Ord( NroClase ), Codigo ] )
       then begin
            Next;
            If   Eof
            then SelectFirst
            else CheckRecord;
            end
       else SelectFirst;
     Result := DmClaseFields.Codigo.Value;
end;

function TClaseModule.ExisteClase( NroClase: TNroClase): Boolean;
begin
     Result := DataModule00.DmEmpresaFields.Articulo_ExisteClase[ NroClase ].Value;
end;

function TClaseModule.NombreClase( NroClase : TNroClase;
                                   Plural   : Boolean = False;
                                   Capital  : Boolean = False ) : String;

const TextoClase : String = 'Clase ';

begin
     Result := DataModule00.DmEmpresaFields.Articulo_NombreClase[ NroClase ].Value;
     If   Result=''
     then Result := TextoClase + AnsiChar( 64 + Ord( NroClase ) )
     else Result := Capitaliza( Result, Capital, Plural );
end;

// Otros procedimientos

procedure ConsultaClases( NroClase        : TNroClase;
                          CodigoArticulo,
                          CodigoClaseA,
                          CodigoClaseB,
                          CodigoClaseC,
                          Propietario     : String;
                          EditControl     : TcxCustomEdit;
                          InitialState    : TQueryGridInitialState = qgsNormal );
begin
     If   ShiftKey
     then ConsultaClases1( NroClase, EditControl, InitialState )
     else ConsultaClases2( NroClase, CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, Propietario, EditControl, InitialState );
end;

function NombreClase( NroClase : TNroClase; Plural, Capital : Boolean ) : String;

const TextoClase : String = 'Clase ';

begin
     Result := DataModule00.DmEmpresaFields.Articulo_NombreClase[ NroClase ].Value;
     If   Result=''
     then Result := TextoClase + AnsiChar( 64 + Ord( NroClase ) )
     else Result := Capitaliza( Result, Capital, Plural );
end;

function  TextoCortado( St : String; Longitud : SmallInt ) : String;
begin
     Result := Copy( St, 1, Pred( Longitud ) ) + st_punto;
end;

end.

