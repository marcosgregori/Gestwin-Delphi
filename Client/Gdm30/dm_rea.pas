
unit dm_rea;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, cxEdit,

  AppContainer,


  AppForms,
  DB,
  nxdb,
  DataManager,

  Gim30Fields;

type

  // Tipo de registro

  TRegistroActualizacionModule = class(TDataModule)
    DmRegistroActualizacionTable: TnxeTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private

    FRegistroActualizacionFields : TRegistroActualizacionFields;

  public


    function Obten( TipoRegistro : Word; Codigo : String ) : Boolean; overload;
    function Obten( TipoRegistro : Word; Codigo : String; out RegistroActualizacionFields : TRegistroActualizacionFields ) : Boolean; overload;

    function Edita( TipoRegistro : Word; Codigo : String ) : TRegistroActualizacionFields;
    procedure Actualizado( TipoRegistro : Word; Codigo : String; Valor : Boolean );
    function ExisteTipo(TipoRegistro: Word): Boolean;

    property RegistroActualizacionFields : TRegistroActualizacionFields read FRegistroActualizacionFields;
  end;

var RegistroActualizacionModule: TRegistroActualizacionModule = nil;

function RegistroActualizacion : TRegistroActualizacionModule;

implementation

uses  LibUtils,
      AppManager,
      EnterpriseDataAccess,

      b_msg;

{$R *.DFM}

function RegistroActualizacion : TRegistroActualizacionModule;
begin
     CreateDataModule( TRegistroActualizacionModule, RegistroActualizacionModule );
     Result := RegistroActualizacionModule;
end;

procedure TRegistroActualizacionModule.DataModuleCreate(Sender: TObject);
begin
     FRegistroActualizacionFields := TRegistroActualizacionFields.Create( DmRegistroActualizacionTable );
end;

procedure TRegistroActualizacionModule.DataModuleDestroy(Sender: TObject);
begin
     RegistroActualizacionModule := nil;
end;

function TRegistroActualizacionModule.ExisteTipo( TipoRegistro : Word ) : Boolean;
begin
     try
       DmRegistroActualizacionTable.SetRange( [ TipoRegistro ] );
       Result := DmRegistroActualizacionTable.RecordCount>0;
     finally
       DmRegistroActualizacionTable.CancelRange;
       end;
end;

function TRegistroActualizacionModule.Obten( TipoRegistro : Word;
                                             Codigo       : String ) : Boolean;

begin
     Result := DmRegistroActualizacionTable.FindKey( [ TipoRegistro, Codigo ] );
end;

function TRegistroActualizacionModule.Obten(     TipoRegistro : Word;
                                                 Codigo       : String;
                                             out RegistroActualizacionFields : TRegistroActualizacionFields ) : Boolean;

begin
     RegistroActualizacionFields := FRegistroActualizacionFields;
     Result := DmRegistroActualizacionTable.FindKey( [ TipoRegistro, Codigo ] );
end;

function TRegistroActualizacionModule.Edita( TipoRegistro : Word;
                                             Codigo       : String ) : TRegistroActualizacionFields;
begin
     If   Obten( TipoRegistro, Codigo )
     then DmRegistroActualizacionTable.Edit
     else begin
          DmRegistroActualizacionTable.Append;
          FRegistroActualizacionFields.TipoRegistro.Value := TipoRegistro;
          FRegistroActualizacionFields.Codigo.Value := Codigo;
          end;
     Result := FRegistroActualizacionFields;
end;

procedure TRegistroActualizacionModule.Actualizado( TipoRegistro : Word;
                                                    Codigo       : String;
                                                    Valor        : Boolean );
begin
     If   Obten( TipoRegistro, Codigo )
     then try
            DmRegistroActualizacionTable.Edit;
            FRegistroActualizacionFields.Actualizado.Value := Valor;
            DmRegistroActualizacionTable.Post;
          except
            DmRegistroActualizacionTable.Cancel;
            raise;
            end;
end;

end.

