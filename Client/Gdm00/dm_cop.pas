unit dm_cop;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, cxEdit, cxTextEdit, cxLabel,

  DB, nxDB,

  DataManager,
  AppForms,

  Gim00Fields;


type
  TCodigoPostalModule = class(TDataModule)
    DmCodigoPostalTable: TnxeTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private

    CodigoPostalFields : TCodigoPostalFields;

  public

    function  Descripcion( CodigoPais, CodigoProvincia, CodigoPostal : Variant; NotificaSiNoExiste : Boolean = False ) : String;
    procedure DescLabel( CodigoPais, CodigoProvincia, CodigoPostal : Variant; ALabel : TcxCustomEdit );
    procedure Valida(     CodigoPais,
                          CodigoProvincia : Variant;
                          EditControl     : TcxCustomEdit;
                      var DisplayValue    : Variant;
                      var ErrorText       : TCaption;
                      var Error           : Boolean );

    procedure SetupCPControl( CodigoPais : String; CodigoProvinciaCtrls : array of TcxCustomTextEdit; CodigoPostalCtrls : array of TcxCustomTextEdit );
  end;

var  CodigoPostalModule: TCodigoPostalModule = nil;

function  CodigoPostal : TCodigoPostalModule;

implementation

uses AppManager,
     AppContainer,
     DataAccess,

     dm_prv;

{$R *.dfm}

function CodigoPostal : TCodigoPostalModule;
begin
     CreateDataModule( TCodigoPostalModule, codigoPostalModule );
     result := codigoPostalModule;
end;

procedure TCodigoPostalModule.DataModuleCreate(Sender: TObject);
begin
     CodigoPostalFields := TCodigoPostalFields.Create( DmCodigoPostalTable );
end;

procedure TCodigoPostalModule.DataModuleDestroy(Sender: TObject);
begin
     CodigoPostalModule := nil;
end;

function TCodigoPostalModule.Descripcion( CodigoPais,
                                          CodigoProvincia,
                                          CodigoPostal       : Variant;
                                          NotificaSiNoExiste : Boolean = False ) : string;
begin
     GetRelationDescription( DmCodigoPostaltable, [ CodigoPais, CodigoProvincia, CodigoPostal ], Result, NotificaSiNoExiste );
end;

procedure TCodigoPostalModule.DescLabel( CodigoPais,
                                         CodigoProvincia,
                                         CodigoPostal       : Variant;
                                         ALabel             : TcxCustomEdit );
var  StProvincia,
     StPoblacion,
     StDescripcion  : String;
     MPLength : SmallInt;

begin
     StPoblacion := Descripcion( CodigoPais, CodigoProvincia, CodigoPostal );
     StProvincia := Provincia.Descripcion( CodigoPais, CodigoProvincia, False );
     If   StPoblacion=''
     then ALabel.EditValue := StProvincia
     else begin
          MPLength := ( ALabel.Width div ALabel.Canvas.TextWidth( 'x' ) ) - Length( StProvincia );
          If   Length( StPoblacion )>MPLength
          then StDescripcion := Copy( StPoblacion, 1, MPLength ) + ' ... '
          else StDescripcion := StPoblacion;
          If   StProvincia<>''
          then StDescripcion := StDescripcion + ' (' + StProvincia + ')';
          ALabel.EditValue := StDescripcion;
          end;
end;

procedure TCodigoPostalModule.Valida(     CodigoPais,
                                          CodigoProvincia : Variant;
                                          EditControl     : TcxCustomEdit;
                                      var DisplayValue    : Variant;
                                      var ErrorText       : TCaption;
                                      var Error           : Boolean );
begin
     If   CodigoPais=CodigoEspaña
     then With EditControl do
            If   DisplayValue=''
            then Description := Provincia.Descripcion( CodigoPais, CodigoProvincia, False )
            else begin
                 DisplayValue := Copy( DisplayValue, 1, 3 );
                 DescLabel( CodigoPais, CodigoProvincia, DisplayValue, DescriptionLabel );
                 end;
end;

procedure TCodigoPostalModule.SetupCPControl( CodigoPais           : String;
                                              CodigoProvinciaCtrls : array of TcxCustomTextEdit;
                                              CodigoPostalCtrls    : array of TcxCustomTextEdit );

procedure SetDecriptionLabel( Control : TcxCustomTextEdit;
                              Caption : String );
begin
     TcxLabel( Control.CaptionLabel ).Caption := Caption;
     TcxLabel( Control.DescriptionLabel ).Caption := '';
end;

begin

     // Tienen que haber tantos controles de provincia como de código postal

     If   High( CodigoProvinciaCtrls ) = High( CodigoPostalCtrls )
     then begin
          For var Index := 0 to High( CodigoProvinciaCtrls ) do
            If   Assigned( CodigoProvinciaCtrls[ Index ] )   // Puede no estar asignado (ver MntCliForm)
            then begin

                 var CodigoProvinciaCtrl := CodigoProvinciaCtrls[ Index ];
                 var CodigoPostalCtrl := CodigoPostalCtrls[ Index ];

                 If   CodigoPais=CodigoEspaña
                 then begin
                      CodigoProvinciaCtrl.Enabled := True;
                      CodigoPostalCtrl.Left := CodigoProvinciaCtrl.Left + CodigoProvinciaCtrl.Width + 4;
                      CodigoPostalCtrl.Width := ScaledToCurrent( 35 );
                      SetDecriptionLabel( CodigoProvinciaCtrl, 'Provincia / C.P.' );
                      CodigoPostalCtrl.Properties.TextEditPad := tpLeftZero;
                      If   Length( CodigoPostalCtrl.EditValue )>3
                      then CodigoPostalCtrl.PostEditValue( Copy( CodigoPostalCtrl.EditValue, 1, 3 ) );
                      CodigoPostalCtrl.Properties.MaxLength := 3;
                      end
                 else begin
                      CodigoProvinciaCtrl.Enabled := False;
                      SetDecriptionLabel( CodigoProvinciaCtrl, 'Codigo postal' );
                      CodigoPostalCtrl.Left := CodigoProvinciaCtrl.Left;
                      CodigoPostalCtrl.Width := ScaledToCurrent( 85 );
                      CodigoPostalCtrl.Properties.TextEditPad := tpNone;
                      CodigoPostalCtrl.Properties.MaxLength := 8;
                      CodigoPostalCtrl.BringToFront;
                      end;
                 end;
          ResetTab;
          end;
end;

end.
