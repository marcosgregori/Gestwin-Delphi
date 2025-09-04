{$TYPEINFO ON}   // Rtti

unit gdm200Dm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  AppContainer,

  Gim00Fields;

type
  TDataModule200 = class(TDataModule)
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private

  public

  end;

var  DataModule200 : TDataModule200 = nil;

const  NroFormasPagoFacturaE = 16;
       TextoFormasPagoFacturaE : array[ 1..16 ] of String = ( 'Contado',
                                                              'Recibo domiciliado',
                                                              'Recibo',
                                                              'Transferencia',
                                                              'Letra aceptada',
                                                              'Crédito documentado',
                                                              'Contrato adjudicación',
                                                              'Letra',
                                                              'Pagare a orden',
                                                              'Pagare',
                                                              'Cheque',
                                                              'Reposición',
                                                              'Especiales',
                                                              'Compensación',
                                                              'Giro',
                                                              'SWIFT' );

implementation                                                                            

uses  AppForms,
      AppManager,

      EnterpriseDataAccess;

{$R *.dfm}

procedure Initialize;
begin
     CreateDataModule( TDataModule200, DataModule200 );
end;

procedure TDataModule200.DataModuleCreate(Sender: TObject);
begin
     //..
end;

procedure TDataModule200.DataModuleDestroy(Sender: TObject);
begin
     DataModule200 := nil;
end;

initialization
     AddProcedure( imStartup, 0, Initialize );

end.

