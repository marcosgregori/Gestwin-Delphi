object MntTurForm: TMntTurForm
  Left = 633
  Top = 388
  HelpType = htKeyword
  HelpKeyword = 'a_tur'
  BorderStyle = bsDialog
  Caption = 'Turnos'
  ClientHeight = 203
  ClientWidth = 518
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs70'
  Position = poDefault
  Visible = True
  TextHeight = 17
  object keyPanel: TgxEditPanel
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epKeyPanel
    ExplicitWidth = 418
    Height = 36
    Width = 518
    object NroTurnoCtrl: TcxDBSpinEdit
      Left = 95
      Top = 5
      DataBinding.DataField = 'NroTurno'
      DataBinding.DataSource = TurnoDataSource
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.MaxValue = 99.000000000000000000
      Properties.MinValue = 1.000000000000000000
      TabOrder = 0
      Width = 50
    end
    object codigoCtrlCaption: TcxLabel
      Left = 12
      Top = 8
      TabStop = False
      Caption = 'Codigo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
  object dataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 36
    Margins.Left = 5
    Margins.Top = 0
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
    PanelKind = epDataPanel
    ExplicitWidth = 408
    Height = 131
    Width = 508
    object DescripcionCtrl: TcxDBTextEdit
      Left = 90
      Top = 7
      DataBinding.DataField = 'Descripcion'
      DataBinding.DataSource = TurnoDataSource
      Properties.Required = True
      TabOrder = 0
      Width = 235
    end
    object Label1: TcxLabel
      Left = 8
      Top = 10
      TabStop = False
      Caption = 'Descripci'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object cxLabel1: TcxLabel
      Left = 8
      Top = 37
      TabStop = False
      Caption = 'Horario'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object cxLabel2: TcxLabel
      Left = 90
      Top = 37
      TabStop = False
      Caption = 'Inicio'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object cxLabel3: TcxLabel
      Left = 159
      Top = 37
      TabStop = False
      Caption = 'Fin'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Inicio1Ctrl: TcxDBTimeEdit
      Left = 90
      Top = 60
      DataBinding.DataField = 'Inicio1'
      DataBinding.DataSource = TurnoDataSource
      Properties.ClearKey = 8238
      Properties.TimeFormat = tfHourMin
      Properties.UseNullString = True
      TabOrder = 1
      Width = 63
    end
    object Fin1Ctrl: TcxDBTimeEdit
      Left = 159
      Top = 60
      DataBinding.DataField = 'Fin1'
      DataBinding.DataSource = TurnoDataSource
      Properties.ClearKey = 8238
      Properties.TimeFormat = tfHourMin
      Properties.UseNullString = True
      TabOrder = 2
      Width = 63
    end
    object Inicio2Ctrl: TcxDBTimeEdit
      Left = 90
      Top = 87
      DataBinding.DataField = 'Inicio2'
      DataBinding.DataSource = TurnoDataSource
      Properties.ClearKey = 8238
      Properties.TimeFormat = tfHourMin
      Properties.UseNullString = True
      TabOrder = 3
      Width = 63
    end
    object Fin2Ctrl: TcxDBTimeEdit
      Left = 159
      Top = 87
      DataBinding.DataField = 'Fin2'
      DataBinding.DataSource = TurnoDataSource
      Properties.ClearKey = 8238
      Properties.TimeFormat = tfHourMin
      Properties.UseNullString = True
      TabOrder = 4
      Width = 63
    end
    object cxLabel4: TcxLabel
      Left = 237
      Top = 63
      TabStop = False
      Caption = 'Use [Shift]+[Supr] para suprimir un valor.'
      Style.TextColor = clMedGray
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 167
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    ExplicitWidth = 418
    DesignSize = (
      518
      36)
    Height = 36
    Width = 518
    object Panel2: TcxGroupBox
      Left = 131
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      ExplicitLeft = 81
      Height = 30
      Width = 260
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
      object DeleteButton: TgBitBtn
        Left = 175
        Top = 1
        Width = 85
        Height = 28
        Caption = '&Suprimir'
        Enabled = True
        ModalResult = 3
        OptionsImage.ImageIndex = 5
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 2
        GlyphBitmap = gmDelete
      end
    end
  end
  object FormManager: TgxFormManager
    Dataset = TurnoTable
    FirstKeyControl = NroTurnoCtrl
    FirstDataControl = DescripcionCtrl
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    Left = 346
    Top = 4
  end
  object TurnoTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Turno'
    IndexFieldNames = 'NroTurno'
    AutoIncFieldName = 'NroTurno'
    Left = 316
    Top = 4
  end
  object TurnoDataSource: TDataSource
    DataSet = TurnoTable
    Left = 284
    Top = 4
  end
end
