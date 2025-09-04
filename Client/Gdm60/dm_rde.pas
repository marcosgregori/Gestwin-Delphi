unit dm_rde;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, cxEdit,
  AppContainer,

  AppForms,
  DB, nxdb, DataManager,

  Gim30Fields,
  Gim60Fields;


type
  TTipoDocumentoRegistro = ( tdrMovimiento, tdrAlbaranVenta, tdrEfecto, tdrEfectoCobrar );

  TRegistroExportacionModule = class(TDataModule)
    DmRegistroExportacionTable: TnxeTable;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private

    RegistroExportacionFields : TRegistroExportacionFields;

  public
    function ExisteRegistro( TipoDocumentoRegistro : TTipoDocumentoRegistro; Ejercicio : SmallInt; Serie : String; NroDocumento : LongInt; NroRegistro : SmallInt ) : Boolean;
    procedure InsertaRegistro( TipoDocumentoRegistro : TTipoDocumentoRegistro; Ejercicio : SmallInt; Serie : String; NroDocumento : LongInt; NroRegistro : SmallInt );
    procedure SuprimeRegistros;
    
    procedure DoOnUpdateEstadoDocumentoLabel( MovimientoFields : TMovimientoFields; var Caption : String );
    
  end;

var  RegistroExportacionModule: TRegistroExportacionModule = nil;

function  RegistroExportacion : TRegistroExportacionModule;

implementation

uses LibUtils,
     AppManager,

     dm_mov,

     b_msg,

     EnterpriseDataAccess;

{$R *.dfm}

function RegistroExportacion : TRegistroExportacionModule;
begin
     CreateDataModule( TRegistroExportacionModule, RegistroExportacionModule );
     Result := RegistroExportacionModule;
end;

procedure TRegistroExportacionModule.DataModuleCreate(Sender: TObject);
begin
     RegistroExportacionFields := TRegistroExportacionFields.Create( DmRegistroExportacionTable );
end;

procedure TRegistroExportacionModule.DataModuleDestroy(Sender: TObject);
begin
     RegistroExportacionModule := nil;
end;

procedure TRegistroExportacionModule.DoOnUpdateEstadoDocumentoLabel( MovimientoFields : TMovimientoFields; var Caption : String );
begin
     If   ExisteRegistro( tdrMovimiento,  MovimientoFields.Ejercicio.Value, '', MovimientoFields.NroOperacion.Value, 0 )
     then StrAdd( Caption, ' (Enviado)' );
end;

function TRegistroExportacionModule.ExisteRegistro( TipoDocumentoRegistro : TTipoDocumentoRegistro;
                                                    Ejercicio             : SmallInt;
                                                    Serie                 : String;
                                                    NroDocumento          : LongInt;
                                                    NroRegistro           : SmallInt ) : Boolean;
begin
     Result := DmRegistroExportacionTable.FindKey( [ Ord( TipoDocumentoRegistro ), Ejercicio, Serie, NroDocumento, NroRegistro ] );
end;

procedure  TRegistroExportacionModule.InsertaRegistro( TipoDocumentoRegistro : TTipoDocumentoRegistro;
                                                       Ejercicio             : SmallInt;
                                                       Serie                 : String;
                                                       NroDocumento          : LongInt;
                                                       NroRegistro           : SmallInt );
begin
     With DmRegistroExportacionTable do
       begin
       Append;
       RegistroExportacionFields.TipoDocumento.Value := Ord( TipoDocumentoRegistro );
       RegistroExportacionFields.Ejercicio.Value := Ejercicio;
       RegistroExportacionFields.Serie.Value := Serie;
       RegistroExportacionFields.NroDocumento.Value := NroDocumento;
       RegistroExportacionFields.NroRegistro.Value :=  NroRegistro;
       Post;
       end;
end;

procedure TRegistroExportacionModule.SuprimeRegistros;
begin
     DmRegistroExportacionTable.DeleteRecords;
end;

procedure SetupMovimientoModule;
begin
     If   Assigned( MovimientoModule )
     then MovimientoModule.OnUpdateEstadoDocumentoLabel.Add( RegistroExportacion.DoOnUpdateEstadoDocumentoLabel );
end;

initialization
    AddProcedure( imOnCreateComponent, idMovimientoModule, SetupMovimientoModule );
    
end.
