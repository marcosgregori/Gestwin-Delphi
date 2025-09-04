object RptDepForm: TRptDepForm
  Left = 448
  Top = 345
  HelpType = htKeyword
  HelpKeyword = 'l_dep'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Listado de datos econ'#243'micos de proveedores'
  ClientHeight = 217
  ClientWidth = 496
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs30'
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
      486
      176)
    Height = 176
    Width = 486
    object gxRangeBox3: TgxRangeBox
      Left = 72
      Top = 118
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object MesInicialCtrl: TcxDBSpinEdit
      Left = 88
      Top = 110
      DescriptionLabel = Label2
      DataBinding.DataField = 'MesInicial'
      DataBinding.DataSource = DataSource
      Properties.ImmediatePost = True
      Properties.MaxValue = 12.000000000000000000
      Properties.MinValue = 1.000000000000000000
      Properties.OnValidate = MesCtrlPropertiesValidate
      TabOrder = 1
      Width = 56
    end
    object MesFinalCtrl: TcxDBSpinEdit
      Left = 88
      Top = 137
      DescriptionLabel = Label5
      DataBinding.DataField = 'MesFinal'
      DataBinding.DataSource = DataSource
      Properties.ImmediatePost = True
      Properties.MaxValue = 12.000000000000000000
      Properties.MinValue = 1.000000000000000000
      Properties.OnValidate = MesCtrlPropertiesValidate
      TabOrder = 2
      Width = 56
    end
    object SeleccionPageControl: TcxPageControl
      Left = 5
      Top = 5
      Width = 479
      Height = 98
      Anchors = [akLeft, akTop, akRight]
      Focusable = False
      TabOrder = 0
      Properties.ActivePage = ProveedorTabSheet
      Properties.CustomButtons.Buttons = <>
      ClientRectBottom = 96
      ClientRectLeft = 2
      ClientRectRight = 477
      ClientRectTop = 35
      object ProveedorTabSheet: TcxTabSheet
        Caption = '&Proveedor'
        ImageIndex = 4
        DesignSize = (
          475
          61)
        object gxRangeBox1: TgxRangeBox
          Left = 64
          Top = 13
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object ProveedorInicialCtrl: TcxDBTextEdit
          Left = 80
          Top = 4
          DescriptionLabel = Label3
          DataBinding.DataField = 'ProveedorInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = ProveedorCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpLeftZero
          Properties.PadAlways = True
          Properties.OnValidate = ProveedorCtrlPropertiesValidate
          TabOrder = 0
          Width = 46
        end
        object ProveedorFinalCtrl: TcxDBTextEdit
          Left = 80
          Top = 31
          DescriptionLabel = Label4
          DataBinding.DataField = 'ProveedorFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = ProveedorCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpLeftHighest
          Properties.PadAlways = True
          Properties.OnValidate = ProveedorCtrlPropertiesValidate
          TabOrder = 1
          Width = 46
        end
        object Label1: TcxLabel
          Left = 6
          Top = 7
          Caption = 'C'#243'digo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label3: TcxLabel
          Left = 150
          Top = 7
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 320
        end
        object Label4: TcxLabel
          Left = 150
          Top = 34
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 320
        end
      end
      object grupoProveedorTabSheet: TcxTabSheet
        Caption = '&Grupo'
        ImageIndex = 2
        DesignSize = (
          475
          61)
        object gxRangeBox2: TgxRangeBox
          Left = 64
          Top = 13
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object GrupoProveedorInicialCtrl: TcxDBTextEdit
          Left = 80
          Top = 4
          DescriptionLabel = Label7
          DataBinding.DataField = 'GrupoProveedorInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = GrupoProveedorCtrlPropertiesQueryRequest
          Properties.OnValidate = GrupoProveedorCtrlPropertiesValidate
          TabOrder = 0
          Width = 32
        end
        object GrupoProveedorFinalCtrl: TcxDBTextEdit
          Left = 80
          Top = 31
          DescriptionLabel = Label8
          DataBinding.DataField = 'GrupoProveedorFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = GrupoProveedorCtrlPropertiesQueryRequest
          Properties.OnValidate = GrupoProveedorCtrlPropertiesValidate
          TabOrder = 1
          Width = 32
        end
        object Label9: TcxLabel
          Left = 6
          Top = 7
          Caption = 'C'#243'digo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label7: TcxLabel
          Left = 150
          Top = 7
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 320
        end
        object Label8: TcxLabel
          Left = 150
          Top = 34
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 320
        end
      end
    end
    object Label6: TcxLabel
      Left = 15
      Top = 115
      Caption = 'Mes'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 159
      Top = 114
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 278
    end
    object Label5: TcxLabel
      Left = 159
      Top = 140
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 278
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 181
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      496
      36)
    Height = 36
    Width = 496
    object Panel3: TcxGroupBox
      Left = 162
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
    FirstDataControl = ProveedorInicialCtrl
    Model = fmReportForm
    
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 436
    Top = 122
  end
  object Report: TgxReportManager
    FileName = 'dm30\l_dep'
    HideReportList = False
    SQLItems = <
      item
        Title = 'Consumos'
        SQLText = 
          'SELECT '#13#10'ProveedorDatEcon.*,'#13#10'Proveedor.Codigo,                 ' +
          '                   '#13#10'Proveedor.Factura_CodigoGrupo,'#13#10'GrupoProvee' +
          'dor.Descripcion AS GrupoProveedor_Descripcion, '#13#10'Proveedor.Nombr' +
          'e AS Proveedor_Nombre, '#13#10'CAST( 0.0 AS BCD(16,4) ) as TotalImport' +
          'eDescuentos, '#13#10'CAST( 0.0 AS BCD(16,4) ) as TotalImporteCompras, ' +
          #13#10'CAST( 0.0 AS BCD(16,4) ) as DescuentosSobreCompras'#13#10'          ' +
          '          '#13#10'FROM '#13#10'ProveedorDatEcon '#13#10'LEFT JOIN Proveedor ON ( P' +
          'roveedorDatEcon.Codigo=Proveedor.Codigo ) '#13#10'LEFT JOIN GrupoProve' +
          'edor ON ( Proveedor.Factura_CodigoGrupo=GrupoProveedor.Codigo ) ' +
          #13#10'     '#13#10'WHERE '#13#10'Ejercicio=<EjercicioActual> AND'#13#10#13#10'        '#13#10
      end>
    ToPrinter = False
    Left = 406
    Top = 122
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 373
    Top = 122
    object DataProveedorInicial: TWideStringField
      FieldName = 'ProveedorInicial'
      Size = 5
    end
    object DataProveedorFinal: TWideStringField
      FieldName = 'ProveedorFinal'
      Size = 5
    end
    object DataGrupoProveedorInicial: TWideStringField
      FieldName = 'GrupoProveedorInicial'
      Size = 3
    end
    object DataGrupoProveedorFinal: TWideStringField
      FieldName = 'GrupoProveedorFinal'
      Size = 3
    end
    object DataMesInicial: TSmallintField
      FieldName = 'MesInicial'
    end
    object DataMesFinal: TSmallintField
      FieldName = 'MesFinal'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 340
    Top = 122
  end
end
