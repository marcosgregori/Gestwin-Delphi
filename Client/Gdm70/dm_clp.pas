
unit dm_clp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, StdCtrls,
  ExtCtrls, Controls, Forms, Dialogs, cxEdit,
  AppContainer,
  cxGridTableView,

  AppForms,
  DB,
  nxdb,

  DataManager,
  ReportManager,

  Gim30Fields,

  dm_cls;

type  TClaseProduccionModule = class( TDataModule )

        procedure ClaseProduccionModuleDestroy(Sender: TObject);

      private

      public

        function ExisteClase( NroClase : TNroClase ) : Boolean;
        function NombreClase( NroClase : TNroClase; Plural, Capital : Boolean ) : String;

        procedure SetupEditControls( EditControlClaseA, EditControlClaseB, EditControlClaseC : TcxCustomEdit;LabelLenght : ShortInt = 0; PanelableControl : Boolean = False );
        procedure SetupEditControl( EditControl : TcxCustomEdit; NroClase : TNroClase; LabelLenght : ShortInt = 0; PanelableControl  : Boolean = False );
        procedure EnableEditControls( EditControlClaseA, EditControlClaseB, EditControlClaseC : TcxCustomEdit; Enabled : Boolean = True );

        procedure SetupGridColumns( GridColumnClaseA, GridColumnClaseB, GridColumnClaseC : TcxGridColumn; LabelLenght : ShortInt = 0 );
        procedure SetupGridColumn( GridColumn : TcxGridColumn; NroClase : TNroClase; LabelLenght : ShortInt );
      end;

var ClaseProduccionModule: TClaseProduccionModule = nil;

function  ClaseProduccion : TClaseProduccionModule;

implementation

uses LibUtils,
     EnterpriseDataAccess,
     AppManager,

     Gdm00Dm,

     a_pde7;

{$R *.DFM}

function ClaseProduccion : TClaseProduccionModule;
begin
     CreateDataModule( TClaseProduccionModule, ClaseProduccionModule );
     Result := ClaseProduccionModule;
end;

procedure TClaseProduccionModule.ClaseProduccionModuleDestroy(Sender: TObject);
begin
     ClaseProduccionModule := nil;
end;

function TClaseProduccionModule.ExisteClase( NroClase: TNroClase ) : Boolean;
begin
     Result := Clase.ExisteClase( NroClase ) or ParametrosProduccionRec.ExisteClase[ NroClase ];
end;

function TClaseProduccionModule.NombreClase( NroClase : TNroClase; Plural, Capital : Boolean ) : String;

const TextoClase : String = 'Clase ';

begin
     Result := DataModule00.DmEmpresaFields.Articulo_NombreClase[ NroClase ].Value;
     If   Result=''
     then Result := ParametrosProduccionRec.NombreClase[ NroClase ];
     If   Result=''
     then Result := TextoClase + AnsiChar( 64 + Ord( NroClase ) )
     else Result := Capitaliza( Result, Capital, Plural );
end;

procedure TClaseProduccionModule.SetupGridColumns( GridColumnClaseA,
                                                   GridColumnClaseB,
                                                   GridColumnClaseC  : TcxGridColumn;
                                                   LabelLenght       : ShortInt = 0 );
begin
     SetupGridColumn( GridColumnClaseA, tcClaseA, LabelLenght );
     SetupGridColumn( GridColumnClaseB, tcClaseB, LabelLenght );
     SetupGridColumn( GridColumnClaseC, tcClaseC, LabelLenght );
end;

procedure TClaseProduccionModule.SetupGridColumn( GridColumn  : TcxGridColumn;
                                                  NroClase    : TNroClase;
                                                  LabelLenght : ShortInt );
begin
     With GridColumn do
       begin
       Visible := ExisteClase( NroClase );
       VisibleForCustomization := Visible;
       HeaderHint := NombreClase( NroClase, False, True );
       If   LabelLenght<>-1
       then If   Visible
            then If   LabelLenght=0
                 then Caption := NombreClase( NroClase, False, True )
                 else Caption := TextoCortado( NombreClase( NroClase, False, True ), LabelLenght );
       end;
end;

procedure TClaseProduccionModule.SetupEditControls( EditControlClaseA,
                                                    EditControlClaseB,
                                                    EditControlClaseC : TcxCustomEdit;
                                                    LabelLenght       : ShortInt = 0;
                                                    PanelableControl  : Boolean = False );
begin
     SetupEditControl( EditControlClaseA, tcClaseA, LabelLenght, PanelableControl );
     SetupEditControl( EditControlClaseB, tcClaseB, LabelLenght, PanelableControl );
     SetupEditControl( EditControlClaseC, tcClaseC, LabelLenght, PanelableControl );
end;

procedure TClaseProduccionModule.SetupEditControl( EditControl       : TcxCustomEdit;
                                                   NroClase          : TNroClase;
                                                   LabelLenght       : ShortInt = 0;
                                                   PanelableControl  : Boolean = False );
var PanelContainer : TPanel;

begin
     EditControl.Enabled := ExisteClase( NroClase );

     If   PanelableControl
     then SetupPanelableCtrl( EditControl, EditControl.Enabled );

     If   LabelLenght<>-1
     then If   EditControl.Enabled and Assigned( EditControl.CaptionLabel )
          then If   LabelLenght=0
               then EditControl.CaptionLabel.EditValue := NombreClase( NroClase, False, True )
               else EditControl.CaptionLabel.EditValue := TextoCortado( NombreClase( NroClase, False, True ), LabelLenght );
end;

procedure TClaseProduccionModule.EnableEditControls( EditControlClaseA,
                                                     EditControlClaseB,
                                                     EditControlClaseC : TcxCustomEdit;
                                                     Enabled           : Boolean = True );
begin
     EditControlClaseA.Enabled := ExisteClase( tcClaseA ) and Enabled;
     ValidateEditControl( EditControlClaseA );  // Esto sirve para actualizar el contenido y la descripción
     EditControlClaseB.Enabled := ExisteClase( tcClaseB ) and Enabled;
     ValidateEditControl( EditControlClaseB );
     EditControlClaseC.Enabled := ExisteClase( tcClaseC ) and Enabled;
     ValidateEditControl( EditControlClaseC );
end;

end.

