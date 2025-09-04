object RptTepForm: TRptTepForm
  Left = 587
  Top = 295
  HelpType = htKeyword
  HelpKeyword = 'l_tep'
  HelpContext = 3111
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Tabla de efectos a pagar'
  ClientHeight = 236
  ClientWidth = 516
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
      506
      195)
    Height = 195
    Width = 506
    object gxRangeBox2: TgxRangeBox
      Left = 93
      Top = 17
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object FechaInicialCtrl: TcxDBDateEdit
      Left = 109
      Top = 7
      DataBinding.DataField = 'FechaInicial'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 0
      Width = 100
    end
    object FechaFinalCtrl: TcxDBDateEdit
      Left = 109
      Top = 34
      DataBinding.DataField = 'FechaFinal'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 1
      Width = 100
    end
    object PageControl: TcxPageControl
      Left = 4
      Top = 83
      Width = 499
      Height = 101
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 2
      Properties.ActivePage = TabSheet1
      Properties.CustomButtons.Buttons = <>
      ExplicitWidth = 491
      ClientRectBottom = 101
      ClientRectRight = 499
      ClientRectTop = 28
      object TabSheet1: TcxTabSheet
        Caption = '&Proveedor o acreedor'
        ExplicitLeft = 4
        ExplicitWidth = 491
        ExplicitHeight = 69
        DesignSize = (
          499
          73)
        object gxRangeBox1: TgxRangeBox
          Left = 85
          Top = 11
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object CodigoProveedorInicialCtrl: TcxDBTextEdit
          Left = 104
          Top = 6
          DescriptionLabel = Label11
          DataBinding.DataField = 'ProveedorInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = SubcuentaCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpRightZero
          Properties.PadAlways = True
          Properties.OnValidate = SubuentaCtrlPropertiesValidate
          TabOrder = 0
          Width = 74
        end
        object CodigoProveedorFinalCtrl: TcxDBTextEdit
          Left = 104
          Top = 33
          DescriptionLabel = Label2
          DataBinding.DataField = 'ProveedorFinal'
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
          Caption = 'C'#243'digo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label11: TcxLabel
          Left = 187
          Top = 9
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          ExplicitWidth = 300
          Height = 19
          Width = 308
        end
        object Label2: TcxLabel
          Left = 187
          Top = 36
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          ExplicitWidth = 300
          Height = 19
          Width = 308
        end
      end
      object TabSheet2: TcxTabSheet
        Caption = 'E&ntidad financiera'
        ExplicitLeft = 4
        ExplicitWidth = 491
        ExplicitHeight = 69
        DesignSize = (
          499
          73)
        object gxRangeBox3: TgxRangeBox
          Left = 85
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
          Caption = 'C'#243'digo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label5: TcxLabel
          Left = 187
          Top = 9
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          ExplicitWidth = 300
          Height = 19
          Width = 308
        end
        object Label7: TcxLabel
          Left = 187
          Top = 36
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          ExplicitWidth = 300
          Height = 19
          Width = 308
        end
      end
    end
    object Label4: TcxLabel
      Left = 9
      Top = 11
      Caption = 'Vencimiento'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 8
      Top = 60
      Caption = 'Agrupar por ...'
      Style.TextColor = clGreen
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 200
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    ExplicitTop = 190
    DesignSize = (
      516
      36)
    Height = 36
    Width = 516
    object Panel3: TcxGroupBox
      Left = 173
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      ExplicitLeft = 162
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
    FirstDataControl = FechaInicialCtrl
    Model = fmReportForm
    
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 420
    Top = 10
  end
  object EfectoPagarTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'EfectoPagar'
    IndexFieldNames = 'FechaVencimiento'
    Left = 420
    Top = 38
  end
  object Report: TgxReportManager
    FileName = 'dm10\l_tep'
    HideReportList = False
    SQLItems = <
      item
        Title = 'Consulta'
        SQLText = 
          'CREATE TABLE <TableName> ('#13#10'Ejercicio SMALLINT,'#13#10'Serie NVARCHAR(' +
          '40),'#13#10'NroFactura INTEGER,'#13#10'NroEfecto SMALLINT,'#13#10'FechaVencimiento' +
          ' DATE,'#13#10'EjercicioAsiento SMALLINT,'#13#10'NroAsiento INTEGER,'#13#10'CodigoP' +
          'roveedor NVARCHAR(9),'#13#10'NombreProveedor NVARCHAR(40),'#13#10'CodigoEnti' +
          'dad NVARCHAR(9),'#13#10'NombreEntidad NVARCHAR(40),'#13#10'Importe1 BCD(16,4)' +
          ','#13#10'Importe2 BCD(16,4),'#13#10'Importe3 BCD(16,4)' +
          ','#13#10'Importe4 BCD(16,4),'#13#10'Importe5 BCD(16,4) );'#13#10#13#10'C' +
          'REATE INDEX Index0 ON <TableName> ( CodigoProveedor, FechaVencim' +
          'iento, Serie, NroFactura );'#13#10'CREATE INDEX Index1 ON <TableName> ' +
          '( CodigoEntidad, FechaVencimiento, Serie, NroFactura );'#13#10
      end>
    ToPrinter = False
    Left = 332
    Top = 10
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 362
    Top = 10
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 391
    Top = 10
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
    object DataProveedorInicial: TWideStringField
      FieldName = 'ProveedorInicial'
      Size = 9
    end
    object DataProveedorFinal: TWideStringField
      FieldName = 'ProveedorFinal'
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
