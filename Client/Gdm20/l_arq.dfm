object RptArqForm: TRptArqForm
  Left = 513
  Top = 369
  HelpType = htKeyword
  HelpKeyword = 'l_arq'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Listado de arqueo diario de caja'
  ClientHeight = 165
  ClientWidth = 445
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs20'
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  PixelsPerInch = 96
  TextHeight = 17
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 129
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epButtonsPanel
    DesignSize = (
      445
      36)
    Height = 36
    Width = 445
    object Panel3: TcxGroupBox
      Left = 138
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
    Height = 124
    Width = 435
    object gxRangeBox1: TgxRangeBox
      Left = 79
      Top = 14
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object gxRangeBox2: TgxRangeBox
      Left = 79
      Top = 68
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object SerieInicialCtrl: TcxDBTextEdit
      Left = 94
      Top = 5
      DescriptionLabel = Label1
      DataBinding.DataField = 'SerieInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = SerieCtrlPropertiesQueryRequest
      TabOrder = 0
      Width = 25
    end
    object SerieFinalCtrl: TcxDBTextEdit
      Left = 94
      Top = 32
      DescriptionLabel = Label2
      DataBinding.DataField = 'SerieFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = SerieCtrlPropertiesQueryRequest
      Properties.OnValidate = SerieFinalCtrlPropertiesValidate
      TabOrder = 1
      Width = 25
    end
    object FechaInicialCtrl: TcxDBDateEdit
      Left = 94
      Top = 59
      DataBinding.DataField = 'FechaInicial'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 2
      Width = 100
    end
    object FechaFinalCtrl: TcxDBDateEdit
      Left = 94
      Top = 86
      DataBinding.DataField = 'FechaFinal'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 3
      Width = 100
    end
    object Label19: TcxLabel
      Left = 9
      Top = 8
      TabStop = False
      Caption = 'Serie'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label1: TcxLabel
      Left = 147
      Top = 6
      TabStop = False
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      Height = 20
      Width = 214
      AnchorY = 16
    end
    object Label2: TcxLabel
      Left = 147
      Top = 33
      TabStop = False
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      Height = 20
      Width = 214
      AnchorY = 43
    end
    object Label6: TcxLabel
      Left = 9
      Top = 62
      TabStop = False
      Caption = 'Fecha'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
  object FormManager: TgxFormManager
    Dataset = Data
    Model = fmReportForm
    
    FirstDataControl = SerieInicialCtrl
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 364
    Top = 12
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 333
    Top = 12
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
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 300
    Top = 12
  end
  object report: TgxReportManager
    FileName = 'dm20\l_arq'
    HideReportList = False
    SQLItems = <
      item
        Title = 'Consulta'
        SQLText = 
          'CREATE TABLE <TableName> ('#13#10'CodigoVendedor NVARCHAR(2),'#13#10'NombreV' +
          'endedor NVARCHAR(40),'#13#10'CodigoCliente NVARCHAR(5),'#13#10'NombreCliente' +
          ' VARCHAR(40),'#13#10'Fecha DATE,'#13#10'Serie NVARCHAR(2),'#13#10'NroDocumento INT' +
          'EGER,'#13#10'Importe BCD(16,4),'#13#10'Comision BCD(16,4),'#13#10'Po' +
          'rcentaje BCD(16,4) );'#13#10#13#10'CREATE INDEX Index0 ON <TableNam' +
          'e> ( CodigoVendedor );'#13#10
      end>
    ToPrinter = False
    Left = 269
    Top = 12
  end
end
