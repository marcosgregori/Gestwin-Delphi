
unit dm_rea207;

interface

uses
  Windows, Messages, SysUtils, Classes,
  DB,
  nxdb,
  DataManager,
  ServerDataModule,

  Gim30Fields,
  Gim207Fields;


type

  TRegistroActualizacionModule = class(TServerDataModule)
    RegistroActualizacionTable: TnxeTable;
    RegistroActualizacionIDTable: TnxeTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private

  public

    RegistroActualizacionFields,
    RegistroActualizacionIDFields : TRegistroActualizacionFields;

    function ObtenId( TipoRegistro : Word; Codigo : String ) : SmallInt;
    function ObtenCodigo( TipoRegistro : Word; Id : SmallInt ) : String;

    procedure Actualiza( TipoRegistro : Word; Codigo : String; ImagenModificada : Boolean = False );

  end;

// Tipo de registro

const rgaGlobal = 0;
      rgaCategoria = 1;
      rgaArticulo  = 2;
      rgaStock = 3;
      rgaCliente = 4;
      rgaCustomerGroup = 5;
      rgaTaxClass = 6;
      rgaTaxRate = 7;
      rgaTaxRule = 8;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses LibUtils,
     Variants,
     AppManager,
     SessionData;

{$R *.DFM}

procedure TRegistroActualizacionModule.DataModuleCreate(Sender: TObject);
begin
     RegistroActualizacionFields := TRegistroActualizacionFields.Create( RegistroActualizacionTable );       // TipoRegistro;Codigo
     RegistroActualizacionIDFields := TRegistroActualizacionFields.Create( RegistroActualizacionIDTable );   // TipoRegistro;ID
end;

procedure TRegistroActualizacionModule.DataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm207.RegistroActualizacionModule := nil;
end;

function TRegistroActualizacionModule.ObtenId( TipoRegistro : Word;
                                               Codigo       : String ) : SmallInt;
begin
     If   RegistroActualizacionTable.FindKey( [ TipoRegistro, Codigo ] )
     then Result := RegistroActualizacionFields.Id.Value
     else Result := 0;
end;

function TRegistroActualizacionModule.ObtenCodigo( TipoRegistro : Word;
                                                   Id           : SmallInt ) : String;
begin
     If   RegistroActualizacionIDTable.FindKey( [ TipoRegistro, Id ] )
     then Result := RegistroActualizacionIDFields.Codigo.Value
     else Result := '';
end;

procedure TRegistroActualizacionModule.Actualiza( TipoRegistro     : Word;
                                                  Codigo           : String;
                                                  ImagenModificada : Boolean = False );
begin
     try

       If   RegistroActualizacionTable.FindKey( [ TipoRegistro, Codigo ] )
       then RegistroActualizacionTable.Edit
       else begin
            RegistroActualizacionTable.Append;
            RegistroActualizacionFields.TipoRegistro.Value := TipoRegistro;
            RegistroActualizacionFields.Codigo.Value := Codigo;
            end;
       If   ImagenModificada
       then RegistroActualizacionFields.ImagenActualizada.Value := False;
       RegistroActualizacionFields.Actualizado.Value := False;
       RegistroActualizacionTable.Post;

     except
       RegistroActualizacionTable.Cancel;
       raise;
       end;

end;

end.
