object BoxTdjForm: TBoxTdjForm
  Left = 436
  Top = 288
  HelpType = htKeyword
  HelpKeyword = 'b_tdj'
  BorderStyle = bsDialog
  Caption = 'Tipos de jornada'
  ClientHeight = 238
  ClientWidth = 506
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs70'
  Position = poDefault
  Visible = True
  PixelsPerInch = 96
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
    Height = 197
    Width = 496
    object PeriodosGroupBox: TcxGroupBox
      Left = 145
      Top = 2
      Align = alClient
      Caption = '  Turnos de actividad'
      PanelStyle.Active = True
      Style.BorderColor = clScrollBar
      Style.BorderStyle = ebsSingle
      Style.Shadow = False
      Style.TextStyle = [fsBold]
      Style.TransparentBorder = True
      TabOrder = 1
      Height = 193
      Width = 349
      object TurnoActividad1Ctrl: TcxDBSpinEdit
        Left = 10
        Top = 25
        DescriptionLabel = DescTurnoActividad1
        BeepOnEnter = False
        DataBinding.DataField = 'Turno1'
        DataBinding.DataSource = TurnosDataSource
        Properties.OnQueryRequest = TurnoActividadCtrlPropertiesQueryRequest
        Properties.OnEditRequest = TurnoActividadCtrlPropertiesEditRequest
        Properties.AssignedValues.MinValue = True
        Properties.DisplayFormat = '#'
        Properties.EditFormat = '#'
        Properties.MaxValue = 99.000000000000000000
        Properties.OnValidate = TurnoActividad1CtrlPropertiesValidate
        TabOrder = 0
        Width = 56
      end
      object DescTurnoActividad1: TcxLabel
        Left = 93
        Top = 28
        TabStop = False
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
        Height = 19
        Width = 223
      end
      object TurnoActividad2Ctrl: TcxDBSpinEdit
        Left = 10
        Top = 52
        DescriptionLabel = DescTurnoActividad2Label
        DataBinding.DataField = 'Turno2'
        DataBinding.DataSource = TurnosDataSource
        Properties.OnQueryRequest = TurnoActividadCtrlPropertiesQueryRequest
        Properties.OnEditRequest = TurnoActividadCtrlPropertiesEditRequest
        Properties.AssignedValues.MinValue = True
        Properties.DisplayFormat = '#'
        Properties.EditFormat = '#'
        Properties.MaxValue = 99.000000000000000000
        Properties.OnValidate = TurnoActividad1CtrlPropertiesValidate
        TabOrder = 2
        Width = 56
      end
      object DescTurnoActividad2Label: TcxLabel
        Left = 93
        Top = 55
        TabStop = False
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
        Height = 19
        Width = 223
      end
      object TurnoActividad3Ctrl: TcxDBSpinEdit
        Left = 10
        Top = 79
        DescriptionLabel = DescTurnoActividad3Label
        DataBinding.DataField = 'Turno3'
        DataBinding.DataSource = TurnosDataSource
        Properties.OnQueryRequest = TurnoActividadCtrlPropertiesQueryRequest
        Properties.OnEditRequest = TurnoActividadCtrlPropertiesEditRequest
        Properties.AssignedValues.MinValue = True
        Properties.DisplayFormat = '#'
        Properties.EditFormat = '#'
        Properties.MaxValue = 99.000000000000000000
        Properties.OnValidate = TurnoActividad1CtrlPropertiesValidate
        TabOrder = 4
        Width = 56
      end
      object DescTurnoActividad3Label: TcxLabel
        Left = 93
        Top = 82
        TabStop = False
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
        Height = 19
        Width = 223
      end
      object TurnoActividad4Ctrl: TcxDBSpinEdit
        Left = 10
        Top = 106
        DescriptionLabel = DescTurnoActividad4Label
        DataBinding.DataField = 'Turno4'
        DataBinding.DataSource = TurnosDataSource
        Properties.OnQueryRequest = TurnoActividadCtrlPropertiesQueryRequest
        Properties.OnEditRequest = TurnoActividadCtrlPropertiesEditRequest
        Properties.AssignedValues.MinValue = True
        Properties.DisplayFormat = '#'
        Properties.EditFormat = '#'
        Properties.MaxValue = 99.000000000000000000
        Properties.OnValidate = TurnoActividad1CtrlPropertiesValidate
        TabOrder = 6
        Width = 56
      end
      object DescTurnoActividad4Label: TcxLabel
        Left = 93
        Top = 109
        TabStop = False
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
        Height = 19
        Width = 223
      end
      object cxLabel8: TcxLabel
        Left = 10
        Top = 135
        TabStop = False
        Caption = 'Tiempo externo'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object TiempoExternoCtrl: TcxDBDurationEdit
        Left = 10
        Top = 156
        DataBinding.DataField = 'TiempoExterno'
        DataBinding.DataSource = TurnosDataSource
        TabOrder = 9
        Width = 87
      end
    end
    object cxGroupBox1: TcxGroupBox
      Left = 2
      Top = 2
      Align = alLeft
      Caption = 'Jornada'
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.Edges = [bLeft, bTop, bRight, bBottom]
      Style.TextStyle = [fsBold]
      TabOrder = 0
      Transparent = True
      Height = 193
      Width = 143
      object TipoJornadaCtrl: TcxDBRadioGroup
        Left = 1
        Top = 22
        Alignment = alCenterCenter
        DataBinding.DataField = 'TipoJornada'
        DataBinding.DataSource = DataSource
        Properties.DefaultValue = 1
        Properties.ImmediatePost = True
        Properties.Items = <
          item
            Caption = 'Configurable'
            Value = 0
          end
          item
            Caption = 'Completa'
            Value = 1
          end
          item
            Caption = 'Media jornada'
            Value = 2
          end
          item
            Caption = 'Jornada intensiva'
            Value = 3
          end
          item
            Caption = 'Festivo'
            Value = 4
          end>
        Properties.OnEditValueChanged = TipoJornadaCtrlPropertiesEditValueChanged
        Style.BorderStyle = ebsNone
        TabOrder = 0
        Height = 122
        Width = 137
      end
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 202
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      506
      36)
    Height = 36
    Width = 506
    object Panel3: TcxGroupBox
      Left = 167
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
    Dataset = MemData
    FirstDataControl = TipoJornadaCtrl
    
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 430
    Top = 12
  end
  object MemData: TgxMemData
    Indexes = <
      item
        FieldName = 'TipoJornada'
        SortOptions = []
      end>
    SortOptions = []
    Left = 431
    Top = 44
    object MemDataTipoJornada: TSmallintField
      FieldName = 'TipoJornada'
    end
  end
  object DataSource: TDataSource
    DataSet = MemData
    Left = 398
    Top = 44
  end
  object CalendarioTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Calendario'
    IndexFieldNames = 'Fecha'
    Left = 431
    Top = 106
  end
  object CalendarioDataSource: TDataSource
    DataSet = CalendarioTable
    Left = 399
    Top = 106
  end
  object TurnosMemData: TgxMemData
    Indexes = <
      item
        FieldName = 'TipoJornada'
        SortOptions = []
      end>
    SortOptions = []
    Left = 431
    Top = 76
    object TurnosMemDataFecha: TDateField
      FieldName = 'Fecha'
    end
    object TurnosMemDataTipoJornada: TSmallintField
      FieldName = 'TipoJornada'
    end
    object TurnosMemDataTurno1: TSmallintField
      FieldName = 'Turno1'
    end
    object TurnosMemDataTurno2: TSmallintField
      FieldName = 'Turno2'
    end
    object TurnosMemDataTurno3: TSmallintField
      FieldName = 'Turno3'
    end
    object TurnosMemDataTurno4: TSmallintField
      FieldName = 'Turno4'
    end
    object TurnosMemDataTiempoExterno: TLongWordField
      FieldName = 'TiempoExterno'
    end
  end
  object TurnosDataSource: TDataSource
    DataSet = TurnosMemData
    Left = 398
    Top = 76
  end
end
