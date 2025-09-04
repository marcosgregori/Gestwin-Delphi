object mntPg101Form: TmntPg101Form
  Left = 447
  Top = 280
  BorderStyle = bsDialog
  Caption = 'Par'#225'metros generales'
  ClientHeight = 349
  ClientWidth = 742
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
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
    Height = 308
    Width = 732
    object Shape1: TShape
      Left = 10
      Top = 57
      Width = 712
      Height = 1
      Pen.Color = clSilver
    end
    object Shape2: TShape
      Left = 6
      Top = 261
      Width = 716
      Height = 1
      Pen.Color = clSilver
    end
    object Label1: TcxLabel
      Left = 489
      Top = 93
      TabStop = False
      Caption = 'C'#243'digo art'#237'culo 4'
      Transparent = True
    end
    object Label4: TcxLabel
      Left = 489
      Top = 120
      TabStop = False
      Caption = 'Cantidad'
      Transparent = True
    end
    object Label11: TcxLabel
      Left = 489
      Top = 147
      TabStop = False
      Caption = 'C'#243'digo art'#237'culo 5'
      Transparent = True
    end
    object Label23: TcxLabel
      Left = 489
      Top = 174
      TabStop = False
      Caption = 'Cantidad'
      Transparent = True
    end
    object Label24: TcxLabel
      Left = 489
      Top = 201
      TabStop = False
      Caption = 'C'#243'digo art'#237'culo 6'
      Transparent = True
    end
    object Label27: TcxLabel
      Left = 489
      Top = 228
      TabStop = False
      Caption = 'Cantidad'
      Transparent = True
    end
    object FicheroImportacionCtrl: TcxDBTextEdit
      Left = 156
      Top = 10
      DataBinding.DataField = 'FicheroImportacion'
      DataBinding.DataSource = DataSource
      TabOrder = 0
      Width = 298
    end
    object CampoObraCtrl: TcxDBRadioGroup
      Left = 155
      Top = 267
      Alignment = alCenterCenter
      DataBinding.DataField = 'CampoObra'
      DataBinding.DataSource = DataSource
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'Registro auxiliar'
          Value = 0
        end
        item
          Caption = 'Grupo de cliente'
          Value = 1
        end>
      Style.BorderStyle = ebsNone
      TabOrder = 51
      Height = 25
      Width = 274
    end
    object CPNroAlbaranCtrl: TcxDBTextEdit
      Left = 163
      Top = 93
      DataBinding.DataField = 'CPNroAlbaran'
      DataBinding.DataSource = DataSource
      TabOrder = 1
      Width = 32
    end
    object CLNroAlbaranCtrl: TcxDBTextEdit
      Left = 204
      Top = 93
      DataBinding.DataField = 'CLNroAlbaran'
      DataBinding.DataSource = DataSource
      TabOrder = 2
      Width = 32
    end
    object CPArticulo1Ctrl: TcxDBTextEdit
      Left = 404
      Top = 93
      DataBinding.DataField = 'CPArticulo1'
      DataBinding.DataSource = DataSource
      TabOrder = 11
      Width = 32
    end
    object CLArticulo1Ctrl: TcxDBTextEdit
      Left = 445
      Top = 93
      DataBinding.DataField = 'CLArticulo1'
      DataBinding.DataSource = DataSource
      TabOrder = 12
      Width = 32
    end
    object CPClienteCtrl: TcxDBTextEdit
      Left = 163
      Top = 120
      DataBinding.DataField = 'CPCliente'
      DataBinding.DataSource = DataSource
      TabOrder = 3
      Width = 32
    end
    object CLClienteCtrl: TcxDBTextEdit
      Left = 204
      Top = 120
      DataBinding.DataField = 'CLCliente'
      DataBinding.DataSource = DataSource
      TabOrder = 4
      Width = 32
    end
    object CPCantidad1Ctrl: TcxDBTextEdit
      Left = 404
      Top = 120
      DataBinding.DataField = 'CPCantidad1'
      DataBinding.DataSource = DataSource
      TabOrder = 13
      Width = 32
    end
    object CLCantidad1Ctrl: TcxDBTextEdit
      Left = 445
      Top = 120
      DataBinding.DataField = 'CLCantidad1'
      DataBinding.DataSource = DataSource
      TabOrder = 14
      Width = 32
    end
    object CPObraCtrl: TcxDBTextEdit
      Left = 163
      Top = 147
      DataBinding.DataField = 'CPObra'
      DataBinding.DataSource = DataSource
      TabOrder = 5
      Width = 32
    end
    object CIObraCtrl: TcxDBTextEdit
      Left = 204
      Top = 147
      DataBinding.DataField = 'CIObra'
      DataBinding.DataSource = DataSource
      TabOrder = 6
      Width = 32
    end
    object CPArticulo2Ctrl: TcxDBTextEdit
      Left = 404
      Top = 147
      DataBinding.DataField = 'CPArticulo2'
      DataBinding.DataSource = DataSource
      TabOrder = 15
      Width = 32
    end
    object CLArticulo2Ctrl: TcxDBTextEdit
      Left = 445
      Top = 147
      DataBinding.DataField = 'CLArticulo2'
      DataBinding.DataSource = DataSource
      TabOrder = 16
      Width = 32
    end
    object CPTarifaCtrl: TcxDBTextEdit
      Left = 163
      Top = 174
      DataBinding.DataField = 'CPTarifa'
      DataBinding.DataSource = DataSource
      TabOrder = 7
      Width = 32
    end
    object CLTarifaCtrl: TcxDBTextEdit
      Left = 204
      Top = 174
      DataBinding.DataField = 'CLTarifa'
      DataBinding.DataSource = DataSource
      TabOrder = 8
      Width = 32
    end
    object CPCantidad2Ctrl: TcxDBTextEdit
      Left = 404
      Top = 174
      DataBinding.DataField = 'CPCantidad2'
      DataBinding.DataSource = DataSource
      TabOrder = 17
      Width = 32
    end
    object CLCantidad2Ctrl: TcxDBTextEdit
      Left = 445
      Top = 174
      DataBinding.DataField = 'CLCantidad2'
      DataBinding.DataSource = DataSource
      TabOrder = 18
      Width = 32
    end
    object CPFechaCtrl: TcxDBTextEdit
      Left = 163
      Top = 201
      DataBinding.DataField = 'CpFecha'
      DataBinding.DataSource = DataSource
      TabOrder = 9
      Width = 32
    end
    object CIFechaCtrl: TcxDBTextEdit
      Left = 204
      Top = 201
      DataBinding.DataField = 'CIFecha'
      DataBinding.DataSource = DataSource
      TabOrder = 10
      Width = 32
    end
    object CPCantidad3Ctrl: TcxDBTextEdit
      Left = 404
      Top = 228
      DataBinding.DataField = 'CPCantidad3'
      DataBinding.DataSource = DataSource
      TabOrder = 21
      Width = 32
    end
    object CLCantidad3Ctrl: TcxDBTextEdit
      Left = 445
      Top = 228
      DataBinding.DataField = 'CLCantidad3'
      DataBinding.DataSource = DataSource
      TabOrder = 22
      Width = 32
    end
    object CLArticulo3Ctrl: TcxDBTextEdit
      Left = 445
      Top = 201
      DataBinding.DataField = 'CLArticulo3'
      DataBinding.DataSource = DataSource
      TabOrder = 20
      Width = 32
    end
    object CPArticulo3Ctrl: TcxDBTextEdit
      Left = 404
      Top = 201
      DataBinding.DataField = 'CPArticulo3'
      DataBinding.DataSource = DataSource
      TabOrder = 19
      Width = 32
    end
    object Label2: TcxLabel
      Left = 10
      Top = 13
      TabStop = False
      Caption = 'Fichero de importaci'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 9
      Top = 240
      TabStop = False
      Caption = 'Asignaci'#243'n de campos'
      Style.TextColor = clGreen
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label5: TcxLabel
      Left = 10
      Top = 270
      TabStop = False
      Caption = 'Obra'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label6: TcxLabel
      Left = 10
      Top = 37
      TabStop = False
      Caption = 'Estructura'
      Style.TextColor = clGreen
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label7: TcxLabel
      Left = 10
      Top = 96
      TabStop = False
      Caption = 'N'#186' de albar'#225'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label8: TcxLabel
      Left = 10
      Top = 123
      TabStop = False
      Caption = 'C'#243'digo del cliente'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label9: TcxLabel
      Left = 10
      Top = 150
      TabStop = False
      Caption = 'C'#243'digo obra'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label10: TcxLabel
      Left = 10
      Top = 177
      TabStop = False
      Caption = 'C'#243'digo tarifa'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label12: TcxLabel
      Left = 10
      Top = 204
      TabStop = False
      Caption = 'Fecha del documento'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label13: TcxLabel
      Left = 251
      Top = 96
      TabStop = False
      Caption = 'C'#243'digo art'#237'culo 1'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label22: TcxLabel
      Left = 251
      Top = 123
      TabStop = False
      Caption = 'Cantidad'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label20: TcxLabel
      Left = 251
      Top = 150
      TabStop = False
      Caption = 'C'#243'digo art'#237'culo 2'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label21: TcxLabel
      Left = 251
      Top = 177
      TabStop = False
      Caption = 'Cantidad'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label25: TcxLabel
      Left = 250
      Top = 204
      TabStop = False
      Caption = 'C'#243'digo art'#237'culo 3'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label26: TcxLabel
      Left = 250
      Top = 233
      TabStop = False
      Caption = 'Cantidad'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object CPArticulo4Ctrl: TcxDBTextEdit
      Left = 643
      Top = 92
      DataBinding.DataField = 'CPArticulo4'
      DataBinding.DataSource = DataSource
      TabOrder = 23
      Width = 32
    end
    object CLArticulo4Ctrl: TcxDBTextEdit
      Left = 684
      Top = 92
      DataBinding.DataField = 'CLArticulo4'
      DataBinding.DataSource = DataSource
      TabOrder = 24
      Width = 32
    end
    object CPCantidad4Ctrl: TcxDBTextEdit
      Left = 643
      Top = 119
      DataBinding.DataField = 'CPCantidad4'
      DataBinding.DataSource = DataSource
      TabOrder = 25
      Width = 32
    end
    object CLCantidad4Ctrl: TcxDBTextEdit
      Left = 684
      Top = 119
      DataBinding.DataField = 'CLCantidad4'
      DataBinding.DataSource = DataSource
      TabOrder = 26
      Width = 32
    end
    object CPArticulo5Ctrl: TcxDBTextEdit
      Left = 643
      Top = 146
      DataBinding.DataField = 'CPArticulo5'
      DataBinding.DataSource = DataSource
      TabOrder = 27
      Width = 32
    end
    object CLArticulo5Ctrl: TcxDBTextEdit
      Left = 684
      Top = 146
      DataBinding.DataField = 'CLArticulo5'
      DataBinding.DataSource = DataSource
      TabOrder = 28
      Width = 32
    end
    object CPCantidad5Ctrl: TcxDBTextEdit
      Left = 643
      Top = 173
      DataBinding.DataField = 'CPCantidad5'
      DataBinding.DataSource = DataSource
      TabOrder = 29
      Width = 32
    end
    object CLCantidad5Ctrl: TcxDBTextEdit
      Left = 684
      Top = 173
      DataBinding.DataField = 'CLCantidad5'
      DataBinding.DataSource = DataSource
      TabOrder = 30
      Width = 32
    end
    object CPCantidad6Ctrl: TcxDBTextEdit
      Left = 643
      Top = 227
      DataBinding.DataField = 'CPCantidad6'
      DataBinding.DataSource = DataSource
      TabOrder = 33
      Width = 32
    end
    object CLCantidad6Ctrl: TcxDBTextEdit
      Left = 684
      Top = 227
      DataBinding.DataField = 'CLCantidad6'
      DataBinding.DataSource = DataSource
      TabOrder = 34
      Width = 32
    end
    object CLArticulo6Ctrl: TcxDBTextEdit
      Left = 684
      Top = 200
      DataBinding.DataField = 'CLArticulo6'
      DataBinding.DataSource = DataSource
      TabOrder = 32
      Width = 32
    end
    object CPArticulo6Ctrl: TcxDBTextEdit
      Left = 643
      Top = 200
      DataBinding.DataField = 'CPArticulo6'
      DataBinding.DataSource = DataSource
      TabOrder = 31
      Width = 32
    end
    object cxHeader1: TcxHeader
      Left = 5
      Top = 64
      Width = 240
      Height = 21
      Sections = <
        item
          Text = 'Campo'
          Width = 150
        end
        item
          Alignment = taCenter
          Text = 'Inicio'
          Width = 45
        end
        item
          Alignment = taCenter
          Text = 'Long.'
          Width = 45
        end>
    end
    object cxHeader2: TcxHeader
      Left = 245
      Top = 64
      Width = 240
      Height = 21
      Sections = <
        item
          Text = 'Campo'
          Width = 150
        end
        item
          Alignment = taCenter
          Text = 'Inicio'
          Width = 45
        end
        item
          Alignment = taCenter
          Text = 'Long.'
          Width = 45
        end>
    end
    object cxHeader3: TcxHeader
      Left = 484
      Top = 64
      Width = 240
      Height = 21
      Sections = <
        item
          Text = 'Campo'
          Width = 150
        end
        item
          Alignment = taCenter
          Text = 'Inicio'
          Width = 45
        end
        item
          Alignment = taCenter
          Text = 'Long.'
          Width = 45
        end>
    end
  end
  object examinarButton: TgBitBtn
    Left = 469
    Top = 13
    Width = 102
    Height = 28
    Caption = 'E&xaminar ...'
    Enabled = True
    OptionsImage.ImageIndex = 21
    OptionsImage.Images = ApplicationContainer.ButtonImageList
    OptionsImage.Margin = 4
    OptionsImage.Spacing = 5
    TabOrder = 1
    TabStop = False
    OnClick = examinarButtonClick
    GlyphBitmap = gmFolder
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 313
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      742
      36)
    Height = 36
    Width = 742
    object Panel3: TcxGroupBox
      Left = 286
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
    Dataset = ConfiguracionTable
    FirstDataControl = FicheroImportacionCtrl
    
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnDestroyForm = FormManagerDestroyForm
    OnOkButton = FormManagerOkButton
    Left = 630
    Top = 248
  end
  object ConfiguracionTable: TnxeTable
    ActiveRuntime = True
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    TableName = 'Configuracion'
    IndexFieldNames = 'Aplicacion;Tipo;Codigo'
    Left = 535
    Top = 248
    object ConfiguracionTableAplicacion: TSmallintField
      FieldName = 'Aplicacion'
    end
    object ConfiguracionTableTipo: TSmallintField
      FieldName = 'Tipo'
    end
    object ConfiguracionTableCodigo: TWideStringField
      FieldName = 'Codigo'
    end
    object ConfiguracionTableData: TBlobField
      FieldName = 'Data'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 567
    Top = 248
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 599
    Top = 248
    object DataFicheroImportacion: TWideStringField
      FieldName = 'FicheroImportacion'
      Size = 80
    end
    object dataCampoObra: TSmallintField
      FieldName = 'CampoObra'
    end
    object dataCPNroAlbaran: TSmallintField
      FieldName = 'CPNroAlbaran'
    end
    object dataCLNroAlbaran: TSmallintField
      FieldName = 'CLNroAlbaran'
    end
    object dataCPCliente: TSmallintField
      FieldName = 'CPCliente'
    end
    object dataCLCliente: TSmallintField
      FieldName = 'CLCliente'
    end
    object dataCPObra: TSmallintField
      FieldName = 'CPObra'
    end
    object dataCLObra: TSmallintField
      FieldName = 'CIObra'
    end
    object dataCPTarifa: TSmallintField
      FieldName = 'CPTarifa'
    end
    object dataCLTarifa: TSmallintField
      FieldName = 'CLTarifa'
    end
    object dataCPFecha: TSmallintField
      FieldName = 'CpFecha'
    end
    object dataCLFecha: TSmallintField
      FieldName = 'CIFecha'
    end
    object dataCPArticulo1: TSmallintField
      FieldName = 'CPArticulo1'
    end
    object dataCLArticulo1: TSmallintField
      FieldName = 'CLArticulo1'
    end
    object dataCPCantidad1: TSmallintField
      FieldName = 'CPCantidad1'
    end
    object dataCLCantidad1: TSmallintField
      FieldName = 'CLCantidad1'
    end
    object dataCPArticulo2: TSmallintField
      FieldName = 'CPArticulo2'
    end
    object dataCLArticulo2: TSmallintField
      FieldName = 'CLArticulo2'
    end
    object dataCPCantidad2: TSmallintField
      FieldName = 'CPCantidad2'
    end
    object dataCLCantidad2: TSmallintField
      FieldName = 'CLCantidad2'
    end
    object dataCPArticulo3: TSmallintField
      FieldName = 'CPArticulo3'
    end
    object dataCLArticulo3: TSmallintField
      FieldName = 'CLArticulo3'
    end
    object dataCPCantidad3: TSmallintField
      FieldName = 'CPCantidad3'
    end
    object dataCLCantidad3: TSmallintField
      FieldName = 'CLCantidad3'
    end
    object DataCPArticulo4: TSmallintField
      FieldName = 'CPArticulo4'
    end
    object DataCLArticulo4: TSmallintField
      FieldName = 'CLArticulo4'
    end
    object DataCPCantidad4: TSmallintField
      FieldName = 'CPCantidad4'
    end
    object DataCLCantidad4: TSmallintField
      FieldName = 'CLCantidad4'
    end
    object DataCPArticulo5: TSmallintField
      FieldName = 'CPArticulo5'
    end
    object DataCLArticulo5: TSmallintField
      FieldName = 'CLArticulo5'
    end
    object DataCPCantidad5: TSmallintField
      FieldName = 'CPCantidad5'
    end
    object DataCLCantidad5: TSmallintField
      FieldName = 'CLCantidad5'
    end
    object DataCPArticulo6: TSmallintField
      FieldName = 'CPArticulo6'
    end
    object DataCLArticulo6: TSmallintField
      FieldName = 'CLArticulo6'
    end
    object DataCPCantidad6: TSmallintField
      FieldName = 'CPCantidad6'
    end
    object DataCLCantidad6: TSmallintField
      FieldName = 'CLCantidad6'
    end
  end
end
