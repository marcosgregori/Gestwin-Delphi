
unit dm_bei;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Generics.Defaults, Generics.Collections,

  dxSpreadSheetCore,
  dxSpreadSheetTypes,
  dxSpreadSheetFormulas,
  dxSpreadSheetFunctions,

  LibUtils,
  DB,
  Nxdb,
  DataManager,

  Gim00Fields,
  Gim10Fields,

  // dmi_fac,

  dm_pai,
  dm_iva;

type

  TBalancesInformesModule = class(TDataModule)
    DmApunteTable: TnxeTable;
    DmAsientoTable: TnxeTable;
    DmCuentaTable: TnxeTable;
    DmExistenciaTable: TnxeTable;
    DmSaldosTable: TnxeTable;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);

  private

    // BalancesInformesService : IBalancesInformesService;

    DmApunteFields : TApunteFields;
    DmAsientoFields : TAsientoFields;
    DmCuentaFields : TCuentaFields;
    DmExistenciaFields : TExistenciaFields;
    DmSaldosFields : TSaldosFields;


    procedure DoOnBalancesInformesClick( Sender : TObject );

  public


  end;

var  BalancesInformesModule: TBalancesInformesModule = nil;

function  BalancesInformes : TBalancesInformesModule;

implementation

uses System.Types,
     DateUtils,
     nxrbTypes,
     nxrdClass,

     Gdm00Dm,

     Gdm10Frm,

     AppContainer,
     AppManager,
     NexusRpcData,

     SpreadSheet,

     dmi_sal,
     
     dm_sub,
     dm_sal,

     l_bei;

{$R *.DFM}

type  TOperacionSaldo = ( osDebe, osHaber, osSaldo, osDebeMes, osHaberMes, osSaldoMes );

      TAcumulado = record
       Debe,
       Haber  : array[ 0..14 ] of Decimal;
       Saldo,
       SumaDebe,
       SumaHaber : Decimal;
       end;
       
resourceString
     StringDescripcionCuenta = 'Cuenta.Descripcion';
     StringDebe = 'Debe';
     StringHaber = 'Haber';
     StringSaldo = 'Saldo';
     StringDebeMes = 'DebeMes';
     StringHaberMes = 'HaberMes';
     StringSaldoMes = 'SaldoMes';

function BalancesInformes : TBalancesInformesModule;
begin
     CreateDataModule( TBalancesInformesModule, BalancesInformesModule );
     Result := BalancesInformesModule;
end;

{ Funciones de la hoja de cálculo }

procedure FunctionDescripcionCuenta(       Sender  : TdxSpreadSheetFormulaResult;
                                     const AParams : TdxSpreadSheetFormulaToken );
begin
     If  ( Sender.GetParamsCount( AParams )<>1 )
     then Sender.SetError( ecValue )
     else Sender.AddValue( Cuenta.Descripcion( Sender.ExtractStringParameter( AParams ) ) );
end;

procedure ParametersDescripcionCuenta( var AParamCount: Integer;
                                       var AParamKind : TdxSpreadSheetFunctionParamKindInfo );
begin
     AParamCount := 1;
     SetLength( AParamKind, AParamCount );
     AParamKind[ 0 ] := fpkValue;
end;

procedure ParametersSaldo( var AParamCount: Integer;
                          var AParamKind : TdxSpreadSheetFunctionParamKindInfo );
begin
     AParamCount := 3;
     SetLength( AParamKind, AParamCount );
     AParamKind[ 0 ] := fpkNonRequiredValue;
     AParamKind[ 1 ] := fpkValue;
     AParamKind[ 2 ] := fpkValue;
end;

function ObtenImporteSaldo(       Operacion : TOperacionSaldo;
                                  Sender    : TdxSpreadSheetFormulaResult;
                            const AParams   : TdxSpreadSheetFormulaToken ) : Decimal;

var  NroParametros : SmallInt;
     Ejercicio,
     MesInicial,
     MesFinal,
     Fecha,
     Cuentas : Variant;
     ListaCuentas : TStringList;
     CodigoCuenta : String;
     Saldo : Decimal;
     Acumulado : ISumasySaldos;
     SaldoAFecha : Boolean;
          
begin

     { Nro. parámetros   Cuentas   Ejercicio   Ultimo mes
                         --------- ----------- -----------
             1           "43,44"
             2           "43,44"      0
             3           "43,44"     -1           6

                                               Primer mes  Ultimo mes
                                               ----------- -----------
             4           "43,44"     -1           2            6

     }

     Result := 0.0;
     
     NroParametros := Sender.GetParamsCount( AParams );

     If   not ( NroParametros in [ 1..4 ] )
     then begin
          Sender.SetError( ecValue );
          Exit;
          end;

     Sender.ExtractParameter( Cuentas, AParams );

     Ejercicio := 0;  // Ejercicio actual

     MesInicial := 0;
     MesFinal := 12;

     SaldoAFecha := False;

     // Se puede utilizar solo ExtractNumericParameter porque comprueba también si es una fecha, pero prefiero usar variables separadas

     If   NroParametros>1
     then If   Sender.ExtractDateTimeParameter( Fecha, AParams, 1 )
          then SaldoAFecha := True
          else Sender.ExtractNumericParameter( Ejercicio, AParams, 1 );

     // Si es un valor menor o igual a cero es un ejercicio relativo al actual

     If   Ejercicio<=0
     then Ejercicio := ApplicationContainer.Ejercicio + Ejercicio;

     If   Operacion in [ osDebeMes..osSaldoMes ]
     then begin
          If   NroParametros<>3
          then begin
               Sender.SetError( ecValue );
               Exit;
               end;
          Sender.ExtractNumericParameter( MesInicial, AParams, 2 );
          MesFinal := MesInicial;
          end
     else case NroParametros of
                // Mes final
            3 : Sender.ExtractNumericParameter( MesFinal, AParams, 2 );
                // Mes inicial, final
            4 : begin
                Sender.ExtractNumericParameter( MesInicial, AParams, 2 );
                Sender.ExtractNumericParameter( MesFinal, AParams, 3 );
                end;
            end;

     ListaCuentas := TStringList.Create;
     try
       ListaCuentas.CommaText := Cuentas;
       Saldo := 0.0;
       For CodigoCuenta in ListaCuentas do
         begin
         If   SaldoAFecha
         then Acumulado := Saldos.SaldoFecha( CodigoCuenta, '', True, Fecha )
         else Acumulado := Saldos.SaldoPeriodo( CodigoCuenta, '', True, Ejercicio, MesInicial, MesFinal );
         case Operacion of
           osSaldo : DecAdd( Saldo, Acumulado.SumaDebe - Acumulado.SumaHaber );
           osDebe  : DecAdd( Saldo, Acumulado.SumaDebe );
           osHaber : DecAdd( Saldo, Acumulado.SumaHaber );
           end;
         end;
        Result := Saldo;
     finally
       ListaCuentas.Free;
       end;

end;

procedure FunctionDebe(       Sender  : TdxSpreadSheetFormulaResult;
                        const AParams : TdxSpreadSheetFormulaToken );
begin
     Sender.AddValue( ObtenImporteSaldo( osDebe, Sender, AParams ) );
end;

procedure FunctionHaber(       Sender  : TdxSpreadSheetFormulaResult;
                         const AParams : TdxSpreadSheetFormulaToken );
begin
     Sender.AddValue( ObtenImporteSaldo( osHaber, Sender, AParams ) );
end;

procedure FunctionSaldo(       Sender  : TdxSpreadSheetFormulaResult;
                         const AParams : TdxSpreadSheetFormulaToken );
begin
     Sender.AddValue( ObtenImporteSaldo( osSaldo, Sender, AParams ) );
end;

procedure FunctionDebeMes(       Sender  : TdxSpreadSheetFormulaResult;
                           const AParams : TdxSpreadSheetFormulaToken );
begin
     Sender.AddValue( ObtenImporteSaldo( osDebeMes, Sender, AParams ) );
end;

procedure FunctionHaberMes(       Sender  : TdxSpreadSheetFormulaResult;
                            const AParams : TdxSpreadSheetFormulaToken );
begin
     Sender.AddValue( ObtenImporteSaldo( osHaberMes, Sender, AParams ) );
end;

procedure FunctionSaldoMes(       Sender  : TdxSpreadSheetFormulaResult;
                            const AParams : TdxSpreadSheetFormulaToken );
begin
     Sender.AddValue( ObtenImporteSaldo( osSaldoMes, Sender, AParams ) );
end;

{ TBalancesInformesModule }

procedure TBalancesInformesModule.DoOnBalancesInformesClick(Sender: TObject);
begin
     BalancesEInformes;
end;

procedure TBalancesInformesModule.DataModuleCreate(Sender: TObject);
begin
     // NexusRpc.CreateRemoteInstance( CLSID_BalancesInformesService, IBalancesInformesService, BalancesInformesService );

     DmApunteFields := TApunteFields.Create( DmApunteTable );
     DmAsientoFields := TAsientoFields.Create( DmAsientoTable );
     DmCuentaFields := TCuentaFields.Create( DmCuentaTable );
     DmExistenciaFields := TExistenciaFields.Create( DmExistenciaTable );
     DmSaldosFields := TSaldosFields.Create( DmSaldosTable );

     SetBarItemVisible( Gds10Frm.BalancesInformesItem, True );
     Gds10Frm.BalancesInformesItem.OnClick := DoOnBalancesInformesClick;

     dxSpreadSheetFunctionsRepository.Add( @StringDescripcionCuenta, FunctionDescripcionCuenta, ParametersDescripcionCuenta, frkValue, 2048, ftDatabase );

     dxSpreadSheetFunctionsRepository.Add( @StringDebe, FunctionDebe, ParametersSaldo, frkValue, 2048, ftDatabase );
     dxSpreadSheetFunctionsRepository.Add( @StringHaber, FunctionHaber, ParametersSaldo, frkValue, 2048, ftDatabase );
     dxSpreadSheetFunctionsRepository.Add( @StringSaldo, FunctionSaldo, ParametersSaldo, frkValue, 2048, ftDatabase );

     dxSpreadSheetFunctionsRepository.Add( @StringDebeMes, FunctionDebeMes, ParametersSaldo, frkValue, 2048, ftDatabase );
     dxSpreadSheetFunctionsRepository.Add( @StringHaberMes, FunctionHaberMes, ParametersSaldo, frkValue, 2048, ftDatabase );
     dxSpreadSheetFunctionsRepository.Add( @StringSaldoMes, FunctionSaldoMes, ParametersSaldo, frkValue, 2048, ftDatabase );

end;

procedure TBalancesInformesModule.DataModuleDestroy(Sender: TObject);
begin
     BalancesInformesModule := nil;
end;

//

procedure InicializaModuloBalancesInformes;
begin
     BalancesInformes;
end;

initialization
  AddProcedure( imOnEnterpriseAccess, 0, InicializaModuloBalancesInformes );

end.
