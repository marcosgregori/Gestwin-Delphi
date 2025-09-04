object RptTecForm: TRptTecForm
  Left = 587
  Top = 295
  HelpType = htKeyword
  HelpKeyword = 'l_tec'
  HelpContext = 3111
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Tabla de efectos a cobrar'
  ClientHeight = 295
  ClientWidth = 556
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs10'
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  PixelsPerInch = 96
  TextHeight = 17
  object dataPanel: TgxEditPanel
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
    DesignSize = (
      546
      254)
    Height = 254
    Width = 546
    object gxRangeBox1: TgxRangeBox
      Left = 93
      Top = 16
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object gxRangeBox2: TgxRangeBox
      Left = 93
      Top = 72
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object SerieInicialCtrl: TcxDBTextEdit
      Left = 109
      Top = 8
      DescriptionLabel = cxLabel1
      DataBinding.DataField = 'SerieInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = SeriePropertiesQueryRequest
      Properties.OnValidate = SeriePropertiesValidate
      TabOrder = 0
      Width = 25
    end
    object SerieFinalCtrl: TcxDBTextEdit
      Left = 109
      Top = 35
      DescriptionLabel = cxLabel2
      DataBinding.DataField = 'SerieFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = SeriePropertiesQueryRequest
      Properties.OnValidate = SeriePropertiesValidate
      TabOrder = 1
      Width = 25
    end
    object FechaInicialCtrl: TcxDBDateEdit
      Left = 109
      Top = 62
      DataBinding.DataField = 'FechaInicial'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 2
      Width = 100
    end
    object FechaFinalCtrl: TcxDBDateEdit
      Left = 109
      Top = 89
      DataBinding.DataField = 'FechaFinal'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 3
      Width = 100
    end
    object PageControl: TcxPageControl
      Left = 3
      Top = 140
      Width = 536
      Height = 100
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 4
      Properties.ActivePage = TabSheet1
      Properties.CustomButtons.Buttons = <>
      ClientRectBottom = 96
      ClientRectLeft = 4
      ClientRectRight = 532
      ClientRectTop = 28
      object TabSheet1: TcxTabSheet
        Caption = 'C&liente o deudor'
        DesignSize = (
          528
          68)
        object gxRangeBox3: TgxRangeBox
          Left = 89
          Top = 11
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object CodigoClienteInicialCtrl: TcxDBTextEdit
          Left = 104
          Top = 6
          DescriptionLabel = Label11
          DataBinding.DataField = 'ClienteInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = SubcuentaCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpRightZero
          Properties.PadAlways = True
          Properties.OnValidate = SubuentaCtrlPropertiesValidate
          TabOrder = 0
          Width = 74
        end
        object CodigoClienteFinalCtrl: TcxDBTextEdit
          Left = 104
          Top = 33
          DescriptionLabel = Label2
          DataBinding.DataField = 'ClienteFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = SubcuentaCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpRightHighest
          Properties.PadAlways = True
          Properties.OnValidate = SubuentaCtrlPropertiesValidate
          TabOrder = 1
          Width = 74
        end
        object Label1: TcxLabel
          Left = 6
          Top = 9
          TabStop = False
          Caption = 'C'#243'digo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label11: TcxLabel
          Left = 189
          Top = 9
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 338
        end
        object Label2: TcxLabel
          Left = 189
          Top = 36
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 338
        end
      end
      object TabSheet2: TcxTabSheet
        Caption = 'E&ntidad financiera'
        ExplicitLeft = 0
        ExplicitWidth = 536
        ExplicitHeight = 72
        DesignSize = (
          528
          68)
        object gxRangeBox4: TgxRangeBox
          Left = 89
          Top = 11
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object CodigoEntidadInicialCtrl: TcxDBTextEdit
          Left = 104
          Top = 6
          DescriptionLabel = Label5
          DataBinding.DataField = 'EntidadInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = SubcuentaCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpRightZero
          Properties.PadAlways = True
          Properties.OnValidate = SubuentaCtrlPropertiesValidate
          TabOrder = 0
          Width = 74
        end
        object CodigoEntidadFinalCtrl: TcxDBTextEdit
          Left = 104
          Top = 33
          DescriptionLabel = Label7
          DataBinding.DataField = 'EntidadFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = SubcuentaCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpRightHighest
          Properties.PadAlways = True
          Properties.OnValidate = SubuentaCtrlPropertiesValidate
          TabOrder = 1
          Width = 74
        end
        object Label8: TcxLabel
          Left = 6
          Top = 9
          TabStop = False
          Caption = 'C'#243'digo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label5: TcxLabel
          Left = 193
          Top = 9
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          ExplicitWidth = 339
          Height = 19
          Width = 331
        end
        object Label7: TcxLabel
          Left = 193
          Top = 36
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          ExplicitWidth = 339
          Height = 19
          Width = 331
        end
      end
    end
    object Label6: TcxLabel
      Left = 9
      Top = 12
      TabStop = False
      Caption = 'Serie'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label4: TcxLabel
      Left = 9
      Top = 66
      TabStop = False
      Caption = 'Vencimiento'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 8
      Top = 118
      TabStop = False
      Caption = 'Agrupar por ...'
      ParentFont = False
      Style.Font.Charset = ANSI_CHARSET
      Style.Font.Color = clGreen
      Style.Font.Height = -13
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.TransparentBorder = False
      Style.IsFontAssigned = True
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object cxLabel1: TcxLabel
      Left = 196
      Top = 10
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      Height = 20
      Width = 260
      AnchorY = 20
    end
    object cxLabel2: TcxLabel
      Left = 196
      Top = 36
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      Height = 20
      Width = 260
      AnchorY = 46
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 259
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      556
      36)
    Height = 36
    Width = 556
    object Panel3: TcxGroupBox
      Left = 193
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
  object FormManager: TgxFormManager
    Dataset = Data
    FirstDataControl = SerieInicialCtrl
    Model = fmReportForm
    
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 388
    Top = 8
  end
  object EfectoCobrarTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'EfectoCobrar'
    IndexFieldNames = 'FechaVencimiento'
    Left = 388
    Top = 36
  end
  object Report: TgxReportManager
    FileName = 'dm10\l_tec'
    HideReportList = False
    SQLItems = <
      item
        Title = 'Consulta'
        SQLText = 
          'CREATE TABLE <TableName> ('#13#10'Ejercicio SMALLINT,'#13#10'Serie NVARCHAR(' +
          '2),'#13#10'NroFactura INTEGER,'#13#10'NroEfecto SMALLINT,'#13#10'FechaVencimiento ' +
          'DATE,'#13#10'EjercicioAsiento SMALLINT,'#13#10'NroAsiento INTEGER,'#13#10'CodigoCl' +
          'iente NVARCHAR(9),'#13#10'NombreCliente NVARCHAR(40),'#13#10'CodigoEntidad N' +
          'VARCHAR(9),'#13#10'NombreEntidad NVARCHAR(40),'#13#10'Importe1 BCD(16,4),'#13#10'I' +
          'mporte2 BCD(16,4),'#13#10'Importe3 BCD(16,4),'#13#10'Importe4 BCD(16,4),'#13#10'Im' +
          'porte5 BCD(16,4) );'#13#10#13#10'CREATE INDEX Index0 ON <TableName> ( Codi' +
          'goCliente, FechaVencimiento, Serie, NroFactura );'#13#10'CREATE INDEX ' +
          'Index1 ON <TableName> ( CodigoEntidad, FechaVencimiento, Serie, ' +
          'NroFactura );'#13#10
      end>
    ToPrinter = False
    Left = 292
    Top = 8
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 326
    Top = 8
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 359
    Top = 8
    object DataSerieInicial: TWideStringField
      FieldName = 'SerieInicial'
      Size = 2
    end
    object DataSerieFinal: TWideStringField
      FieldName = 'SerieFinal'
      Size = 2
    end
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
    object DataClienteInicial: TWideStringField
      FieldName = 'ClienteInicial'
      Size = 9
    end
    object DataClienteFinal: TWideStringField
      FieldName = 'ClienteFinal'
      Size = 9
    end
    object DataEntidadInicial: TWideStringField
      FieldName = 'EntidadInicial'
      Size = 9
    end
    object DataEntidadFinal: TWideStringField
      FieldName = 'EntidadFinal'
      Size = 9
    end
  end
end
