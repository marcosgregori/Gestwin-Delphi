
unit dm_dco;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  cxEdit,

  DB, nxDB,

  LibUtils,

  AppContainer,
  AppForms,
  DataManager,

  Gim10Fields;

type

  TTipoPropietario = ( tdpCliente, tdpProveedor );
  TTipoDocumento = ( tdmNinguno, tdmOfertaPresupuesto, tdmPedido, tdmAlbaran, tdmFactura, tdmTodos );

  TDireccionContactoModule = class(TDataModule)
    DmDireccionContactoTable: TnxeTable;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private

    DmDireccionContactoFields  : TDireccionContactoFields;

  public
    function ObtenDireccionCorreo( TipoPropietario : TTipoPropietario; Codigo : String; TipoDocumento : TTipoDocumento; DireccionDefecto : String ) : String;
    function ObtenDireccionesCorreo( TipoPropietario : TTipoPropietario; Codigo : String; TipoDocumento : TTipoDocumento; Nombre, Direccion : String ) : TStringArray;
  end;

var DireccionContactoModule: TDireccionContactoModule = nil;


function  DireccionContacto : TDireccionContactoModule;

implementation

uses Variants,
     StrUtils,
     EnterpriseDataAccess,
     AppManager,

     cxIndexedComboBox,

     // clTranslator,

     Gim00Fields;

{$R *.DFM}

const  ValuesArray : Array[ 0..4 ] of String = ( 'Ninguno', 'Presupuesto', 'Pedido', 'Albarán', 'Factura' );

function DireccionContacto : TDireccionContactoModule;
begin
     CreateDataModule( TDireccionContactoModule, DireccionContactoModule );
     Result := DireccionContactoModule;
end;

procedure TDireccionContactoModule.DataModuleCreate(Sender: TObject);
begin
     DmDireccionContactoFields := TDireccionContactoFields.Create( DmDireccionContactoTable );
end;

procedure TDireccionContactoModule.DataModuleDestroy( Sender : TObject );
begin
     DireccionContactoModule := nil;
end;

function TDireccionContactoModule.ObtenDireccionCorreo( TipoPropietario  : TTipoPropietario;
                                                        Codigo           : String;
                                                        TipoDocumento    : TTipoDocumento;
                                                        DireccionDefecto : String ): String;
begin
     If   DmDireccionContactoTable.FindKey( [ Ord( TipoPropietario ), Codigo, Ord( TipoDocumento ) ] )
     then Result := DmDireccionContactoFields.Correo.Value
     else Result := DireccionDefecto;
end;

function TDireccionContactoModule.ObtenDireccionesCorreo( TipoPropietario  : TTipoPropietario;
                                                          Codigo           : String;
                                                          TipoDocumento    : TTipoDocumento;
                                                          Nombre,
                                                          Direccion        : String ) : TStringArray;
begin
     Result := [];

     If   Direccion<>''
     then Result := Result + [ StrToUNIFI( Nombre ), Direccion ];

     // Tipo;Codigo;TipoDocumento

     With DmDireccionContactoTable do
       begin
       SetRange( [ Ord( TipoPropietario ), Codigo ] );
       try
         While not Eof do
           begin
           If   ( DmDireccionContactoFields.TipoDocumento.Value=Ord( tdmTodos ) ) or
                ( DmDireccionContactoFields.TipoDocumento.Value=Ord( TipoDocumento ) )
           then Result := Result + [ StrToUNIFI( DmDireccionContactoFields.Nombre.Value ),
                                     DmDireccionContactoFields.Correo.Value ];
           Next;
           end;
       finally
         CancelRange;
         end;
       end;
     
end;

end.
