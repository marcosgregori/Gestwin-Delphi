object MntTarForm: TMntTarForm
  Left = 458
  Top = 255
  HelpType = htKeyword
  HelpKeyword = 'a_tar'
  HelpContext = 80515
  BorderStyle = bsDialog
  Caption = 'Tareas'
  ClientHeight = 514
  ClientWidth = 673
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  PixelsPerInch = 96
  TextHeight = 17
  object KeyPanel: TgxEditPanel
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epKeyPanel
    Height = 36
    Width = 673
    object NroTareaCtrl: TcxDBTextEdit
      Left = 138
      Top = 6
      DataBinding.DataField = 'NroTarea'
      DataBinding.DataSource = TareaDataSource
      Properties.OnQueryRequest = NroTareaCtrlPropertiesQueryRequest
      Properties.MaxLength = 8
      TabOrder = 0
      Width = 81
    end
    object codigoCtrlCaption: TcxLabel
      Left = 14
      Top = 9
      TabStop = False
      Caption = 'N'#186' tarea'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object EjercicioLabel: TcxLabel
      Left = 240
      Top = 9
      TabStop = False
      AutoSize = False
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 17
      Width = 140
    end
  end
  object DataPanel: TgxEditPanel
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
    DesignSize = (
      663
      442)
    Height = 442
    Width = 663
    object FechaCtrl: TcxDBDateEdit
      Left = 133
      Top = 8
      DataBinding.DataField = 'Fecha'
      DataBinding.DataSource = TareaDataSource
      Properties.Required = True
      Properties.OnValidate = FechaCtrlPropertiesValidate
      TabOrder = 0
      Width = 103
    end
    object CodigoClienteCtrl: TcxDBTextEdit
      Left = 133
      Top = 62
      DescriptionLabel = ClienteLabel
      DataBinding.DataField = 'CodigoCliente'
      DataBinding.DataSource = TareaDataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoClienteCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoClienteCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.OnValidate = CodigoClienteCtrlPropertiesValidate
      TabOrder = 2
      Width = 49
    end
    object CodigoTecnicoCtrl: TcxDBTextEdit
      Left = 133
      Top = 89
      DescriptionLabel = DescTecnicoLabel
      DataBinding.DataField = 'CodigoTecnico'
      DataBinding.DataSource = TareaDataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoTecnicoCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoTecnicoCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      Properties.OnValidate = CodigoTecnicoCtrlPropertiesValidate
      TabOrder = 3
      Width = 28
    end
    object CodigoTipoTareaCtrl: TcxDBTextEdit
      Left = 133
      Top = 116
      DescriptionLabel = DescTareaLabel
      DataBinding.DataField = 'CodigoTipoTarea'
      DataBinding.DataSource = TareaDataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoTipoTareaCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoTipoTareaCtrlPropertiesEditRequest
      Properties.OnValuePosted = CodigoTipoTareaCtrlPropertiesValuePosted
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      Properties.OnValidate = CodigoTipoTareaCtrlPropertiesValidate
      TabOrder = 4
      Width = 28
    end
    object FechaResolucionCtrl: TcxDBDateEdit
      Left = 133
      Top = 273
      CaptionLabel = CapFechaResolucionLabel
      DataBinding.DataField = 'FechaResolucion'
      DataBinding.DataSource = TareaDataSource
      Enabled = False
      Properties.Required = True
      Properties.OnValidate = FechaCtrlPropertiesValidate
      TabOrder = 8
      Width = 103
    end
    object UrgenteCtrl: TcxDBCheckBox
      Left = 6
      Top = 142
      AutoSize = False
      Caption = 'Urgente'
      DataBinding.DataField = 'Urgente'
      DataBinding.DataSource = TareaDataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      Style.TransparentBorder = True
      TabOrder = 5
      Transparent = True
      Height = 24
      Width = 144
    end
    object TiempoCtrl: TcxDBTimeEdit
      Left = 133
      Top = 300
      CaptionLabel = CapTiempoLabel
      DataBinding.DataField = 'Duracion'
      DataBinding.DataSource = TareaDataSource
      Enabled = False
      Properties.Required = True
      TabOrder = 9
      Width = 73
    end
    object EstadoCtrl: TcxDBRadioGroup
      Left = 126
      Top = 244
      Alignment = alCenterCenter
      DataBinding.DataField = 'Estado'
      DataBinding.DataSource = TareaDataSource
      Properties.Columns = 4
      Properties.Items = <
        item
          Caption = 'Pendiente'
          Value = 0
        end
        item
          Caption = 'Resuelto'
          Value = 1
        end
        item
          Caption = 'Cancelado'
          Value = 2
        end
        item
          Caption = 'Oficina'
          Value = 3
        end>
      Properties.OnEditValueChanged = EstadoCtrlPropertiesEditValueChanged
      Style.BorderStyle = ebsNone
      TabOrder = 7
      Height = 25
      Width = 414
    end
    object Label1: TcxLabel
      Left = 9
      Top = 11
      TabStop = False
      Caption = 'Fecha'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 9
      Top = 67
      TabStop = False
      Caption = 'Cliente'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object ClienteLabel: TcxLabel
      Left = 204
      Top = 67
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 17
      Width = 345
    end
    object Label4: TcxLabel
      Left = 9
      Top = 93
      TabStop = False
      Caption = 'T'#233'cnico'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object DescTecnicoLabel: TcxLabel
      Left = 204
      Top = 92
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 17
      Width = 345
    end
    object Label3: TcxLabel
      Left = 9
      Top = 120
      TabStop = False
      Caption = 'Tipo de tarea'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object DescTareaLabel: TcxLabel
      Left = 204
      Top = 119
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 17
      Width = 345
    end
    object Label6: TcxLabel
      Left = 9
      Top = 172
      TabStop = False
      Caption = 'Asunto'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label7: TcxLabel
      Left = 9
      Top = 249
      TabStop = False
      Caption = 'Estado'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object CapFechaResolucionLabel: TcxLabel
      Left = 9
      Top = 277
      TabStop = False
      Caption = 'Fecha de resoluci'#243'n'
      Enabled = False
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object CapResolucionLabel: TcxLabel
      Left = 9
      Top = 327
      TabStop = False
      Caption = 'Resoluci'#243'n'
      Enabled = False
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object CapTiempoLabel: TcxLabel
      Left = 9
      Top = 304
      TabStop = False
      Caption = 'Tiempo'
      Enabled = False
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object AsuntoCtrl: TcxDBMemo
      Left = 133
      Top = 169
      Anchors = [akLeft, akTop, akRight]
      DataBinding.DataField = 'Asunto'
      DataBinding.DataSource = TareaDataSource
      Properties.WantReturns = False
      TabOrder = 6
      Height = 71
      Width = 522
    end
    object ResolucionCtrl: TcxDBMemo
      Left = 133
      Top = 327
      CaptionLabel = CapResolucionLabel
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataBinding.DataField = 'Resolucion'
      DataBinding.DataSource = TareaDataSource
      Enabled = False
      Properties.WantReturns = False
      TabOrder = 10
      Height = 107
      Width = 522
    end
    object Label8: TcxLabel
      Left = 9
      Top = 39
      TabStop = False
      Caption = 'Aplicaci'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object AplicacionCtrl: TcxDBIndexedComboBox
      Left = 133
      Top = 35
      DataBinding.DataField = 'NroAplicacion'
      DataBinding.DataSource = TareaDataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.ImmediatePost = True
      Properties.Items.Strings = (
        '1 : Gesti'#243'n contable'
        '2 : Terminal punto de venta (TPV)'
        '3 : Gesti'#243'n contable, financiera y comercial'
        '4 : Aprovisionamiento y carga'
        '5 : Gesti'#243'n financiera y comercial'
        '6 : Preventa'
        '7 : Producci'#243'n')
      Properties.FirstIndexValue = 1
      TabOrder = 1
      Width = 288
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 478
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      673
      36)
    Height = 36
    Width = 673
    object Panel2: TcxGroupBox
      Left = 207
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
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
  object TecnicoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Tecnico'
    IndexFieldNames = 'Codigo'
    Left = 432
    Top = 4
  end
  object TipoTareaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'TipoTarea'
    IndexFieldNames = 'Codigo'
    Left = 400
    Top = 4
  end
  object TareaTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    OnNewRecord = TareaTableNewRecord
    TableName = 'Tarea'
    IndexFieldNames = 'Ejercicio;NroTarea'
    AutoIncFieldName = 'NroTarea'
    OnSetKey = TareaTableSetKey
    OnGetRecord = TareaTableGetRecord
    OnUpdateState = TareaTableUpdateState
    OnGetAutoIncValue = TareaTableGetAutoIncValue
    Left = 518
    Top = 4
  end
  object FormManager: TgxFormManager
    Dataset = TareaTable
    FirstKeyControl = NroTareaCtrl
    FirstDataControl = FechaCtrl
    Model = fmEditForm
    
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    Left = 548
    Top = 4
  end
  object TareaDataSource: TDataSource
    DataSet = TareaTable
    Left = 486
    Top = 4
  end
end
