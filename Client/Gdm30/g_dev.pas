
unit g_dev;

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
    TGphDevForm = class(TGphTemplateForm)

    private
      
    public

      function ObtenTipoPlantillaGrafico : TTipoPlantillaGrafico; override;
      procedure DoOnNroOperacionEditRequest(Sender: TcxCustomEdit); override;
      procedure DoOnInitialize; override;
      procedure DoOnCalculateSeries( NroEjercicio, SeriesIndex : SmallInt ); override;
    end;

var  GphDevForm : TGphDevForm = nil;

procedure GraficosVendedores;


implementation

uses   DateUtils,
       AppManager,
       AppForm,

       EnterpriseDataAccess,

       dm_pga,
       dm_ven,

       b_msg,

       a_pev,

       cx_plg;

{$R *.DFM}

procedure GraficosVendedores;
begin
     CreateEditForm( TGphDevForm, GphDevForm, [] );
end;


function TGphDevForm.ObtenTipoPlantillaGrafico: TTipoPlantillaGrafico;
begin
     Result := pgVendedor;
end;
procedure TGphDevForm.DoOnInitialize;
begin

end;

procedure TGphDevForm.DoOnNroOperacionEditRequest(Sender: TcxCustomEdit);
begin
     MantenimientoPlantillaVendedor( [ Ord( pgVendedor ), Sender.Editingvalue, 0 ] );
end;

procedure TGphDevForm.DoOnCalculateSeries( NroEjercicio, SeriesIndex: SmallInt);

var   SumaImporteAcumulado,
      SumaComisionesAcumulado : Decimal;
      NroMes,
      NroPeriodo : SmallInt;

procedure InsertaRegistroPeriodo( Periodo : SmallInt );

var   ValorNumerico : Decimal;

begin
     With Vendedor.DmVendedorDatEconFields, LineaPlantillaGraficoFields do
       begin
       case Operacion[ 1 ].Value of
         0 : ValorNumerico := Ventas[ Periodo ].Value;
         1 : begin
             SumaImporteAcumulado := SumaImporteAcumulado + Ventas[ Periodo ].Value;
             ValorNumerico := SumaImporteAcumulado;
             end;
         2 : ValorNumerico := Comision[ Periodo ].Value;
         3 : begin
             SumaComisionesAcumulado := SumaComisionesAcumulado + Comision[ Periodo ].Value;
             ValorNumerico := SumaComisionesAcumulado;
             end;
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

     Vendedor.DmVendedorDatEconTable.FindKey( [ NroEjercicio, LineaPlantillaGraficoFields.Codigo[ 1 ].Value ] );

     SumaImporteAcumulado := 0.0;
     SumaComisionesAcumulado  := 0.0;
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
