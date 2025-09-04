
unit dm_rdp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, cxEdit,

  LibUtils,
  AppForms,

  DB, nxdb, DataManager,

  Gim10Fields,

  dmi_rdp,

  RemesaPagoIntf;


       // Estados de la remesa

const  erpPendiente  = 0;
       erpPagada     = 1;

       // Tipos de orden no normalizadas

       onnPagare               = 1000;
       onnPagosCertificadosBV  = 1001;
       onnPagosFactoringBBV    = 1002;

type

  TRemesaPagoModule = class(TDataModule)
    DmRemesaPagoTable: TnxeTable;
    procedure RemesaPagoModuleCreate(Sender: TObject);
    procedure RemesaPagoModuleDestroy(Sender: TObject);
  private

    RemesaPagoService : IRemesaPagoService;
    DmRemesaPagoFields : TRemesaPagoFields;

  public

    function  Obten( Ejercicio : SmallInt; NroRemesa : LongInt; RemesaPagoFields : TRemesaPagoFields = nil; NotificaSiNoExiste : Boolean = False ) : Boolean;
    function  TextoEstado( RemesaPagoFields : TRemesaPagoFields ) : string;

    function ObtenConceptoAsientoPago( Ejercicio : SmallInt; NroRemesa : LongInt; FechaPago : TDate ) : String;
    function ImporteRemesa( Ejercicio : SmallInt; NroRemesa : LongInt ) : Decimal;

    procedure Valida( EditControl : TcxCustomEdit; var DisplayValue : Variant; var ErrorText : TCaption; var Error : Boolean; RemesaPagoFields : TRemesaPagoFields = nil ); overload;

    procedure ActualizaRemesa( RemesaPagoFields : TRemesaPagoFields );
    procedure SuprimeRemesa( RemesaPagoFields : TRemesaPagoFields );

    procedure ActualizaAnotacionPago( RemesaPagoFields : TRemesaPagoFields; Concepto : String );
    procedure SuprimeAnotacionPago( RemesaPagoFields : TRemesaPagoFields );
  end;

var RemesaPagoModule: TRemesaPagoModule = nil;


function RemesaPago : TRemesaPagoModule;

implementation

uses AppManager,
     EnterpriseDataAccess,
     DateUtils,
     AppContainer,
     NexusRpcData,

     Gim00Fields,

     dm_ast,

     b_msg;

{$R *.DFM}

resourceString
       RsMsg1 = 'La remesa de pago nº %d no existe.';

function RemesaPago : TRemesaPagoModule;
begin
     CreateDataModule( TRemesaPagoModule,RemesaPagoModule );
     Result := RemesaPagoModule;
end;

procedure TRemesaPagoModule.RemesaPagoModuleCreate(Sender: TObject);
begin
     NexusRpc.CreateRemoteInstance( CLSID_RemesaPagoService, IRemesaPagoService, RemesaPagoService );
     DmRemesaPagoFields := TRemesaPagoFields.Create( DmRemesaPagoTable );
end;

procedure TRemesaPagoModule.RemesaPagoModuleDestroy(Sender: TObject);
begin
    RemesaPagoModule := nil;
end;

procedure TRemesaPagoModule.SuprimeAnotacionPago( RemesaPagoFields : TRemesaPagoFields );
begin
     With RemesaPagoFields do
       RemesaPagoService.SuprimeAnotacionPago( GetRemoteCursorID, Ejercicio.Value, NroRemesa.Value );
end;

procedure TRemesaPagoModule.SuprimeRemesa( RemesaPagoFields : TRemesaPagoFields );
begin
     RemesaPagoService.SuprimeRemesa( RemesaPagoFields.GetRemoteCursorID, RemesaPagoFields.NroRemesa.Value );
end;

procedure TRemesaPagoModule.Valida(     EditControl      : TcxCustomEdit;
                                    var DisplayValue     : Variant;
                                    var ErrorText        : TCaption;
                                    var Error            : Boolean;
                                        RemesaPagoFields : TRemesaPagoFields = nil );
begin
     ValidateRelationEx( EditControl, DmRemesaPagoTable, [ ApplicationContainer.Ejercicio, DisplayValue ], DisplayValue, ErrorText, Error, RemesaPagoFields );
end;

procedure TRemesaPagoModule.ActualizaRemesa( RemesaPagoFields : TRemesaPagoFields );
begin
     RemesaPagoService.ActualizaRemesa( TRemesaPago.FromDataset( RemesaPagoFields ) );
end;

function TRemesaPagoModule.ImporteRemesa( Ejercicio : SmallInt;
                                          NroRemesa : Integer ) : Decimal;
begin
     Result := RemesaPagoService.ImporteRemesa( Ejercicio, NroRemesa );
end;

function  TRemesaPagoModule.Obten( Ejercicio          : SmallInt;
                                   NroRemesa          : LongInt;
                                   RemesaPagoFields   : TRemesaPagoFields = nil;
                                   NotificaSiNoExiste : Boolean = False ) : Boolean;
begin
     Result := DmRemesaPagoTable.FindKey( [ Ejercicio, NroRemesa ] );
     If   Assigned( RemesaPagoFields )
     then RemesaPagoFields.Update( DmRemesaPagoTable );
     If   NotificaSiNoExiste and not Result
     then begin
          ShowNotification( ntStop, Format( rsMsg1, [ NroRemesa ] ), '' );
          Abort;
          end;
end;

function TRemesaPagoModule.ObtenConceptoAsientoPago( Ejercicio : SmallInt;
                                                     NroRemesa : LongInt;
                                                     FechaPago : TDate ) : String;
begin
     Result := RemesaPagoService.ObtenConceptoAsientoPago( Ejercicio, NroRemesa, FechaPago );
end;

procedure TRemesaPagoModule.ActualizaAnotacionPago( RemesaPagoFields : TRemesaPagoFields;
                                                    Concepto         : String );
begin
     RemesaPagoService.ActualizaAnotacionPago( TRemesaPago.FromDataset( RemesaPagoFields ), Concepto );
end;

function TRemesaPagoModule.TextoEstado( RemesaPagoFields : TRemesaPagoFields ) : string;

var  TextoTipoOrden : String;

begin
     Result := '';
     With RemesaPagoFields do
       case Estado.Value of
         erpPendiente : Result := 'Pendiente de pago';
         erpPagada    : begin
                        Result := 'Pagada el ' + StrFormatDate( RemesaPagoFields.FechaPago.Value );
                        If   TipoOrden.Value<>0
                        then begin
                             TextoTipoOrden := '';
                             case TipoOrden.Value of
                               34  : case CodigoOrden.Value of
                                        51 : TextoTipoOrden := '34 - Facturas para Confirming';
                                        56 : TextoTipoOrden := '34 - Orden de transferencia';
                                        57 : TextoTipoOrden := '34 - Facturas para emitir cheque y pagaré';
                                        59 : TextoTipoOrden := '34 - Facturas para emitir pago certificado';
                                        end;
                               68  : case CodigoOrden.Value of
                                        59 : TextoTipoOrden := '68 - Pagos domiciliados';
                                        end;
                               onnPagare :
                                      TextoTipoOrden := 'Pagarés';
                               onnPagosCertificadosBV :
                                      TextoTipoOrden := 'Pagos certificados/Confirming BV';
                               onnPagosFactoringBBV :
                                      TextoTipoOrden := 'Pagos/Factoring BBV-Netcash';
                               end;
                             If   TextoTipoOrden<>''
                             then Result := Result + ' ( ' + TextoTipoOrden + ' )';
                             end;
                        end;
         end;
end;


end.


