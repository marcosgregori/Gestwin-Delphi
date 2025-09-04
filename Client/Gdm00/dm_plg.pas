
unit dm_plg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, cxEdit,

  AppContainer,
  AppForms,

  DB, nxdb, DataManager,

  Gim00Fields;

type  TTipoPlantillaGrafico = ( pgSaldos,
                                pg1,
                                pg2,
                                pg3,
                                pg4,
                                pgCliente,
                                pgClienteConsumo,
                                pgProveedor,
                                pgProveedorConsumo,
                                pgVendedor,
                                pgArticulo );


  TPlantillaGraficoModule = class(TDataModule)
    DmPlantillaGraficoTable: TnxeTable;
    procedure PlantillaGraficoModuleCreate(Sender: TObject);
    procedure PlantillaGraficoModuleDestroy(Sender: TObject);
  private

    DmPlantillaGraficoFields  : TPlantillaGraficoFields;

    procedure DoOnShowChartEditor( Sender : TObject );

  public

    function ProximaOperacion( Tipo : TTipoPlantillaGrafico ) : LongInt;
    procedure Valida( EditControl : TcxCustomEdit; Tipo : TTipoPlantillaGrafico; var DisplayValue : Variant; var ErrorText : TCaption; var Error : Boolean; IsInfoControl : Boolean = False );
    function  Descripcion( Tipo : TTipoPlantillaGrafico; NroOperacion : LongInt; NotificaSiNoExiste : boolean ) : string;
    function ObtenEjercicio( LineaPlantillaGraficoFields: TPlantillaGraficoFields): SmallInt;
  end;

var  PlantillaGraficoModule: TPlantillaGraficoModule = nil;


function  PlantillaGrafico : TPlantillaGraficoModule;

implementation

{$R *.dfm}

uses   LibUtils,
       AppManager,

       b_msg;

function PlantillaGrafico : TPlantillaGraficoModule;
begin
     CreateDataModule( TPlantillaGraficoModule, PlantillaGraficoModule );
     Result := PlantillaGraficoModule;
end;

procedure TPlantillaGraficoModule.PlantillaGraficoModuleCreate(Sender: TObject);
begin
     DmPlantillaGraficoFields := TPlantillaGraficoFields.Create( DmPlantillaGraficoTable );
end;

procedure TPlantillaGraficoModule.PlantillaGraficoModuleDestroy(Sender: TObject);
begin
     PlantillaGraficoModule := nil;
end;

function TPlantillaGraficoModule.ProximaOperacion( Tipo : TTipoPlantillaGrafico ) : LongInt;
begin
     With DmPlantillaGraficoTable do
       If   FindEqualLast( [ Ord( Tipo ) ] )
       then Result := DmPlantillaGraficoFields.NroOperacion.Value + 1
       else Result := 1;
end;

procedure TPlantillaGraficoModule.Valida(    EditControl   : TcxCustomEdit;
                                             Tipo          : TTipoPlantillaGrafico;
                                         var DisplayValue  : Variant;
                                         var ErrorText     : TCaption;
                                         var Error         : Boolean;
                                             IsInfoControl : Boolean = False );
begin
     ValidateRelationEx( EditControl, DmPlantillaGraficoTable, [ Ord( Tipo ), DisplayValue, 0 ], DisplayValue, ErrorText, Error, nil, RsDescripcion, IsInfoControl );
end;

function TPlantillaGraficoModule.Descripcion( Tipo               : TTipoPlantillaGrafico;
                                              NroOperacion       : LongInt;
                                              NotificaSiNoExiste : Boolean ) : string;
begin
     GetRelationDescription( DmPlantillaGraficoTable, [ Ord( Tipo ), NroOperacion, 0 ],  Result, NotificaSiNoExiste, RsDescripcion );
end;

procedure TPlantillaGraficoModule.DoOnShowChartEditor( Sender : TObject );
begin
     If  Sender is TForm
     then With TForm( Sender ) do
            begin
            Position := poMainFormCenter;
            Width := 600;
            Height := 500;
            end;
end;

function TPlantillaGraficoModule.ObtenEjercicio( LineaPlantillaGraficoFields : TPlantillaGraficoFields ) : SmallInt;
begin
     // Los valores menores o iguales a cero permiten utilizar ejercicios relativos al actual

     If   LineaPlantillaGraficoFields.Ejercicio.Value<=0
     then Result := ApplicationContainer.Ejercicio + LineaPlantillaGraficoFields.Ejercicio.Value
     else Result := LineaPlantillaGraficoFields.Ejercicio.Value;
end;

end.

