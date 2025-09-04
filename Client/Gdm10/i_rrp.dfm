object RptRrpForm: TRptRrpForm
  Left = 576
  Top = 346
  HelpType = htKeyword
  HelpKeyword = 'i_rrp'
  HelpContext = 3142
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Emisi'#243'n de documentos de pago de una remesa'
  ClientHeight = 297
  ClientWidth = 605
  Color = clWindow
  Ctl3D = False
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs10'
  Position = poDefault
  Visible = True
  TextHeight = 17
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
    TabOrder = 0
    PanelKind = epInputPanel
    ExplicitHeight = 282
    Height = 256
    Width = 595
    object SoporteMagneticoGroupBox: TcxGroupBox
      Left = 2
      Top = 87
      Align = alTop
      Alignment = alCenterCenter
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 1
      DesignSize = (
        591
        130)
      Height = 130
      Width = 591
      object PathCtrl: TcxDBTextEdit
        Left = 149
        Top = 3
        CaptionLabel = Label3
        Anchors = [akLeft, akTop, akRight]
        DataBinding.DataField = 'Path'
        DataBinding.DataSource = DataSource
        Properties.OnValidate = PathCtrlPropertiesValidate
        TabOrder = 0
        Width = 333
      end
      object ExaminarButton: TgBitBtn
        Left = 486
        Top = 2
        Width = 99
        Height = 27
        Anchors = [akTop, akRight]
        Caption = 'E&xaminar ...'
        Enabled = True
        OptionsImage.ImageIndex = 21
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 1
        TabStop = False
        OnClick = ExaminarButtonClick
        GlyphBitmap = gmFolder
      end
      object Label3: TcxLabel
        Left = 10
        Top = 6
        Caption = 'Path (directorio)'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 3
        Transparent = True
      end
      object TipoOrdenLabel: TcxLabel
        Left = 10
        Top = 34
        Caption = 'Tipo de orden'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 4
        Transparent = True
      end
      object TipoOrdenCtrl: TcxDBIndexedComboBox
        Left = 149
        Top = 30
        DataBinding.DataField = 'TipoOrden'
        DataBinding.DataSource = DataSource
        Properties.Alignment.Horz = taLeftJustify
        Properties.DropDownListStyle = lsFixedList
        Properties.ImmediatePost = True
        Properties.Items.Strings = (
          'Transferencias y cheques SEPA'
          'Pagos domiciliados (AEB 68)'
          'Formato '#250'nico de confirming')
        Properties.OnEditValueChanged = TipoOrdenCtrlPropertiesEditValueChanged
        TabOrder = 2
        Width = 210
      end
      object OpcionesPC: TcxPageControl
        Left = 4
        Top = 58
        Width = 585
        Height = 68
        TabOrder = 5
        TabStop = False
        Properties.ActivePage = cxTabSheet1
        Properties.CustomButtons.Buttons = <>
        Properties.HideTabs = True
        ClientRectBottom = 64
        ClientRectLeft = 4
        ClientRectRight = 581
        ClientRectTop = 4
        object cxTabSheet1: TcxTabSheet
          Caption = 'cxTabSheet1'
          ImageIndex = 0
          ExplicitWidth = 579
          object CaptionTipoFicheroLabel: TcxLabel
            Left = 5
            Top = 2
            Caption = 'Forma de pago'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 2
            Transparent = True
          end
          object ConceptoOrdenCtrl: TcxDBIndexedComboBox
            Left = 143
            Top = 29
            CaptionLabel = Label1
            DataBinding.DataField = 'ConceptoOrden'
            DataBinding.DataSource = DataSource
            Properties.Alignment.Horz = taLeftJustify
            Properties.DropDownListStyle = lsFixedList
            Properties.Items.Strings = (
              'N'#243'mina'
              'Pensi'#243'n'
              'Otros conceptos')
            TabOrder = 1
            Width = 128
          end
          object Label1: TcxLabel
            Left = 5
            Top = 33
            Caption = 'Concepto'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 3
            Transparent = True
          end
          object TipoFicheroCtrl: TcxDBRadioGroup
            Left = 135
            Top = 0
            CaptionLabel = CaptionTipoFicheroLabel
            Alignment = alCenterCenter
            DataBinding.DataField = 'FormaPago'
            DataBinding.DataSource = DataSource
            Properties.Columns = 2
            Properties.DefaultValue = 0
            Properties.ImmediatePost = True
            Properties.Items = <
              item
                Caption = 'transferencia'
                Value = 0
              end
              item
                Caption = 'cheque'
                Value = 1
              end>
            Style.BorderStyle = ebsNone
            TabOrder = 0
            Transparent = True
            Height = 24
            Width = 217
          end
        end
        object cxTabSheet3: TcxTabSheet
          Caption = 'cxTabSheet3'
          ImageIndex = 2
          ExplicitWidth = 579
          ExplicitHeight = 61
        end
        object cxTabSheet2: TcxTabSheet
          Caption = 'cxTabSheet2'
          ImageIndex = 1
          ExplicitTop = 28
          ExplicitWidth = 189
          ExplicitHeight = 41
          object cxLabel1: TcxLabel
            Left = 5
            Top = 4
            Caption = 'Modalidad'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 1
            Transparent = True
          end
          object ModalidadCtrl: TcxDBRadioGroup
            Left = 135
            Top = 2
            CaptionLabel = cxLabel1
            Alignment = alCenterCenter
            DataBinding.DataField = 'Modalidad'
            DataBinding.DataSource = DataSource
            Properties.Columns = 2
            Properties.DefaultValue = 1
            Properties.ImmediatePost = True
            Properties.Items = <
              item
                Caption = 'est'#225'ndar'
                Value = 1
              end
              item
                Caption = 'pronto pago'
                Value = 2
              end>
            Style.BorderStyle = ebsNone
            TabOrder = 0
            Transparent = True
            Height = 24
            Width = 217
          end
        end
      end
    end
    object cxGroupBox2: TcxGroupBox
      Left = 2
      Top = 217
      Align = alClient
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 2
      ExplicitTop = 241
      ExplicitHeight = 39
      DesignSize = (
        591
        37)
      Height = 37
      Width = 591
      object FormatoCtrl: TcxDBTextEdit
        Left = 149
        Top = 1
        CaptionLabel = Label5
        DescriptionLabel = formatoLabel
        DataBinding.DataField = 'Formato'
        DataBinding.DataSource = DataSource
        Enabled = False
        Properties.OnQueryRequest = FormatoCtrlPropertiesQueryRequest
        Properties.OnEditRequest = FormatoCtrlPropertiesEditRequest
        Properties.OnValidate = FormatoCtrlPropertiesValidate
        TabOrder = 0
        Width = 25
      end
      object formatoLabel: TcxLabel
        Left = 218
        Top = 4
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Enabled = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 1
        Transparent = True
        Height = 19
        Width = 361
      end
      object Label5: TcxLabel
        Left = 10
        Top = 4
        Caption = 'Formato'
        Enabled = False
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 2
        Transparent = True
      end
    end
    object cxGroupBox1: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 85
      Width = 591
      object FechaEmisionCtrl: TcxDBDateEdit
        Left = 149
        Top = 35
        DataBinding.DataField = 'FechaEmision'
        DataBinding.DataSource = DataSource
        Properties.Required = True
        TabOrder = 1
        Width = 100
      end
      object Label4: TcxLabel
        Left = 10
        Top = 11
        Caption = 'N'#186' de remesa'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 3
        Transparent = True
      end
      object Label6: TcxLabel
        Left = 10
        Top = 39
        Caption = 'Fecha de emisi'#243'n'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 4
        Transparent = True
      end
      object NroRemesaCtrl: TcxDBTextEdit
        Left = 149
        Top = 8
        DataBinding.DataField = 'NroRemesa'
        DataBinding.DataSource = DataSource
        Properties.Required = True
        Properties.OnQueryRequest = NroRemesaCtrlPropertiesQueryRequest
        Properties.OnValidate = NroRemesaCtrlPropertiesValidate
        TabOrder = 0
        Width = 52
      end
      object SoporteMagneticoCtrl: TcxDBCheckBox
        Left = 8
        Top = 62
        AutoSize = False
        Caption = 'En soporte &magn'#233'tico'
        DataBinding.DataField = 'SoporteMagnetico'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.NullStyle = nssUnchecked
        Properties.OnChange = SoporteMagneticoCtrlPropertiesChange
        Style.TransparentBorder = False
        TabOrder = 2
        Transparent = True
        Height = 23
        Width = 157
      end
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 261
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    ExplicitTop = 287
    DesignSize = (
      605
      36)
    Height = 36
    Width = 605
    object Panel3: TcxGroupBox
      Left = 219
      Top = 3
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
  object RemesaPagoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'RemesaPago'
    IndexFieldNames = 'Ejercicio;NroRemesa'
    Left = 415
    Top = 44
  end
  object FormManager: TgxFormManager
    Dataset = Data
    FirstDataControl = NroRemesaCtrl
    Model = fmReportForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 416
    Top = 10
  end
  object EfectoPagarTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'EfectoPagar'
    IndexFieldNames = 'EjercicioRemesa;NroRemesa'
    Left = 384
    Top = 44
  end
  object FormaPagoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'FormaPago'
    IndexFieldNames = 'Codigo'
    Left = 354
    Top = 44
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 384
    Top = 10
    object DataNroRemesa: TIntegerField
      FieldName = 'NroRemesa'
      DisplayFormat = '#'
    end
    object DataFechaEmision: TDateField
      FieldName = 'FechaEmision'
    end
    object DataSoporteMagnetico: TBooleanField
      FieldName = 'SoporteMagnetico'
    end
    object DataPath: TWideStringField
      FieldName = 'Path'
      Size = 128
    end
    object DataTipoOrden: TSmallintField
      FieldName = 'TipoOrden'
      OnChange = DataTipoOrdenChange
    end
    object DataFormaPago: TSmallintField
      FieldName = 'FormaPago'
    end
    object DataModalidad: TSmallintField
      FieldName = 'Modalidad'
    end
    object DataConceptoOrden: TSmallintField
      FieldName = 'ConceptoOrden'
    end
    object DataFormato: TSmallintField
      FieldName = 'Formato'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 353
    Top = 10
  end
  object Report: TgxReportManager
    FileName = 'fdp'
    HideReportList = True
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    OnSelectPrinter = ReportSelectPrinter
    OnSetReportName = ReportSetReportName
    BeforeStart = ReportBeforeStart
    Left = 322
    Top = 10
  end
  object EfectoPagarQuery: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    Left = 322
    Top = 44
  end
  object XMLDocument: TXMLDocument
    Options = [doNodeAutoCreate, doNodeAutoIndent, doAttrNull, doAutoPrefix]
    Left = 447
    Top = 44
    DOMVendorDesc = 'MSXML'
  end
end
