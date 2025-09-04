
unit g_dep;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons, Grids,
  Mask, ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb, DataManager,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,

  cxGraphics, cxLookAndFeels, dxSkinsCore, dxSkinsDefaultPainters,
  cxLabel, cxGroupBox, cxStyles, cxCustomData, cxDBData,
  cxGridLevel, cxGridChartView, cxGridDBChartView, cxClasses, cxGridCustomView,
  cxGrid, dxmdaset, dxPScxGridLnk,

  LibUtils,
  AppContainer,

  Gim00Fields,
  Gim10Fields,

  dm_plg,

  p_gph;

type
    TGphDepForm = class(TGphTemplateForm)
   
    private

    public
      function ObtenTipoPlantillaGrafico : TTipoPlantillaGrafico; override;
      procedure DoOnNroOperacionEditRequest(Sender: TcxCustomEdit); override;
      procedure DoOnInitialize; override;
      procedure DoOnCalculateSeries( NroEjercicio, SeriesIndex : SmallInt ); override;
    end;

var  GphDepForm : TGphDepForm = nil;

procedure GraficosProveedores;


implementation

uses   AppManager,
   
       EnterpriseDataAccess,

       dm_pga,
       dm_pro,
       dm_rpr,

       b_msg,
  
       a_pep,

       cx_plg;

{$R *.DFM}

procedure GraficosProveedores;
begin
     CreateEditForm( TGphDepForm, GphDepForm, [] );
end;

function TGphDepForm.ObtenTipoPlantillaGrafico: TTipoPlantillaGrafico;
begin
     Result := pgProveedor;
end;

procedure TGphDepForm.DoOnInitialize;
begin
end;

procedure TGphDepForm.DoOnNroOperacionEditRequest(Sender: TcxCustomEdit);
begin
     MantenimientoPlantillaProveedor( [ Ord( pgProveedor ), Sender.Editingvalue, 0 ] );
end;

procedure TGphDepForm.DoOnCalculateSeries( NroEjercicio, SeriesIndex: SmallInt);

var   SumaImporteAcumulado,
      SumaDescuentosAcumulado : Decimal;
      NroMes,
      NroPeriodo : SmallInt;

procedure InsertaRegistroPeriodo( Periodo : SmallInt );

var   ValorNumerico : Decimal;

begin
     With RelacionesProveedor.ProveedorDatEconFields, LineaPlantillaGraficoFields do
       begin
       case Operacion[ 1 ].Value of
        0 : ValorNumerico := Compras[ Periodo ].Value;
        1 : begin
            SumaImporteAcumulado := SumaImporteAcumulado + Compras[ Periodo ].Value;
            ValorNumerico := SumaImporteAcumulado;
            end;
        2 : ValorNumerico := Descuentos[ Periodo ].Value;
        3 : begin
            SumaDescuentosAcumulado := SumaDescuentosAcumulado + Descuentos[ Periodo ].Value;
            ValorNumerico := SumaDescuentosAcumulado;
            end;
        4 : If   Compras[ Periodo ].Value=0.0
            then ValorNumerico := 0.0
            else ValorNumerico := ( Descuentos[ Periodo ].Value * 100 ) / Compras[ Periodo ].Value;
        end;

       If   GridData.Locate( 'NroPeriodo', Periodo, [] )
       then GridData.Edit
       else begin
            GridData.Append;
            GridData.FieldValues[ 'NroPeriodo' ] := Periodo;
            GridData.FieldValues[ 'TextoPeriodo' ] := StrMonth( Periodo, True );
            end;

       GridData.FieldValues[ 'Valor' + IntToStr( SeriesIndex ) ] := ValorNumerico;

       GridData.Post;
       end;

end;

begin
     RelacionesProveedor.DmProveedorDatEconTable.FindKey( [ NroEjercicio, LineaPlantillaGraficoFields.Codigo[ 1 ].Value ] );

     SumaImporteAcumulado := 0.0;
     SumaDescuentosAcumulado := 0.0;

     NroMes := ApplicationContainer.NroMesInicial;
     NroPeriodo := 1;

     repeat
       InsertaRegistroPeriodo( NroMes );
       Inc( NroPeriodo );
       Inc( NroMes );
       If   NroMes=13
       then NroMes := 1;
     until NroPeriodo=13;

end;

end.

