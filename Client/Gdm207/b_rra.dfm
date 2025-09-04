object BoxRraForm: TBoxRraForm
  Left = 619
  Top = 458
  HelpContext = 80515
  BorderStyle = bsDialog
  Caption = 'Modificaci'#243'n del registro de actualizaci'#243'n'
  ClientHeight = 359
  ClientWidth = 465
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  Position = poDefault
  Visible = True
  TextHeight = 17
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 323
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epButtonsPanel
    DesignSize = (
      465
      36)
    Height = 36
    Width = 465
    object Panel3: TcxGroupBox
      Left = 146
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
    Height = 318
    Width = 455
    object cxGroupBox1: TcxGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 165
      Align = alTop
      Caption = 'Informaci'#243'n'
      Style.BorderStyle = ebsNone
      Style.TextStyle = [fsBold]
      TabOrder = 1
      ExplicitTop = 157
      Height = 126
      Width = 445
      object cxLabel1: TcxLabel
        AlignWithMargins = True
        Left = 10
        Top = 22
        Margins.Left = 8
        Margins.Top = 0
        Margins.Bottom = 0
        TabStop = False
        Align = alTop
        Caption = 
          'Indique el proceso y el tipo de registro que desea modificar. La' +
          ' invalidaci'#243'n tan solo marca los registros como no actualizados,' +
          ' de forma que en la pr'#243'xima sincronizaci'#243'n que se realice simple' +
          'mente se actualizar'#225'n. El reinicio elimina los registros, por lo' +
          ' que en la pr'#243'xima sincronizaci'#243'n se suprimir'#225'n y volver'#225'n a cre' +
          'ar los registros en la tienda.'
        Style.TextColor = clInfoText
        Properties.WordWrap = True
        Transparent = True
        Width = 430
      end
    end
    object cxGroupBox2: TcxGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 5
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TextStyle = []
      TabOrder = 0
      Transparent = True
      Height = 154
      Width = 445
      object cxLabel2: TcxLabel
        Left = 11
        Top = 10
        TabStop = False
        Caption = 'Proceso'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object Label2: TcxLabel
        Left = 11
        Top = 40
        TabStop = False
        Caption = 'Tipo de registro'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object ProcesoCtrl: TcxDBRadioGroup
        Left = 113
        Top = 6
        Alignment = alCenterCenter
        DataBinding.DataField = 'Proceso'
        DataBinding.DataSource = DataSource
        Properties.Columns = 2
        Properties.Items = <
          item
            Caption = 'Invalidar'
            Value = 0
          end
          item
            Caption = 'Reiniciar'
            Value = 1
          end>
        Properties.OnEditValueChanged = ProcesoCtrlPropertiesEditValueChanged
        Style.BorderStyle = ebsNone
        Style.TransparentBorder = True
        TabOrder = 0
        Height = 29
        Width = 198
      end
      object TodosCtrl: TcxDBCheckBox
        Left = 122
        Top = 37
        Caption = 'Todos (inclu'#237'dos los globales)'
        DataBinding.DataField = 'Todos'
        DataBinding.DataSource = DataSource
        Properties.FullFocusRect = True
        Properties.NullStyle = nssUnchecked
        Properties.OnChange = TodosCtrlPropertiesChange
        Style.TransparentBorder = True
        TabOrder = 1
        Transparent = True
      end
      object ArticulosCtrl: TcxDBCheckBox
        Left = 122
        Top = 83
        Caption = 'Art'#237'culos'
        DataBinding.DataField = 'Articulos'
        DataBinding.DataSource = DataSource
        Properties.FullFocusRect = True
        Properties.NullStyle = nssUnchecked
        Style.TransparentBorder = True
        TabOrder = 3
        Transparent = True
      end
      object ExistenciasCtrl: TcxDBCheckBox
        Left = 122
        Top = 106
        Caption = 'Existencias'
        DataBinding.DataField = 'Existencias'
        DataBinding.DataSource = DataSource
        Properties.FullFocusRect = True
        Properties.NullStyle = nssUnchecked
        Style.TransparentBorder = True
        TabOrder = 4
        Transparent = True
      end
      object ClientesCtrl: TcxDBCheckBox
        Left = 122
        Top = 131
        Caption = 'Clientes'
        DataBinding.DataField = 'Clientes'
        DataBinding.DataSource = DataSource
        Properties.FullFocusRect = True
        Properties.NullStyle = nssUnchecked
        Style.TransparentBorder = True
        TabOrder = 5
        Transparent = True
      end
      object ClasesCtrl: TcxDBCheckBox
        Left = 122
        Top = 60
        Caption = 'Clases'
        DataBinding.DataField = 'Clases'
        DataBinding.DataSource = DataSource
        Properties.FullFocusRect = True
        Properties.NullStyle = nssUnchecked
        Style.TransparentBorder = True
        TabOrder = 2
        Transparent = True
      end
    end
  end
  object FormManager: TgxFormManager
    Dataset = Data
    FirstDataControl = ProcesoCtrl
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 404
    Top = 8
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 373
    Top = 8
    object DataProceso: TSmallintField
      FieldName = 'Proceso'
    end
    object DataTodos: TBooleanField
      FieldName = 'Todos'
    end
    object DataArticulos: TBooleanField
      FieldName = 'Articulos'
    end
    object DataClientes: TBooleanField
      FieldName = 'Clientes'
    end
    object DataExistencias: TBooleanField
      FieldName = 'Existencias'
    end
    object DataClases: TBooleanField
      FieldName = 'Clases'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 340
    Top = 8
  end
end
