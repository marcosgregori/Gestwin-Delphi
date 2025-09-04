
unit g_dea;

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
    TGphDeaForm = class(TGphTemplateForm)
    ArticuloTable: TnxeTable;
    ArticuloTableCodigo: TWideStringField;
    ArticuloTableFamilia: TWideStringField;
   
    private

      Elemento : SmallInt;

    public

      function ObtenTipoPlantillaGrafico : TTipoPlantillaGrafico; override;
      procedure DoOnNroOperacionEditRequest(Sender: TcxCustomEdit); override;
      procedure DoOnInitialize; override;
      procedure DoOnCalculateSeries( NroEjercicio, SeriesIndex : SmallInt ); override;
    end;

var  GphDeaForm : TGphDeaForm = nil;

procedure GraficosArticulos;


implementation

uses   
       EnterpriseDataAccess,
       AppManager,

       dm_pga,
       dm_art,

       b_msg,
       
       a_pea,

       cx_plg;

{$R *.DFM}

procedure GraficosArticulos;
begin
     CreateEditForm( TGphDeaForm, GphDeaForm, [] );
end;

function TGphDeaForm.ObtenTipoPlantillaGrafico: TTipoPlantillaGrafico;
begin
     Result := pgArticulo;
end;

procedure TGphDeaForm.DoOnInitialize;
begin

end;

procedure TGphDeaForm.DoOnNroOperacionEditRequest(Sender: TcxCustomEdit);
begin
     MantenimientoPlantillaArticulo( [ Ord( pgArticulo ), Sender.Editingvalue, 0 ] );
end;

procedure TGphDeaForm.DoOnCalculateSeries( NroEjercicio, SeriesIndex: SmallInt);

var  AcumuladoUnidadesVendidas,
     AcumuladoImporteVentas,
     AcumuladoUnidadesCompradas,
     AcumuladoImporteCompras : Decimal;
     AcumuladoArticulo,
     AcumuladoTotal : TAcumuladoArticulo;
     NroMes,
     NroPeriodo : SmallInt;

procedure InsertaRegistroPeriodo( Periodo : SmallInt );

var   ValorNumerico : Decimal;

begin
     With AcumuladoTotal, LineaPlantillaGraficoFields do
       begin
       case Operacion[ 1 ].Value of
        0 : ValorNumerico := UnidadesComprasMes[ Periodo ];
        1 : begin
            AcumuladoUnidadesCompradas := AcumuladoUnidadesCompradas + UnidadesComprasMes[ Periodo ];
            ValorNumerico := AcumuladoUnidadesCompradas;
            end;
        2 : ValorNumerico := UnidadesVentasMes[ Periodo ];
        3 : begin
            AcumuladoUnidadesCompradas := AcumuladoUnidadesCompradas + UnidadesVentasMes[ Periodo ];
            ValorNumerico := AcumuladoUnidadesCompradas;
            end;
        4 : ValorNumerico := ImporteComprasMes[ Periodo ];
        5 : begin
            AcumuladoImporteCompras := AcumuladoImporteCompras + ImporteComprasMes[ Periodo ];
            ValorNumerico := AcumuladoImporteCompras;
            end;
        6 : ValorNumerico := ImporteVentasMes[ Periodo ];
        7 : begin
            AcumuladoImporteVentas := AcumuladoImporteVentas + ImporteVentasMes[ Periodo ];
            ValorNumerico := AcumuladoImporteVentas;
            end;
        8 : ValorNumerico := ImporteDescuentosComprasMes[ Periodo ];
        9 : ValorNumerico := ImporteDescuentosVentasMes[ Periodo ];
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

procedure AcumulaRegistro( CodigoArticulo : String );
begin
     With LineaPlantillaGraficoFields do
       Articulo.CalculaResultados( CodigoArticulo,
                                   False,
                                   Codigo[ 2 ].Value,  // Las mismas clases para todos los artículos
                                   Codigo[ 3 ].Value,
                                   Codigo[ 4 ].Value,
                                   '',
                                   NroEjercicio,
                                   0,
                                   ApplicationContainer.NroMesFinal,
                                   True,
                                   True,
                                   AcumuladoArticulo );

     Articulo.CalculaAcumulados( AcumuladoArticulo, AcumuladoTotal, 1, 12 );

end;

begin

     FillChar( AcumuladoTotal, SizeOf( AcumuladoTotal ), #0 );

     var FieldIndexArray := [ 1, 5, 6, 7, 8 ];

     With LineaPlantillaGraficoFields do
       For var Index := 0 to 4 do
         begin
         var CodigoElemento := Codigo[ FieldIndexArray[ Index ] ].Value;  // Código del artículo o familia
         If   CodigoElemento<>''
         then If   PlantillaGraficoFields.Operacion[ 3 ].Value=0  // Artículo
              then AcumulaRegistro( CodigoElemento )
              else begin
                   // Familia;Articulo
                   With ArticuloTable do
                     begin
                     SetRange( [ CodigoElemento ] );
                     First;
                     While not Eof do
                       begin
                       AcumulaRegistro( ArticuloTableCodigo.Value );
                       Next;
                       end;
                     end;
                   end;
         end;

     AcumuladoUnidadesCompradas := 0.0;
     AcumuladoUnidadesVendidas := 0.0;
     AcumuladoImporteVentas := 0.0;
     AcumuladoImporteCompras := 0.0;
	 
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

