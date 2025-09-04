object BoxGmrForm: TBoxGmrForm
  Left = 522
  Top = 284
  HelpType = htKeyword
  HelpKeyword = 'b_gmr'
  HelpContext = 8157
  BorderStyle = bsDialog
  Caption = 'Generaci'#243'n de movimientos de reubicaci'#243'n'
  ClientHeight = 275
  ClientWidth = 486
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
    ExplicitHeight = 211
    Height = 234
    Width = 476
    object RangoFechasPanel: TcxGroupBox
      Left = 4
      Top = 4
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 60
      Width = 468
      object gxRangeBox1: TgxRangeBox
        Left = 102
        Top = 15
        Width = 13
        Height = 37
        ParentShowHint = False
        ShowHint = True
      end
      object FechaInicialCtrl: TcxDBDateEdit
        Left = 116
        Top = 7
        DataBinding.DataField = 'FechaInicial'
        DataBinding.DataSource = DataSource
        TabOrder = 0
        Width = 100
      end
      object FechaFinalCtrl: TcxDBDateEdit
        Left = 116
        Top = 34
        DataBinding.DataField = 'FechaFinal'
        DataBinding.DataSource = DataSource
        TabOrder = 1
        Width = 100
      end
      object Label3: TcxLabel
        Left = 11
        Top = 10
        TabStop = False
        Caption = 'Fecha'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
    end
    object MainPanel: TcxGroupBox
      Left = 4
      Top = 64
      Align = alClient
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 1
      ExplicitHeight = 143
      DesignSize = (
        468
        166)
      Height = 166
      Width = 468
      object cxGroupBox1: TcxGroupBox
        AlignWithMargins = True
        Left = 2
        Top = 61
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Informaci'#243'n'
        Style.BorderStyle = ebsNone
        Style.TextStyle = [fsBold]
        TabOrder = 2
        Height = 90
        Width = 449
        object cxLabel1: TcxLabel
          AlignWithMargins = True
          Left = 7
          Top = 23
          Margins.Bottom = 0
          TabStop = False
          Align = alClient
          Caption = 
            'Este proceso crea movimientos  de reubicaci'#243'n de material a part' +
            'ir de las hojas de carga.'
          Style.TextColor = clInfoText
          Properties.WordWrap = True
          Transparent = True
          ExplicitHeight = 33
          Width = 435
        end
      end
      object Label1: TcxLabel
        Left = 11
        Top = 4
        TabStop = False
        Caption = 'Almac'#233'n'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object CodigoAlmacenCtrl: TcxDBTextEdit
        Left = 116
        Top = 1
        CaptionLabel = Label1
        DescriptionLabel = DescAlmacenLabel
        DataBinding.DataField = 'CodigoAlmacen'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = CodigoAlmacenCtrlPropertiesQueryRequest
        Properties.OnEditRequest = CodigoAlmacenCtrlPropertiesEditRequest
        Properties.OnValidate = CodigoAlmacenCtrlPropertiesValidate
        TabOrder = 0
        Width = 25
      end
      object DescAlmacenLabel: TcxLabel
        Left = 218
        Top = 4
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
        Height = 19
        Width = 248
      end
      object Label10: TcxLabel
        Left = 11
        Top = 31
        TabStop = False
        Caption = 'Ubicaci'#243'n'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object UbicacionCtrl: TcxDBTextEdit
        Left = 116
        Top = 28
        CaptionLabel = Label10
        DescriptionLabel = Label11
        DataBinding.DataField = 'Ubicacion'
        DataBinding.DataSource = DataSource
        Properties.Required = True
        Properties.OnQueryRequest = UbicacionCtrlPropertiesQueryRequest
        Properties.OnEditRequest = UbicacionCtrlPropertiesEditRequest
        Properties.OnValidate = UbicacionCtrlPropertiesValidate
        TabOrder = 1
        Width = 53
      end
      object Label11: TcxLabel
        Left = 218
        Top = 31
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
        Height = 19
        Width = 248
      end
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 239
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    ExplicitTop = 216
    DesignSize = (
      486
      36)
    Height = 36
    Width = 486
    object Panel3: TcxGroupBox
      Left = 155
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
    
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 380
    Top = 13
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 350
    Top = 13
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
    object DataCodigoAlmacen: TWideStringField
      FieldName = 'CodigoAlmacen'
      Size = 2
    end
    object DataUbicacion: TWideStringField
      FieldName = 'Ubicacion'
      Size = 6
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 317
    Top = 13
  end
end
