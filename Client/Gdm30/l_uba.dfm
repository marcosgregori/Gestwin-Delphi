object RptUbaForm: TRptUbaForm
  Left = 378
  Top = 273
  HelpType = htKeyword
  HelpKeyword = 'l_uba'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Listado de ubicaci'#243'n'
  ClientHeight = 300
  ClientWidth = 599
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = ANSI_CHARSET
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
    ParentBackground = False
    ParentColor = False
    Style.BorderStyle = ebsSingle
    Style.Color = cl3DLight
    TabOrder = 0
    PanelKind = epInputPanel
    ExplicitWidth = 519
    ExplicitHeight = 244
    DesignSize = (
      589
      259)
    Height = 259
    Width = 589
    object gxRangeBox1: TgxRangeBox
      Left = 79
      Top = 14
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object CodigoInicialCtrl: TcxDBTextEdit
      Left = 96
      Top = 6
      DescriptionLabel = Label4
      DataBinding.DataField = 'ArticuloInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.ExpandZeroes = False
      Properties.OnValidate = CodigoCtrlPropertiesValidate
      TabOrder = 0
      Width = 102
    end
    object CodigoFinalCtrl: TcxDBTextEdit
      Left = 96
      Top = 33
      DescriptionLabel = Label7
      DataBinding.DataField = 'ArticuloFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.ExpandZeroes = False
      Properties.TextEditPad = tpRightHighest
      Properties.PadAlways = True
      Properties.OnValidate = CodigoCtrlPropertiesValidate
      TabOrder = 1
      Width = 102
    end
    object Label1: TcxLabel
      Left = 16
      Top = 9
      TabStop = False
      Caption = 'Art'#237'culo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label4: TcxLabel
      Left = 214
      Top = 9
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      ExplicitWidth = 369
      Height = 19
      Width = 370
    end
    object Label7: TcxLabel
      Left = 214
      Top = 36
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      ExplicitWidth = 369
      Height = 19
      Width = 370
    end
    object cxLabel1: TcxLabel
      Left = 8
      Top = 63
      TabStop = False
      Caption = 'Selecci'#243'n por ...'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object PageControl: TcxPageControl
      Left = 8
      Top = 88
      Width = 572
      Height = 126
      Anchors = [akLeft, akTop, akRight]
      Focusable = False
      TabOrder = 2
      Properties.ActivePage = TabSheet1
      Properties.CustomButtons.Buttons = <>
      ExplicitWidth = 522
      ClientRectBottom = 122
      ClientRectLeft = 4
      ClientRectRight = 568
      ClientRectTop = 28
      object TabSheet1: TcxTabSheet
        Caption = 'A&lmacenes'
        ExplicitLeft = 134
        ExplicitTop = 66
        ExplicitWidth = 563
        DesignSize = (
          564
          94)
        object gxRangeBox2: TgxRangeBox
          Left = 67
          Top = 15
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object AlmacenInicialCtrl: TcxDBTextEdit
          Left = 84
          Top = 6
          DescriptionLabel = Label2
          DataBinding.DataField = 'AlmacenInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = AlmacenCtrlPropertiesQueryRequest
          Properties.OnValidate = AlmacenCtrlPropertiesValidate
          TabOrder = 0
          Width = 25
        end
        object AlmacenFinalCtrl: TcxDBTextEdit
          Left = 84
          Top = 33
          DescriptionLabel = Label5
          DataBinding.DataField = 'AlmacenFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = AlmacenCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpRightHighest
          Properties.PadAlways = True
          Properties.OnValidate = AlmacenCtrlPropertiesValidate
          TabOrder = 1
          Width = 25
        end
        object Label3: TcxLabel
          Left = 4
          Top = 9
          TabStop = False
          Caption = 'Almac'#233'n'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label2: TcxLabel
          Left = 202
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
          Width = 340
        end
        object Label5: TcxLabel
          Left = 202
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
          Width = 340
        end
      end
      object TabSheet2: TcxTabSheet
        Caption = 'Almac'#233'n y ubicaciones'
        ExplicitWidth = 514
        ExplicitHeight = 89
        DesignSize = (
          564
          94)
        object gxRangeBox4: TgxRangeBox
          Left = 67
          Top = 42
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object UbicacionInicialCtrl: TcxDBTextEdit
          Left = 84
          Top = 34
          DescriptionLabel = Label9
          DataBinding.DataField = 'UbicacionInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = UbicacionCtrlPropertiesQueryRequest
          Properties.OnValidate = UbicacionCtrlPropertiesValidate
          TabOrder = 1
          Width = 62
        end
        object UbicacionFinalCtrl: TcxDBTextEdit
          Left = 84
          Top = 61
          DescriptionLabel = Label10
          DataBinding.DataField = 'UbicacionFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = UbicacionCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpRightHighest
          Properties.OnValidate = UbicacionCtrlPropertiesValidate
          TabOrder = 2
          Width = 62
        end
        object cxLabel4: TcxLabel
          Left = 4
          Top = 37
          TabStop = False
          Caption = 'Ubicaci'#243'n'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label9: TcxLabel
          Left = 202
          Top = 37
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          ExplicitWidth = 339
          Height = 19
          Width = 340
        end
        object Label10: TcxLabel
          Left = 202
          Top = 64
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          ExplicitWidth = 339
          Height = 19
          Width = 340
        end
        object cxLabel2: TcxLabel
          Left = 4
          Top = 9
          TabStop = False
          Caption = 'Almac'#233'n'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object AlmacenCtrl: TcxDBTextEdit
          Left = 84
          Top = 6
          DescriptionLabel = cxLabel3
          DataBinding.DataField = 'Almacen'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = AlmacenCtrlPropertiesQueryRequest
          Properties.OnValidate = AlmacenCtrlPropertiesValidate
          TabOrder = 0
          Width = 25
        end
        object cxLabel3: TcxLabel
          Left = 202
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
          Width = 340
        end
      end
    end
    object cxLabel5: TcxLabel
      Left = 12
      Top = 226
      TabStop = False
      Caption = 'Existencias'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object ExistenciasCtrl: TcxDBIndexedComboBox
      Left = 96
      Top = 222
      DataBinding.DataField = 'Existencias'
      DataBinding.DataSource = DataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.ImmediatePost = True
      Properties.Items.Strings = (
        'Positivas'
        'Negativas'
        'Todas')
      TabOrder = 3
      Width = 121
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 264
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    ExplicitTop = 249
    ExplicitWidth = 529
    DesignSize = (
      599
      36)
    Height = 36
    Width = 599
    object Panel3: TcxGroupBox
      Left = 213
      Top = 4
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      ExplicitLeft = 212
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
    
    FirstDataControl = CodigoInicialCtrl
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 424
    Top = 12
  end
  object Report: TgxReportManager
    FileName = 'dm30\l_uba'
    HideReportList = False
    SQLItems = <
      item
        Title = 'Stock'
        SQLText = 
          'SELECT *'#13#10'     FROM ( SELECT'#13#10'           CodigoArticulo,'#13#10'      ' +
          '     CodigoClaseA,'#13#10'           CodigoClaseB,'#13#10'           CodigoC' +
          'laseC,'#13#10'           CodigoAlmacen,'#13#10'           Ubicacion,'#13#10'      ' +
          '     LoteFabricacion,'#13#10'           FechaUltEntrada,'#13#10'           F' +
          'echaUltSalida,'#13#10'           ( Apertura_Entradas + Enero_Entradas ' +
          '+ Febrero_Entradas + Marzo_Entradas + Abril_Entradas + Mayo_Entr' +
          'adas + Junio_Entradas + Julio_Entradas + Agosto_Entradas + Septi' +
          'embre_Entradas + Octubre_Entradas + Noviembre_Entradas +Diciembr' +
          'e_Entradas ) AS SumaEntradas,'#13#10'           ( Apertura_Salidas + E' +
          'nero_Salidas + Febrero_Salidas + Marzo_Salidas + Abril_Salidas +' +
          ' Mayo_Salidas + Junio_Salidas + Julio_Salidas + Agosto_Salidas +' +
          ' Septiembre_Salidas + Octubre_Salidas + Noviembre_Salidas + Dici' +
          'embre_Salidas ) AS SumaSalidas'#13#10#13#10'           FROM   Stock'#13#10'     ' +
          '      WHERE  <Seleccion> ) AS Stock'#13#10#13#10'     <SeleccionExistencia' +
          's>'#13#10#13#10'     ORDER BY CodigoArticulo, CodigoClaseA, CodigoClaseB, ' +
          'CodigoClaseC, CodigoAlmacen, Ubicacion'#13#10'       '#13#10
      end>
    ParamsDataset = Data
    ToPrinter = False
    Left = 326
    Top = 12
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 360
    Top = 12
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 393
    Top = 12
    object DataArticuloInicial: TWideStringField
      FieldName = 'ArticuloInicial'
    end
    object DataArticuloFinal: TWideStringField
      FieldName = 'ArticuloFinal'
    end
    object DataAlmacenInicial: TWideStringField
      FieldName = 'AlmacenInicial'
      Size = 2
    end
    object DataAlmacenFinal: TWideStringField
      FieldName = 'AlmacenFinal'
      Size = 2
    end
    object DataAlmacen: TWideStringField
      FieldName = 'Almacen'
      Size = 2
    end
    object DataUbicacionInicial: TWideStringField
      FieldName = 'UbicacionInicial'
      Size = 6
    end
    object DataUbicacionFinal: TWideStringField
      FieldName = 'UbicacionFinal'
      Size = 6
    end
    object DataExistencias: TSmallintField
      FieldName = 'Existencias'
    end
  end
end
