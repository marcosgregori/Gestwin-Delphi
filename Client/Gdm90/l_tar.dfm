object RptTarForm: TRptTarForm
  Left = 331
  Top = 343
  HelpContext = 35501
  BorderStyle = bsDialog
  Caption = 'Listado de tareas'
  ClientHeight = 207
  ClientWidth = 554
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
    DesignSize = (
      544
      166)
    Height = 166
    Width = 544
    object gxRangeBox1: TgxRangeBox
      Left = 130
      Top = 16
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object FechaInicialCtrl: TcxDBDateEdit
      Left = 145
      Top = 7
      DataBinding.DataField = 'FechaInicial'
      DataBinding.DataSource = DataSource
      TabOrder = 0
      Width = 100
    end
    object FechaFinalCtrl: TcxDBDateEdit
      Left = 145
      Top = 34
      DataBinding.DataField = 'FechaFinal'
      DataBinding.DataSource = DataSource
      TabOrder = 1
      Width = 100
    end
    object SituacionCtrl: TcxDBIndexedComboBox
      Left = 145
      Top = 61
      DataBinding.DataField = 'Situacion'
      DataBinding.DataSource = DataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.ImmediatePost = True
      Properties.Items.Strings = (
        'Todas las tareas pendientes'
        'Todas las tareas realizadas'
        'Tareas pendientes de ...'
        'Tareas realizadas de ...'
        'Todas las tareas'
        '')
      Properties.OnEditValueChanged = SituacionCtrlPropertiesEditValueChanged
      TabOrder = 2
      Width = 179
    end
    object UrgentesCtrl: TcxDBCheckBox
      Left = 7
      Top = 89
      AutoSize = False
      Caption = '&S'#243'lo tareas urgentes'
      DataBinding.DataField = 'SoloUrgentes'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 4
      Transparent = True
      Height = 24
      Width = 155
    end
    object CodigoTecnicoCtrl: TcxDBTextEdit
      Left = 327
      Top = 61
      DescriptionLabel = DescTecnicoLabel
      DataBinding.DataField = 'CodigoTecnico'
      DataBinding.DataSource = DataSource
      Enabled = False
      Properties.Required = True
      Properties.OnQueryRequest = CodigoTecnicoCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      Properties.OnValidate = CodigoTecnicoCtrlPropertiesValidate
      TabOrder = 3
      Width = 25
    end
    object AgruparPorResolucionCtrl: TcxDBCheckBox
      Left = 7
      Top = 113
      AutoSize = False
      Caption = 'A&grupar por fecha de resoluci'#243'n'
      DataBinding.DataField = 'AgruparPorResolucion'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.MultiLine = True
      Properties.NullStyle = nssUnchecked
      TabOrder = 5
      Transparent = True
      Height = 36
      Width = 155
    end
    object Label2: TcxLabel
      Left = 10
      Top = 10
      TabStop = False
      Caption = 'Fecha'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label1: TcxLabel
      Left = 10
      Top = 64
      TabStop = False
      Caption = 'Situaci'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object DescTecnicoLabel: TcxLabel
      Left = 361
      Top = 64
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Enabled = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 194
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 171
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      554
      36)
    Height = 36
    Width = 554
    object Panel3: TcxGroupBox
      Left = 191
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
    FirstDataControl = FechaInicialCtrl
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 508
    Top = 14
  end
  object Report: TgxReportManager
    FileName = 'dm90\l_tar'
    HideReportList = False
    SQLItems = <
      item
        Title = 'Agrupado'
        SQLText = 
          'SELECT Tarea.*, Cliente.Nombre, Cliente.Telefono, ResumenTarea.C' +
          'ontador, Tecnico.Nombre AS NombreTecnico                        ' +
          '         '#13#10'FROM ( SELECT FechaResolucion, CodigoTecnico, Count( ' +
          'FechaResolucion ) AS Contador'#13#10'       FROM Tarea '#13#10'       WHERE ' +
          'FechaResolucion BETWEEN <FechaInicial> AND <FechaFinal> <Estado>' +
          #13#10'       GROUP BY FechaResolucion, CodigoTecnico ) AS ResumenTar' +
          'ea'#13#10'       LEFT JOIN Tarea ON ( ResumenTarea.FechaResolucion=Tar' +
          'ea.FechaResolucion AND ResumenTarea.CodigoTecnico=Tarea.CodigoTe' +
          'cnico )'#13#10'       LEFT JOIN Cliente ON ( Tarea.CodigoCliente=Clien' +
          'te.Codigo )'#13#10'       LEFT JOIN Tecnico ON ( Tarea.CodigoTecnico=T' +
          'ecnico.Codigo )                                                 ' +
          '                                               '#13#10'ORDER BY FechaR' +
          'esolucion'#13#10
      end
      item
        Title = 'Simple'
        SQLText = 
          'SELECT Tarea.*, Cliente.Nombre, Cliente.Telefono, Tecnico.Nombre' +
          ' AS NombreTecnico                                               ' +
          '                      '#13#10'FROM   Tarea '#13#10'       LEFT JOIN Cliente ' +
          'ON ( CodigoCliente=Cliente.Codigo )'#13#10'       LEFT JOIN Tecnico ON' +
          ' ( Tarea.CodigoTecnico=Tecnico.Codigo )           '#13#10'WHERE  Fecha' +
          ' BETWEEN <FechaInicial> AND <FechaFinal> <Estado>'#13#10'ORDER BY NroT' +
          'area'#13#10
      end>
    ToPrinter = False
    Left = 419
    Top = 14
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 448
    Top = 14
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 479
    Top = 14
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
    object DataSituacion: TSmallintField
      FieldName = 'Situacion'
    end
    object DataCodigoTecnico: TWideStringField
      FieldName = 'CodigoTecnico'
      Size = 2
    end
    object DataSoloUrgentes: TBooleanField
      FieldName = 'SoloUrgentes'
    end
    object DataAgruparPorResolucion: TBooleanField
      FieldName = 'AgruparPorResolucion'
    end
  end
end
