unit f_dcm114;

interface

uses Classes,

     AppContainer, DB, nxdb, DataManager,

     Gim30Fields,
     Gim114Fields,
     
     Gdm114Dm;

type TDCMFunctionsModule = class(TDataModule)
    DmDocumentoControlMercanciasTable: TnxeTable;
    procedure DataModuleCreate(Sender: TObject);
     private
       DmDocumentoControlMercanciasFields : TDocumentoControlMercanciasFields;
       procedure DoBeforePostMovimientoCompra( MovimientoFields : TMovimientoFields );
       procedure DoBeforeDeleteMovimientoCompra( MovimientoFields : TMovimientoFields );
       procedure DoBeforePostMovimientoVenta( MovimientoFields : TMovimientoFields );
       procedure DoBeforeDeleteMovimientoVenta( MovimientoFields : TMovimientoFields );
       procedure DoMuestraDocumentoOrigen( MovimientoFields : TMovimientoFields );
       end;

var  DCMFunctionsModule : TDCMFunctionsModule = nil;

implementation

uses LibUtils,
     EnterpriseDataAccess,
     AppManager,
     AppForms,

     a_mco,
     a_mve,
     a_dcm114,

     dmi_mov,

     dm_mov,
     dm_dcm114;

{$R *.DFM}

resourceString
    RsMsg1  = 'No se ha podido localizar el documento de control de mercancias';
    RsMsg2  = 'El documento vinculado a este albaran no existe.'#13'Se ha suprimido la relación entre ambos.';

procedure TDCMFunctionsModule.DataModuleCreate(Sender: TObject);
begin
     DmDocumentoControlMercanciasFields := TDocumentoControlMercanciasFields.Create( DmDocumentoControlMercanciasTable );
end;

// Compras

procedure SetupMantenimientoCompras;
begin
     If   Assigned( MntMcoForm[ tmCompra ] ) and
          ( TipoMovimientoCreado=tmCompra )
     then begin
          CreateDataModule( TDCMFunctionsModule, DCMFunctionsModule );
          MntMcoForm[ tmCompra ].BeforePostMovimiento.Add( DCMFunctionsModule.DoBeforePostMovimientoCompra );
          MntMcoForm[ tmCompra ].BeforeDeleteMovimiento.Add( DCMFunctionsModule.DoBeforeDeleteMovimientoCompra );
          MntMcoForm[ tmCompra ].OnMuestraDocumentoOrigen.Add( DCMFunctionsModule.DoMuestraDocumentoOrigen );
          end;
end;

procedure TDCMFunctionsModule.DoBeforePostMovimientoCompra( MovimientoFields : TMovimientoFields );
begin
     If   MovimientoFields.Origen.Value=omDocumentoControlMercancias
     then With DmDocumentoControlMercanciasTable do
            If   not FindKey( [ MovimientoFields.EjercicioOrigen.Value, MovimientoFields.NroOperacionOrigen.Value ] )
            then begin
                 MovimientoFields.Origen.Clear;
                 ShowNotification( ntWarning, RsMsg1, RsMsg2 );
                 end;
end;

procedure TDCMFunctionsModule.DoBeforeDeleteMovimientoCompra( MovimientoFields : TMovimientoFields );
begin
     If   MovimientoFields.Origen.Value=omDocumentoControlMercancias
     then With DmDocumentoControlMercanciasTable do
            If   FindKey( [ MovimientoFields.EjercicioOrigen.Value, MovimientoFields.NroOperacionOrigen.Value ] )
            then begin
                 DocumentoControlMercancias.CompruebaDocumentoLibre( DmDocumentoControlMercanciasTable );
                 Edit;
                 DmDocumentoControlMercanciasFields.NroOperacionCompra.Clear;
                 If   DmDocumentoControlMercanciasFields.SituacionCarga.Value=scAsignada
                 then DmDocumentoControlMercanciasFields.SituacionCarga.Value := scPendiente;
                 Post;
                 end;

end;

// Ventas

procedure SetupMantenimientoVentas;
begin
     If   Assigned( MntMveForm[ tmVenta ] ) and
          ( TipoMovimientoCreado=tmVenta )
     then begin
          CreateDataModule( TDCMFunctionsModule, DCMFunctionsModule );
          MntMveForm[ tmVenta ].BeforePostMovimiento.Add( DCMFunctionsModule.DoBeforePostMovimientoVenta );
          MntMveForm[ tmVenta ].BeforeDeleteMovimiento.Add( DCMFunctionsModule.DoBeforeDeleteMovimientoVenta );
          MntMveForm[ tmVenta ].OnMuestraDocumentoOrigen.Add( DCMFunctionsModule.DoMuestraDocumentoOrigen );
          end;
end;

procedure TDCMFunctionsModule.DoBeforePostMovimientoVenta( MovimientoFields : TMovimientoFields );
begin
     If   MovimientoFields.Origen.Value=omDocumentoControlMercancias
     then With DmDocumentoControlMercanciasTable do
            If   not FindKey( [ MovimientoFields.EjercicioOrigen.Value, MovimientoFields.NroOperacionOrigen.Value ] )
            then begin
                 MovimientoFields.Origen.Clear;
                 ShowNotification( ntWarning, RsMsg1, RsMsg2 );
                 end;
end;

procedure TDCMFunctionsModule.DoBeforeDeleteMovimientoVenta( MovimientoFields : TMovimientoFields );
begin
     If   MovimientoFields.Origen.Value=omDocumentoControlMercancias
     then With DmDocumentoControlMercanciasTable do
            If   FindKey( [ MovimientoFields.EjercicioOrigen.Value, MovimientoFields.NroOperacionOrigen.Value ] )
            then begin
                 DocumentoControlMercancias.CompruebaDocumentoLibre( DmDocumentoControlMercanciasTable );
                 Edit;
                 DmDocumentoControlMercanciasFields.NroOperacionVenta.Clear;
                 If   DmDocumentoControlMercanciasFields.SituacionCarga.Value=scTerminada
                 then DmDocumentoControlMercanciasFields.SituacionCarga.Value := scBuzon;
                 Post;
                 end;
end;

procedure TDCMFunctionsModule.DoMuestraDocumentoOrigen( MovimientoFields : TMovimientoFields );
begin
     With MovimientoFields do
       MntDocumentosControlMercancias( [ EjercicioOrigen.Value, NroOperacionOrigen.Value] );
end;

initialization
  AddProcedure( imOnCreateComponent, idMntMcoForm, SetupMantenimientoCompras );
  AddProcedure( imOnCreateComponent, idMntMveForm, SetupMantenimientoVentas );

end.
