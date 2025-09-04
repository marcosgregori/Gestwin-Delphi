
unit dm_con;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  cxEdit,

  DB, nxDB,

  AppContainer,
  AppForms,
  DataManager,

  Gim10Fields;

type
  TConceptoApunteModule = class(TDataModule)
    DmConceptoApteTable: TnxeTable;
    procedure conceptoApunteModuleDestroy(Sender: TObject);
    procedure conceptoApunteModuleCreate(Sender: TObject);
  private

    DmConceptoApteFields  : TConceptoApteFields;

  public

    procedure Valida( EditControl : TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean; IsInfoControl : Boolean = False );
    function  Descripcion( Value : SmallInt; NotificaSiNoExiste : Boolean = True ) : String;
    function  Obten( Value : SmallInt; NotificaSiNoExiste : Boolean = False ) : boolean;
    procedure CompruebaTexto( var DisplayValue : Variant; var ErrorText : TCaption; var Error : Boolean; ConceptoAnterior : String = '' );
  end;

var ConceptoApunteModule: TConceptoApunteModule = nil;


function  ConceptoApunte : TConceptoApunteModule;

implementation

uses LibUtils,
     Variants,
     EnterpriseDataAccess,
     AppManager,

     Gim00Fields;

{$R *.DFM}

resourceString
     RsMsg1 = 'No existe un concepto de apunte con este código|Puede consultar los conceptos existentes pulsando [F4].';
     RsMsg2 = 'El concepto de apunte número %d ha sido dado de baja.';

function ConceptoApunte : TConceptoApunteModule;
begin
     CreateDataModule( TConceptoApunteModule, ConceptoApunteModule );
     Result := ConceptoApunteModule;
end;

procedure TConceptoApunteModule.conceptoApunteModuleDestroy( Sender : TObject );
begin
     ConceptoApunteModule := nil;
end;

procedure TConceptoApunteModule.Valida(     EditControl    : TcxCustomEdit;
                                        var DisplayValue  : Variant;
                                        var ErrorText     : TCaption;
                                        var Error         : Boolean;
                                            IsInfoControl : Boolean = False );
begin
     ValidateRelationEx( EditControl, DmConceptoApteTable, [ DisplayValue ], DisplayValue, ErrorText, Error, nil, RsDescripcion, IsInfoControl );
end;

function TConceptoApunteModule.Descripcion( Value : SmallInt; NotificaSiNoExiste : Boolean ) : String;
begin
     GetRelationDescription( DmConceptoApteTable, [ Value ],  Result, NotificaSiNoExiste, RsDescripcion );
end;

function TConceptoApunteModule.Obten( Value              : SmallInt;
                                      NotificaSiNoExiste : Boolean = False ) : Boolean;
begin
     Result := DmConceptoApteTable.FindKey( [ Value ] );
     If   NotificaSiNoExiste and not Result
     then begin
          ShowNotification( ntStop, Format( RsMsg2, [ Value ] ), '' );
          Abort;
          end;
end;

procedure TConceptoApunteModule.conceptoApunteModuleCreate(Sender: TObject);
begin
     DmConceptoApteFields := TConceptoApteFields.Create( DmConceptoApteTable );
end;

procedure TConceptoApunteModule.CompruebaTexto( var DisplayValue     : Variant;
                                                var ErrorText        : TCaption;
                                                var Error            : Boolean;
                                                    ConceptoAnterior : String = '' );

var  NroConcepto : Integer;

begin
     If   not VarIsNull( DisplayValue )
     then If   TabKey and not ShiftKey and ( System.Length( DisplayValue )<4 )
          then If   DisplayValue='.'
               then DisplayValue := ConceptoAnterior
               else If   TryStrToInt( Copy( DisplayValue, 1, 3 ), NroConcepto )
                    then begin
                         ErrorText := '';
                         If   DmConceptoApteTable.FindKey( [ NroConcepto ] )
                         then DisplayValue := DmConceptoApteFields.Descripcion.Value
                         else ErrorText := RsMsg1;
                         Error := True;
                         end;
end;

end.
