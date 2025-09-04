object MailForm: TMailForm
  Left = 300
  Top = 248
  HelpType = htKeyword
  HelpKeyword = 'b_mail'
  HelpContext = 103
  BorderIcons = [biSystemMenu]
  Caption = 'Mensajes de correo'
  ClientHeight = 530
  ClientWidth = 855
  Color = clBtnFace
  DefaultMonitor = dmMainForm
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  HelpFile = 'hs00'
  Position = poScreenCenter
  TextHeight = 17
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 494
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      855
      36)
    Height = 36
    Width = 855
    object Panel3: TcxGroupBox
      Left = 370
      Top = 0
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 174
      object OkButton: TgBitBtn
        Left = 1
        Top = 2
        Width = 85
        Height = 28
        Caption = '&Aceptar'
        Enabled = True
        ModalResult = 1
        OptionsImage.ImageIndex = 2
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 0
        GlyphBitmap = gmOk
      end
      object CloseButton: TgBitBtn
        Left = 88
        Top = 2
        Width = 85
        Height = 28
        Cancel = True
        Caption = '&Cerrar'
        Enabled = True
        ModalResult = 2
        OptionsImage.ImageIndex = 7
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 1
        GlyphBitmap = gmClose
      end
    end
  end
  object gEditPanel1: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 5
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 0
    Align = alClient
    Alignment = alCenterCenter
    PanelStyle.Active = True
    ParentBackground = False
    ParentColor = False
    Style.BorderStyle = ebsSingle
    Style.Color = cl3DLight
    TabOrder = 0
    PanelKind = epInputPanel
    Height = 489
    Width = 845
    object TipoPaquetePanel: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 32
      Width = 841
      object cxLabel1: TcxLabel
        Left = 4
        Top = 7
        TabStop = False
        Caption = 'Tipo de paquete'
        TabOrder = 0
        Transparent = True
      end
      object TipoPaqueteCtrl: TcxComboBox
        Left = 114
        Top = 5
        Properties.DropDownListStyle = lsFixedList
        Properties.Items.Strings = (
          '<Todos>'
          'Fichero maestro'
          'Asiento'
          'Pedido de compras'
          'Albaran de compras'
          'Presupuesto'
          'Pedido de ventas'
          'Albaran de ventas'
          'Movimiento de almac'#233'n'
          'Preventa'
          'Tareas'
          'Factura PDF'
          'Impresos de clientes'
          'Informe'
          'Mandato'
          'Presupuesto PDF'
          'Pedido de ventas PDF'
          'Albaran de ventas PDF'
          'Articulo'
          'Oferta PDF'
          'Pedido de dompras PDF'
          'Albaran de compras PDF'
          'Oferta'
          'Carta de operaciones de clientes'
          'Factura XML')
        Properties.OnChange = TipoPaqueteCtrlPropertiesChange
        TabOrder = 1
        Width = 181
      end
      object Image1: TcxImage
        Left = 805
        Top = 2
        TabStop = False
        Align = alRight
        Picture.Data = {
          0D546478536D617274496D6167653C3F786D6C2076657273696F6E3D22312E30
          2220656E636F64696E673D225554462D38223F3E0D0A3C737667207665727369
          6F6E3D22312E31222069643D224C617965725F312220786D6C6E733D22687474
          703A2F2F7777772E77332E6F72672F323030302F7376672220786D6C6E733A78
          6C696E6B3D22687474703A2F2F7777772E77332E6F72672F313939392F786C69
          6E6B2220783D223070782220793D22307078222077696474683D223234707822
          206865696768743D2232347078222076696577426F783D223020302032342032
          342220656E61626C652D6261636B67726F756E643D226E657720302030203234
          2032342220786D6C3A73706163653D227072657365727665223E262331303B20
          202623393B2623393B3C672069643D226D61696E2220786D6C3A73706163653D
          227072657365727665223E202020202623393B2623393B2623393B2623393B3C
          636C6970506174682069643D22636C69705F6D61736B2220786D6C3A73706163
          653D227072657365727665223E2020202020202623393B2623393B2623393B26
          23393B2623393B2623393B3C7061746820643D224D31342C31392E3563302C2D
          332E303332372C322E343637332C2D352E352C352E352C2D352E3563312E3835
          38382C302C332E353033392C302E393237382C342E352C322E33343336563048
          307632346831362E333433364331342E393237382C32332E303033392C31342C
          32312E333538382C31342C31392E357A222F3E0D0A09093C2F636C6970506174
          683E0D0A3C672069643D2269636F6E2220636C69702D706174683D2275726C28
          23636C69705F6D61736B292220786D6C3A73706163653D227072657365727665
          223E2020202020202623393B2623393B2623393B2623393B2623393B2623393B
          3C672069643D227472616E73666F726D65645F69636F6E22207472616E73666F
          726D3D227472616E736C617465282D31202D31292220786D6C3A73706163653D
          227072657365727665223E262331333B262331303B3C7061746820643D224D31
          2E333037352C342E3337363543312E313136352C342E353736362C312C342E38
          3430382C312C352E313239347631332E3734313263302C302E333332362C302E
          313534382C302E363332382C302E342C302E383463302E323132372C302E3137
          39372C32302E393837332C302E313739372C32312E322C3063302E323435322C
          2D302E323037322C302E342C2D302E353037342C302E342C2D302E383456352E
          3132393463302C2D302E333332362C2D302E313534382C2D302E363332382C2D
          302E333939392C2D302E383339394332322E333837342C342E313039372C312E
          353237362C342E313435372C312E333037352C342E333736357A222066696C6C
          3D2223414142324244222F3E0D0A3C7061746820643D224D31302E303537312C
          31312E353239346C2D382E383631332C372E3935363443312E343130362C3139
          2E373934362C312E373830382C32302C322E322C32306831392E3663302E3431
          39322C302C302E373839342C2D302E323035342C312E303034312C2D302E3531
          34326C2D382E383631332C2D372E393536344331322E382C31302E363037312C
          31312E313636372C31302E353934352C31302E303537312C31312E353239347A
          222066696C6C3D2223434344304439222F3E0D0A3C7061746820643D224D3132
          2C31352E333838324C312E313935392C342E3532363663302E323134382C2D30
          2E333235332C32312E333933352C2D302E333235332C32312E363038332C304C
          31322C31352E333838327A222066696C6C3D222332343238324422206F706163
          6974793D22302E3231222F3E0D0A3C7061746820643D224D31322C31332E3431
          31384C312E313935392C342E3531343243312E343130362C342E323035342C31
          2E373830382C342C322E322C346831392E3663302E343139322C302C302E3738
          39342C302E323035342C312E303034312C302E353134324C31322C31332E3431
          31387A222066696C6C3D2223453645394545222F3E0D0A0909093C2F673E0D0A
          09093C2F673E0D0A3C672069643D226F7665726C61792220786D6C3A73706163
          653D227072657365727665223E262331333B262331303B3C636972636C652063
          783D2231392E35222063793D2231392E352220723D22342E3438393922206669
          6C6C3D2223344643304538222F3E0D0A3C7061746820643D224D32322E363734
          392C31362E33323531632D302E303036312C2D302E303036312C2D302E303132
          342C2D302E303132312C2D302E303138362C2D302E303138326C2D362E333439
          332C362E3334393363302E303036312C302E303036322C302E3031322C302E30
          3132352C302E303138322C302E3031383663312E373533342C312E373533342C
          342E353936332C312E373533342C362E333439372C305332342E343238332C31
          382E303738362C32322E363734392C31362E333235317A222066696C6C3D2223
          33424145444122206F7061636974793D22302E37222F3E0D0A3C706174682064
          3D224D32322E333431372C31392E333536346C2D322E363939312C2D322E3639
          3931632D302E303737382C2D302E303737382C2D302E323035312C2D302E3037
          37382C2D302E323832382C306C2D302E343234332C302E34323433632D302E30
          3737382C302E303737382C2D302E303737382C302E323035362C302C302E3238
          33344C32302E35372C3139682D332E37303938632D302E31312C302C2D302E32
          3630322C302E303838392C2D302E323630322C302E3139383976302E3663302C
          302E31312C302E313530322C302E323031312C302E323630322C302E32303131
          68332E373037366C2D312E363332332C312E36333138632D302E303737382C30
          2E303737382C2D302E303737382C302E323034382C302C302E323832366C302E
          343234332C302E3432343163302E303737382C302E303737382C302E32303531
          2C302E303737372C302E323832382C2D302E303030316C322E323734392C2D32
          2E323734396C302E343234332C2D302E343234334332322E343139342C31392E
          353631342C32322E343139342C31392E343334312C32322E333431372C31392E
          333536347A222066696C6C3D2223464646464646222F3E0D0A09093C2F673E0D
          0A093C2F673E0D0A3C2F7376673E0D0A}
        Properties.ShowFocusRect = False
        Style.BorderStyle = ebsNone
        Style.HotTrack = False
        Style.TransparentBorder = True
        TabOrder = 2
        Transparent = True
        Height = 28
        Width = 34
      end
    end
    object ParametrosPanel: TcxGroupBox
      Left = 2
      Top = 34
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 1
      Visible = False
      Height = 53
      Width = 841
      object FechaInicialCtrl: TcxDateEdit
        Left = 195
        Top = 22
        Properties.Required = True
        Properties.ImmediatePost = True
        Properties.OnEditValueChanged = FechaCtrlPropertiesEditValueChanged
        TabOrder = 2
        Width = 100
      end
      object cxLabel2: TcxLabel
        Left = 7
        Top = 1
        TabStop = False
        Caption = 'Mostrar'
        TabOrder = 4
        Transparent = True
      end
      object FechaFinalCtrl: TcxDateEdit
        Left = 362
        Top = 22
        CaptionLabel = cxLabel3
        Properties.Required = True
        Properties.ImmediatePost = True
        Properties.OnEditValueChanged = FechaCtrlPropertiesEditValueChanged
        TabOrder = 3
        Width = 100
      end
      object cxLabel3: TcxLabel
        Left = 304
        Top = 23
        TabStop = False
        Caption = 'hasta el'
        TabOrder = 5
        Transparent = True
      end
      object TodosLosMensajesCtrl: TcxRadioButton
        Left = 114
        Top = 2
        Caption = 'Todos los mensajes'
        TabOrder = 0
        OnClick = RadionButtonCtrlClick
        AutoSize = True
        Transparent = True
      end
      object DesdeHastaCtrl: TcxRadioButton
        Left = 114
        Top = 24
        Caption = 'Desde el'
        TabOrder = 1
        OnClick = RadionButtonCtrlClick
        AutoSize = True
        Transparent = True
      end
    end
    object FoldersPanel: TcxGroupBox
      Left = 2
      Top = 87
      Align = alClient
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 2
      OnExit = FoldersPanelExit
      Height = 400
      Width = 841
      object CarpetasPageControl: TcxPageControl
        Left = 2
        Top = 2
        Width = 837
        Height = 291
        Align = alClient
        TabOrder = 0
        Properties.ActivePage = BuzonEntradaTabSheet
        Properties.CustomButtons.Buttons = <>
        ClientRectBottom = 287
        ClientRectLeft = 4
        ClientRectRight = 833
        ClientRectTop = 28
        object BuzonEntradaTabSheet: TcxTabSheet
          Caption = 'Buz'#243'n de entrada'
          ImageIndex = 0
          object EntranteGrid: TcxGrid
            Left = 0
            Top = 0
            Width = 829
            Height = 259
            Align = alClient
            TabOrder = 0
            OnEnter = GridEnter
            object EntranteView: TcxGridDBTableView
              OnDblClick = EntranteViewDblClick
              OnKeyDown = EntranteViewKeyDown
              Navigator.Buttons.CustomButtons = <>
              ScrollbarAnnotations.CustomAnnotations = <>
              OnCanFocusRecord = TableViewCanFocusRecord
              DataController.DataSource = CorreoEntranteDataSource
              DataController.Filter.Active = True
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsSelection.HideSelection = True
              OptionsView.ColumnAutoWidth = True
              OptionsView.GroupByBox = False
              OptionsView.Indicator = True
              Preview.Visible = True
              object EntranteViewSeleccionado: TcxGridDBColumn
                Caption = 'Sel.'
                DataBinding.FieldName = 'Seleccionado'
                DataBinding.IsNullValueType = True
                PropertiesClassName = 'TcxCheckBoxProperties'
                Properties.NullStyle = nssUnchecked
                Width = 29
              end
              object EntranteViewAsunto: TcxGridDBColumn
                DataBinding.FieldName = 'Asunto'
                DataBinding.IsNullValueType = True
                Width = 304
              end
              object EntranteViewRemitente: TcxGridDBColumn
                DataBinding.FieldName = 'Remitente'
                DataBinding.IsNullValueType = True
                Width = 209
              end
              object EntranteViewFecha: TcxGridDBColumn
                DataBinding.FieldName = 'Fecha'
                DataBinding.IsNullValueType = True
                Width = 77
              end
              object EntranteViewHora: TcxGridDBColumn
                DataBinding.FieldName = 'Hora'
                DataBinding.IsNullValueType = True
                Width = 61
              end
              object EntranteViewParametros: TcxGridDBColumn
                DataBinding.FieldName = 'Parametros'
                DataBinding.IsNullValueType = True
                Visible = False
              end
            end
            object EntranteLevel: TcxGridLevel
              GridView = EntranteView
            end
          end
        end
        object RecibidosTabSheet: TcxTabSheet
          Caption = '&Recibidos'
          ImageIndex = 2
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 236
          object RecibidosGrid: TcxGrid
            Left = 0
            Top = 0
            Width = 791
            Height = 235
            Align = alClient
            TabOrder = 0
            OnEnter = GridEnter
            ExplicitHeight = 236
            object RecibidosView: TcxGridDBTableView
              Navigator.Buttons.CustomButtons = <>
              ScrollbarAnnotations.CustomAnnotations = <>
              OnCanFocusRecord = TableViewCanFocusRecord
              DataController.DataSource = CorreoRecibidoDataSource
              DataController.Filter.Active = True
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsData.DeletingConfirmation = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsSelection.CellSelect = False
              OptionsSelection.MultiSelect = True
              OptionsSelection.HideSelection = True
              OptionsView.ColumnAutoWidth = True
              OptionsView.GroupByBox = False
              OptionsView.Indicator = True
              Preview.Visible = True
              object RecibidosViewTextoTipo: TcxGridDBColumn
                Caption = 'Tipo'
                DataBinding.FieldName = 'TextoTipo'
                Width = 120
              end
              object RecibidosViewAsunto: TcxGridDBColumn
                DataBinding.FieldName = 'Asunto'
                Width = 218
              end
              object RecibidosViewRemitente: TcxGridDBColumn
                DataBinding.FieldName = 'Remitente'
                Width = 160
              end
              object RecibidosViewFecha: TcxGridDBColumn
                DataBinding.FieldName = 'Fecha'
                Width = 80
              end
              object RecibidosViewHora: TcxGridDBColumn
                DataBinding.FieldName = 'Hora'
                Width = 80
              end
              object RecibidosViewID: TcxGridDBColumn
                DataBinding.FieldName = 'ID'
                Visible = False
              end
              object RecibidosViewParametros: TcxGridDBColumn
                DataBinding.FieldName = 'Parametros'
                Visible = False
              end
            end
            object RecibidosLevel: TcxGridLevel
              GridView = RecibidosView
            end
          end
          object RecibidosViewManager: TGridTableViewController
            Left = 791
            Top = 0
            Align = alRight
            Enabled = False
            PanelStyle.Active = True
            Style.BorderStyle = ebsNone
            Style.TransparentBorder = False
            TabOrder = 1
            TableView = RecibidosView
            ShiftRecords = False
            UseGridFilterBox = False
            OnDelete = RecibidosViewManagerDelete
            Height = 259
            Width = 38
          end
        end
        object EnviadosTabSheet: TcxTabSheet
          Caption = 'Enviados'
          ImageIndex = 1
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 236
          object GridTableViewController1: TGridTableViewController
            Left = 791
            Top = 0
            Align = alRight
            Enabled = False
            PanelStyle.Active = True
            Style.BorderStyle = ebsNone
            Style.TransparentBorder = False
            TabOrder = 0
            TableView = EnviadosView
            ShiftRecords = False
            UseGridFilterBox = False
            OnDelete = GridTableViewController1Delete
            Height = 259
            Width = 38
          end
          object EnviadosGrid: TcxGrid
            Left = 0
            Top = 0
            Width = 791
            Height = 259
            Align = alClient
            TabOrder = 1
            OnEnter = GridEnter
            ExplicitHeight = 236
            object EnviadosView: TcxGridDBTableView
              Navigator.Buttons.CustomButtons = <>
              ScrollbarAnnotations.CustomAnnotations = <>
              OnCanFocusRecord = TableViewCanFocusRecord
              DataController.DataSource = CorreoEnviadoDataSource
              DataController.Filter.Active = True
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsData.DeletingConfirmation = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsSelection.CellSelect = False
              OptionsSelection.MultiSelect = True
              OptionsSelection.HideSelection = True
              OptionsView.ColumnAutoWidth = True
              OptionsView.GroupByBox = False
              OptionsView.Indicator = True
              Preview.Visible = True
              object EnviadosViewTextoTipo: TcxGridDBColumn
                Caption = 'Tipo'
                DataBinding.FieldName = 'TextoTipo'
                Width = 130
              end
              object EnviadosViewAsunto: TcxGridDBColumn
                DataBinding.FieldName = 'Asunto'
                Width = 235
              end
              object EnviadosViewRemitente: TcxGridDBColumn
                DataBinding.FieldName = 'Destinatario'
                Width = 160
              end
              object EnviadosViewFecha: TcxGridDBColumn
                DataBinding.FieldName = 'Fecha'
                Width = 80
              end
              object EnviadosViewHora: TcxGridDBColumn
                DataBinding.FieldName = 'Hora'
                Width = 80
              end
              object EnviadosViewID: TcxGridDBColumn
                DataBinding.FieldName = 'ID'
                Visible = False
              end
              object EnviadosViewParametros: TcxGridDBColumn
                DataBinding.FieldName = 'Parametros'
                Visible = False
              end
            end
            object EnviadosLevel: TcxGridLevel
              GridView = EnviadosView
            end
          end
        end
      end
      object ParametrosCtrl: TcxMCListBox
        Left = 2
        Top = 301
        Width = 837
        Height = 97
        Align = alBottom
        Delimiter = ':'
        ExtendedSelect = False
        HeaderSections = <
          item
            Text = 'Parametro'
            Width = 150
          end
          item
            AutoSize = True
            Text = 'Valor'
            Width = 683
          end>
        TabOrder = 1
      end
      object cxSplitter1: TcxSplitter
        Left = 2
        Top = 293
        Width = 837
        Height = 8
        Cursor = crVSplit
        HotZoneClassName = 'TcxXPTaskBarStyle'
        AlignSplitter = salBottom
        Control = ParametrosCtrl
      end
    end
  end
  object FormManager: TgxFormManager
    FirstDataControl = TipoPaqueteCtrl
    ShowQueryOption = False
    OnCreateForm = FormManagerCreateForm
    OnPreparedForm = FormManagerPreparedForm
    Left = 672
    Top = 16
  end
  object CorreoRecibidoQuery: TnxeQuery
    Database = DataAccessModule.AppDatabase
    Timeout = 180000
    OnCalcFields = CorreoRecibidoQueryCalcFields
    RequestLive = True
    SQL.Strings = (
      'SELECT * FROM Correo Where 0>0')
    Left = 470
    Top = 15
    object CorreoRecibidoQueryCodigoEmpresa: TWideStringField
      FieldName = 'CodigoEmpresa'
      Size = 3
    end
    object CorreoRecibidoQueryCodigoUsuario: TWideStringField
      FieldName = 'CodigoUsuario'
      Size = 2
    end
    object CorreoRecibidoQueryCarpeta: TSmallintField
      FieldName = 'Carpeta'
    end
    object CorreoRecibidoQueryTipo: TSmallintField
      FieldName = 'Tipo'
    end
    object CorreoRecibidoQueryId: TUnsignedAutoIncField
      FieldName = 'Id'
    end
    object CorreoRecibidoQueryAsunto: TWideStringField
      FieldName = 'Asunto'
      Size = 128
    end
    object CorreoRecibidoQueryRemitente: TWideStringField
      FieldName = 'Remitente'
      Size = 128
    end
    object CorreoRecibidoQueryFecha: TDateField
      FieldName = 'Fecha'
    end
    object CorreoRecibidoQueryHora: TTimeField
      FieldName = 'Hora'
    end
    object CorreoRecibidoQueryFechaProceso: TDateField
      FieldName = 'FechaProceso'
    end
    object CorreoRecibidoQueryHoraProceso: TTimeField
      FieldName = 'HoraProceso'
    end
    object CorreoRecibidoQueryParametros: TWideMemoField
      FieldName = 'Parametros'
      BlobType = ftWideMemo
    end
    object CorreoRecibidoQueryAdjunto: TBlobField
      FieldName = 'Adjunto'
    end
    object CorreoRecibidoQueryTextoTipo: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'TextoTipo'
      Size = 30
      Calculated = True
    end
  end
  object CorreoRecibidoDataSource: TDataSource
    DataSet = CorreoRecibidoQuery
    Left = 436
    Top = 16
  end
  object CorreoEntranteDataSource: TDataSource
    Left = 354
    Top = 16
  end
  object CorreoTable: TnxeTable
    ActiveRuntime = True
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    TableName = 'Correo'
    IndexFieldNames = 'ID'
    Left = 594
    Top = 16
    object CorreoTableID: TUnsignedAutoIncField
      FieldName = 'ID'
    end
  end
  object CorreoEnviadoDataSource: TDataSource
    DataSet = CorreoEnviadoQuery
    Left = 518
    Top = 16
  end
  object CorreoEnviadoQuery: TnxeQuery
    Database = DataAccessModule.AppDatabase
    Timeout = 180000
    OnCalcFields = CorreoEnviadoQueryCalcFields
    RequestLive = True
    SQL.Strings = (
      'SELECT * FROM Correo Where 0>0')
    Left = 552
    Top = 16
    object CorreoEnviadoQueryCodigoEmpresa: TWideStringField
      FieldName = 'CodigoEmpresa'
      Size = 3
    end
    object CorreoEnviadoQueryCodigoUsuario: TWideStringField
      FieldName = 'CodigoUsuario'
      Size = 2
    end
    object CorreoEnviadoQueryCarpeta: TSmallintField
      FieldName = 'Carpeta'
    end
    object CorreoEnviadoQueryTipo: TSmallintField
      FieldName = 'Tipo'
    end
    object CorreoEnviadoQueryId: TUnsignedAutoIncField
      FieldName = 'Id'
    end
    object CorreoEnviadoQueryAsunto: TWideStringField
      FieldName = 'Asunto'
      Size = 128
    end
    object CorreoEnviadoQueryRemitente: TWideStringField
      FieldName = 'Remitente'
      Size = 128
    end
    object CorreoEnviadoQueryDestinatario: TWideStringField
      FieldName = 'Destinatario'
      Size = 128
    end
    object CorreoEnviadoQueryFecha: TDateField
      FieldName = 'Fecha'
    end
    object CorreoEnviadoQueryHora: TTimeField
      FieldName = 'Hora'
    end
    object CorreoEnviadoQueryFechaProceso: TDateField
      FieldName = 'FechaProceso'
    end
    object CorreoEnviadoQueryHoraProceso: TTimeField
      FieldName = 'HoraProceso'
    end
    object CorreoEnviadoQueryAdjunto: TBlobField
      FieldName = 'Adjunto'
    end
    object CorreoEnviadoQueryParametros: TWideMemoField
      FieldName = 'Parametros'
      BlobType = ftWideMemo
    end
    object CorreoEnviadoQueryTextoTipo: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'TextoTipo'
      Size = 30
      Calculated = True
    end
  end
end
