object BoxIarForm: TBoxIarForm
  Left = 472
  Top = 304
  HelpType = htKeyword
  HelpKeyword = 'b_iar'
  BorderStyle = bsDialog
  Caption = 'Actualizaci'#243'n de datos de art'#237'culos desde ficheros externos'
  ClientHeight = 443
  ClientWidth = 771
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs30'
  Position = poDefault
  Visible = True
  TextHeight = 17
  object Panel2: TgxEditPanel
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
    Height = 402
    Width = 761
    object ProcesoPC: TcxPageControl
      Left = 2
      Top = 2
      Width = 757
      Height = 398
      Align = alClient
      TabOrder = 0
      Properties.ActivePage = cxTabSheet1
      Properties.CustomButtons.Buttons = <>
      ClientRectBottom = 394
      ClientRectLeft = 4
      ClientRectRight = 753
      ClientRectTop = 28
      object cxTabSheet1: TcxTabSheet
        Caption = 'Plantilla'
        ImageIndex = 0
        object cxGroupBox1: TcxGroupBox
          AlignWithMargins = True
          Left = 3
          Top = 220
          Align = alTop
          Caption = 'Informaci'#243'n'
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.TextStyle = [fsBold]
          TabOrder = 1
          Height = 84
          Width = 743
          object cxLabel1: TcxLabel
            AlignWithMargins = True
            Left = 10
            Top = 20
            Margins.Left = 8
            Margins.Top = 18
            Margins.Bottom = 0
            TabStop = False
            Align = alTop
            Caption = 
              'Este proceso actualiza los datos de su fichero de art'#237'culos con ' +
              'la informaci'#243'n obtenida de un fichero de texto externo. Los dato' +
              's a importar se definen mediante la opci'#243'n '#39'Estructuras de fiche' +
              'ros externos'#39'.'
            Style.TextColor = clInfoText
            Properties.WordWrap = True
            TabOrder = 0
            Transparent = True
            Width = 728
          end
        end
        object cxGroupBox3: TcxGroupBox
          Left = 0
          Top = 0
          Align = alTop
          Alignment = alCenterCenter
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 0
          DesignSize = (
            749
            217)
          Height = 217
          Width = 749
          object Shape1: TShape
            Left = 7
            Top = 120
            Width = 734
            Height = 1
            Anchors = [akLeft, akTop, akRight]
            Pen.Color = clBtnShadow
            ExplicitWidth = 605
          end
          object ClaveCtrl: TcxDBIndexedComboBox
            Left = 176
            Top = 130
            DataBinding.DataField = 'Clave'
            DataBinding.DataSource = DataSource
            Properties.Alignment.Horz = taLeftJustify
            Properties.DropDownListStyle = lsFixedList
            Properties.Items.Strings = (
              'C'#243'digo del art'#237'culo'
              'C'#243'digo de barras')
            TabOrder = 0
            Width = 163
          end
          object CrearRegistrosCtrl: TcxDBCheckBox
            Left = 3
            Top = 161
            AutoSize = False
            Caption = 'Crear registros inexistentes'
            DataBinding.DataField = 'Insertar'
            DataBinding.DataSource = DataSource
            Properties.Alignment = taRightJustify
            Properties.NullStyle = nssUnchecked
            TabOrder = 1
            Transparent = True
            Height = 25
            Width = 189
          end
          object cxLabel13: TcxLabel
            Left = 10
            Top = 39
            TabStop = False
            Caption = 'Path (directorio)'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 2
            Transparent = True
          end
          object cxLabel3: TcxLabel
            AlignWithMargins = True
            Left = 177
            Top = 62
            Margins.Left = 8
            Margins.Top = 18
            Margins.Bottom = 0
            TabStop = False
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Caption = 
              'Si no se indica un fichero se utilizar'#225' el de la ficha de la pla' +
              'ntilla.'
            Style.TextColor = clGrayText
            Properties.WordWrap = True
            TabOrder = 3
            Transparent = True
            Height = 39
            Width = 457
          end
          object cxLabel5: TcxLabel
            Left = 7
            Top = 97
            TabStop = False
            Caption = 'Opciones'
            Style.TextColor = clGreen
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 4
            Transparent = True
          end
          object DescPlantillaLabel: TcxLabel
            Left = 252
            Top = 12
            TabStop = False
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 5
            Transparent = True
            Height = 19
            Width = 489
          end
          object ExaminarPathDatosBtn: TgBitBtn
            Left = 640
            Top = 35
            Width = 103
            Height = 27
            Anchors = [akTop, akRight]
            Caption = 'E&xaminar ...'
            Enabled = True
            OptionsImage.ImageIndex = 21
            OptionsImage.Images = ApplicationContainer.ButtonImageList
            OptionsImage.Margin = 4
            OptionsImage.Spacing = 5
            TabOrder = 6
            TabStop = False
            OnClick = ExaminarPathDatosBtnClick
            GlyphBitmap = gmFolder
          end
          object IVAIncluidoCtrl: TcxDBCheckBox
            Left = 3
            Top = 186
            AutoSize = False
            Caption = 'Precios con I.V.A. incluido'
            DataBinding.DataField = 'IVAIncluido'
            DataBinding.DataSource = DataSource
            Properties.Alignment = taRightJustify
            Properties.NullStyle = nssUnchecked
            TabOrder = 7
            Transparent = True
            Height = 25
            Width = 189
          end
          object Label1: TcxLabel
            Left = 8
            Top = 134
            TabStop = False
            Caption = 'Clave de referencia'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 8
            Transparent = True
          end
          object Label2: TcxLabel
            Left = 10
            Top = 12
            TabStop = False
            Caption = 'N'#186'  de plantilla'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 9
            Transparent = True
          end
          object NroPlantillaCtrl: TcxDBSpinEdit
            Left = 177
            Top = 9
            DescriptionLabel = DescPlantillaLabel
            DataBinding.DataField = 'NroPlantilla'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = NroPlantillaCtrlPropertiesQueryRequest
            Properties.OnEditRequest = NroPlantillaCtrlPropertiesEditRequest
            Properties.DisplayFormat = '#'
            Properties.EditFormat = '#'
            Properties.ExceptionOnInvalidInput = True
            Properties.MaxValue = 99.000000000000000000
            Properties.MinValue = 1.000000000000000000
            Properties.OnValidate = NroPlantillaCtrlPropertiesValidate
            TabOrder = 10
            Width = 56
          end
          object PathDatosCtrl: TcxDBTextEdit
            Left = 177
            Top = 36
            Anchors = [akLeft, akTop, akRight]
            DataBinding.DataField = 'PathDatos'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = PathDatosCtrlPropertiesQueryRequest
            Properties.OnValidate = PathDatosCtrlPropertiesValidate
            TabOrder = 11
            Width = 457
          end
        end
      end
      object cxTabSheet2: TcxTabSheet
        Caption = 'Im'#225'genes'
        ImageIndex = 1
        object cxGroupBox2: TcxGroupBox
          AlignWithMargins = True
          Left = 3
          Top = 48
          Align = alTop
          Caption = 'Informaci'#243'n'
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.TextStyle = [fsBold]
          TabOrder = 1
          Height = 70
          Width = 743
          object cxLabel2: TcxLabel
            AlignWithMargins = True
            Left = 10
            Top = 20
            Margins.Left = 8
            Margins.Top = 18
            Margins.Bottom = 0
            TabStop = False
            Align = alTop
            Caption = 
              'Este proceso realiza la importaci'#243'n de im'#225'genes situadas en fich' +
              'eros externos en  los art'#237'culos. Se utiliza el nombre del ficher' +
              'o para determinar el art'#237'culo destino a partir de su c'#243'digo.'
            Style.TextColor = clInfoText
            Properties.WordWrap = True
            TabOrder = 0
            Transparent = True
            Width = 728
          end
        end
        object cxGroupBox4: TcxGroupBox
          Left = 0
          Top = 0
          Align = alTop
          Alignment = alCenterCenter
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 0
          DesignSize = (
            749
            45)
          Height = 45
          Width = 749
          object ExaminarButton: TgBitBtn
            Left = 641
            Top = 8
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
            TabStop = False
            OnClick = ExaminarButtonClick
            GlyphBitmap = gmFolder
          end
          object Label3: TcxLabel
            Left = 9
            Top = 13
            TabStop = False
            Caption = 'Path (directorio)'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 1
            Transparent = True
          end
          object PathCtrl: TcxDBTextEdit
            Left = 108
            Top = 9
            Anchors = [akLeft, akTop, akRight]
            DataBinding.DataField = 'PathImagenes'
            DataBinding.DataSource = DataSource
            Properties.Required = True
            Properties.OnQueryRequest = PathCtrlPropertiesQueryRequest
            Properties.OnValidate = PathCtrlPropertiesValidate
            TabOrder = 2
            Width = 522
          end
        end
      end
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 407
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      771
      36)
    Height = 36
    Width = 771
    object Panel3: TcxGroupBox
      Left = 301
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
    FirstDataControl = NroPlantillaCtrl
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 456
    Top = 166
  end
  object ArticuloTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Articulo'
    IndexFieldNames = 'Codigo'
    Left = 522
    Top = 166
  end
  object CodigoBarrasTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'CodigoBarras'
    IndexFieldNames = 'CodigoBarras'
    Left = 489
    Top = 166
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 423
    Top = 166
    object DataPathDatos: TStringField
      FieldName = 'PathDatos'
      Size = 256
    end
    object DataNroPlantilla: TSmallintField
      FieldName = 'NroPlantilla'
    end
    object DataClave: TSmallintField
      FieldName = 'Clave'
    end
    object DataIVAIncluido: TBooleanField
      FieldName = 'IVAIncluido'
    end
    object DataPathImagenes: TStringField
      FieldName = 'PathImagenes'
      Size = 256
    end
    object DataInsertar: TBooleanField
      FieldName = 'Insertar'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 390
    Top = 166
  end
  object OpenDialog: TdxOpenFileDialog
    Title = 'Selecci'#243'n del fichero a importar'
    Left = 424
    Top = 134
  end
end
