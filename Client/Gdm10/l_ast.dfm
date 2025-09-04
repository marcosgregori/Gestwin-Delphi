object RptAstForm: TRptAstForm
  Left = 386
  Top = 267
  HelpType = htKeyword
  HelpKeyword = 'l_ast'
  HelpContext = 1109
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Listado de comprobaci'#243'n de asientos'
  ClientHeight = 262
  ClientWidth = 489
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
    DesignSize = (
      479
      221)
    Height = 221
    Width = 479
    object PageControl: TcxPageControl
      Left = 6
      Top = 26
      Width = 468
      Height = 106
      Anchors = [akLeft, akTop, akRight]
      Focusable = False
      TabOrder = 0
      Properties.ActivePage = TabSheet1
      Properties.CustomButtons.Buttons = <>
      ClientRectBottom = 106
      ClientRectRight = 468
      ClientRectTop = 28
      object TabSheet1: TcxTabSheet
        Caption = '&N'#186' de asiento'
        object gxRangeBox1: TgxRangeBox
          Left = 110
          Top = 15
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object AsientoInicialCtrl: TcxDBTextEdit
          Left = 126
          Top = 8
          DataBinding.DataField = 'NroAsientoInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = AsientoCtrlPropertiesQueryRequest
          Properties.MaxLength = 8
          TabOrder = 0
          Width = 67
        end
        object AsientoFinalCtrl: TcxDBTextEdit
          Left = 126
          Top = 36
          DataBinding.DataField = 'NroAsientoFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = AsientoCtrlPropertiesQueryRequest
          Properties.MaxLength = 8
          TabOrder = 1
          Width = 67
        end
        object Label1: TcxLabel
          Left = 8
          Top = 11
          Caption = 'N'#186' de asiento'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
      end
      object TabSheet2: TcxTabSheet
        Caption = '&Fecha'
        object gxRangeBox2: TgxRangeBox
          Left = 113
          Top = 14
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object FechaInicialCtrl: TcxDBDateEdit
          Left = 128
          Top = 8
          DataBinding.DataField = 'FechaInicial'
          DataBinding.DataSource = DataSource
          Properties.Required = True
          TabOrder = 0
          Width = 100
        end
        object FechaFinalCtrl: TcxDBDateEdit
          Left = 128
          Top = 36
          DataBinding.DataField = 'FechaFinal'
          DataBinding.DataSource = DataSource
          Properties.Required = True
          TabOrder = 1
          Width = 100
        end
        object Label4: TcxLabel
          Left = 8
          Top = 11
          Caption = 'Fecha'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
      end
    end
    object DescuadradosCtrl: TcxDBCheckBox
      Left = 14
      Top = 165
      AutoSize = False
      Caption = 'S'#243'lo asientos &descuadrados'
      DataBinding.DataField = 'Descuadrados'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.ImmediatePost = True
      Properties.MultiLine = True
      Properties.NullStyle = nssUnchecked
      Style.TransparentBorder = False
      TabOrder = 2
      Transparent = True
      Height = 40
      Width = 137
    end
    object TipoAsientoCtrl: TcxDBSpinEdit
      Left = 134
      Top = 141
      DescriptionLabel = desTipoAstoLabel
      DataBinding.DataField = 'TipoAsiento'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = TipoAsientoCtrlPropertiesQueryRequest
      Properties.AssignedValues.MinValue = True
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.ImmediatePost = True
      Properties.MaxValue = 999.000000000000000000
      Properties.OnValidate = TipoAsientoCtrlPropertiesValidate
      TabOrder = 1
      Width = 54
    end
    object Label3: TcxLabel
      Left = 12
      Top = 5
      Caption = 'Seleccionar por ...'
      Style.TextColor = clGreen
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label6: TcxLabel
      Left = 14
      Top = 144
      Caption = 'Tipo de asiento'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object desTipoAstoLabel: TcxLabel
      Left = 226
      Top = 144
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 235
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 226
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      489
      36)
    Height = 36
    Width = 489
    object Panel3: TcxGroupBox
      Left = 155
      Top = 0
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 36
      Width = 180
      object OkButton: TgBitBtn
        AlignWithMargins = True
        Left = 2
        Top = 2
        Width = 85
        Height = 32
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
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
        AlignWithMargins = True
        Left = 91
        Top = 2
        Width = 85
        Height = 32
        Margins.Left = 4
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
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
        ExplicitLeft = 90
      end
    end
  end
  object FormManager: TgxFormManager
    Dataset = Data
    FirstDataControl = AsientoInicialCtrl
    Model = fmReportForm
    ShowQueryOption = True
    OnInitializeForm = InitializeForm
    OnPreparedForm = FormManagerPreparedForm
    OnOkButton = FormManagerOkButton
    Left = 388
    Top = 12
  end
  object Report: TgxReportManager
    FileName = 'dm10\l_ast'
    HideReportList = False
    SQLItems = <
      item
        Title = 'Descuadre'
        SQLText = 
          'SELECT ApunteFinal.*,'#13#10'       Cuenta.Descripcion AS Subcuenta_De' +
          'scripcion,'#13#10'       ApunteFinal.Debe,'#13#10'       ApunteFinal.Haber,'#13 +
          #10'       Asiento.TipoAsiento,'#13#10'       Asiento.NroFactura,'#13#10'      ' +
          ' Asiento.Serie,'#13#10'       Asiento.FechaDocumento,'#13#10'       Asiento.' +
          'NroRegistro,'#13#10'       Asiento.Anotacion, '#13#10'       TipoAsiento.Des' +
          'cripcion AS Tipo_Descripcion'#13#10'FROM ( SELECT Apunte.*'#13#10'       FRO' +
          'M ( SELECT Ejercicio, NroAsiento'#13#10'              FROM Apunte'#13#10'   ' +
          '           WHERE <Seleccion>'#13#10'              GROUP BY Ejercicio, ' +
          'NroAsiento'#13#10'              HAVING CAST( SUM( Debe ) AS BCD(16,4) ' +
          ' )<>CAST( SUM ( Haber ) AS BCD(16,4) ) ) AS ApunteDescuadre'#13#10'   ' +
          '    LEFT JOIN Apunte ON ( Apunte.Ejercicio=ApunteDescuadre.Ejerc' +
          'icio AND Apunte.NroAsiento=ApunteDescuadre.NroAsiento ) ) AS Apu' +
          'nteFinal'#13#10'LEFT JOIN Asiento ON ( Asiento.Ejercicio=ApunteFinal.E' +
          'jercicio AND Asiento.NroAsiento=ApunteFinal.NroAsiento )'#13#10'LEFT J' +
          'OIN Cuenta ON ( ApunteFinal.Subcuenta=Cuenta.Codigo )'#13#10'LEFT JOIN' +
          ' TipoAsiento ON ( Asiento.TipoAsiento=TipoAsiento.NroRegistro )'#13 +
          #10'<SeleccionTipoAsiento>  '#13#10
      end
      item
        Title = 'Diario'
        SQLText = 
          '#L+'#13#10#13#10'SELECT'#13#10'Relacion.*,'#13#10'TipoAsiento.Descripcion AS Tipo_Desc' +
          'ripcion,'#13#10'Cuenta.Descripcion AS Subcuenta_Descripcion,'#13#10'Asiento.' +
          'Fecha,'#13#10'Asiento.TipoAsiento,'#13#10'Asiento.NroFactura,'#13#10'Asiento.Serie' +
          ','#13#10'Asiento.FechaDocumento,'#13#10'Asiento.NroRegistro,'#13#10'Asiento.Anotac' +
          'ion'#13#10#13#10'FROM     '#13#10'( SELECT  '#13#10'    Ejercicio,'#13#10'    NroAsiento,'#13#10' ' +
          '   NroApunte,'#13#10'    Subcuenta,'#13#10'    CentroCoste,'#13#10'    Contraparti' +
          'da,'#13#10'    Concepto,'#13#10'    Debe,'#13#10'    Haber'#13#10'    FROM  '#13#10'    Apunte' +
          #13#10'    WHERE <Seleccion> ) AS Relacion'#13#10' LEFT JOIN Asiento ON Rel' +
          'acion.Ejercicio=Asiento.Ejercicio AND Relacion.NroAsiento=Asient' +
          'o.NroAsiento'#13#10' LEFT JOIN TipoAsiento ON Asiento.TipoAsiento=Tipo' +
          'Asiento.NroRegistro'#13#10' LEFT JOIN Cuenta ON Relacion.Subcuenta=Cue' +
          'nta.Codigo'#13#10'<SeleccionTipoAsiento>                     '#13#10
      end>
    ParamsDataset = Data
    ToPrinter = False
    BeforeStart = ReportBeforeStart
    Left = 294
    Top = 12
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 356
    Top = 12
    object DataNroAsientoInicial: TIntegerField
      FieldName = 'NroAsientoInicial'
      DisplayFormat = '#'
    end
    object DataNroAsientoFinal: TIntegerField
      FieldName = 'NroAsientoFinal'
      DisplayFormat = '#'
    end
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
    object DataTipoAsiento: TSmallintField
      FieldName = 'TipoAsiento'
    end
    object DataDescuadrados: TBooleanField
      FieldName = 'Descuadrados'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 325
    Top = 12
  end
end
