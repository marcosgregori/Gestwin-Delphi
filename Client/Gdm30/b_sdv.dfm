object BoxSdvForm: TBoxSdvForm
  Left = 479
  Top = 221
  HelpType = htKeyword
  HelpKeyword = 'b_sdv'
  BorderStyle = bsDialog
  Caption = 'Selecci'#243'n del documento a importar'
  ClientHeight = 288
  ClientWidth = 638
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs30'
  Position = poDefault
  Visible = True
  TextHeight = 17
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 252
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epButtonsPanel
    DesignSize = (
      638
      36)
    Height = 36
    Width = 638
    object Panel3: TcxGroupBox
      Left = 233
      Top = 4
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 174
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
    end
  end
  object DataPanel: TgxEditPanel
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
    TabOrder = 1
    PanelKind = epInputPanel
    Height = 247
    Width = 628
    object DocumentosMultiplesPanel: TcxGroupBox
      Left = 3
      Top = 3
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Visible = False
      Height = 53
      Width = 622
      object Label4: TcxLabel
        Left = 6
        Top = 9
        TabStop = False
        Caption = 'Tipo de documento'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 1
        Transparent = True
      end
      object TipoMovimientoCtrl: TcxDBRadioGroup
        Left = 127
        Top = 6
        Alignment = alCenterCenter
        DataBinding.DataField = 'TipoMovimiento'
        DataBinding.DataSource = DataSource
        Properties.Columns = 3
        Properties.ImmediatePost = True
        Properties.Items = <
          item
            Caption = 'Presupuesto'
            Value = 13
          end
          item
            Caption = 'Pedido de compra'
            Value = 11
          end
          item
            Caption = 'Pedido de venta'
            Value = 14
          end
          item
            Caption = 'Albaran de compra'
            Value = 12
          end
          item
            Caption = 'Albar'#225'n de venta'
            Value = 15
          end
          item
            Caption = 'Fichero externo'
            Value = 16
          end>
        Properties.OnEditValueChanged = TipoMovimientoCtrlPropertiesEditValueChanged
        Style.BorderStyle = ebsNone
        TabOrder = 0
        Height = 48
        Width = 474
      end
    end
    object DocumentoUnicoPanel: TcxGroupBox
      Left = 3
      Top = 56
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 1
      Visible = False
      Height = 29
      Width = 622
      object cxLabel1: TcxLabel
        Left = 6
        Top = 8
        TabStop = False
        Caption = 'Tipo de documento'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 0
        Transparent = True
      end
      object TipoDocumentoLabel: TcxLabel
        Left = 138
        Top = 4
        TabStop = False
        AutoSize = False
        Style.BorderColor = clScrollBar
        Style.BorderStyle = ebsSingle
        Style.Edges = [bBottom]
        Style.LookAndFeel.NativeStyle = False
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.NativeStyle = False
        Properties.Alignment.Horz = taLeftJustify
        Properties.Alignment.Vert = taVCenter
        TabOrder = 1
        Transparent = True
        Height = 23
        Width = 135
        AnchorY = 16
      end
    end
    object ParametrosPanel: TcxGroupBox
      Left = 3
      Top = 85
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 2
      DesignSize = (
        622
        115)
      Height = 115
      Width = 622
      object SerieCtrl: TcxDBTextEdit
        Left = 138
        Top = 56
        CaptionLabel = CapSerieLabel
        DescriptionLabel = Label3
        DataBinding.DataField = 'Serie'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = SerieCtrlPropertiesQueryRequest
        Properties.OnValidate = SerieCtrlPropertiesValidate
        TabOrder = 2
        Width = 25
      end
      object NroDocumentoCtrl: TcxDBTextEdit
        Left = 138
        Top = 83
        CaptionLabel = TipoMovimientoLabel
        DescriptionLabel = Label2
        DataBinding.DataField = 'NroDocumento'
        DataBinding.DataSource = DataSource
        Properties.Required = True
        Properties.OnQueryRequest = NroDocumentoCtrlPropertiesQueryRequest
        Properties.MaxLength = 8
        Properties.OnValidate = NroDocumentoCtrlPropertiesValidate
        TabOrder = 3
        Width = 67
      end
      object PropietarioCtrl: TcxDBTextEdit
        Left = 138
        Top = 29
        CaptionLabel = CaptionPropietarioLabel
        DescriptionLabel = DescPropietarioLabel
        DataBinding.DataField = 'Propietario'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = PropietarioCtrlPropertiesQueryRequest
        Properties.OnEditRequest = PropietarioCtrlPropertiesEditRequest
        Properties.TextEditPad = tpLeftZero
        Properties.OnValidate = PropietarioCtrlPropertiesValidate
        TabOrder = 1
        Width = 46
      end
      object EjercicioCtrl: TcxDBTextEdit
        Left = 138
        Top = 2
        CaptionLabel = Label1
        DataBinding.DataField = 'Ejercicio'
        DataBinding.DataSource = DataSource
        Properties.Required = True
        Properties.MaxLength = 4
        TabOrder = 0
        Width = 39
      end
      object TipoMovimientoLabel: TcxLabel
        Left = 6
        Top = 87
        TabStop = False
        Caption = 'N'#186' de pedido'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 4
        Transparent = True
      end
      object CapSerieLabel: TcxLabel
        Left = 6
        Top = 60
        TabStop = False
        Caption = 'Serie'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 5
        Transparent = True
      end
      object CaptionPropietarioLabel: TcxLabel
        Left = 6
        Top = 33
        TabStop = False
        Caption = 'Codigo cliente'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 6
        Transparent = True
      end
      object DescPropietarioLabel: TcxLabel
        Left = 218
        Top = 33
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 7
        Transparent = True
        Height = 19
        Width = 397
      end
      object Label1: TcxLabel
        Left = 6
        Top = 6
        TabStop = False
        Caption = 'Ejercicio'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 8
        Transparent = True
      end
      object Label2: TcxLabel
        Left = 218
        Top = 85
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 9
        Transparent = True
        Height = 19
        Width = 397
      end
      object Label3: TcxLabel
        Left = 218
        Top = 57
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 10
        Transparent = True
        Height = 19
        Width = 397
      end
    end
    object FicheroPanel: TcxGroupBox
      Left = 3
      Top = 200
      Align = alClient
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.Edges = [bTop]
      TabOrder = 3
      DesignSize = (
        622
        44)
      Height = 44
      Width = 622
      object ExaminarButton: TgBitBtn
        Left = 507
        Top = 0
        Width = 103
        Height = 27
        Anchors = [akTop, akRight]
        Caption = 'E&xaminar ...'
        Enabled = True
        OptionsImage.ImageIndex = 21
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 0
        OnClick = ExaminarButtonClick
        GlyphBitmap = gmFolder
      end
      object captionFicheroDatosLabel: TcxLabel
        Left = 6
        Top = 4
        TabStop = False
        Caption = 'Fichero de datos'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 1
        Transparent = True
      end
      object FicheroDatosBox: TcxLabel
        Left = 138
        Top = 2
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.BorderColor = clScrollBar
        Style.BorderStyle = ebsSingle
        Style.Edges = [bBottom]
        Style.LookAndFeel.NativeStyle = False
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.NativeStyle = False
        Properties.Alignment.Vert = taVCenter
        TabOrder = 2
        Transparent = True
        Height = 25
        Width = 359
        AnchorY = 15
      end
    end
  end
  object MovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'TipoMovimiento;Ejercicio;Propietario;Serie;NroDocumento'
    Left = 481
    Top = 162
  end
  object FormManager: TgxFormManager
    Dataset = Data
    FirstDataControl = TipoMovimientoCtrl
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 481
    Top = 131
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 452
    Top = 131
    object DataSerie: TWideStringField
      FieldName = 'Serie'
      Size = 5
    end
    object DataTipoMovimiento: TSmallintField
      FieldName = 'TipoMovimiento'
    end
    object DataEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object DataPropietario: TWideStringField
      FieldName = 'Propietario'
      Size = 5
    end
    object DataNroDocumento: TIntegerField
      FieldName = 'NroDocumento'
      DisplayFormat = '#'
      EditFormat = '#'
    end
    object DataNroOperacion: TIntegerField
      FieldName = 'NroOperacion'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 423
    Top = 131
  end
end
