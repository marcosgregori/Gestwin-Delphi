unit f_cpe40;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,

  cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,

  Menus,
  cxLookAndFeelPainters,
  cxButtons,

  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  nxdb, DataManager, cxCurrencyEdit,

  LibUtils,
  AppContainer,
  AppForms,

  Gim30Fields,
  Gim40Fields,

  l_cpe;

type
  TRptCpe40Module = class(TDataModule)
    DmHojaCargaTable: TnxeTable;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    NroLinea : SmallInt;

    DmHojaCargaFields : THojaCargaFields;

  public
    function DoProcesaRegistroCarga( TipoInsercion : TTipoInsercionRegistro; CodTransportista : String = ''; LineaMovimientoOrigenFields : TLineaMovimientoFields = nil ) : Decimal;
  end;

var RptCpe40Module : TRptCpe40Module = nil;

implementation

uses AppManager,
     EnterpriseDataAccess,

     Gim00Fields,

     dmi_mov,

     dm_hdc,
     dm_mov,
     dm_rdr,

     a_pde4,

     b_msg;

{$R *.dfm}

resourceString
      RsMsg1 = 'No se ha creado ninguna hoja de carga.';
      RsMsg2 = 'No hay ninguna cantidad pendiente de carga en los documentos seleccionados.'#13'Se cancela el proceso.';

procedure SetupListadoCarga;
begin
     CreateDataModule( TRptCpe40Module, RptCpe40Module );
     If   Assigned( RptCpeForm )
     then With RptCpeForm do
            If   ( ( ParametrosAprovisionamientoRec.DocumentoHojaCarga=0 ) and ( TipoMovimiento=tmPedidoVenta ) ) or
                 ( ( ParametrosAprovisionamientoRec.DocumentoHojaCarga=1 ) and ( TipoMovimiento=tmVenta ) )
            then begin
                 OnProcesaRegistroCarga.Add( RptCpe40Module.DoProcesaRegistroCarga );
                 CrearHojaCargaCtrl.Visible := True;
                 Height := Height + 12;
                 end;
end;

// !!! La reasignaci�n de n�meros de registro se ha trasladado al servidor

procedure TRptCpe40Module.DataModuleCreate(Sender: TObject);
begin
     DmHojaCargaFields := THojaCargaFields.Create( DmHojaCargaTable );
end;

procedure TRptCpe40Module.DataModuleDestroy(Sender: TObject);
begin
     RptCpe40Module := nil;
end;

function TRptCpe40Module.DoProcesaRegistroCarga( TipoInsercion               : TTipoInsercionRegistro;
                                                 CodTransportista            : String = '';
                                                 LineaMovimientoOrigenFields : TLineaMovimientoFields = nil ) : Decimal;
begin

     // Todo este proceso est� inclu�do en una transacci�n iniciada en RptCpeForm

     Result := 0.0;
     If   RptCpeForm.DataCrearHojaCarga.Value
     then case TipoInsercion of
            irCabecera : begin                         // Hay que crear la cabecera
                         DmHojaCargaTable.Append;
                         With DmHojaCargaFields do
                           begin
                           Ejercicio.Value := ApplicationContainer.Ejercicio;
                           NroHoja.Value := HojaCarga.ProximoNroHoja;
                           Fecha.Value := ApplicationContainer.TodayDate;
                           CodigoTransportista.Value := CodTransportista;
                           end;
                         NroLinea := 1;
                         end;
            irLinea    : Result := HojaCarga.InsertaLinea( DmHojaCargaFields, LineaMovimientoOrigenFields, NroLinea );
            irPie      : If   NroLinea=1
                         then begin
                              DmHojaCargaTable.Cancel;
                              ShowNotification( ntStop, RsMsg1, RsMsg2 );
                              Abort;
                              end
                         else DmHojaCargaTable.Post;
            end;
end;

initialization
   AddProcedure( imOnCreateComponent, idRptCpeForm, SetupListadoCarga );

end.
