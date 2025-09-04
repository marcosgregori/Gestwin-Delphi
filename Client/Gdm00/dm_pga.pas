unit dm_pga;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, ExtCtrls,

  AppForms,
  AppContainer,
  cxEdit,
  nxllTransport,
  nxptBasePooledTransport,
  nxtwWinsockTransport,
  nxtmSharedMemoryTransport,
  nxllSimpleSession,
  nxllComponent,
  nxllPluginBase,
  nxsiServerInfoPluginBase,
  nxsiServerInfoPluginClient,

  AppManager,

  DataManager,
  DB,
  nxdb,

  Xml.Win.msxmldom,
  Xml.xmldom,
  XMLIntf,
  XMLDoc,

  cxGroupBox,
  cxGridDBTableView,
  cxSplitter,
  dxBar,
  dxBarExtItems,

  Gim00Fields,

  dmi_pga;

type

  TConfiguracionModule = class(TDataModule)
    DmConfiguracionTable: TnxeTable;
    DmConfiguracionTableAplicacion: TSmallintField;
    DmConfiguracionTableTipo: TSmallintField;
    DmConfiguracionTableCodigo: TWideStringField;
    DmConfiguracionTableData: TBlobField;
    DmFicherosTable: TnxeTable;
    XMLDocument: TXMLDocument;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private

    function ObtenCodigoRegistro( AForm : TForm ) : String;

    function FindChildNodeOrCreate( Node : IXMLNode; NodeName : String ) : IXMLNode;
    procedure RecuperaListaParametros( RootNode : IXMLNode; ListaParametros : TStringList );
    procedure GuardaListaParametros( RootNode : IXMLNode; ListaParametros : TStringList );
    procedure SaveGridColumnWidths( SectionNode : IXMLNode; TableView : TcxGridDBTableView );
    procedure ReadGridColumnWidths( SectionNode : IXMLNode; TableView : TcxGridDBTableView );

    procedure SaveSplitterPos( SectionNode : IXMLNode; Splitter : TcxSplitter );

    // procedure DoSetupNumericKeyboard;
    procedure DoSetupCheckUpgrade;

  public

    ParametrosGlbRec : TParametrosGlbRec;
    ParametrosUsrRec : TParametrosUsrRec;
    ParametrosSeguridadRec : TParametrosSeguridadRec;

    procedure Update;
    procedure ObtenParametrosLocales;

    procedure ObtenParametros( Tipo : SmallInt; Codigo : String; var ParametrosRec : TParametrosRec );
    procedure GuardaParametros( Tipo : SmallInt; Codigo : String; var ParametrosRec : TParametrosRec );

    function  GuardaEstadoVentana( AForm : TForm; ListaParametros : TStringList; GuardaEstado : Boolean = False ) : Boolean;
    function  RecuperaEstadoVentana( AForm : TForm; ListaParametros : TStringList ) : Boolean;

    function  BorraEstadoVentana( AForm : TForm ) : Boolean; overload;
    function  BorraEstadoVentana( AForm : TForm; ConfigRegType : TConfigRegType ) : Boolean; overload;
    function  BorraEstadoVentana( CodigoRegistro : String; ConfigRegType : TConfigRegType ) : Boolean; overload;

    function  GuardaContenidoCampo( AForm : TForm; EditControl : TcxCustomEdit; ListaParametros : TStringList ) : Boolean;
    function  RecuperaContenidoCampo( AForm : TForm; EditControl : TcxCustomEdit; ListaParametros : TStringList ) : Boolean;

    function  GuardaConfiguracionConsulta( AQueryPanel : TcxGroupBox ) : Boolean;
    function  RecuperaConfiguracionConsulta( AQueryPanel : TcxGroupBox ) : Boolean;

    procedure GuardaParametrosGlobales( var ParametrosGlbRec : TParametrosGlbRec );

    procedure AñadeModuloOpcional( ModuloOpcional: TModuloOpcional );
    function  ModuloOpcionalActivado( ModuloOpcional : TModuloOpcional ): Boolean;

    procedure InicializaComplementos;

    procedure ActualizaParametros( SoloParametrosGlobales : Boolean = False );
    procedure AccesoUsuario( FechaAcceso : TDate );

  end;

var ConfiguracionModule: TConfiguracionModule = nil;
    ModulosOpcionales : TModulosOpcionales = [];

function Configuracion : TConfiguracionModule;

implementation

{$R *.dfm}

uses   Variants,
       Menus,
       Math,
       LibUtils,

       nxreRemoteServerEngine,

       cxLookAndFeelPainters,
       cxDBEdit,
       cxPC,

       DataAccess,
       ReportManager,
       NexusRpcData,
       QueryForm,

       Gdm00Dm,

       Scheduler,
       Dashboard,

       dm_ine,
       dm_iex,
       dm_emp,
       dm_upd,
       dm_cnd,

       b_mail,
       b_msg;

resourceString
       RsMsg3  = 'Listados e informes definidos por el usuario ';

function Configuracion : TConfiguracionModule;
begin
     CreateDataModule( TConfiguracionModule, ConfiguracionModule );
     Result := ConfiguracionModule;
end;

procedure TConfiguracionModule.DataModuleCreate(Sender: TObject);
begin
     With ApplicationContainer do
       begin
       OnSaveWindowState := GuardaEstadoVentana;
       OnReadWindowState := RecuperaEstadoVentana;
       OnSaveFieldContent := GuardaContenidoCampo;
       OnReadFieldContent := RecuperaContenidoCampo;
       OnDeleteWindowState := BorraEstadoVentana;
       OnSaveQueryConfig := GuardaConfiguracionConsulta;
       OnReadQueryConfig := RecuperaConfiguracionConsulta;
       end;

end;

procedure TConfiguracionModule.DataModuleDestroy(Sender: TObject);
begin

     With ApplicationContainer do
       begin
       OnSaveWindowState := nil;
       OnReadWindowState := nil;
       OnSaveFieldContent := nil;
       OnReadFieldContent := nil;
       OnDeleteWindowState := nil;
       OnSaveQueryConfig := nil;
       OnReadQueryConfig := nil;
       OnSetupScheduler := nil;
       end;

     ConfiguracionModule := nil;

end;

procedure TConfiguracionModule.Update;
begin
     ActualizaParametros;
     ObtenParametrosLocales;
end;


procedure TConfiguracionModule.InicializaComplementos;
begin

     With  ApplicationContainer do
       If   Assigned( MainBarManager )
       then begin

            MainBarManager.BeginUpdate;

            try

              // Hay que crear la ventana del Scheduler para que se activen los reminders

              SetBarItemVisible( SchedulerButton, ShowScheduler );
              If   ShowScheduler
              then SetupScheduler;

              SetBarItemVisible( DashboardButton, ShowDashboard );
              If   ShowDashboard
              then OnSetupDashboard := TDashboardForm.DoSetupDashboard;

              SetBarItemVisible( MailButton, ShowMail );
              If   ShowMail
              then OnShowMailForm := TMailForm.DoShowMail;

              {
              If   ShowUpgrade
              then OnShowUpgradeForm := DoShowUpgrade;
              }

              // DoSetupNumericKeyboard;
              DoSetupCheckUpgrade;

            finally
              MainBarManager.EndUpdate;
              end;

          end;
end;

procedure TConfiguracionModule.ObtenParametrosLocales;
begin
     With DmConfiguracionTable do
       begin

       If   FindKey( [ ProgramNumber, ctGlobal, '' ] )
       then ReadMemoBuffer( DmConfiguracionTableData, ParametrosGlbRec, SizeOf( ParametrosGlbRec ) )
       else FillChar( ParametrosGlbRec, SizeOf( ParametrosGlbRec ), #0 );

       FillChar( ParametrosUsrRec, SizeOf( ParametrosUsrRec ), #0 );

       //* 21.01.2000 Añadida la inserción automática del registro de configuración del usuario

       If   CodigoUsuarioActual<>''
       then begin

            If   FindKey( [ ProgramNumber, ctUsuario, CodigoUsuarioActual ] )
            then ReadMemoBuffer( DmConfiguracionTableData, ParametrosUsrRec, SizeOf( ParametrosUsrRec ) )
            else begin

                 Append;

                 FillChar( ParametrosUsrRec, SizeOf( ParametrosUsrRec ), #0 );

                 DmConfiguracionTableAplicacion.Value := ProgramNumber;
                 DmConfiguracionTableTipo.Value := ctUsuario;
                 DmConfiguracionTableCodigo.Value := CodigoUsuarioActual;

                 Post;

                 end;

            // Parámetros de seguridad

            ObtenParametros( ctSeguridad, CodigoEmpresaActual + CodigoUsuarioActual, TParametrosRec( ParametrosSeguridadRec ) );

            end;

       end;

     //* 22.10.2003  Si un módulo desea leer parámetros adicionales debe añadir un procedimiento
     //              de Tipo imGetParamConf.

     ExecuteProcedures( imGetParamConf, [] );

end;

procedure TConfiguracionModule.ObtenParametros(     Tipo          : SmallInt;
                                                    Codigo        : String;
                                                var ParametrosRec : TParametrosRec );
begin
     With DmConfiguracionTable do
       If   FindKey( [ ProgramNumber, Tipo, Codigo ] )
       then ReadMemoBuffer( DmConfiguracionTableData, ParametrosRec, SizeOf( ParametrosRec ) )
       else FillChar( ParametrosRec, SizeOf( ParametrosRec ), #0 );
end;

procedure TConfiguracionModule.GuardaParametros(     Tipo          : SmallInt;
                                                     Codigo        : String;
                                                 var ParametrosRec : TParametrosRec );
begin
     With DmConfiguracionTable do
       try

         If   FindKey( [ ProgramNumber, Tipo, Codigo ] )
         then Edit
         else begin
              Append;
              DmConfiguracionTableAplicacion.Value := ProgramNumber;
              DmConfiguracionTableTipo.Value := Tipo;
              DmConfiguracionTableCodigo.Value := Codigo;
              end;

         WriteMemoBuffer( DmConfiguracionTableData, ParametrosRec, SizeOf( ParametrosRec ) );
         Post;

       except
         Cancel;
         raise;
         end;
end;

procedure TConfiguracionModule.ActualizaParametros( SoloParametrosGlobales : Boolean = False );

var   ConfigurationSection : TgAppSection;
      MainMenuBar : TdxBar;
      MenuItem : TdxBarItem;
      BarButton : TdxBarButton;
      BarStatic : TdxBarStatic;
      MenuSeparator : TdxBarSeparator;
      Link : TdxBarItemLink;
      Index,
      MenuItemIndex : Integer;
      DmFicherosFields : TFicherosFields;
      HasItems : Boolean;

function AddStaticBar( BarCaption : String; Position : SmallInt ) : TdxBarStatic;
begin
     Result := TdxBarStatic.Create( MenuItem );
     If   Assigned( Result )
     then With Result do
            begin
            Caption := BarCaption;
            Alignment := taLeftJustify;
            Style := ApplicationContainer.MenuNoteStyle;
            Link := TdxBarSubItem( MenuItem ).ItemLinks.Insert( Position );
            Link.Item := Result;
            end;
end;

begin

     With DmConfiguracionTable do
       begin

       If   FindKey( [ ProgramNumber, 0, '' ] )
       then ReadMemoBuffer( DmConfiguracionTableData, ParametrosGlbRec, SizeOf( ParametrosGlbRec ) )
       else begin

            FillChar( ParametrosGlbRec, sizeOf( ParametrosGlbRec ), #0 );

            ParametrosGlbRec.SubrayadoLineas := True;
            ParametrosGlbRec.ColorBarraTituloInforme := clGray;
            ParametrosGlbRec.BarraNavegacion := False;

            end;

       // Como el registro sufre muchas variaciones, y reciclo algunos campos de vez en cuando, he incluido
       // un control de versiones para saber cuando asignar nuevos valores por defecto (entre otras cosas)

       var CurrentVersion := GetAppComparableVersion( { IncludeBuild } False );
       If   ParametrosGlbRec.Version<>CurrentVersion
       then begin

            // Si es la primera vez puede que haya basura en el contenido de la versión (reciclado de campos viejos)

            If   Copy( ParametrosGlbRec.Version, 1, 4 )<>'1100'
            then ParametrosGlbRec.ColorBarraTituloInforme := clGray;

            {  Ejemplo de comprobación

            If   ParametrosGlbRec.Version<'11000086'
            then begin
                 end;

            }

            ParametrosGlbRec.Version := CurrentVersion;

            try
              Edit;
              WriteMemoBuffer( DmConfiguracionTableData, ParametrosGlbRec, SizeOf( ParametrosGlbRec ) );
              Post;
            except
              Cancel;
              raise;
              end;

            end;

       // DataAccessModule.SelectableFileLocation := AccesoRemoto;

       SQLTimeOut := ParametrosGlbRec.TiempoEsperaSQL;                     // Están en DataManager
       RemoteDataCompression := ParametrosGlbRec.CompresionDatosRemotos;   // ..

       ApplicationContainer.LogRecordDataChanges := ParametrosGlbRec.RegistrarCambiosFicheros;
       ApplicationContainer.ReportUnderline := ParametrosGlbRec.SubrayadoLineas;
       ApplicationContainer.ReportTitleBarColor := ParametrosGlbRec.ColorBarraTituloInforme;
       // ApplicationContainer.UseNavBar := BarraNavegacion;

       ApplicationContainer.PDFCompressed := ParametrosGlbRec.PDFComprimido;
       ApplicationContainer.PDFCompressionLevel := ParametrosGlbRec.PDFNivelCompresion;
       ApplicationContainer.PDFEmbeddedFonts := ParametrosGlbRec.PDFFuentesEmbebidas;
       ApplicationContainer.PDFBackground := ParametrosGlbRec.PDFFondo;
       ApplicationContainer.PDFPrintOptimized := ParametrosGlbRec.PDFOptimizadoImpresion;

       ApplicationContainer.DontAskForBackup := ParametrosGlbRec.NoPreguntarCopiasSeguridad;
       If   ParametrosGlbRec.NroCopiasInternas=0
       then ParametrosGlbRec.NroCopiasInternas := 7;
       ApplicationContainer.NumOfInternalCopies := ParametrosGlbRec.NroCopiasInternas;

       end;

     DataAccessModule.UpdateRemoteDataCompression;   // Se actualiza el valor del transporte remoto

     ApplicationContainer.DoOnSetupMainForm;

     If   SoloParametrosGlobales
     then Exit;

     // Incluyendo los informes externos en los menus de cada sección

     If   Assigned( ApplicationContainer.MainBarManager )
     then begin

          DataModule00.DmInformeExternoTable.CancelRange;
          If   DataModule00.DmInformeExternoTable.RecordCount<>0
          then With ApplicationContainer.AppSectionList do
                 For Index := Count - 1 downto 0 do
                    If   Assigned( Items[ Index ] )
                    then begin
                         ConfigurationSection := TgAppSection( Items[ Index ] );
                         MainMenuBar := ConfigurationSection.MainMenuBar;
                         If   Assigned( MainMenuBar )
                         then With MainMenuBar do
                                try
                                  // BarManager.BeginUpdate;
                                  MenuItem := FindMenuItemByTag( MainMenuBar, mtInformesExternos );
                                  If   Assigned( MenuItem ) and ( MenuItem is TdxBarSubItem )
                                  then begin

                                       TdxBarSubItem( MenuItem ).ItemLinks.Clear;

                                       HasItems := False;

                                       //* 04.03.2009 Añadido el aviso de los listados personalizados

                                       With DataModule00, DmInformeExternoTable do
                                         try
                                           IndexFieldNames := 'Seccion;TipoDocumento;NroRegistro';
                                           SetRange( [ SmallInt( ConfigurationSection.Tag ), Ord( impDefinidoUsuario ), 1 ],
                                                     [ SmallInt( ConfigurationSection.Tag ), Ord( impDefinidoUsuario ), MaxSmallint ] );
                                           First;
                                           While not Eof do
                                             begin

                                             With DmInformeExternoFields do
                                               If   ( ValueIsEmpty( Empresa.Value ) or ( Empresa.Value=CodigoEmpresaActual ) ) and
                                                    ( ValueIsEmpty( Usuario.Value ) or ( Usuario.Value=CodigoUsuarioActual ) )
                                               then begin
                                                    BarButton := MainMenuBar.BarManager.AddButton;
                                                    If   Assigned( BarButton )
                                                    then With BarButton do
                                                           begin
                                                           Caption := Descripcion.Value;
                                                           Hint := Fichero.Value;
                                                           If   Assigned( ApplicationContainer.OnExternalReport )
                                                           then OnClick := ApplicationContainer.OnExternalReport;
                                                           Link := TdxBarSubItem( MenuItem ).ItemLinks.Add;
                                                           Link.Item := BarButton;
                                                           If   not HasItems
                                                           then Link.BeginGroup := True;
                                                           HasItems := True;
                                                           end;
                                                    end;

                                             Next;
                                             end;
                                         finally
                                           CancelRange;
                                           end;

                                       If   HasItems
                                       then begin

                                            var HeaderBar := AddStaticBar( RsMsg3, 0 );
                                            If   Assigned( HeaderBar )
                                            then begin
                                                 ApplicationForms.ControlsImageList.GetImage( 6, HeaderBar.Glyph );
                                                 If   Assigned( HeaderBar.Glyph )
                                                 then begin
                                                      HeaderBar.Glyph.SourceHeight := 14;
                                                      HeaderBar.Glyph.SourceWidth := 14;
                                                      end;
                                                 end;

                                            MenuItem.Visible := ivAlways;
                                            end
                                       else MenuItem.Visible := ivNever;

                                       end;

                                finally
                                  // BarManager.EndUpdate;
                                  end;

                         end;

          end;

     CloseAllDataModules;

end;

procedure TConfiguracionModule.AccesoUsuario( FechaAcceso : TDate );
begin

     DataModule00.SetupAppParams( FechaAcceso );

     // Así puedo entrar a realizar modificaciones sin que se intente ajustar

     {$IFNDEF DEBUGAPP}

     If   ( CodigoEmpresaActual='999' )  and  // La Empresa de demostración
          not Configuracion.ParametrosGlbRec.EmpresaDemostracionActualizada
     then try
            Actualizacion.UpdateDemoDatabase;
          finally
            ActualizacionModule.Free;  // El módulo es persistente. Hay que suprimirlo de forma explícita.
            end;

     {$ENDIF}

     Empresa.CompruebaFicherosRemotos;

     ExecuteProcedures( imOnEnterpriseAccess, [] );

     ApplicationContainer.ShowMainFormCaption( ApplicationContainer.CabeceraEmpresa );
     ApplicationContainer.SectionsButton.Enabled := True;

     MainMenuActive( True );

     Contadores;

     ApplicationContainer.DoOnUpdateLookAndFeel;
     ApplicationContainer.ApplyTDI;
     ApplicationContainer.UpdateAppSections;

end;

procedure TConfiguracionModule.GuardaParametrosGlobales( var ParametrosGlbRec : TParametrosGlbRec );
begin
     With DmConfiguracionTable do
       try

         If   FindKey( [ ProgramNumber, 0, '' ] )
         then Edit
         else begin
              Append;
              DmConfiguracionTableAplicacion.Value := ProgramNumber;
              DmConfiguracionTableTipo.Value := 0;
              DmConfiguracionTableCodigo.Value := '';
              end;

         WriteMemoBuffer( DmConfiguracionTableData, ParametrosGlbRec, SizeOf( ParametrosGlbRec ) );
         Post;

       except
         Cancel;
         raise;
         end;


end;

procedure TConfiguracionModule.SaveGridColumnWidths( SectionNode : IXMLNode;
                                                     TableView   : TcxGridDBTableView );

var  ChildNode,
     ValueNode : IXMLNode;
     ColInx : SmallInt;

begin
     If   Assigned( TableView )
     then With TableView do
            begin
            ChildNode := SectionNode.AddChild( 'TableView' );
            If   Assigned( ChildNode )
            then begin
                 ChildNode.Attributes[ 'ComponentName' ] := Name;
                 For ColInx := 0 to ColumnCount - 1 do
                   With Columns[ ColInx ] do
                     If   DataBinding.FieldName<>''
                     then begin
                          ValueNode := ChildNode.AddChild( DataBinding.FieldName );
                          If   Assigned( ValueNode )
                          then ValueNode.NodeValue := Width;
                          end;

                 If   Assigned( Preview.Column )
                 then ChildNode.Attributes[ 'PreviewVisible' ] := Preview.Visible;

                 end;
            end;
end;

procedure TConfiguracionModule.ReadGridColumnWidths( SectionNode : IXMLNode;
                                                     TableView   : TcxGridDBTableView );

var ChildIndex : SmallInt;
    ValueNode : IXMLNode;
    Column :TcxGridDBColumn;

begin
     If   Assigned( TableView )
     then With TableView do
            begin

            For ChildIndex := 0 to SectionNode.ChildNodes.Count - 1 do
                begin
                ValueNode := SectionNode.ChildNodes.Nodes[ ChildIndex ];
                If   Assigned( ValueNode )
                then begin
                     Column := GetColumnByFieldName( ValueNode.NodeName );
                     If   Assigned( Column )
                     then Column.Width := ValueNode.NodeValue;
                     end;
                end;

            If   Assigned( Preview.Column )
            then Preview.Visible := SectionNode.Attributes[ 'PreviewVisible' ];

            end;
end;


procedure TConfiguracionModule.SaveSplitterPos( SectionNode : IXMLNode;
                                                Splitter    : TcxSplitter );

var  ChildNode : IXMLNode;
     Size : Integer;

begin
     If   Assigned( Splitter ) and Assigned( Splitter.Control )
     then begin
          ChildNode := SectionNode.AddChild( 'Splitter' );
          If   Assigned( ChildNode )
          then begin
               ChildNode.Attributes[ 'ComponentName' ] := Splitter.Name;
               If   Splitter.AlignSplitter=salTop
               then Size := Splitter.Control.Height
               else Size := Splitter.Control.Width;
               ChildNode.Attributes[ 'Size' ] := Size;
               end;
          end;
end;

function TConfiguracionModule.ObtenCodigoRegistro( AForm : TForm ) : String;

var  ExtName : String;

begin
     var BaseFormName :=  RemoveSuffix( AForm.Name, '_', 1 );  // Cuando se crea más de un form con el mismo nombre base se añade un sufijo numérico del tipo MntMveForm_1, MntMveForm_2, etc..
     Result := CodigoEmpresaActual + '.' + CodigoUsuarioActual + '.' + BaseFormName;
     If   AForm is TgxForm
     then begin
          ExtName := TgxForm( AForm ).ExtendedName;  // Es donde guardo el nombre extendido del form (por ejemplo : pre, pdv, adv)
          If   ExtName<>''
          then Result := Result + '.' + ExtName;
          end;
end;

function TConfiguracionModule.GuardaEstadoVentana( AForm             : TForm;
                                                   ListaParametros   : TStringList;
                                                   GuardaEstado      : Boolean = False ) : Boolean;

var  ParamStr : string;
     Inx,
     CmpInx,
     ColInx : SmallInt;
     CodigoRegistro : String;

     RootNode,
     SectionNode,
     ChildNode,
     ValueNode : IXMLNode;

     RecordExists : Boolean;

begin
     Result := False;

     CodigoRegistro := ObtenCodigoRegistro( AForm );

     RecordExists := DmConfiguracionTable.FindKey( [ ProgramNumber, ctParametrosVentana, CodigoRegistro ] );

     With XMLDocument do
       begin

       try

         Active := False;
         If   RecordExists
         then LoadFromXML( DmConfiguracionTableData.AsString )
         else XML.Text := '';
         Active := True;

         RootNode := FindChildNodeOrCreate( Node, 'Form' );

         If   Assigned( RootNode )
         then begin

              If   GuardaEstado
              then begin

                   SectionNode := FindChildNodeOrCreate( RootNode, 'Layout' );

                   With SectionNode do
                     begin

                     If   AForm is TgxForm
                     then Attributes[ 'Maximized' ] := TgxForm( AForm ).Maximized
                     else Attributes[ 'WindowState' ] := AForm.WindowState;

                     Attributes[ 'Top' ] := AForm.Top;
                     Attributes[ 'Left' ] := AForm.Left;
                     Attributes[ 'Width' ] := AForm.Width;
                     Attributes[ 'Height' ] := AForm.Height;
                     end;

                   With AForm do
                     begin

                     For CmpInx := 0 to ComponentCount - 1 do
                       begin
                       var Component := Components[ CmpInx ];
                       If   Component is TcxGridDBTableView
                       then SaveGridColumnWidths( SectionNode, TcxGridDBTableView( Component ) )
                       else If   Component is TcxSplitter
                            then SaveSplitterPos( SectionNode, TcxSplitter( Component ) );
                       end;

                     end;

                   end;

              GuardaListaParametros( RootNode, ListaParametros );

              try
                If   RecordExists
                then DmConfiguracionTable.Edit
                else begin
                     DmConfiguracionTable.Append;
                     DmConfiguracionTableAplicacion.Value := ProgramNumber;
                     DmConfiguracionTableTipo.Value := ctParametrosVentana;
                     DmConfiguracionTableCodigo.Value := CodigoRegistro;
                     end;
                DmConfiguracionTableData.Assign( XML );
                DmConfiguracionTable.Post;
              except
                 DmConfiguracionTable.Cancel;
                 raise;
                end;

              Result := True;

              end;

       except on E : Exception do
         ShowException( E, AForm );
         end;

       Active := False;
       end;

end;

function TConfiguracionModule.GuardaContenidoCampo( AForm           : TForm;
                                                    EditControl     : TcxCustomEdit;
                                                    ListaParametros : TStringList ) : Boolean;

var  FieldName,
     FieldValue : String;

begin
     Result := False;
     If   Assigned( AForm ) and Assigned( EditControl ) and ( EditControl.DataBinding is TcxDBEditDataBinding )
     then begin

          FieldName := TcxDBEditDataBinding( EditControl.DataBinding ).Field.FieldName;
          FieldValue := VarToStr( EditControl.EditValue );

          // TStringList no admite guardar valore vacíos. Cuando se intenta actualizar un valor con Values[ FieldName ] := Value, se borra el parámetro

          var ParamInx := ListaParametros.IndexOfName( FieldName );
          If   ParamInx>=0
          then ListaParametros.Delete( ParamInx );

          ListaParametros.Add( FieldName + '=' + FieldValue );

          GuardaEstadoVentana( AForm, ListaParametros, False );

          Result := True;
          end;
end;

function TConfiguracionModule.RecuperaContenidoCampo( AForm           : TForm;
                                                      EditControl     : TcxCustomEdit;
                                                      ListaParametros : TStringList ) : Boolean;

var  FieldName : String;

begin
     Result := False;
     If   Assigned( AForm ) and Assigned( EditControl ) and ( EditControl.DataBinding is TcxDBEditDataBinding )
     then begin
          FieldName := TcxDBEditDataBinding( EditControl.DataBinding ).DataField;
          With ListaParametros do
            If   IndexOfName( FieldName )>=0
            then begin
                 EditControl.EditValue := Values[ FieldName ];
                 Result := True;
                 end;
          end;
end;

procedure TConfiguracionModule.RecuperaListaParametros( RootNode        : IXMLNode;
                                                        ListaParametros : TStringList );

var  SectionNode,
     ChildNode,
     ValueNode : IXMLNode;
     ChildIndex : SmallInt;

begin
     If   Assigned( ListaParametros )
     then begin
          SectionNode := RootNode.ChildNodes.FindNode( 'FieldValues' );
          If   Assigned( SectionNode )
          then With SectionNode do
                 For ChildIndex := 0 to ChildNodes.Count - 1 do
                   begin
                   ValueNode := ChildNodes.Nodes[ ChildIndex ];
                   If   Assigned( ValueNode )
                   then If   not VarIsNull( ValueNode.NodeValue )
                        then ListaParametros.Add( ValueNode.NodeName + '=' + ValueNode.NodeValue );
                   end;
          end;
end;

function TConfiguracionModule.FindChildNodeOrCreate( Node     : IXMLNode;
                                                     NodeName : String ) : IXMLNode;
begin
     Result := Node.ChildNodes.FindNode( NodeName );
     If   not Assigned( Result )
     then Result := Node.AddChild( NodeName );
end;

procedure TConfiguracionModule.GuardaListaParametros( RootNode        : IXMLNode;
                                                      ListaParametros : TStringList );

var  SectionNode,
     ChildNode,
     ValueNode : IXMLNode;
     ChildIndex : SmallInt;

begin
     If   Assigned( ListaParametros )
     then With ListaParametros do
            begin
            SectionNode := FindChildNodeOrCreate( RootNode, 'FieldValues' );
            For ChildIndex := 0 to Count - 1 do
              begin
              ChildNode := SectionNode.ChildNodes.FindNode( Names[ ChildIndex ] );
              If   not Assigned( ChildNode )
              then ChildNode := SectionNode.AddChild( Names[ ChildIndex ] );
              If   Assigned( ChildNode )
              then ChildNode.NodeValue := ValueFromIndex[ ChildIndex ];
              end;
            end;
end;

function TConfiguracionModule.RecuperaEstadoVentana( AForm           : TForm;
                                                     ListaParametros : TStringList ) : Boolean;

var  CodigoRegistro : String;
     LockState : Boolean;
     FormManager : TgxFormManager;
     RootNode,
     SectionNode,
     ChildNode,
     ValueNode : IXMLNode;
     AttNodes : IXMLNodeList;
     XMLNode : IXMLNode;
     NodeComponent : TComponent;
     Index,
     ChildIndex : SmallInt;
     Column :TcxGridDBColumn;
     ComponentName : String;
     IntegerValue : Integer;

procedure SetFormBounds;
begin
     With SectionNode do
       begin
       AForm.Top := Attributes[ 'Top' ];
       AForm.Left := Attributes[ 'Left' ];
       AForm.Width := Attributes[ 'Width' ];
       AForm.Height := Attributes[ 'Height' ];
       If   AForm is TgxForm
       then TgxForm( AForm ).SavedBounds := True;
       end;
end;

begin
     Result := False;
     try

       CodigoRegistro := ObtenCodigoRegistro( AForm );

       With DmConfiguracionTable do
         begin
         If   FindKey( [ ProgramNumber, ctParametrosVentana, CodigoRegistro ] )
         then With XMLDocument do
                begin

                Active := False;
                LoadFromXML( DmConfiguracionTableData.AsString );
                Active := True;

                LockState := False;

                FormManager := TgxFormManager ( AForm.FindComponent( FormManagerName ) );
                If   Assigned( FormManager )
                then LockState := ApplicationContainer.TDI and ( FormManager.Model in [ fmEditForm, fmPersistentInputForm ] );

                RootNode := ChildNodes.FindNode( 'Form' );
                If   Assigned( RootNode )
                then begin

                      SectionNode := RootNode.ChildNodes.FindNode( 'Layout' );
                      If   Assigned( SectionNode )
                      then With SectionNode do
                             begin

                             If   not LockState and ( ApplicationContainer.CurrentMDILayout=mdiNone )
                             then If   AForm is TgxForm
                                  then begin
                                       With TgxForm( AForm ) do
                                         If   Attributes[ 'Maximized' ]
                                         then Maximize
                                         else SetFormBounds;
                                       end
                                  else begin
                                       AForm.WindowState := Attributes[ 'WindowState' ];
                                       If   AForm.WindowState=wsNormal
                                       then SetFormBounds;
                                       end;

                             With SectionNode.ChildNodes do
                               For Index := 0 to Count - 1 do
                                 begin
                                 ChildNode := Nodes[ Index ];
                                 With ChildNode do
                                   begin
                                   If   NodeName='TableView'
                                   then begin
                                        NodeComponent := AForm.FindComponent( Attributes[ 'ComponentName' ] );
                                        If   Assigned( NodeComponent ) and ( NodeComponent is TcxGridDBTableView )
                                        then ReadGridColumnWidths( ChildNode, TcxGridDBTableView( NodeComponent ) );
                                        end
                                   {
                                   else If   NodeName='PageControls'
                                        then begin
                                             For ChildIndex := 0 to ChildNodes.Count - 1 do
                                               begin
                                               ValueNode := ChildNodes.Nodes[ ChildIndex ];
                                               If   Assigned( ValueNode )
                                               then begin
                                                    ComponentName := ValueNode.NodeName;
                                                    If   ComponentName<>''
                                                    then begin
                                                         NodeComponent := AForm.FindComponent( ComponentName );
                                                         If   Assigned( NodeComponent ) and ( NodeComponent is TcxPageControl )
                                                         then begin
                                                              IntegerValue := StrToIntDef( ValueNode.Attributes[ 'ActivePageIndex' ], 0 );
                                                              TcxPageControl( NodeComponent ).ActivePageIndex := IntegerValue;
                                                              end;
                                                         end;
                                                    end;
                                               end;
                                             end
                                             }
                                        else If   NodeName='Splitter'
                                             then begin
                                                  NodeComponent := AForm.FindComponent( Attributes[ 'ComponentName' ] );
                                                  If   Assigned( NodeComponent ) and ( NodeComponent is TcxSplitter )
                                                  then begin
                                                       var Splitter := TcxSplitter( NodeComponent );
                                                       If   Assigned( Splitter.Control )
                                                       then begin
                                                            IntegerValue := StrToIntDef( Attributes[ 'Size' ], 0 ) ;
                                                            If   IntegerValue>0
                                                            then begin
                                                                 If   Splitter.AlignSplitter=salTop
                                                                 then Splitter.Control.Height := IntegerValue
                                                                 else Splitter.Control.Width := IntegerValue;
                                                                 Splitter.PositionAfterOpen := IntegerValue;  // Para indicar que se ha asignado
                                                                 end;
                                                            end;
                                                       end;
                                                  end;
                                   end;
                                 end;
                             end;

                      RecuperaListaParametros( RootNode, ListaParametros );

                      Result := True;
                      end;
                end;

         end;

     except
       BorraEstadoVentana( CodigoRegistro, ctParametrosVentana );
       end;
end;

function TConfiguracionModule.BorraEstadoVentana( AForm : TForm ) : Boolean;
begin
     Result := BorraEstadoVentana( AForm, ctParametrosVentana );
end;

function TConfiguracionModule.BorraEstadoVentana( AForm         : TForm;
                                                  ConfigRegType : TConfigRegType ) : Boolean;
begin
     Result := BorraEstadoVentana( ObtenCodigoRegistro( AForm ), ConfigRegType );
end;

function TConfiguracionModule.BorraEstadoVentana( CodigoRegistro : String;
                                                  ConfigRegType  : TConfigRegType ) : Boolean;
begin
     Result := False;
     try
       With DmConfiguracionTable do
         If   FindKey( [ ProgramNumber, ConfigRegType, CodigoRegistro ] )
         then Delete;
       Result := True;
     except on e : Exception do ShowException( E, nil );
       end;
end;

function TConfiguracionModule.GuardaConfiguracionConsulta( AQueryPanel : TcxGroupBox ) : Boolean;

var  Index : SmallInt;
     FieldsStr : String;
     CodigoRegistro : String;
     RootNode,
     SectionNode : IXMLNode;
     QueryPanel : TgQueryPanel;

procedure SaveSectionNode( SectionName : String;
                           List        : TStringList );

var  I : SmallInt;

begin
     SectionNode := RootNode.AddChild( SectionName );
     If   Assigned( SectionNode )
     then begin
          FieldsStr := '';
          With List do
            For I := 0 to Count - 1 do
              begin
              If   FieldsStr<>''
              then StrAdd( FieldsStr, ';' );
              StrAdd( FieldsStr, Strings[ I ] );
              end;
          SectionNode.NodeValue := FieldsStr;
          end;
end;

begin

     Result := False;

     With XMLDocument do
       begin

       If   AQueryPanel is TgQueryPanel
       then begin
            QueryPanel := TGQueryPanel( AQueryPanel );
            try

              CodigoRegistro := CodigoEmpresaActual + '.' + CodigoUsuarioActual + '.' + TForm( QueryPanel.Owner ).Name;

              Active := False;
              XML.Text := '';
              Active := True;

              RootNode := AddChild( 'QueryForm' );
              If   Assigned( RootNode )
              then With QueryPanel do
                     begin

                     If   Assigned( QueryPanel.OwnerForm )
                     then begin
                          SectionNode := RootNode.AddChild( 'Layout' );
                          If   Assigned( SectionNode )
                          then SectionNode.Attributes[ 'Width' ] := QueryPanel.OwnerForm.Width;
                          end;

                     SaveGridColumnWidths( SectionNode, QueryPanel.GridTableView );

                     SectionNode := RootNode.AddChild( 'InitSearchButton' );  // Mantengo los nombres con el sufijo Button por compatibilidad
                     If   Assigned( SectionNode )
                     then SectionNode.NodeValue := InitSearchQuery;

                     If   Assigned( VisibleFieldList )
                     then SaveSectionNode( 'ActiveFields', VisibleFieldList );

                     If   Assigned( FilterFieldList )
                     then SaveSectionNode( 'FilterFields', FilterFieldList );

                     GuardaListaParametros( RootNode, ValueList );

                     end;

              With DmConfiguracionTable do
                begin

                try

                  If   FindKey( [ ProgramNumber, ctCamposConsulta, CodigoRegistro ] )
                  then Edit
                  else begin
                       Append;
                       DmConfiguracionTableAplicacion.Value := ProgramNumber;
                       DmConfiguracionTableTipo.Value := ctCamposConsulta;
                       DmConfiguracionTableCodigo.Value := CodigoRegistro;
                       end;

                  DmConfiguracionTableData.Assign( XML );

                  Post;

                except
                  Cancel;
                  raise;
                  end;

                Result := True;
                end;

            except on E : Exception do ShowException( E, QueryPanel );
              end;

            end;

     Active := False;
     end;
end;

function TConfiguracionModule.RecuperaConfiguracionConsulta( AQueryPanel : TcxGroupBox ) : Boolean;

var  CodigoRegistro : String;
     RootNode,
     ChildNode,
     SectionNode : IXMLNode;
     QueryPanel : TgQueryPanel;

begin
     Result := False;
     If   AQueryPanel is TgQueryPanel
     then try

          QueryPanel := TgQueryPanel( AQueryPanel );
          CodigoRegistro := CodigoEmpresaActual + '.' + CodigoUsuarioActual + '.' + TForm( QueryPanel.Owner ).Name;

          With DmConfiguracionTable do
              If   FindKey( [ ProgramNumber, ctCamposConsulta, CodigoRegistro ] )
              then If   DmConfiguracionTableData.AsString<>''
                   then With XMLDocument do
                          begin

                          Active := False;
                          LoadFromXML( DmConfiguracionTableData.AsString );
                          Active := True;

                          RootNode := ChildNodes.FindNode( 'QueryForm' );
                          If   Assigned( RootNode )
                          then With QueryPanel do
                                 begin

                                 SectionNode := RootNode.ChildNodes.FindNode( 'Layout' );
                                 If   Assigned( SectionNode )
                                 then begin
                                      If   Assigned( QueryPanel.OwnerForm )
                                      then QueryPanel.OwnerForm.Width := SectionNode.Attributes[ 'Width' ];
                                      QueryPanel.CustomQueryFormWidth := True;
                                      ChildNode := SectionNode.ChildNodes.FindNode( 'TableView' );
                                      If   Assigned( ChildNode )
                                      then ReadGridColumnWidths( ChildNode, QueryPanel.GridTableView );
                                      end;

                                 SectionNode := RootNode.ChildNodes.FindNode( 'InitSearchButton' );
                                 If   Assigned( SectionNode )
                                 then InitSearchQuery := StrToBool( SectionNode.NodeValue );

                                 If   Assigned( VisibleFieldList )
                                 then begin
                                      SectionNode := RootNode.ChildNodes.FindNode( 'ActiveFields' );
                                      If   Assigned( SectionNode ) and not VarIsNull( SectionNode.NodeValue )
                                      then ExtractStringList( SectionNode.NodeValue, VisibleFieldList, False, ';' );
                                      end;

                                 If   Assigned( FilterFieldList )
                                 then begin
                                      SectionNode := RootNode.ChildNodes.FindNode( 'FilterFields' );
                                      If   Assigned( SectionNode ) and not VarIsNull( SectionNode.NodeValue )
                                      then ExtractStringList( SectionNode.NodeValue, FilterFieldList, False, ';' );
                                      end;

                                 RecuperaListaParametros( RootNode, ValueList );

                                 Result := True;
                                 end;

                          Active := False;
                          end;

             except
               BorraEstadoVentana( CodigoRegistro, ctCamposConsulta );
               end;
end;

{
procedure TConfiguracionModule.DoSetupNumericKeyboard;
begin
     ApplicationContainer.SetupNumericKeyboard;
end;

procedure TConfiguracionModule.DoSetupMail;
begin
     ApplicationContainer.SetupMail;
end;
}

procedure TConfiguracionModule.DoSetupCheckUpgrade;
begin
     ApplicationContainer.SetupCheckUpgrade;
end;

procedure TConfiguracionModule.AñadeModuloOpcional( ModuloOpcional : TModuloOpcional );
begin
     ModulosOpcionales := ModulosOpcionales + [ ModuloOpcional ];
     NexusRpc.RegisterOptionDataModule( ModuloOpcional );
end;

function TConfiguracionModule.ModuloOpcionalActivado( ModuloOpcional : TModuloOpcional ) : Boolean;
begin
     Result := ModuloOpcional in ModulosOpcionales;
end;

end.


