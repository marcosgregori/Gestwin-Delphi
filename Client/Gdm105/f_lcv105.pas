unit f_lcv105;

interface

uses Classes,

     AppContainer, DB, nxdb, DataManager, cxEdit,

     Gdm105Dm;

type TRptLcv105Module = class(TDataModule)
    VendedoresFacturaTable: TnxeTable;
    VendedoresFacturaTableEjercicio: TSmallintField;
    VendedoresFacturaTableSerie: TWideStringField;
    VendedoresFacturaTableNroFactura: TIntegerField;
    VendedoresFacturaTableNroRegistro: TSmallintField;
    VendedoresFacturaTableCodigoVendedor: TWideStringField;
    VendedoresFacturaTableNombre: TWideStringField;
    VendedoresFacturaTableImporteBase: TBCDField;
    VendedoresFacturaTableComision: TBCDField;
    procedure DataModuleCreate(Sender: TObject);
     private
       VendedoresFacturaFields : TVendedoresFacturaFields;
       procedure DoOnGeneraRegistroFactura;
       end;

var  RptLcv105Module: TRptLcv105Module = nil;

implementation

uses LibUtils,
     EnterpriseDataAccess,
     AppManager,
     AppForms,

     Gdm00Dm,
     Gim30Fields,

     dm_cli,
     dm_ven,
     dm_art,
     dm_fdv,
     dm_ecc,

     l_lcv;

{$R *.DFM}

procedure Setup;
begin
     If   Assigned( RptLcvForm )
     then begin
          RptLcv105Module := TRptLcv105Module.Create( RptLcvForm );
          RptLcvForm.OnGeneraRegistroFactura.Add( RptLcv105Module.DoOnGeneraRegistroFactura );
          end;
end;

procedure TRptLcv105Module.DataModuleCreate(Sender: TObject);
begin
     VendedoresFacturaFields := TVendedoresFacturaFields.Create( VendedoresFacturaTable );
end;

procedure TRptLcv105Module.DoOnGeneraRegistroFactura;

var  ImporteCobradoFra : Decimal;
     IncluirRegistro : Boolean;

begin

     With RptLcvForm do
       begin

       With FacturaVentasFields do
         begin

         If   DataTipoImportes.Value=1   // 0 = Todos, 1 = Solo los importes cobrados
         then With EfectoCobrarTable do
                begin
                ImporteCobradoFra := 0.0;
                SetRange( [ Ejercicio.Value, Serie.Value, NroFactura.Value, 0 ],
                          [ Ejercicio.Value, Serie.Value, NroFactura.Value, MaxSmallint ] );
                First;
                While not Eof do
                  begin
                  If   not EfectoCobrar.EfectoPendiente( EfectoCobrarFields )
                  then If   EfectoCobrarFields.NroRemesa.Value=0
                       then DecAdd( ImporteCobradoFra, EfectoCobrarFields.ImporteCobrado.Value )
                       else DecAdd( ImporteCobradoFra, EfectoCobrarFields.Importe.Value );
                  Next;
                  end;
                IncluirRegistro := Abs( ImporteCobradoFra )>=Abs( TotalFactura.Value );
                end
         else IncluirRegistro := True;

         If   not IncluirRegistro
         then Exit;

         Cliente.Obten( CodigoCliente.Value );

         With VendedoresFacturaTable do
           begin
           SetRange( [ Ejercicio.Value, Serie.Value, NroFactura.Value ] , [ Ejercicio.Value, Serie.Value, NroFactura.Value ] );
           First;
           While not Eof do
             begin

             If   ( VendedoresFacturaFields.CodigoVendedor.Value>=DataVendedorInicial.Value ) and
                  ( VendedoresFacturaFields.CodigoVendedor.Value<=DataVendedorFinal.Value )
             then begin

                  ConsultaTable.Append;

                  ImporteNetoFactura := VendedoresFacturaFields.ImporteBase.Value;
                  ImporteComisionFactura := ( ImporteNetoFactura * VendedoresFacturaFields.Comision.Value ) / 100.0;

                  ConsultaFields.CodigoVendedor.Value := VendedoresFacturaFields.CodigoVendedor.Value;
                  ConsultaFields.NombreVendedor.Value := Vendedor.Descripcion( VendedoresFacturaFields.CodigoVendedor.Value );
                  ConsultaFields.Fecha.Value := Fecha.Value;
                  ConsultaFields.Serie.Value := Serie.Value;
                  ConsultaFields.NroDocumento.Value := NroFactura.Value;
                  ConsultaFields.Importe.Value := ImporteNetoFactura;
                  ConsultaFields.Comision.Value := ImporteComisionFactura;

                  If   DataComisionReal.Value
                  then begin
                       If   ImporteNetoFactura<>0.0
                       then Porcentaje := ( ImporteComisionFactura * 100.0 ) / ImporteNetoFactura
                       else Porcentaje := 0.0;
                       end
                  else Porcentaje := VendedoresFacturaFields.Comision.Value;

                  ConsultaFields.Porcentaje.Value := Porcentaje;
                  ConsultaFields.CodigoCliente.Value := CodigoCliente.Value;
                  ConsultaFields.NombreCliente.Value := Cliente.Descripcion( CodigoCliente.Value, True );

                  ConsultaTable.Post;

                  ApplicationContainer.ShowProgression;
                  end;

             Next;
             end;
           end;
         end;
       end;

end;

initialization
  AddProcedure( imOnCreateComponent, idLiquidacionComisiones, Setup );

end.
