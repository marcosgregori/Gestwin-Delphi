unit b_lcl;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxMapControlTypes, dxMapControl,
  AppForms, dxMapItem, dxCustomMapItemLayer, dxMapItemLayer, cxClasses,
  dxMapLayer, dxMapImageTileLayer, dxMapControlBingMapImageryDataProvider, dxMapControlOpenStreetMapImageryDataProvider,
  dxBar, dxBarExtItems, dxSkinsCore, dxSkinsDefaultPainters,
  dxBingMapLocationDataService, dxBingMapRouteDataService,
  dxMapControlInformationProvider, dxMapControlBingMapInformationProviders,
  dxUIAClasses;

type
  TBoxLclForm = class(TgxForm)
    FormManager: TgxFormManager;
    dxMapControl1: TdxMapControl;
    dxMapControl1ImageTileLayer1: TdxMapImageTileLayer;
    dxMapControl1ItemLayer1: TdxMapItemLayer;
    dxMapControl1ItemLayer1CustomItem1: TdxMapCustomElement;
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    OpenStreetButton: TdxBarButton;
    dxBarStatic1: TdxBarStatic;
    CloseButton: TdxBarButton;
    dxMapControl1BingMapGeoCodingDataProvider: TdxMapControlBingMapGeoCodingDataProvider;
    SaveButton: TdxBarButton;
    procedure FormManagerCreateForm;
    procedure MapButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure dxMapControl1BingMapGeoCodingDataProviderResponse(Sender: TObject;
      AResponse: TdxBingMapLocationDataServiceResponse;
      var ADestroyResponse: Boolean);
    procedure SaveButtonClick(Sender: TObject);
  private
    FMapKind: TdxBingMapKind;
    FProviderId: Integer;
    Pushpin: TdxMapPushpin;

    procedure UpdateMapKind;
    procedure UpdateProvider;
  protected
    class var
    Nombre : String;
    Latitud,
    Longitud : Double;
    Direccion : String;
  public

  end;

var  BoxLclForm : TBoxLclForm = nil;

procedure LocalizacionCliente( Nombre : String; Latitud, Longitud : Double ); overload;
procedure LocalizacionCliente( Nombre : String; Direccion : String ); overload;

implementation

uses dxBingMapRESTService,

     AppManager,
     AppContainer,

     b_msg, a_cli;

{$R *.dfm}

const
  GestwinBingKey = 'Agw_WV_lWhJQ6r_NYySG1kjuaJDmeNpxNAMU5xCArNWmDK-pb_pX782bYriItcVJ';

  // GestwinBingKey = 'RaC46xuDJXVjcombIOII~4cTOU3P0U_qcKb3qu3pAOA~Ar_bacfvJW4jfPq5WsPdoXtTwcIJfv1J-DdzZz1RgTJEo2WeCiNT_l1M54ZKy9Nt';

resourceString
  RsMsg1 = 'No se ha podido localizar al cliente.';

procedure LocalizacionCliente( Nombre   : String;
                               Latitud,
                               Longitud : Double );
begin
     TBoxLclForm.Nombre := Nombre;
     TBoxLclForm.Latitud := Latitud;
     TBoxLclForm.Longitud := Longitud;
     CreateForm( fmBackground, TBoxLclForm, BoxLclForm );
     // CreateEditForm( TBoxLclForm, BoxLclForm );
end;

procedure LocalizacionCliente( Nombre    : String;
                               Direccion : String );
begin
     TBoxLclForm.Nombre := Nombre;
     TBoxLclForm.Direccion := Direccion;
     TBoxLclForm.Latitud := 0.0;
     TBoxLclForm.Longitud := 0.0;
     CreateForm( fmBackground, TBoxLclForm, BoxLclForm );
     // CreateEditForm( TBoxLclForm, BoxLclForm );
end;

procedure TBoxLclForm.CloseButtonClick(Sender: TObject);
begin
     Close;
end;

procedure TBoxLclForm.dxMapControl1BingMapGeoCodingDataProviderResponse(     Sender           : TObject;
                                                                             AResponse        : TdxBingMapLocationDataServiceResponse;
                                                                         var ADestroyResponse : Boolean );

var  ALocationInfo: TdxBingMapLocationInfo;

function CheckResponse( AResponse : TdxBingMapResponse ) : Boolean;
begin
     Result := False;
     If   AResponse<>nil
     then If   AResponse.IsSuccess
          then Result := True
          else If   AResponse.ErrorInfo <> nil
               then ShowNotification( ntWarning, RsMsg1, AResponse.ErrorInfo.ErrorDetails, AResponse.ErrorInfo.StatusDescription );
end;

begin
     If   CheckResponse( AResponse ) and ( AResponse.Locations.Count>0 )
     then begin
          ALocationInfo := nil;
          For ALocationInfo in AResponse.Locations do
            begin
            Pushpin := dxMapControl1ItemLayer1.MapItems.Add( TdxMapPushpin ) as TdxMapPushpin;
            Pushpin.Location.GeoPoint := ALocationInfo.Point;
            Pushpin.Text := Nombre;
            Pushpin.Hint := ALocationInfo.GetDisplayText;
            end;
          dxMapControl1.CenterPoint.GeoPoint := AResponse.Locations[0].Point;
          dxMapControl1.ZoomToGeoRect(ALocationInfo.BoundingBox);
          SaveButton.Enabled := True;
          end;
end;

procedure TBoxLclForm.FormManagerCreateForm;
begin

     If   ( Latitud=0.0 ) and ( Longitud=0.0 )
     then begin
          dxMapControl1BingMapGeoCodingDataProvider.BingKey := GestwinBingKey;
          dxMapControl1BingMapGeoCodingDataProvider.CancelRequests;
          dxMapControl1BingMapGeoCodingDataProvider.SearchAsync( Nombre + ' ' + Direccion );
          end
     else begin
          dxMapControl1ItemLayer1CustomItem1.Location.Latitude := Latitud;
          dxMapControl1ItemLayer1CustomItem1.Location.Longitude := Longitud;
          dxMapControl1ItemLayer1CustomItem1.Text := Nombre;
          end;

     dxMapControl1.CenterPoint := dxMapControl1ItemLayer1CustomItem1.Location;
     dxMapControl1.ZoomLevel := 17;
     // dxMapControl1ItemLayer1CustomItem1.Selected := True;
     FProviderId := 1;
     FMapKind := bmkRoad; // bmkHybrid;
     UpdateProvider;
end;

procedure TBoxLclForm.MapButtonClick(Sender: TObject);
begin
     If   ( Sender as TComponent ).Tag>0
     then begin
          FProviderId := 1;
          FMapKind := TdxBingMapKind( ( Sender as TComponent ).Tag - 1 );
          end
     else FProviderId := 0;
     UpdateProvider;
end;

procedure TBoxLclForm.SaveButtonClick(Sender: TObject);
begin
     If   Assigned( MntCliForm )
     then With MntCliForm do
            If   Assigned( Pushpin )
            then begin
                 FormManager.EditRecord;
                 ClienteFields.Latitud.Value := Pushpin.Location.GeoPoint.Latitude;
                 ClienteFields.Longitud.Value := Pushpin.Location.GeoPoint.Longitude;
                 end;
     Close;
end;

procedure TBoxLclForm.UpdateMapKind;
begin
     If   dxMapControl1ImageTileLayer1.Provider is TdxMapControlBingMapImageryDataProvider
     then TdxMapControlBingMapImageryDataProvider( dxMapControl1ImageTileLayer1.Provider ).Kind := FMapKind;
end;

procedure TBoxLclForm.UpdateProvider;
begin
     dxMapControl1.BeginUpdate;
     try
       If   FProviderId=1
       then begin
            dxMapControl1ImageTileLayer1.ProviderClass := TdxMapControlBingMapImageryDataProvider;
            ( dxMapControl1ImageTileLayer1.Provider as TdxMapControlBingMapImageryDataProvider ).BingKey := GestwinBingKey;
            UpdateMapKind;
            end
       else dxMapControl1ImageTileLayer1.ProviderClass := TdxMapControlOpenStreetMapImageryDataProvider;
       dxMapControl1ImageTileLayer1.Provider.MaxParallelConnectionCount := 30;
     finally
       dxMapControl1.EndUpdate;
       end;
end;

end.
