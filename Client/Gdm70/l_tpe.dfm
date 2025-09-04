object RptTpeForm: TRptTpeForm
  Left = 394
  Top = 275
  HelpType = htKeyword
  HelpKeyword = 'l_tpe'
  HelpContext = 1107
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Listado de tareas pendientes'
  ClientHeight = 252
  ClientWidth = 512
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs70'
  OldCreateOrder = False
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
    ExplicitHeight = 220
    DesignSize = (
      502
      211)
    Height = 211
    Width = 502
    object gxRangeBox1: TgxRangeBox
      Left = 94
      Top = 15
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object gxRangeBox2: TgxRangeBox
      Left = 96
      Top = 68
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object gxRangeBox3: TgxRangeBox
      Left = 97
      Top = 124
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object MaquinaInicialCtrl: TcxDBTextEdit
      Left = 111
      Top = 6
      DescriptionLabel = Label3
      DataBinding.DataField = 'MaquinaInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.PadAlways = True
      Properties.OnValidate = CodigoCtrlPropertiesValidate
      TabOrder = 0
      Width = 61
    end
    object MaquinaFinalCtrl: TcxDBTextEdit
      Left = 111
      Top = 33
      DescriptionLabel = Label4
      DataBinding.DataField = 'MaquinaFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpRightHighest
      Properties.PadAlways = True
      Properties.OnValidate = CodigoCtrlPropertiesValidate
      TabOrder = 1
      Width = 61
    end
    object Label1: TcxLabel
      Left = 11
      Top = 9
      TabStop = False
      Caption = 'M'#225'quina'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 192
      Top = 7
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      Height = 20
      Width = 294
      AnchorY = 17
    end
    object Label4: TcxLabel
      Left = 192
      Top = 34
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      Height = 20
      Width = 294
      AnchorY = 44
    end
    object FechaInicialCtrl: TcxDBDateEdit
      Left = 111
      Top = 60
      DataBinding.DataField = 'FechaInicial'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 5
      Width = 100
    end
    object FechaFinalCtrl: TcxDBDateEdit
      Left = 111
      Top = 87
      DataBinding.DataField = 'FechaFinal'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 6
      Width = 100
    end
    object Label6: TcxLabel
      Left = 11
      Top = 63
      TabStop = False
      Caption = 'Fecha'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object TurnoInicialCtrl: TcxDBSpinEdit
      Left = 112
      Top = 115
      DescriptionLabel = cxLabel2
      DataBinding.DataField = 'TurnoInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = TurnoCtrlPropertiesQueryRequest
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.MaxValue = 99.000000000000000000
      Properties.MinValue = 1.000000000000000000
      TabOrder = 8
      Width = 51
    end
    object TurnoFinalCtrl: TcxDBSpinEdit
      Left = 112
      Top = 142
      DescriptionLabel = cxLabel3
      DataBinding.DataField = 'TurnoFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = TurnoCtrlPropertiesQueryRequest
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.MaxValue = 99.000000000000000000
      Properties.MinValue = 1.000000000000000000
      TabOrder = 9
      Width = 51
    end
    object cxLabel1: TcxLabel
      Left = 12
      Top = 118
      TabStop = False
      Caption = 'Turno'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object cxLabel2: TcxLabel
      Left = 192
      Top = 116
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      Height = 20
      Width = 294
      AnchorY = 126
    end
    object cxLabel3: TcxLabel
      Left = 192
      Top = 143
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      Height = 20
      Width = 294
      AnchorY = 153
    end
    object cxLabel4: TcxLabel
      Left = 12
      Top = 173
      TabStop = False
      Caption = 'Agrupar por'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object AgruparPorCtrl: TcxDBRadioGroup
      Left = 105
      Top = 169
      Alignment = alCenterCenter
      DataBinding.DataField = 'AgruparPor'
      DataBinding.DataSource = DataSource
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'M'#225'quina'
          Value = 0
        end
        item
          Caption = 'Operaci'#243'n'
          Value = 1
        end>
      Style.BorderStyle = ebsNone
      TabOrder = 14
      Transparent = True
      Height = 28
      Width = 186
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 216
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    ExplicitTop = 225
    DesignSize = (
      512
      36)
    Height = 36
    Width = 512
    object Panel3: TcxGroupBox
      Left = 170
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
    FirstDataControl = MaquinaInicialCtrl
    Model = fmReportForm
    
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 464
    Top = 18
  end
  object Report: TgxReportManager
    FileName = 'dm70\l_tpe'
    HideReportList = False
    SQLItems = <
      item
        Title = 'TareasPendientes'
        SQLText = 
          'CREATE TABLE <TableName> ('#13#10'CodigoGrupo  NVARCHAR(5),'#13#10'Descripci' +
          'onGrupo  NVARCHAR(30),                                       '#13#10'N' +
          'roPedido Integer,'#13#10'Fecha Date,'#13#10'CodigoCliente NVARCHAR(5),      ' +
          '                             '#13#10'NombreCliente NVARCHAR(60),'#13#10'Codi' +
          'goArticulo NVARCHAR(20),    '#13#10'DescripcionArticulo NVARCHAR(60),'#13 +
          #10'CodigoClaseA NVARCHAR(3),'#13#10'CodigoClaseB NVARCHAR(3),'#13#10'CodigoCla' +
          'seC NVARCHAR(3),'#13#10'NroOrden Integer,'#13#10'NroProceso Integer,      '#13#10 +
          'Turno SmallInt,'#13#10'UnidadesAFabricar BCD(16,4),'#13#10'Cantidad BCD(16,4' +
          ') ,'#13#10'Tiempo DWORD );'#13#10#13#10'CREATE INDEX Index1 ON <TableName> ( Nro' +
          'Pedido );  '#13#10
      end>
    ParamsDataset = Data
    ToPrinter = False
    Left = 370
    Top = 18
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 433
    Top = 18
    object DataMaquinaInicial: TWideStringField
      DisplayWidth = 5
      FieldName = 'MaquinaInicial'
      Size = 5
    end
    object DataMaquinaFinal: TWideStringField
      DisplayWidth = 5
      FieldName = 'MaquinaFinal'
      Size = 5
    end
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
    object DataTurnoInicial: TSmallintField
      FieldName = 'TurnoInicial'
    end
    object DataTurnoFinal: TSmallintField
      FieldName = 'TurnoFinal'
    end
    object DataAgruparPor: TSmallintField
      FieldName = 'AgruparPor'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 400
    Top = 18
  end
  object SecuenciaAsignacionTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'SecuenciaAsignacion'
    IndexFieldNames = 'Fecha;Turno;CodigoMaquina;NroOrdenEntrada'
    Left = 436
    Top = 54
  end
end
