
unit dm_rem;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, cxEdit,

  LibUtils,
  AppForms,

  DB, nxdb, DataManager,

  Gim10Fields,

  RemesaIntf,

  dmi_rem;


  // Estados de la Remesa

const  erPendiente  = 0;
       erCobrada    = 1;
       erDescontada = 2;
       erCancelada  = 3;
       erAceptada   = 4;

type

  TRemesaModule = class(TDataModule)
    DmRemesaTable: TnxeTable;
    procedure RemesaModuleCreate(Sender: TObject);
    procedure RemesaModuleDestroy(Sender: TObject);
  private

    RemesaService : IRemesaService;

    DmRemesaFields : TRemesaFields;

  public

    procedure Valida( EditControl : TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean; IsInfoControl : Boolean = False );
    function  Obten( Ejercicio : SmallInt; NroRemesa : longInt; RemesaFields : TRemesaFields = nil; NotificaSiNoExiste : Boolean = False ) : Boolean;
    function  TextoEstado( RemesaFields : TRemesaFields ) : string;

    procedure ActualizaRemesa( RemesaFields : TRemesaFields );
    procedure SuprimeRemesa( RemesaFields : TRemesaFields );

    procedure ActualizaAnotacionCobro( RemesaFields : TRemesaFields; Concepto : String );
    procedure SuprimeAnotacionCobro( RemesaFields : TRemesaFields );

    procedure ActualizaAceptacion( RemesaFields : TRemesaFields; Concepto : String );
    procedure SuprimeAceptacion( RemesaFields : TRemesaFields );

    procedure ActualizaDescuento( RemesaFields : TRemesaFields; Concepto : String );
    procedure SuprimeDescuento( RemesaFields : TRemesaFields );

    procedure ActualizaCancelacion( RemesaFields : TRemesaFields );
    procedure SuprimeCancelacion( RemesaFields : TRemesaFields );

    procedure CancelacionAutomatica( Fecha : TDate; MesesAntiguedad : SmallInt );

    function  ObtenConcepto( Ejercicio : SmallInt; NroRemesa : LongInt; TipoAsiento : SmallInt ) : String;
    procedure ImporteRemesa( Ejercicio : SmallInt; NroRemesa : longInt; var Importe : Decimal; var ImporteImpagados : Decimal; var ImporteCancelados : Decimal );
	function UltimoVencimiento( Ejercicio : SmallInt; NroRemesa : longInt ) : TDate;
  end;

var
 RemesaModule: TRemesaModule = nil;


function Remesa : TRemesaModule;

implementation

uses Variants,
     DateUtils,
     DataAccess,
     EnterpriseDataAccess,
     AppManager,
     AppContainer,
     NexusRpcData,

     Gdm00Dm,
     Gim00Fields,

     dm_ast,
     dm_ban,
     dm_sal,
     dm_ecc,
     dm_cli,
     dm_iva,

     b_msg;

{$R *.DFM}

resourceString
       RsMsg1 = 'La remesa nº %d no existe.';
       RsMsg7 = 'Cancelacion N/Remesa nº %d.';

function Remesa : TRemesaModule;
begin
     CreateDataModule( TRemesaModule,RemesaModule );
     Result := RemesaModule;
end;

procedure TRemesaModule.RemesaModuleCreate(Sender: TObject);
begin

     NexusRpc.CreateRemoteInstance( CLSID_RemesaService, IRemesaService, RemesaService );

     DmRemesaFields := TRemesaFields.Create( DmRemesaTable );
end;

procedure TRemesaModule.RemesaModuleDestroy(Sender: TObject);
begin
    RemesaModule := nil;
end;

procedure TRemesaModule.SuprimeAceptacion( RemesaFields : TRemesaFields );
begin
     With RemesaFields do
       RemesaService.SuprimeAceptacion( GetRemoteCursorID, Ejercicio.Value, NroRemesa.Value );
end;

procedure TRemesaModule.SuprimeAnotacionCobro( RemesaFields : TRemesaFields );
begin
     With RemesaFields do
       RemesaService.SuprimeAnotacionCobro( GetRemoteCursorID, Ejercicio.Value, NroRemesa.Value );
end;

procedure TRemesaModule.SuprimeCancelacion( RemesaFields : TRemesaFields );
begin
     With RemesaFields do
       RemesaService.SuprimeCancelacion( GetRemoteCursorID, Ejercicio.Value, NroRemesa.Value );
end;

procedure TRemesaModule.SuprimeDescuento( RemesaFields : TRemesaFields );
begin
     With RemesaFields do
       RemesaService.SuprimeDescuento( GetRemoteCursorID, Ejercicio.Value, NroRemesa.Value );
end;

procedure TRemesaModule.SuprimeRemesa( RemesaFields : TRemesaFields );
begin
     RemesaService.SuprimeRemesa( RemesaFields.GetRemoteCursorID, RemesaFields.NroRemesa.Value );
end;

procedure TRemesaModule.Valida(      EditControl   : TcxCustomEdit;
                                 var DisplayValue  : Variant;
                                 var ErrorText     : TCaption;
                                 var Error         : Boolean;
                                     IsInfoControl : Boolean = False );
begin
     ValidateRelationEx( EditControl, DmRemesaTable, [ ApplicationContainer.Ejercicio, DisplayValue ], DisplayValue, ErrorText, Error, nil, '', IsInfoControl );
end;

function  TRemesaModule.Obten( Ejercicio          : SmallInt;
                               NroRemesa          : longInt;
                               RemesaFields       : TRemesaFields = nil;
                               NotificaSiNoExiste : Boolean = False ) : Boolean;
begin
     Result := DmRemesaTable.FindKey( [ Ejercicio, NroRemesa ] );
     If   Assigned( RemesaFields )
     then RemesaFields.Update( DmRemesaTable );
     If   NotificaSiNoExiste and not Result
     then begin
          ShowNotification( ntStop, Format( RsMsg1, [ NroRemesa ] ), '' );
          Abort;
          end;
end;

procedure TRemesaModule.ImporteRemesa(     Ejercicio         : SmallInt;
                                           NroRemesa         : Integer;
                                       var Importe,
                                           ImporteImpagados,
                                           ImporteCancelados : Decimal);
begin
     RemesaService.ImporteRemesa( Ejercicio, NroRemesa, Importe, ImporteImpagados, ImporteCancelados );
end;

function TRemesaModule.UltimoVencimiento( Ejercicio : SmallInt;
                                          NroRemesa : longInt ) : TDate;
begin
     Result := RemesaService.UltimoVencimiento( Ejercicio, NroRemesa );
end;

function TRemesaModule.TextoEstado( RemesaFields : TRemesaFields ) : string;

const  TextoEstado : array [ erPendiente..erAceptada ] of String = ( 'Pendiente de descuento, cobro o aceptación.',
                                                                     'Cobrada',
                                                                     'Descontada',
                                                                     'Cancelada',
                                                                     'Aceptada' );
var    TextoTipoOrden,
       TextoFecha : String;
begin
     Result := '';
     With RemesaFields do
       begin

       If   Estado.Value=erPendiente
       then Result := TextoEstado[ erPendiente ]
       else begin

            // Primer posible estado

            If   NroAsientoCobro.Value<>0
            then Result := TextoEstado[ erCobrada ] + ' el ' + StrFormatDate( RemesaFields.FechaCobro.Value ) + '. '
            else begin
                 If   NroAsientoAceptacion.Value<>0
                 then Result := TextoEstado[ erAceptada ] + ' el ' + StrFormatDate( RemesaFields.FechaAceptacion.Value )  + '. ';
                 If   NroAstoDescuento1.Value<>0
                 then Result := Result + TextoEstado[ erDescontada ] + ' el ' + StrFormatDate( RemesaFields.FechaDescuento.Value )  + '. ';

            end;

       If   ( NroAstoDescuento1.Value<>0 ) and ( TipoOrden.Value<>0 )
       then begin
            TextoTipoOrden := '';
            case TipoOrden.Value of
              19 : begin
                   TextoTipoOrden := 'Orden de adeudo';
                   case CodigoOrden.Value of
                     0 : ;
                     1 : StrAdd( TextoTipoOrden, ' financiada' );
                     2 : StrAdd( TextoTipoOrden, ' a la vista' );
                     end;
                   end;
              32 : TextoTipoOrden := 'Remesa de efectos';
              58 : TextoTipoOrden := 'Anticipo de crédito';
              end;
            If   TextoTipoOrden<>''
            then Result := Result + ' ( ' + IntToStr( TipoOrden.Value ) + ' - ' + TextoTipoOrden + ' ) ';
            end;

            end;

       // Ultimo estado

       If   Estado.Value=erCancelada
       then Result := Result + ' ' + TextoEstado[ erCancelada ] + ' el ' + StrFormatDate( RemesaFields.FechaCancelacion.Value );

       end;
end;

procedure TRemesaModule.ActualizaAceptacion( RemesaFields : TRemesaFields; Concepto : String);
begin
     RemesaService.ActualizaAceptacion( TRemesa.FromDataset( RemesaFields ), Concepto );
end;

procedure TRemesaModule.ActualizaAnotacionCobro( RemesaFields : TRemesaFields; Concepto : String);
begin
     RemesaService.ActualizaAnotacionCobro( TRemesa.FromDataset( RemesaFields ), Concepto );
end;

procedure TRemesaModule.ActualizaCancelacion( RemesaFields : TRemesaFields );
begin
     RemesaService.ActualizaCancelacion( TRemesa.FromDataset( RemesaFields ) );
end;

procedure TRemesaModule.ActualizaDescuento( RemesaFields : TRemesaFields; Concepto : String );
begin
     RemesaService.ActualizaDescuento( TRemesa.FromDataset( RemesaFields ), Concepto );
end;

procedure TRemesaModule.ActualizaRemesa( RemesaFields : TRemesaFields );
begin
     RemesaService.ActualizaRemesa( TRemesa.FromDataset( RemesaFields ) );
end;

procedure TRemesaModule.CancelacionAutomatica( Fecha : TDate; MesesAntiguedad : SmallInt );
begin
     RemesaService.CancelacionAutomatica( Fecha, MesesAntiguedad );
end;

function TRemesaModule.ObtenConcepto( Ejercicio    : SmallInt;
                                      NroRemesa    : Integer;
                                      TipoAsiento  : SmallInt ): String;
begin
     Result := RemesaService.ObtenConcepto( Ejercicio, NroRemesa, TipoAsiento );
end;

end.

