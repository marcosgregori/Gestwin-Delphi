object rptDiaForm: TrptDiaForm
  Left = 419
  Top = 210
  HelpType = htKeyword
  HelpKeyword = 'l_dia'
  HelpContext = 1115
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Diario contable'
  ClientHeight = 211
  ClientWidth = 423
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs10'
  Position = poDefault
  Visible = True
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
    Height = 170
    Width = 413
    object gxRangeBox1: TgxRangeBox
      Left = 124
      Top = 13
      Width = 13
      Height = 37
      Hint = 
        'Los campos situados a la derecha marcan un rango de valores.'#13'Arr' +
        'iba el l'#237'mite inferior y abajo el superior.'
      ParentShowHint = False
      ShowHint = True
    end
    object RayadoModernoCtrl: TcxDBCheckBox
      Left = 7
      Top = 112
      AutoSize = False
      Caption = '&Rayado moderno o americano'
      DataBinding.DataField = 'RayadoModerno'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.MultiLine = True
      Properties.NullStyle = nssUnchecked
      Properties.OnChange = RayadoModernoCtrlPropertiesChange
      TabOrder = 4
      Transparent = True
      Height = 40
      Width = 150
    end
    object FechaInicialCtrl: TcxDBDateEdit
      Left = 140
      Top = 8
      DataBinding.DataField = 'FechaInicial'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 0
      Width = 100
    end
    object FechaFinalCtrl: TcxDBDateEdit
      Left = 140
      Top = 35
      DataBinding.DataField = 'FechaFinal'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 1
      Width = 100
    end
    object PrimeraPaginaCtrl: TcxDBSpinEdit
      Left = 140
      Top = 62
      CaptionLabel = Label1
      DataBinding.DataField = 'PrimeraPagina'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.MaxValue = 9999.000000000000000000
      Properties.MinValue = 1.000000000000000000
      TabOrder = 2
      Width = 58
    end
    object IncluirAnotacionesCtrl: TcxDBCheckBox
      Left = 7
      Top = 89
      AutoSize = False
      Caption = '&Mostrar anotaciones'
      DataBinding.DataField = 'MostrarAnotaciones'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 3
      Transparent = True
      Height = 25
      Width = 150
    end
    object Label4: TcxLabel
      Left = 11
      Top = 11
      Caption = 'Fecha'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label1: TcxLabel
      Left = 11
      Top = 65
      Caption = 'Primer n'#186' de p'#225'gina'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 175
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      423
      36)
    Height = 36
    Width = 423
    object Panel3: TcxGroupBox
      Left = 125
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
    FirstDataControl = FechaInicialCtrl
    Model = fmReportForm
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 342
    Top = 14
  end
  object Report: TgxReportManager
    FileName = 'dm10\l_dia'
    HideReportList = False
    SQLItems = <
      item
        Title = 'Diario'
        SQLText = 
          'SELECT'#13#10'Relacion.*,'#13#10'TipoAsiento.Descripcion AS Tipo_Descripcion' +
          ','#13#10'Apunte.Subcuenta,'#13#10'Cuenta.Descripcion AS Subcuenta_Descripcio' +
          'n,'#13#10'Apunte.CentroCoste,'#13#10'Apunte.Contrapartida,'#13#10'Apunte.Concepto,' +
          #13#10'Debe,'#13#10'Haber'#13#10#13#10'FROM     '#13#10'( SELECT  '#13#10'    Ejercicio,'#13#10'    Nro' +
          'Asiento,'#13#10'    Fecha,'#13#10'    TipoAsiento,'#13#10'    NroFactura,'#13#10'    Ser' +
          'ie,'#13#10'    FechaDocumento,'#13#10'    NroRegistro,'#13#10'    Anotacion'#13#10'    F' +
          'ROM  '#13#10'    Asiento  '#13#10'    WHERE Fecha BETWEEN %s AND %s ) AS Rel' +
          'acion'#13#10' LEFT JOIN Apunte ON Relacion.Ejercicio=Apunte.Ejercicio ' +
          'AND Relacion.NroAsiento=Apunte.NroAsiento'#13#10' LEFT JOIN TipoAsient' +
          'o ON Relacion.TipoAsiento=TipoAsiento.NroRegistro'#13#10' LEFT JOIN Cu' +
          'enta ON Apunte.Subcuenta=Cuenta.Codigo'#13#10#13#10'ORDER '#13#10'BY Fecha, NroA' +
          'siento, NroApunte'#13#10
      end>
    ParamsDataset = Data
    ToPrinter = False
    OnSetReportName = ReportSetReportName
    BeforeStart = ReportBeforeStart
    Left = 310
    Top = 46
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 311
    Top = 14
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
    object DataPrimeraPagina: TSmallintField
      FieldName = 'PrimeraPagina'
    end
    object DataMostrarAnotaciones: TBooleanField
      FieldName = 'MostrarAnotaciones'
    end
    object DataRayadoModerno: TBooleanField
      FieldName = 'RayadoModerno'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 278
    Top = 14
  end
end
