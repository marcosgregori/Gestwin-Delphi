unit dm_enf;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, cxEdit,
  cxDBEdit,

  LibUtils,

  AppForms,

  DB,
  nxdb,
  DataManager,

  Gim00Fields;


type
  TEntidadFinancieraModule = class(TDataModule)
    DmEntidadFinancieraTable: TnxeTable;
    procedure EntidadFinancieraModuleDestroy(Sender: TObject);
    procedure EntidadFinancieraModuleCreate(Sender: TObject);
  private

    DmEntidadFinancieraFields : TEntidadFinancieraFields;

  public

    procedure Valida( EditControl : TcxCustomEdit; var DisplayValue : Variant; var ErrorText : TCaption; var Error : Boolean; IsInfoControl : Boolean = False ); overload;
    function  Descripcion( Codigo, Oficina : String; NotificaSiNoExiste : Boolean ) : string;

    function  ObtenBIC( Codigo, Oficina : String ) : String;
    procedure CompletaValidacion( DisplayValue : Variant; EntidadCtrl : TcxDBTextEdit; OficinaCtrl : TcxDBTextEdit; CuentaCtrl : TcxDBTextEdit = nil; DCCtrl : TcxDBTextEdit = nil );
  end;

var  EntidadFinancieraModule: TEntidadFinancieraModule = nil;

function  EntidadFinanciera : TEntidadFinancieraModule;

implementation

uses  AppManager,

      AppContainer,

      B_msg;

{$R *.dfm}

function EntidadFinanciera : TEntidadFinancieraModule;
begin
     CreateDataModule( TEntidadFinancieraModule, EntidadFinancieraModule );
     Result := EntidadFinancieraModule;
end;

procedure TEntidadFinancieraModule.EntidadFinancieraModuleCreate(Sender: TObject);
begin
     DmEntidadFinancieraFields := TEntidadFinancieraFields.Create( DmEntidadFinancieraTable );
end;

procedure TEntidadFinancieraModule.EntidadFinancieraModuleDestroy(Sender: TObject);
begin
     EntidadFinancieraModule := nil;
end;

procedure TEntidadFinancieraModule.Valida(     EditControl    : TcxCustomEdit;
                                           var DisplayValue  : Variant;
                                           var ErrorText     : TCaption;
                                           var Error         : Boolean;
                                               IsInfoControl : Boolean = False );
begin
     // De momento no espero que estén dadas de altas todas las oficinas y solo valido la entidad
     ValidateRelationEx( EditControl, DmEntidadFinancieraTable, [ DisplayValue, '' ], DisplayValue, ErrorText, Error, nil, 'Nombre', IsInfoControl );
end;

function TEntidadFinancieraModule.Descripcion( Codigo,
                                               Oficina            : String;
                                               NotificaSiNoExiste : Boolean ) : String;
begin
     GetRelationDescription( DmEntidadFinancieraTable, [ Codigo, Oficina ], Result, NotificaSiNoExiste );
end;

function TEntidadFinancieraModule.ObtenBIC( Codigo, Oficina : String ) : String;
begin
     If   not DmEntidadFinancieraTable.FindKey( [ Codigo, Oficina ] )
     then If   not DmEntidadFinancieraTable.FindKey( [ Codigo, '' ] )  // La central
          then begin
               Result := '';
               Exit;
               end;
     Result := DmEntidadFinancieraFields.BIC.Value;
end;

procedure TEntidadFinancieraModule.CompletaValidacion( DisplayValue : Variant;
                                                       EntidadCtrl  : TcxDBTextEdit;
                                                       OficinaCtrl  : TcxDBTextEdit;
                                                       CuentaCtrl   : TcxDBTextEdit = nil;
                                                       DCCtrl       : TcxDBTextEdit = nil );
var  Empty : Boolean;

begin
     Empty := ValueIsEmpty( DisplayValue );
     If   Empty and EntidadCtrl.Editing
     then begin
          OficinaCtrl.ClearAndPost;
          If   Assigned( CuentaCtrl )
          then CuentaCtrl.ClearAndPost;
          If   Assigned( DCCtrl )
          then DCCtrl.ClearAndPost;
          end;

     OficinaCtrl.Enabled := not Empty;
     If   Assigned( CuentaCtrl )
     then CuentaCtrl.Enabled := not Empty;
     If   Assigned( DCCtrl )
     then DCCtrl.Enabled := not Empty;

     If   EntidadCtrl.Editing
     then ResetTab;
end;


end.
