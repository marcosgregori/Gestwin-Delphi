
unit dm_cls;

interface

uses
  Windows, Messages, SysUtils, Classes,

  DB,
  nxdb,

  DataManager,
  ServerDataModule,

  Gim30Fields,

  dmi_cls;

type
  TClaseModule = class(TServerDataModule)
    DmTarifaClaseTable: TnxeTable;
    DmClaseTable: TnxeTable;
    procedure ServerDataModuleCreate(Sender: TObject);
    procedure ServerDataModuleDestroy(Sender: TObject);
  private

  public

    DmClaseFields  : TClaseFields;
    DmTarifaClaseFields : TTarifaClaseFields;


    function Descripcion( NroClase : TNroClase; Codigo : String; NotificaSiNoExiste : Boolean = True ) : String;
    function Obten( NroClase : TNroClase; Codigo : String; ClaseFields : TClaseFields = nil ) : Boolean;
    function ProximoCodigo( NroClase : TNroClase; Codigo : String ) : String;

    function ClaseActiva( NroClase : TNroClase ) : Boolean;

    function Selecciona( NroClase : TNroClase; CodigoClaseA, CodigoClaseB, CodigoClaseC  : String ) : String; overload;
    function Selecciona( NroClase : TNroClase; LineaMovimientoFields : TLineaMovimientoFields ) : String; overload;
    function NombreClase( NroClase : TNroClase; Plural, Capital : Boolean ) : String;
  end;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses LibUtils,
     EnterpriseData,
     AppManager,
     SessionData,

     Gsm30Dm,
     Gim00Fields;

{$R *.DFM}

resourceString
  RsTituloClase = 'TituloClase';
  RsClase = 'Clase';
  RsTodas = '<Todas las clases>';
  RsVacia = '<Sin clase asignada>';
  RsMsg1 = 'Debe introducir el código de las clases de articulos previas.';

procedure TClaseModule.ServerDataModuleCreate(Sender: TObject);
begin
     DmClaseFields := TClaseFields.Create( DmClaseTable );
     DmTarifaClaseFields := TTarifaClaseFields.Create( DmTarifaClaseTable );
end;

procedure TClaseModule.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm30.ClaseModule := nil;
end;

function TClaseModule.ClaseActiva( NroClase : TNroClase ) : Boolean;
begin
     Result := SessionDataModule.EmpresaFields.Articulo_ExisteClase[ NroClase ].Value;
end;

function TClaseModule.Descripcion( NroClase           : TNroClase;
                                   Codigo             : String;
                                   NotificaSiNoExiste : Boolean = True ) : String;
begin
     Result := '';
     If   DmClaseTable.FindKey( [ Ord( NroClase ), Codigo ] )
     then Result := DmClaseFields.Descripcion.Value
     else If   NotificaSiNoExiste
          then Result := RsRegistroInexistente;
end;

function  TClaseModule.Obten( NroClase    : TNroClase;
                              Codigo      : String;
                              ClaseFields : TClaseFields = nil ) : Boolean;
begin
     Result := DmClaseTable.FindKey( [ Ord( NroClase ), Codigo ] );
     If   Assigned( ClaseFields )
     then ClaseFields.Update( DmClaseTable );
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

function TClaseModule.NombreClase( NroClase : TNroClase; Plural, Capital : Boolean ) : String;

const TextoClase : String = 'Clase ';

begin
     Result := SessionDataModule.EmpresaFields.Articulo_NombreClase[ NroClase ].Value;
     If   Result=''
     then Result := TextoClase + AnsiChar( 64 + Ord( NroClase ) )
     else Result := Capitaliza( Result, Capital, Plural );
end;

end.

