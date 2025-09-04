object RptEdnForm: TRptEdnForm
  Left = 493
  Top = 244
  HelpType = htKeyword
  HelpKeyword = 'l_edn'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Listado de disponibilidad para fabricaci'#243'n'
  ClientHeight = 160
  ClientWidth = 561
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs40'
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  PixelsPerInch = 96
  TextHeight = 17
  object Panel1: TgxEditPanel
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
      551
      119)
    Height = 119
    Width = 551
    object gxRangeBox2: TgxRangeBox
      Left = 64
      Top = 62
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object ArticuloInicialCtrl: TcxDBTextEdit
      Left = 79
      Top = 56
      DescriptionLabel = Label4
      DataBinding.DataField = 'ArticuloInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = ArticuloCtrlPropertiesQueryRequest
      Properties.OnValidate = ArticuloCtrlPropertiesValidate
      TabOrder = 2
      Width = 120
    end
    object ArticuloFinalCtrl: TcxDBTextEdit
      Left = 79
      Top = 83
      DescriptionLabel = Label7
      DataBinding.DataField = 'ArticuloFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = ArticuloCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpRightHighest
      Properties.PadAlways = True
      Properties.OnValidate = ArticuloCtrlPropertiesValidate
      TabOrder = 3
      Width = 120
    end
    object SeleccionAlmacenCtrl: TcxDBRadioGroup
      Left = 73
      Top = 5
      Alignment = alCenterCenter
      DataBinding.DataField = 'SeleccionAlmacen'
      DataBinding.DataSource = DataSource
      Properties.ImmediatePost = True
      Properties.Items = <
        item
          Caption = 'Todos'
          Value = 0
        end
        item
          Caption = 'Solo el ...'
          Value = 1
        end>
      Properties.OnEditValueChanged = SeleccionAlmacenCtrlPropertiesEditValueChanged
      Style.BorderStyle = ebsNone
      Style.LookAndFeel.NativeStyle = True
      StyleDisabled.LookAndFeel.NativeStyle = True
      TabOrder = 0
      Height = 48
      Width = 117
    end
    object AlmacenCtrl: TcxDBTextEdit
      Left = 171
      Top = 28
      DescriptionLabel = DescAlmacenLabel
      DataBinding.DataField = 'Almacen'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = AlmacenCtrlPropertiesQueryRequest
      Properties.OnValidate = AlmacenCtrlPropertiesValidate
      TabOrder = 1
      Width = 28
    end
    object Label3: TcxLabel
      Left = 8
      Top = 59
      TabStop = False
      Caption = 'Art'#237'culo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label1: TcxLabel
      Left = 10
      Top = 9
      TabStop = False
      Caption = 'Almac'#233'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object DescAlmacenLabel: TcxLabel
      Left = 211
      Top = 29
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      Height = 20
      Width = 334
      AnchorY = 39
    end
    object Label4: TcxLabel
      Left = 211
      Top = 57
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      Height = 20
      Width = 334
      AnchorY = 67
    end
    object Label7: TcxLabel
      Left = 211
      Top = 84
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      Height = 20
      Width = 334
      AnchorY = 94
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 124
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      561
      36)
    Height = 36
    Width = 561
    object Panel3: TcxGroupBox
      Left = 194
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
  object FormManager: TgxFormManager
    Dataset = Data
    Model = fmReportForm
    
    FirstDataControl = SeleccionAlmacenCtrl
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 404
    Top = 10
  end
  object report: TgxReportManager
    FileName = 'dm70\l_edn'
    HideReportList = False
    SQLItems = <
      item
        Title = 'Disponibilidad'
        SQLText = 
          'CREATE TABLE <TableName> ('#13#10'NroRegistro Integer,'#13#10'Nivel SmallInt' +
          ','#13#10'CodigoArticulo NVARCHAR(20),'#13#10'DescripcionArticulo NVARCHAR(60' +
          '),'#13#10'CodigoClaseA NVARCHAR(3),'#13#10'CodigoClaseB NVARCHAR(3),'#13#10'Codigo' +
          'ClaseC NVARCHAR(3),'#13#10'CodigoComponente NVARCHAR(20),'#13#10'Descripcion' +
          'Componente NVARCHAR(60),'#13#10'Existencias BCD(16,4),'#13#10'Cantida' +
          'd BCD(16,4),'#13#10'CantidadMaxima BCD(16,4),'#13#10'PrecioCom' +
          'pra BCD(16,4),'#13#10'PrecioVenta BCD(16,4) );'#13#10#13#10'CREATE' +
          ' INDEX Index1 ON <TableName> ( NroRegistro, Nivel, CodigoArticul' +
          'o, CodigoClaseA, CodigoClaseB, CodigoClaseC );'#13#10
      end>
    ParamsDataset = Data
    ToPrinter = False
    Left = 311
    Top = 10
  end
  object ArticuloTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Articulo'
    IndexFieldNames = 'Codigo'
    Left = 406
    Top = 40
  end
  object RelacionMateriales2Table: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'RelacionMateriales'
    IndexFieldNames = 
      'CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoClaseC;Proceso;Nr' +
      'oLinea'
    Left = 312
    Top = 40
  end
  object RelacionMateriales1Table: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'RelacionMateriales'
    IndexFieldNames = 
      'CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoClaseC;Proceso;Nr' +
      'oLinea'
    Left = 344
    Top = 40
  end
  object RelacionMaterialesTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'RelacionMateriales'
    IndexFieldNames = 
      'CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoClaseC;Proceso;Nr' +
      'oLinea'
    Left = 376
    Top = 40
  end
  object AlmacenTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Almacen'
    IndexFieldNames = 'Codigo'
    Left = 404
    Top = 71
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 373
    Top = 10
    object DataSeleccionAlmacen: TSmallintField
      FieldName = 'SeleccionAlmacen'
    end
    object DataArticuloInicial: TWideStringField
      FieldName = 'ArticuloInicial'
    end
    object DataArticuloFinal: TWideStringField
      FieldName = 'ArticuloFinal'
    end
    object DataAlmacen: TWideStringField
      FieldName = 'Almacen'
      Size = 2
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 342
    Top = 10
  end
end
