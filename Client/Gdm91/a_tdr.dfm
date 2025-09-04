object MntTdrForm: TMntTdrForm
  Left = 430
  Top = 230
  HelpContext = 80515
  BorderStyle = bsDialog
  Caption = 'Tarjetas de registro'
  ClientHeight = 702
  ClientWidth = 1033
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  Position = poDefault
  Visible = True
  OnResize = gFormResize
  TextHeight = 17
  object KeyScreen: TgxEditPanel
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epKeyPanel
    Height = 35
    Width = 1033
    object NroRegistroCtrl: TcxDBTextEdit
      Left = 133
      Top = 6
      DataBinding.DataField = 'NroRegistro'
      DataBinding.DataSource = TarjetaRegistroDataSource
      Properties.Required = True
      Properties.OnQueryRequest = NroRegistroCtrlPropertiesQueryRequest
      Properties.MaxLength = 8
      TabOrder = 0
      Width = 68
    end
    object codigoCtrlCaption: TcxLabel
      Left = 17
      Top = 9
      TabStop = False
      Caption = 'N'#186' registro'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
  object DataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 35
    Margins.Left = 5
    Margins.Top = 0
    Margins.Right = 5
    Margins.Bottom = 0
    Align = alClient
    Alignment = alCenterCenter
    PanelStyle.Active = True
    ParentBackground = False
    ParentColor = False
    Style.BorderStyle = ebsSingle
    Style.Color = cl3DLight
    Style.TransparentBorder = False
    TabOrder = 1
    PanelKind = epDataPanel
    Height = 631
    Width = 1023
    object ScrollBox: TcxScrollBox
      Left = 1
      Top = 1
      Width = 1021
      Height = 629
      Align = alClient
      BorderStyle = cxcbsNone
      LookAndFeel.ScrollbarMode = sbmClassic
      TabOrder = 0
      Transparent = True
      object Panel1: TcxGroupBox
        Left = 0
        Top = 0
        Align = alTop
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 0
        DesignSize = (
          1021
          385)
        Height = 385
        Width = 1021
        object AplicacionCtrl: TcxDBIndexedComboBox
          Left = 126
          Top = 4
          DataBinding.DataField = 'Aplicacion'
          DataBinding.DataSource = TarjetaRegistroDataSource
          Properties.Alignment.Horz = taLeftJustify
          Properties.DropDownListStyle = lsFixedList
          Properties.ImmediatePost = True
          Properties.Items.Strings = (
            '<Reservado>'
            '1 : Gesti'#243'n contable'
            '2 : Terminal punto de venta (TPV)'
            '3 : Gesti'#243'n contable, financiera y comercial'
            '4 : Aprovisionamiento y carga'
            '5 : Gesti'#243'n financiera y comercial'
            '6 : Preventa'
            '7 : Producci'#243'n')
          TabOrder = 0
          Width = 233
        end
        object VersionCtrl: TcxDBSpinEdit
          Left = 126
          Top = 31
          DataBinding.DataField = 'Version'
          DataBinding.DataSource = TarjetaRegistroDataSource
          Properties.Required = True
          TabOrder = 1
          Width = 50
        end
        object ReleaseCtrl: TcxDBSpinEdit
          Left = 185
          Top = 31
          DataBinding.DataField = 'Release'
          DataBinding.DataSource = TarjetaRegistroDataSource
          TabOrder = 2
          Width = 45
        end
        object NroUsuariosCtrl: TcxDBSpinEdit
          Left = 126
          Top = 58
          DataBinding.DataField = 'NroUsuarios'
          DataBinding.DataSource = TarjetaRegistroDataSource
          Properties.Required = True
          Properties.OnEnter = NroUsuariosCtrlPropertiesEnter
          TabOrder = 3
          Width = 50
        end
        object TipoContratoCtrl: TcxDBRadioGroup
          Left = 119
          Top = 85
          Alignment = alCenterCenter
          DataBinding.DataField = 'TipoContrato'
          DataBinding.DataSource = TarjetaRegistroDataSource
          Properties.Columns = 3
          Properties.DefaultValue = 0
          Properties.ImmediatePost = True
          Properties.Items = <
            item
              Caption = 'Mantenimiento'
              Value = 0
            end
            item
              Caption = 'Suscripci'#243'n'
              Enabled = False
              Value = 1
            end
            item
              Caption = 'Bloqueado'
              Value = 2
            end>
          Style.BorderStyle = ebsNone
          TabOrder = 5
          Transparent = True
          Height = 25
          Width = 352
        end
        object CodigoGestionCtrl: TcxDBTextEdit
          Left = 126
          Top = 138
          DescriptionLabel = NombreLabel
          DataBinding.DataField = 'CodigoGestion'
          DataBinding.DataSource = TarjetaRegistroDataSource
          Properties.OnQueryRequest = ClienteCtrlPropertiesQueryRequest
          Properties.OnEditRequest = ClienteCtrlPropertiesEditRequest
          Properties.OnValuePosted = CodigoGestionCtrlPropertiesValuePosted
          Properties.TextEditPad = tpLeftZero
          Properties.PadAlways = True
          Properties.OnValidate = ClienteCtrlPropertiesValidate
          TabOrder = 8
          Width = 46
        end
        object NroSerieCtrl: TcxDBTextEdit
          Left = 126
          Top = 165
          DataBinding.DataField = 'NroSerie'
          DataBinding.DataSource = TarjetaRegistroDataSource
          Properties.Required = True
          Properties.OnValuePosted = NroSerieCtrlPropertiesValuePosted
          Properties.MaxLength = 12
          TabOrder = 9
          Width = 91
        end
        object FechaInstalacionCtrl: TcxDBDateEdit
          Left = 126
          Top = 111
          DataBinding.DataField = 'FechaInstalacion'
          DataBinding.DataSource = TarjetaRegistroDataSource
          Properties.Required = True
          TabOrder = 6
          Width = 110
        end
        object FechaCaducidadCtrl: TcxDBDateEdit
          Left = 338
          Top = 111
          DataBinding.DataField = 'FechaCaducidad'
          DataBinding.DataSource = TarjetaRegistroDataSource
          Enabled = False
          TabOrder = 7
          Width = 110
        end
        object ModulosOpcionalesCtrl: TcxCheckListBox
          Left = 484
          Top = 4
          Width = 528
          Height = 121
          Anchors = [akLeft, akTop, akRight]
          Columns = 2
          Items = <
            item
              Text = 'Factura electr'#243'nica'
            end
            item
              Text = 'Trazabilidad'
            end
            item
              Text = 'Partidas presupuestarias'
            end
            item
              Text = 'Gesti'#243'n de envases y contenedores'
            end
            item
              Text = 'Exportaci'#243'n'
            end
            item
              Text = 'Tableta de firma digital'
            end
            item
              Enabled = False
              Text = 'Administraciones p'#250'blicas (FACe)'
            end
            item
              Text = 'Tienda virtual (Magento)'
            end
            item
              Text = 'Suministro inmediato de informaci'#243'n'
            end
            item
              Text = 'Servidor de 64 bits'
            end>
          TabOrder = 4
          OnEditValueChanged = ModulosOpcionalesCtrlEditValueChanged
        end
        object Label8: TcxLabel
          Left = 8
          Top = 8
          TabStop = False
          Caption = 'Aplicaci'#243'n'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label11: TcxLabel
          Left = 8
          Top = 36
          TabStop = False
          Caption = 'Versi'#243'n'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label12: TcxLabel
          Left = 179
          Top = 36
          TabStop = False
          Caption = '.'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label10: TcxLabel
          Left = 8
          Top = 61
          TabStop = False
          Caption = 'N'#186' de usuarios'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label13: TcxLabel
          Left = 8
          Top = 89
          TabStop = False
          Caption = 'Tipo de contrato'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label14: TcxLabel
          Left = 8
          Top = 141
          TabStop = False
          Caption = 'C'#243'digo gesti'#243'n'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object NombreLabel: TcxLabel
          Left = 259
          Top = 141
          TabStop = False
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 352
        end
        object Label9: TcxLabel
          Left = 8
          Top = 168
          TabStop = False
          Caption = 'N'#186' de serie'
          Style.TextColor = clNavy
          Style.TextStyle = [fsBold]
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label5: TcxLabel
          Left = 8
          Top = 114
          TabStop = False
          Caption = 'Instalaci'#243'n / Alta'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label18: TcxLabel
          Left = 259
          Top = 114
          TabStop = False
          Caption = 'Caducidad'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label19: TcxLabel
          Left = 399
          Top = 8
          TabStop = False
          AutoSize = False
          Caption = 'M'#243'dulos y opciones'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.WordWrap = True
          Transparent = True
          Height = 34
          Width = 76
        end
        object ClaveActivacionBox: TcxLabel
          Left = 210
          Top = 193
          TabStop = False
          AutoSize = False
          Style.BorderColor = clScrollBar
          Style.BorderStyle = ebsSingle
          Style.Edges = [bBottom]
          Style.LookAndFeel.NativeStyle = False
          Style.TextStyle = [fsBold]
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.NativeStyle = False
          Properties.Alignment.Horz = taRightJustify
          Properties.Alignment.Vert = taVCenter
          Transparent = True
          Height = 21
          Width = 78
          AnchorX = 288
          AnchorY = 204
        end
        object CodigoPaisCtrl: TcxDBTextEdit
          Left = 126
          Top = 298
          DescriptionLabel = descPaisLabel
          DataBinding.DataField = 'CodigoPais'
          DataBinding.DataSource = TarjetaRegistroDataSource
          Properties.OnEnter = CodigoPaisCtrlPropertiesEnter
          Properties.OnQueryRequest = CodigoPaisCtrlPropertiesQueryRequest
          Properties.OnEditRequest = CodigoPaisCtrlPropertiesEditRequest
          Properties.OnValidate = CodigoPaisCtrlPropertiesValidate
          TabOrder = 13
          Width = 32
        end
        object CodigoPostalCtrl: TcxDBTextEdit
          Left = 153
          Top = 325
          DescriptionLabel = descCPLabel
          DataBinding.DataField = 'CodigoPostal'
          DataBinding.DataSource = TarjetaRegistroDataSource
          Properties.OnQueryRequest = CodigoPostalCtrlPropertiesQueryRequest
          Properties.OnEditRequest = CodigoPostalCtrlPropertiesEditRequest
          Properties.OnValidate = CodigoPostalCtrlPropertiesValidate
          TabOrder = 15
          Width = 32
        end
        object CodigoProveedorCtrl: TcxDBTextEdit
          Left = 126
          Top = 352
          DescriptionLabel = proveedorLabel
          DataBinding.DataField = 'CodigoProveedor'
          DataBinding.DataSource = TarjetaRegistroDataSource
          Properties.OnQueryRequest = ClienteCtrlPropertiesQueryRequest
          Properties.OnEditRequest = ClienteCtrlPropertiesEditRequest
          Properties.TextEditPad = tpLeftZero
          Properties.OnValidate = ClienteCtrlPropertiesValidate
          TabOrder = 16
          Width = 46
        end
        object CodigoProvinciaCtrl: TcxDBTextEdit
          Left = 126
          Top = 325
          DescriptionLabel = descCPLabel
          DataBinding.DataField = 'CodigoProvincia'
          DataBinding.DataSource = TarjetaRegistroDataSource
          Properties.OnQueryRequest = CodigoProvinciaCtrlPropertiesQueryRequest
          Properties.OnEditRequest = CodigoProvinciaCtrlPropertiesEditRequest
          Properties.OnEditValueChanged = CodigoProvinciaCtrlPropertiesEditValueChanged
          Properties.OnValidate = CodigoProvinciaCtrlPropertiesValidate
          TabOrder = 14
          Width = 25
        end
        object descCPLabel: TcxLabel
          Left = 259
          Top = 328
          TabStop = False
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 300
        end
        object descPaisLabel: TcxLabel
          Left = 259
          Top = 301
          TabStop = False
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 300
        end
        object DomicilioCtrl: TcxDBTextEdit
          Left = 126
          Top = 244
          DataBinding.DataField = 'Domicilio'
          DataBinding.DataSource = TarjetaRegistroDataSource
          TabOrder = 11
          Width = 353
        end
        object Label1: TcxLabel
          Left = 8
          Top = 220
          TabStop = False
          Caption = 'Nombre'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label15: TcxLabel
          Left = 8
          Top = 329
          TabStop = False
          Caption = 'Provincia / C.P.'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label2: TcxLabel
          Left = 8
          Top = 247
          TabStop = False
          Caption = 'Domicilio'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label3: TcxLabel
          Left = 8
          Top = 274
          TabStop = False
          Caption = 'Localidad'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label4: TcxLabel
          Left = 8
          Top = 301
          TabStop = False
          Caption = 'Pais'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label6: TcxLabel
          Left = 8
          Top = 195
          TabStop = False
          Caption = 'Clave de activaci'#243'n'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label7: TcxLabel
          Left = 8
          Top = 356
          TabStop = False
          Caption = 'Proveedor'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object LocalidadCtrl: TcxDBTextEdit
          Left = 126
          Top = 271
          DataBinding.DataField = 'Localidad'
          DataBinding.DataSource = TarjetaRegistroDataSource
          TabOrder = 12
          Width = 201
        end
        object NombreCtrl: TcxDBTextEdit
          Left = 126
          Top = 217
          DataBinding.DataField = 'Nombre'
          DataBinding.DataSource = TarjetaRegistroDataSource
          TabOrder = 10
          Width = 353
        end
        object NroRegistroBox: TcxLabel
          Left = 126
          Top = 193
          TabStop = False
          AutoSize = False
          Style.BorderColor = clScrollBar
          Style.BorderStyle = ebsSingle
          Style.Edges = [bBottom]
          Style.LookAndFeel.NativeStyle = False
          Style.TextStyle = [fsBold]
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.NativeStyle = False
          Properties.Alignment.Horz = taRightJustify
          Properties.Alignment.Vert = taVCenter
          Transparent = True
          Height = 21
          Width = 56
          AnchorX = 182
          AnchorY = 204
        end
        object NroUsuariosBox: TcxLabel
          Left = 183
          Top = 193
          TabStop = False
          AutoSize = False
          Style.BorderColor = clScrollBar
          Style.BorderStyle = ebsSingle
          Style.Edges = [bBottom]
          Style.LookAndFeel.NativeStyle = False
          Style.TextStyle = [fsBold]
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.NativeStyle = False
          Properties.Alignment.Horz = taRightJustify
          Properties.Alignment.Vert = taVCenter
          Transparent = True
          Height = 21
          Width = 26
          AnchorX = 209
          AnchorY = 204
        end
        object proveedorLabel: TcxLabel
          Left = 259
          Top = 356
          TabStop = False
          AutoSize = False
          ParentFont = False
          Style.Font.Charset = ANSI_CHARSET
          Style.Font.Color = clNavy
          Style.Font.Height = -11
          Style.Font.Name = 'Segoe UI'
          Style.Font.Style = []
          Style.TransparentBorder = False
          Style.IsFontAssigned = True
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 396
        end
      end
      object GridPanel: TcxGroupBox
        Left = 0
        Top = 385
        Align = alClient
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 1
        Height = 244
        Width = 1021
        object Grid: TcxGrid
          Left = 2
          Top = 2
          Width = 979
          Height = 240
          Align = alClient
          Anchors = [akLeft, akTop, akBottom]
          TabOrder = 0
          object GridView: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            ScrollbarAnnotations.CustomAnnotations = <>
            DataController.DataSource = LineaTarjetaRegistroDataSource
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsBehavior.PostponedSynchronization = False
            OptionsBehavior.FocusCellOnTab = True
            OptionsBehavior.FocusFirstCellOnNewRecord = True
            OptionsBehavior.FocusCellOnCycle = True
            OptionsBehavior.PullFocusing = True
            OptionsCustomize.ColumnFiltering = False
            OptionsCustomize.ColumnGrouping = False
            OptionsCustomize.ColumnHidingOnGrouping = False
            OptionsCustomize.ColumnHorzSizing = False
            OptionsCustomize.ColumnMoving = False
            OptionsCustomize.ColumnSorting = False
            OptionsData.Appending = True
            OptionsData.DeletingConfirmation = False
            OptionsSelection.InvertSelect = False
            OptionsView.ColumnAutoWidth = True
            OptionsView.FooterAutoHeight = True
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            object GridViewFecha: TcxGridDBColumn
              DataBinding.FieldName = 'Fecha'
              PropertiesClassName = 'TcxDateEditProperties'
              Properties.Required = True
              Width = 72
            end
            object GridViewNroSerie: TcxGridDBColumn
              Caption = 'N'#186' serie'
              DataBinding.FieldName = 'NroSerie'
              PropertiesClassName = 'TcxTextEditProperties'
              Properties.Required = True
              Properties.MaxLength = 12
              Width = 86
            end
            object GridViewVersion: TcxGridDBColumn
              Caption = 'Versi'#243'n'
              DataBinding.FieldName = 'Version'
              PropertiesClassName = 'TcxSpinEditProperties'
              Properties.Required = True
              Properties.MaxValue = 99.000000000000000000
              Properties.MinValue = 1.000000000000000000
              Width = 45
            end
            object GridViewRelease: TcxGridDBColumn
              Caption = 'Entrega'
              DataBinding.FieldName = 'Release'
              PropertiesClassName = 'TcxSpinEditProperties'
              Properties.AssignedValues.MinValue = True
              Properties.MaxValue = 99.000000000000000000
              Width = 48
            end
            object GridViewNroUsuarios: TcxGridDBColumn
              Caption = 'N'#186' usua.'
              DataBinding.FieldName = 'NroUsuarios'
              PropertiesClassName = 'TcxSpinEditProperties'
              Properties.Required = True
              Properties.MaxValue = 99.000000000000000000
              Properties.MinValue = 1.000000000000000000
              Width = 55
            end
            object GridViewFechaCaducidad: TcxGridDBColumn
              Caption = 'Caducidad'
              DataBinding.FieldName = 'FechaCaducidad'
              PropertiesClassName = 'TcxDateEditProperties'
              Visible = False
            end
            object GridViewClaveActivacion: TcxGridDBColumn
              Caption = 'Clave activaci'#243'n'
              DataBinding.FieldName = 'ClaveActivacion'
              Options.Editing = False
              Width = 95
            end
            object GridViewObservaciones: TcxGridDBColumn
              DataBinding.FieldName = 'Observaciones'
              Width = 298
            end
          end
          object GridLevel: TcxGridLevel
            GridView = GridView
          end
        end
        object TableViewManager: TGridTableViewController
          Left = 981
          Top = 2
          Align = alRight
          Enabled = False
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.TransparentBorder = False
          TabOrder = 1
          TableView = GridView
          ShiftRecords = False
          UseGridFilterBox = False
          Height = 240
          Width = 38
        end
      end
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 666
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      1033
      36)
    Height = 36
    Width = 1033
    object Panel2: TcxGroupBox
      Left = 387
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 260
      object OkButton: TgBitBtn
        Left = 1
        Top = 1
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
        Top = 1
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
      object DeleteButton: TgBitBtn
        Left = 175
        Top = 1
        Width = 85
        Height = 28
        Caption = '&Suprimir'
        Enabled = True
        ModalResult = 3
        OptionsImage.ImageIndex = 5
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 2
        GlyphBitmap = gmDelete
      end
    end
  end
  object FormManager: TgxFormManager
    Dataset = TarjetaRegistroTable
    FirstKeyControl = NroRegistroCtrl
    FirstDataControl = AplicacionCtrl
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    Left = 572
    Top = 2
  end
  object TarjetaRegistroTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    BeforePost = TarjetaRegistroTableBeforePost
    BeforeDelete = TarjetaRegistroTableBeforeDelete
    OnNewRecord = TarjetaRegistroTableNewRecord
    TableName = 'TarjetaRegistro'
    IndexFieldNames = 'NroRegistro'
    AutoIncFieldName = 'NroRegistro'
    OnGetRecord = TarjetaRegistroTableGetRecord
    OnRecordChanged = TarjetaRegistroTableRecordChanged
    OnUpdateState = TarjetaRegistroTableUpdateState
    Left = 520
    Top = 2
  end
  object LineaTarjetaRegistroTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    OnCalcFields = LineaTarjetaRegistroTableCalcFields
    TableName = 'LineaTarjetaRegistro'
    IndexFieldNames = 'NroRegistro;NroLinea'
    MasterFields = 'NroRegistro'
    MasterSource = TarjetaRegistroDataSource
    AutoIncFieldName = 'NroLinea'
    MasterRelation = mrBalanced
    Left = 438
    Top = 2
    object LineaTarjetaRegistroTableNroRegistro: TIntegerField
      FieldName = 'NroRegistro'
    end
    object LineaTarjetaRegistroTableNroLinea: TSmallintField
      FieldName = 'NroLinea'
    end
    object LineaTarjetaRegistroTableFecha: TDateField
      FieldName = 'Fecha'
    end
    object LineaTarjetaRegistroTableNroSerie: TLargeintField
      FieldName = 'NroSerie'
    end
    object LineaTarjetaRegistroTableVersion: TSmallintField
      FieldName = 'Version'
    end
    object LineaTarjetaRegistroTableRelease: TSmallintField
      FieldName = 'Release'
    end
    object LineaTarjetaRegistroTableNroUsuarios: TSmallintField
      FieldName = 'NroUsuarios'
    end
    object LineaTarjetaRegistroTableFechaCaducidad: TDateField
      FieldName = 'FechaCaducidad'
    end
    object LineaTarjetaRegistroTableClaveActivacion: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'ClaveActivacion'
      DisplayFormat = '#'
      Calculated = True
    end
    object LineaTarjetaRegistroTableObservaciones: TWideStringField
      FieldName = 'Observaciones'
      Size = 80
    end
  end
  object TarjetaRegistroDataSource: TDataSource
    DataSet = TarjetaRegistroTable
    Left = 488
    Top = 2
  end
  object LineaTarjetaRegistroDataSource: TDataSource
    DataSet = LineaTarjetaRegistroTable
    Left = 408
    Top = 2
  end
end
