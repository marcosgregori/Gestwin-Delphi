
unit SectionData;

interface

uses SysUtils,
     Classes,
     Windows,

     DB,
     nxDB,
     nxllTypes,

     AppManager,
     DataManager,
     BaseSessionData,

     nxllComponent;

type
  TTableLocation = ( dlLocal, dlRemote, dlLocalUpdatable );

  TSectionDataModule = class(TDataModule)

  private

    FSessionDataModule  : TBaseSessionDataModule;

    procedure SetSessionDataModule( const Value : TBaseSessionDataModule );

  protected
    FSectionDatabase : TnxDatabase;
  public

    constructor Create( ASessionData : TBaseSessionDataModule ); reintroduce;

    function  ExecSQLCommand( const SQLString : String; RaiseError : Boolean = True; Notify : Boolean = True; ATimeOut : Integer = -1 ) : TnxDynVariantArray;
    function  OpenQuery( SQLString  : String; RaiseError : Boolean = True; Notify : Boolean = True ) : TnxQuery;

    property SessionDataModule : TBaseSessionDataModule read FSessionDataModule write SetSessionDataModule;
    property SectionDatabase : TnxDatabase read FSectionDatabase;
  end;


implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

{$R *.dfm}

uses   Variants,
       LibUtils,

       nxDBBase,

       nxdmServer,
       ServerDataModule;

resourceString

      RsMsg79  = 'Se ha producido un error ejecutando una sentencia SQL.';

constructor TSectionDataModule.Create( ASessionData  : TBaseSessionDataModule );
begin
     inherited Create( nil ); // No le asigno un owner para poder destruirlo manualmente
     FSessionDataModule := ASessionData;
end;

// ExecSQLCommand, solo debe utilizarse para ejecutar comandos, no consultas.
// Hay que usar OpenQuery para las consultas, recordando que se devuelve el Query (TnxQuery) y que está abierto
// para que se pueda consultar cualquier parámetro, como Query.RecordsRead, o el valor de un campo en cualquier registro.

function TSectionDataModule.ExecSQLCommand( const SQLString  : String;
                                                  RaiseError : Boolean = True;
                                                  Notify     : Boolean = True;
                                                  ATimeOut   : Integer = -1 ) : TnxDynVariantArray;
begin
     try
       With TnxeQuery.Create( nil ) do
         try
           Database := SectionDatabase;
           If   ATimeOut=-1
           then TimeOut := GetSQLTimeout
           else TimeOut := ATimeOut;
           SQL.Text := SQLString;
           ExecSql;
           Result := ValuesFromParams( Params );
         finally
           Free;
           end;

     except on E : EnxDatabaseError do
       If   RaiseError
       then raise
       else If   Notify
            then begin
                 FSessionDataModule.SendNotification( ntError, RsMsg79, ExceptionMessage( E ) );
                 Result := VarArrayOf( [ E.ErrorCode, E.ErrorString ] );
                 end;
     else raise;
     end;
end;

function TSectionDataModule.OpenQuery( SQLString  : String;
                                       RaiseError : Boolean = True;
                                       Notify     : Boolean = True ) : TnxQuery;
begin
     Result := TnxQuery.Create( nil );
     try
       With Result do
         try
           Database := SectionDatabase;
           TimeOut := GetSQLTimeOut;
           Sql.Text := SQLString;
           RequestLive := False;
           Open;
         except
           Free;
           raise;
           end;

     except on E : EnxDatabaseError do
       If   RaiseError
       then raise
       else If   Notify
            then begin
                 FSessionDataModule.SendNotification( ntError, RsMsg79,  ExceptionMessage( E ) );
                 Result := nil;
                 end;
       else raise;
       end;

end;

procedure TSectionDataModule.SetSessionDataModule( const Value : TBaseSessionDataModule );
begin
     FSessionDataModule := Value;
end;

end.
