
unit dm_tas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, cxEdit,
  AppContainer,

  AppForms,

  DB, nxdb,
  DataManager,

  Gim10Fields;


type
  TTipoAsientoModule = class(TDataModule)
    DmTipoAsientoTable: TnxeTable;
    DmLineaTipoAsientoTable: TnxeTable;
    procedure TipoAsientoModuleDestroy(Sender: TObject);
    procedure TipoAsientoModuleCreate(Sender: TObject);
  private

    DmTipoAsientoFields : TTipoAsientoFields;
    DmLineaTipoAsientoFields : TLineaTipoAsientoFields;

    function CompletaRegistroPredefinido( Value : SmallInt; TipoAsientoFields : TTipoAsientoFields = nil ) : Boolean;

  public

    function  Valida( EditControl : TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean; TipoAsientoFields  : TTipoAsientoFields = nil; IsInfoControl : Boolean = False ) : Boolean;
    procedure Comprueba( Fecha : TDateTime; var DisplayValue : Variant; var ErrorText : TCaption; var Error : Boolean; OldValue : Variant );
    function  Descripcion( Value : SmallInt; NotificaSiNoExiste : Boolean = False ) : string;
    function  Obten( Value : SmallInt; TipoAsientoFields : TTipoAsientoFields = nil ) : Boolean;
    function  ObtenApunteTipo( TipoAsiento, NroApunte : SmallInt; LineaTipoAsientoFields : TLineaTipoAsientoFields ) : Boolean;
  end;

var
  TipoAsientoModule: TTipoAsientoModule = nil;


function  TipoAsiento : TTipoAsientoModule;

implementation

uses DateUtils,
     LibUtils,

     AppManager,
     DataAccess,
     EnterpriseDataAccess,

     Gdm00Dm,
     Gim00Fields,

     b_msg,

     dmi_ast,

     dm_ast;

{$R *.DFM}

resourceString
       RsMsg1  = 'Código de tipo de asiento incorrecto.';
       RsMsg2  = 'Para crear registros de los tipos 5 al 19 utilice las ventanas especializadas.';
       RsMsg3  = 'El tipo de asiento es de apertura pero la fecha del asiento no coincide con el primer mes contable.';
       RsMsg4  = 'El tipo de asiento es de regularización o cierre pero la fecha del asiento no coincide con el último mes contable.';
       RsMsg5  = '¿Está seguro de que desea utilizar este tipo de asiento?';

const  TextoTipoAsiento   : array[ 0..taRegularizacionIVA ] of string  = ( '<Todos>',
                                                                           'Apertura',
                                                                           'Ordinario',
                                                                           'Regularización',
                                                                           'Cierre',
                                                                           'Factura emitida',
                                                                           'Factura recibida',
                                                                           'Cobro',
                                                                           'Pago',
                                                                           'Descuento de remesa',
                                                                           'Cancelación de remesa',
                                                                           'Cobro de remesa',
                                                                           'Amortización',
                                                                           'Cancelación de efecto',
                                                                           'Impagado',
                                                                           'Pago de remesa',
                                                                           'Movimiento de caja',
                                                                           'Cartera',
                                                                           'Aceptación de remesa',
                                                                           'Reg. IVA criterio caja' );

function TipoAsiento : TTipoAsientoModule;
begin
     CreateDataModule( TTipoAsientoModule, TipoAsientoModule );
     Result := TipoAsientoModule;
end;

procedure TTipoAsientoModule.TipoAsientoModuleDestroy(Sender: TObject);
begin
     TipoAsientoModule := nil;
end;

function TTipoAsientoModule.Valida(     EditControl       : TcxCustomEdit;
                                    var DisplayValue      : Variant;
                                    var ErrorText         : TCaption;
                                    var Error             : Boolean;
                                        TipoAsientoFields : TTipoAsientoFields = nil;
                                        IsInfoControl     : Boolean = False ) : Boolean;

var  Tipo : SmallInt;

begin
     Tipo := VarToSmallInt( DisplayValue );
     If   Tipo in [ 0..taRegularizacionIVA ]
     then begin
          Result := CompletaRegistroPredefinido( Tipo, TipoAsientoFields );
          EditControl.Description := TextoTipoAsiento[ Tipo ];
          end
     else begin
          ValidateRelationEx( EditControl, DmTipoAsientoTable, [ Tipo ], DisplayValue, ErrorText, Error, TipoAsientoFields, RsDescripcion, IsInfoControl );
          Result := DmTipoAsientoFields.Documento.Value;
          end;
end;

procedure TTipoAsientoModule.Comprueba(     Fecha         : TDateTime;
                                        var DisplayValue  : Variant;
                                        var ErrorText     : TCaption;
                                        var Error         : Boolean;
                                            OldValue      : Variant );
var  Tipo,
     Mes : SmallInt;

begin
     Tipo := VarToSmallInt( DisplayValue );
     If   Tipo in [ taFraEmitida..taRegularizacionIVA ]
     then begin
          Error := True;
          ErrorText := JoinMessage( RsMsg1, RsMsg2 );
          end
     else begin
          Mes := MonthOf( Fecha );
          If   ( Mes<>ApplicationContainer.NroMesInicial ) and ( Tipo=taApertura )
          then Error := ShowNotification( ntQuestionWarning, RsMsg3, RsMsg5 )<>mrYes
          else If   ( Mes<>ApplicationContainer.NroMesFinal ) and ( Tipo in [ taRegularizacion, taCierre ] )
               then Error := ShowNotification( ntQuestionWarning, RsMsg4, RsMsg5 )<>mrYes;
          If   Error
          then DisplayValue := OldValue;
          end;
end;

function TTipoAsientoModule.Descripcion( Value              : SmallInt;
                                         NotificaSiNoExiste : Boolean = False ) : String;
begin
     Result := '';
     If   Value in [ 0..taMovimientoCaja ]
     then Result := TextoTipoAsiento[ Value ]
     else GetRelationDescription( DmTipoAsientoTable, [ Value], Result, NotificaSiNoExiste, RsDescripcion );
end;

function TTipoAsientoModule.Obten( Value             : SmallInt;
                                   TipoAsientoFields : TTipoAsientoFields = nil ) : Boolean;
begin
     If   Value in [ 0..taMovimientoCaja ]
     then begin
          CompletaRegistroPredefinido( Value, TipoAsientoFields );
          Result := True;
          end
     else begin
          Result := DmTipoAsientoTable.FindKey( [ Value ] );
          If   Assigned( TipoAsientoFields )
          then TipoAsientoFields.Update( DmTipoAsientoTable );
          end;
end;

function TTipoAsientoModule.CompletaRegistroPredefinido( Value             : SmallInt;
                                                         TipoAsientoFields : TTipoAsientoFields = nil ) : Boolean;
begin
     Result := Value in [ taFraEmitida..taCobroRemesa, taCancelacionEfecto..taPagoRemesa ];
     If   Assigned( TipoAsientoFields )
     then begin
          TipoAsientoFields.Clear( DmTipoAsientoTable );
          With TipoAsientoFields do
            begin
            NroRegistro.Value := Value;
            Descripcion.Value := TextoTipoAsiento[ Value ];
            Documento.Value := Result;
            Registro.Value := DataModule00.DmEmpresaFields.Contable_NroRegAstos.Value or ( ( Value=taFraRecibida ) and DataModule00.DmEmpresaFields.Contable_NroRegistro.Value );
            end;
          end;
end;

procedure TTipoAsientoModule.TipoAsientoModuleCreate(Sender: TObject);

var   Index  : SmallInt;

begin
     DmTipoAsientoFields := TTipoAsientoFields.Create( DmTipoAsientoTable );
     DmLineaTipoAsientoFields := TLineaTipoAsientoFields.Create( DmLineaTipoAsientoTable );

     With DmTipoAsientoTable do
       try
         ShowErrorDialog := False;
         If   not FindKey( [ taRegularizacionIVA ] )   // Es el último de los predefinidos
         then For Index := taApertura to taRegularizacionIVA do
                With DmTipoAsientoFields do
                  begin
                  Append;
                  NroRegistro.Value := Index;
                  Descripcion.Value := TextoTipoAsiento[ Index ];
                  try
                    Post;
                  except
                    Cancel;
                    end;
                  end;
       finally
         ShowErrorDialog := True;
         end;

end;

function TTipoAsientoModule.ObtenApunteTipo( TipoAsiento,
                                             NroApunte              : SmallInt;
                                             LineaTipoAsientoFields : TLineaTipoAsientoFields ) : Boolean;

var  Contador  : SmallInt;

begin
     Result := False;
     With DmLineaTipoAsientoTable do
       try
         SetRange( [ TipoAsiento, 1 ], [ TipoAsiento, MaxSmallint ] );
         First;
         Contador := 1;
         While not Eof and ( Contador<NroApunte ) do
           begin
           Inc( Contador );
           Next;
           end;

         Result := not Eof;

         With LineaTipoAsientoFields do
           If   Result
           then Update( DmLineaTipoAsientoTable )
           else Clear( DmLineaTipoAsientoTable );

       finally
         CancelRange
         end;
end;

end.
