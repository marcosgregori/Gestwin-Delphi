unit f_lma105;

interface

uses Classes,

     AppContainer;

type TListaMateriales105Module = class(TDataModule)
     private
       {
       procedure CorteEditValueChanged(Sender: TObject);
       procedure AnchoEditValueChanged(Sender: TObject);

       function ObtenCantidad( Corte, Ancho : Double ) : Double;
       }
       end;

var  ListaMateriales105Module: TListaMateriales105Module = nil;

implementation

uses AppForms,
     AppManager,

     Gdm00Dm,
     Gdm30Dm,
     Gim30Fields,

     a_lma,

     l_cli;

{$R *.DFM}

procedure SetupMntLma;
begin
     If   Assigned( MntLmaForm )
     then With MntLmaForm do
            begin

            ListaMateriales105Module := TListaMateriales105Module.Create( MntLmaForm );

            GridViewReferencia.Visible := True;

            With GridViewLargo do
              begin
              Visible := True;
              Caption := 'Corte';
              // Properties.OnEditValueChanged := ListaMateriales105Module.CorteEditValueChanged;
              end;

            With GridViewAncho do
              begin
              Visible := True;
              // Properties.OnEditValueChanged := ListaMateriales105Module.AnchoEditValueChanged;
              end;

            SetColumnsDecimals( [ GridViewLargo, GridViewAncho ], DataModule00.DmEmpresaFields.Ventas_DecCantidad.Value );


            end;
end;
{
function TListaMateriales105Module.ObtenCantidad( Corte, Ancho : Double ) : Double;
begin
     If   DblEqualZero( Ancho )
     then Result := 0.0
     else Result := Round( ( ( Corte * 0.8 ) / Ancho )  + 0.05 );
end;

procedure TListaMateriales105Module.CorteEditValueChanged(Sender: TObject);
begin
     With MntLmaForm, GridViewLargo do
       If   Editing
       then ListaComponentesFields.Cantidad.Value := ObtenCantidad( EditValue, ListaComponentesFields.Ancho.Value );
end;

procedure TListaMateriales105Module.AnchoEditValueChanged(Sender: TObject);
begin
     With MntLmaForm, GridViewAncho do
       If   Editing
       then ListaComponentesFields.Cantidad.Value := ObtenCantidad( ListaComponentesFields.Largo.Value, EditValue );
end;
}

procedure SetupRptCli;
begin
     If   Assigned( RptCliForm )
     then RptCliForm.Report.FileName := '\dm105\l_cli';
end;

initialization
  AddProcedure( imOnCreateComponent, idMntLmaForm, SetupMntLma );
  AddProcedure( imOnCreateComponent, idRptCliForm, SetupRptCli );

end.
