unit dm_tbf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AppContainer, StdCtrls, ExtCtrls, Generics.Collections,

  DB, AppForms, nxdb,

  AppManager,
  DataManager,

  Winapi.ActiveX,
  wgssSTU_TLB;

type
  TTabletButton = class( TComponent )
    private
      FOnClick : TSimpleEvent;
    public
      Bounds : TRect;  // in Screen coordinates
      Text : String;

      procedure DoOnClick;
      property OnClick : TSimpleEvent read FOnClick write FOnClick;
      end;

  TTabletaFirmaDataModule = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  public

    USBDevices : TUSBDevices;
    USBDevice : IUSBDevice;
    USBInterface : TUSBInterface;
    ProtocolHelper : TProtocolHelper;
    Tablet : TTablet;
    Capability : ICapability2;
    Information : IInformation;
    PenData : TList<IPenData>;

    FormManager : TgxFormManager;
    GraphicField : TGraphicField;

    PenIsDown : Integer; // The isDown flag is used like this: 0 = up, +ve = down, pressed on button number, -1 = down, inking -2 = down, ignoring

    FTabletFirmaConectado : Boolean;

    TabletWidth,
    TabletHeight : Integer;
    Buttons : Array[ 0..2 ] of TTabletButton;
    
    // Bitmap : TBitmap;            // This bitmap that we display on the screen.
    EncodingMode : TEncodingMode;   // How we send the bitmap to the device.
    EncodingFlag : Byte;
    UseColor : Boolean;
    BitmapData : PSafeArray;        // This is the flattened data of the bitmap that we send to the device.
    Encrypted : Boolean;
    TabletLocked : Boolean;

    MessageBounds : TRect;
    MessageA,
    MessageB : String;
    
    procedure DoCapturaFirma( AFormManager : TgxFormManager; AField : TGraphicField; MessageA, MessageB: String ); 
    procedure DoDesconecta;

    function ConectaTableta : Boolean;
    procedure CapturaFirma;
    procedure CleanUp;
    procedure DrawBackground;

    procedure PressOkButton;
    procedure PressClearButton;
    procedure PressCancelButton;
  private
    procedure BMPToVariant( ABitmap : TBitmap; var AVariant: OleVariant);
    procedure StreamToVariant(Stream: TMemoryStream; var V: OleVariant);
    function TabletToClient( PenData : IPenData ) : TPoint;
    function TabletToScreen( PenData : IPenData ) : TPoint;
    function ClientToScreen( Pt : TPoint ) : TPoint;
    procedure DrawInk( ACanvas : TCanvas; pd0 : IPenData; pd1 : IPenData ); overload;
    procedure DrawInk( ACanvas : TCanvas ); overload;
    procedure ClearScreen;

    procedure TabletOnGetReportException( ASender : TObject; const pException : ITabletEventsException );
    procedure TabletOnPenData( ASender: TObject; const pPenData : IPenData );
  public

  end;

var  TabletaFirmaDataModule : TTabletaFirmaDataModule = nil;

function TabletaFirma : TTabletaFirmaDataModule;

implementation

uses LibUtils,
     EnterpriseDataAccess,
     Files,
     
     cxGraphics,
     pngImage,

     AxCtrls,
     
     Gdm00Dm,
     Gim30Fields,

     dm_pga,
     dm_mov,

     dmi_mov,

     a_mve,
     a_tck,

     b_tbf,
     b_msg;

{$R *.dfm}

resourceString
     RsMsg1  = 'No se ha podido inicializar la tableta de firma.';
     RsMsg2  = 'Compruebe que el periférico esté conectado y que el driver está instalado y funcionando correctamente.';
     RsMsg3  = 'Se ha producido un error en la tableta de firma.';
     RsMsg4  = ''#13'Mensaje enviado por la tableta : ';
     RsMsg5  = 'Ha ocurrido un error y no se ha podido guardar la firma.';
     RsMsg6  = 'Reintente el proceso cuando lo considere oportuno.';
     RsMsg7  = 'No se ha realizado ningún trazo en la tableta de firma.';
     RsMsg8  = 'No se ha podido registrar y cargar la librería de la tableta de firma.';
     RsMsg9  = 'El periférico no estará disponible durante esta sesión.';

const  VendorId_Wacom = 1386;
       ProductId_500 = 161;
       ProductId_300 = 162;
       ProductId_520A = 163;
       ProductId_430 = 164;
       ProductId_530 = 165;
       ProductId_min = 161;
       ProductId_max = 175;

function TabletaFirma : TTabletaFirmaDataModule;
begin
     CreateDataModule( TTabletaFirmaDataModule, TabletaFirmaDataModule );
     Result := TabletaFirmaDataModule;
end;

procedure SetupAlbaranVentas;
begin
     If   TabletaFirma<>nil
     then With MntMveForm[ TipoMovimientoCreado ] do
            begin
            OnCapturaFirma.Add( TabletaFirmaDataModule.DoCapturaFirma );
            OnDesconectaTabletFirma.Add( TabletaFirmaDataModule.DoDesconecta );
            TabletFirmaConectado := TabletaFirma.ConectaTableta;
            end;
end;

procedure SetupTickets;
begin
     If   ( TabletaFirma<>nil ) and
          Assigned( MntTckForm )
     then With MntTckForm do
            begin
            OnCapturaFirma.Add( TabletaFirmaDataModule.DoCapturaFirma );
            OnDesconectaTabletFirma.Add( TabletaFirmaDataModule.DoDesconecta );
            TabletFirmaConectado := TabletaFirma.ConectaTableta;
            end;
end;

procedure SetupModule;
begin
     // Aprovecho para fijar el valor de seguridad del módulo
     Configuracion.AñadeModuloOpcional( moTabletaFirma );
end;

procedure TTabletaFirmaDataModule.DataModuleCreate(Sender: TObject);
begin
     USBDevices := TUSBDevices.Create( Self );
end;

procedure TTabletaFirmaDataModule.StreamToVariant(     Stream : TMemoryStream;
                                                   var V      : OleVariant );
var P : pointer;

begin
     V := VarArrayCreate ( [ 0, Stream.Size - 1 ], varByte );
     P := VarArrayLock( v );
     Stream.Position := 0;
     Stream.Read ( p^, Stream.Size );
     VarArrayUnlock ( V );
end;

procedure TTabletaFirmaDataModule.BMPToVariant(     ABitmap  : TBitmap;
                                                var AVariant : OleVariant );
var Stream : TMemoryStream;

begin
     try
       Stream := TMemoryStream.Create;
       ABitmap.SaveToStream( Stream );
       StreamToVariant( Stream, AVariant );
     finally
       Stream.Free;
       end;
end;

function TTabletaFirmaDataModule.TabletToClient( PenData : IPenData ) : TPoint;
begin
     // Client means the TabletImage coordinates.
     Result := Point( PenData.X * TabletaFirmaForm.TabletImage.Width div Capability.TabletMaxX, PenData.Y * TabletaFirmaForm.TabletImage.Height div Capability.TabletMaxY );
end;

function TTabletaFirmaDataModule.TabletToScreen( PenData : IPenData ) : TPoint;
begin
     // Screen means LCD screen of the tablet.
     result := Point( PenData.X * Capability.ScreenWidth div Capability.TabletMaxX,  PenData.Y * Capability.ScreenHeight div Capability.TabletMaxY );
end;

function TTabletaFirmaDataModule.ClientToScreen( Pt : TPoint ) : TPoint;
begin
     // client (window) coordinates to LCD screen coordinates.
     // This is needed for converting mouse coordinates into LCD bitmap coordinates as that's
     // what this application uses as the coordinate space for buttons.
     Result := Point( Round( pt.X * Capability.ScreenWidth / TabletaFirmaForm.TabletImage.Width ), Round( pt.Y * Capability.ScreenHeight / TabletaFirmaForm.TabletImage.Height ) );
end;

procedure TTabletaFirmaDataModule.DrawInk( ACanvas : TCanvas;
                                           pd0     : IPenData;
                                           pd1     : IPenData );

var  pt0, pt1 : TPoint;

begin
     pt0 := TabletToClient( pd0 );
     pt1 := TabletToClient( pd1 );
     ACanvas.MoveTo( pt0.x, pt0.y );
     ACanvas.LineTo( pt1.x, pt1.y );
end;

procedure TTabletaFirmaDataModule.DrawInk( ACanvas : TCanvas );

var  I : Integer;

begin
     ACanvas.Pen.Color := Configuracion.ParametrosGlbRec.ColorTrazoFirma;  // clBlack;
     ACanvas.Pen.Width := 2;
     For I := 1 to PenData.Count- 1 do
       If   ( PenData[ I - 1 ].sw <> 0 ) and ( PenData[ I ].sw<>0 )
       then DrawInk( ACanvas, PenData[ I - 1 ], PenData[ I ] );
end;

procedure TTabletaFirmaDataModule.ClearScreen;
begin
     DrawBackground;
     Tablet.DefaultInterface.WriteImage( EncodingMode, BitmapData );
     PenData.Clear;
     PenIsDown := 0;
     TabletaFirmaForm.TabletImage.Repaint;
end;

procedure TTabletaFirmaDataModule.TabletOnGetReportException(       ASender    : TObject;
                                                              const pException : ITabletEventsException );
begin
      ShowNotification( ntExceptionError, RsMsg3 );
      DestroyTabletaFirmaForm( False );
end;

procedure TTabletaFirmaDataModule.CleanUp;
begin
     If   Assigned( Tablet )
     then Tablet.Disconnect;
     FreeAndNil( Tablet );
     FreeAndNil( ProtocolHelper );
     FreeAndNil( PenData );
end;

procedure TTabletaFirmaDataModule.TabletOnPenData(       ASender  : TObject;
                                                   const PPenData : IPenData );

var  pt : TPoint;
     i,
     btn : Integer;
     IsDown : Boolean;

begin

     If   TabletLocked
     then Exit;

     pt := TabletToScreen( PPenData );

     btn := 0; // will be +ve if the pen is over a button.

     For i := 0 to 2 do
       If   Buttons[ i ].Bounds.Contains( pt )
       then begin
            btn := i + 1;
            Break;
            end;

     IsDown := PPenData.sw<>0;

     // This code uses a model of four states the pen can be in:
     // down or up, and whether this is the first sample of that state.

     If   IsDown
     then begin
          If   PenIsDown=0
          then begin
               // transition to down
               If   btn> 0
               then PenIsDown := btn  // We have put the pen down on a button. Track the pen without inking on the client.
               else PenIsDown := -1;  // We have put the pen down somewhere else.Treat it as part of the signature.
               end
          else If   ( PenData.Count<>0 ) and ( PenIsDown=-1) // already down, keep doing what we're doing! draw
               then begin
                    // Draw a line from the previous down point to this down point.
                    // This is the simplist thing you can do; a more sophisticated program
                    // can perform higher quality rendering than this!
                    DrawInk( TabletaFirmaForm.TabletImage.Canvas, PenData.Items[ PenData.Count - 1 ], PPenData );
                    end;
          // The pen is down, store it for use later.
          If   PenIsDown=-1
          then PenData.Add( PPenData );
          end
     else begin
          If   PenIsDown<>0
          then try
                 // transition to up
                 If   btn>0
                 then If   btn=PenIsDown   // The pen is over a button
                      then begin
                           Buttons[ btn - 1 ].DoOnClick;  // The pen was pressed down over the same button as is was lifted now. Consider that as a click!
                           Exit;
                           end;
               finally
                 PenIsDown := 0;
                 end;
          // Add up data once we have collected some down data.
          If   PenData.Count<>0
          then PenData.Add( PPenData );
          end;
end;

procedure TTabletaFirmaDataModule.DrawBackground;

var  I : Integer;
     Button : TTabletButton;
     BitmapVariant : OleVariant;
     LineYPos : Integer;
     TextBounds : TRect;
     
begin
     With TabletaFirmaForm.TabletImage.Canvas do
       begin

       Pen.Color := clActiveBorder;
       Brush.Color := clWhite;
       Pen.Width := 1;

       Rectangle( 0, 0, TabletWidth, TabletHeight );

       For I := 0 to 2 do
         begin
         Button := Buttons[ I ];
         If   UseColor
         then begin
              Brush.Color := clLtGray;
              FillRect( Button.Bounds );
              end;
         
         Pen.Color := clBlack;
         Brush.Style := bsClear;
         // Brush.Color := clNone;
         Rectangle( Button.Bounds );

         TextRect( Button.Bounds, Button.Text, [ tfSingleLine, tfCenter, tfVerticalCenter ] );
         end;

       If   MessageA<>''
       then begin
            Pen.Style := psDot;            
            MoveTo( MessageBounds.Left, MessageBounds.Top );
            LineTo( MessageBounds.Right, MessageBounds.Top );
            TextBounds := Bounds( MessageBounds.Left, MessageBounds.Top + 4, MessageBounds.Width, 18 );
            TextRect( TextBounds, MessageA, [ tfSingleLine, tfRight, tfVerticalCenter ] );
            If   MessageB<>''
            then begin
                 TextBounds := Bounds( MessageBounds.Left, MessageBounds.Top + 18, MessageBounds.Width, 18 );
                 TextRect( TextBounds, MessageB, [ tfSingleLine, tfRight, tfVerticalCenter ] );
                 end;
            end;
         
       Pen.Style := psSolid;
       Pen.Color := Configuracion.ParametrosGlbRec.ColorTrazoFirma;
       Pen.Width := 2;  // Para la firma
       end;

     // Now the bitmap has been created, it needs to be converted to device-native format.

     BMPToVariant( TabletaFirmaForm.TabletImage.Picture.Bitmap, BitmapVariant );
     BitmapData := ProtocolHelper.flatten_( BitmapVariant, TabletWidth, TabletHeight, EncodingMode );

     (*
     // If you wish to further optimize image transfer, you can compress the image using
     // the Zlib algorithm.
     boolean useZlibCompression = false;

     if (!useColor && useZlibCompression) {
         // m_bitmapData = compress_using_zlib(m_bitmapData); // insert compression here!
         // m_encodingMode = EncodingMode.EncodingMode_1bit_Zlib;
     }
     *)
end;

function TTabletaFirmaDataModule.ConectaTableta : Boolean;

const hp = 12;  // Pad horizontal
      vp = 4;   // Pad vertical

var  ErrorCode : IErrorCode;
     w, bw, x, y, h, h1, h2, h3  : Integer;
     DevicesCount : Integer;

begin

     FTabletFirmaConectado := False;

     If   not DataModule00.DmUsuarioFields.Ventas_DesactivarTabletaFirma.Value
     then begin

          DestroyTabletaFirmaForm( False );  // Por si acaso

          CleanUp;

          try
            DevicesCount := USBDevices.Count;
          except
            ShowNotification( ntExceptionError, RsMsg8, RsMsg9 );
            Exit;
            end;

         If   DevicesCount>0
         then begin                   
              USBDevice := USBDevices.Item[ 0 ];
              try                                 
                Tablet := TTablet.Create( Self );
                PenData := TList< IPenData >.Create;
                ErrorCode := Tablet.DefaultInterface.USBConnect( USBDevice, False );
                If   ErrorCode.value=0
                then begin
                     ProtocolHelper := TProtocolHelper.Create( Self );

                     Capability := Tablet.DefaultInterface.GetCapability2;
                     Information := Tablet.DefaultInterface.GetInformation;

                     TabletWidth := Capability.ScreenWidth;
                     TabletHeight := Capability.ScreenHeight;

                     Buttons[ 0 ] := TTabletButton.Create( Self );
                     Buttons[ 1 ] := TTabletButton.Create( Self );
                     Buttons[ 2 ] := TTabletButton.Create( Self );

                     If   Tablet.GetProductId<>ProductId_300
                     then begin

                          bw := ( TabletWidth - ( hp * 4 ) ) div 3;

                          y := TabletHeight * 6 div 7;
                          h := TabletHeight - y - vp;

                          Buttons[ 0 ].Bounds := Bounds( hp, y, bw, h );
                          Buttons[ 1 ].Bounds := Bounds( bw + ( hp * 2 ), y, bw, h );
                          Buttons[ 2 ].Bounds := Bounds( ( bw * 2 ) + ( hp * 3 ), y, bw, h );

                          MessageBounds := Bounds( hp, y - 42, TabletWidth - ( hp * 2 ), 40 );
                          end
                     else begin

                          // EL STU-300 es muy estrecho y es mejor poner los botones a la derecha

                          x := TabletWidth * 3 div 4;
                          w := TabletWidth - x;

                          h2 := TabletHeight div 3;
                          h3 := TabletHeight div 3;
                          h1 := TabletHeight - h2 - h3;

                          Buttons[ 0 ].Bounds := Bounds( x, 0, w, h1 + 1 );
                          Buttons[ 1 ].Bounds := Bounds( x, h1, w, h2 + 1 );
                          Buttons[ 2 ].Bounds := Bounds( x, h1 + h2, w, h3 );

                          MessageBounds := Bounds( 4, TabletHeight - 42, TabletWidth - x - 4, 40 );
                          end;

                     Buttons[ 0 ].Text := 'Aceptar';
                     Buttons[ 1 ].Text := 'Limpiar';
                     Buttons[ 2 ].Text := 'Cancelar';

                     Buttons[ 0 ].OnClick := PressOkButton;
                     Buttons[ 1 ].OnClick := PressClearButton;
                     Buttons[ 2 ].OnClick := PressCancelButton;

                     EncodingFlag := ProtocolHelper.SimulateEncodingFlag( Tablet.GetProductId, Capability.EncodingFlag );
                     UseColor := ProtocolHelper.EncodingFlagSupportsColor( EncodingFlag );

                     // Disable color if the bulk driver isn't installed.
                     // This isn't necessary, but uploading colour images with out the driver
                     // is very slow.

                     UseColor := UseColor and Tablet.DefaultInterface.SupportsWrite;

                     // Calculate the encodingMode that will be used to update the image

                     If   UseColor
                     then begin
                          If   Tablet.DefaultInterface.SupportsWrite
                          then EncodingMode := EncodingMode_16bit_Bulk
                          else EncodingMode := EncodingMode_16bit;
                          end
                     else EncodingMode := EncodingMode_1bit;

                     If   ProtocolHelper.DefaultInterface.SupportsEncryption( Tablet.Protocol2 )
                     then begin
                          Tablet.DefaultInterface.StartCapture( $C0FFEE );
                          Encrypted := True;
                          end;

                     // Enable the pen data on the screen (if not already)

                     Tablet.DefaultInterface.SetInkingMode( InkingMode_On );

                     Tablet.OnonGetReportException := TabletOnGetReportException;
                     Tablet.OnonPenData := TabletOnPenData;

                     FTabletFirmaConectado := True;
                     end
                else ShowNotification( ntWarning, RsMsg1, RsMsg2 + RsMsg4 + ErrorCode.Get_Message );

              except
                end;
              end;
         end;

     Result := FTabletFirmaConectado;
end;

procedure TTabletaFirmaDataModule.CapturaFirma;
begin
     ConectaTableta;
     If   FTabletFirmaConectado
     then begin

          TabletLocked := False;

          CreateTabletaFirmaForm;

          TabletaFirmaForm.TabletImage.Width := TabletWidth;
          TabletaFirmaForm.TabletImage.Height := TabletHeight;

          TabletaFirmaForm.Width := TabletWidth + 72;
          TabletaFirmaForm.Height := TabletHeight + 54;
          
          ClearScreen;
          end;
end;

procedure TTabletaFirmaDataModule.DataModuleDestroy(Sender: TObject);
begin
     CleanUp;
     TabletaFirmaDataModule := nil;
end;

procedure TTabletaFirmaDataModule.DoCapturaFirma( AFormManager   : TgxFormManager;
                                                  AField         : TGraphicField;
                                                  MessageA,
                                                  MessageB       : String );
begin
     FormManager := AFormManager;
     GraphicField := AField;
     Self.MessageA := MessageA;
     Self.MessageB := MessageB;
     CapturaFirma;
end;

procedure TTabletaFirmaDataModule.DoDesconecta;
begin
     USBDevices.Disconnect;
end;

procedure TTabletaFirmaDataModule.PressCancelButton;
begin
     DestroyTabletaFirmaForm;
end;

procedure TTabletaFirmaDataModule.PressClearButton;
begin
     ClearScreen;
end;

procedure TTabletaFirmaDataModule.PressOkButton;

var Stream : TMemoryStream;
    SourceBitmap : TBitmap;
    PngImage : TPngImage;

begin

     If   PenData.Count=0
     then begin
          ShowNotification( ntWarning, RsMsg7 );
          Exit;
          end;

     TabletLocked := True;
     // Hay que guardar la imagen
     If   Assigned( GraphicField ) and
          Assigned( FormManager )
     then try

            SourceBitmap := TBitmap.Create;
            PngImage := TPngImage.Create;
            Stream := TMemoryStream.Create;
            try

               // Los intentos que he hecho de dibujar directamente sobre el PngImage han sido infructuosos
               // De todas formas al convertir el Bitmap en Png se consigue algo de antialias y la firma mejora en apariencia

               SourceBitmap.Width := TabletWidth;
               SourceBitmap.Height := TabletHeight;

               DrawInk( SourceBitmap.Canvas );

               PngImage.Assign( SourceBitmap );
               PngImage.SaveToStream( Stream );

               try

                 GraphicField.DataSet.Edit;  // Por si acaso

                 Stream.Position := 0;
                 GraphicField.LoadFromStream( Stream );

                 GraphicField.DataSet.Post;

               except
                 GraphicField.DataSet.Cancel;
                 raise;
                 end;

               FormManager.SelectFirstKeyControl;

            finally
              PngImage.Free;
              SourceBitmap.Free;
              Stream.Free;
              end;

          except on E : Exception do
            ShowNotification( ntExceptionError, RsMsg5, RsMsg6 + ''#13'Excepción : ' +  E.Message );
            end;

     DestroyTabletaFirmaForm( False );

     MessageA := '';
     MessageB := '';
     
     ClearScreen;
end;

{ TTabletButton }

procedure TTabletButton.DoOnClick;
begin
     If   Assigned( FOnClick )
     then FOnClick;
end;

initialization

   AddProcedure( imStartup, 0, SetupModule );

   AddProcedure( imOnCreateComponent, idMntMveForm, SetupAlbaranVentas );
   AddProcedure( imOnCreateComponent, idMntTckForm, SetupTickets );

end.
