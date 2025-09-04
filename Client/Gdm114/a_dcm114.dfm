object MntDcm114Form: TMntDcm114Form
  Left = 369
  Top = 292
  HelpType = htKeyword
  HelpKeyword = 'a_dcm'
  HelpContext = 1106
  BorderStyle = bsDialog
  Caption = 'Documentos de control de mercanc'#237'as'
  ClientHeight = 584
  ClientWidth = 735
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs114'
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
    Height = 36
    Width = 735
    object NroOperacionCtrl: TcxDBIntegerEdit
      Left = 148
      Top = 6
      DataBinding.DataField = 'NroOperacion'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = NroOperacionCtrlPropertiesQueryRequest
      Properties.MaxLength = 8
      Properties.MaxValue = 99999999.000000000000000000
      Properties.MinValue = 1.000000000000000000
      TabOrder = 0
      Width = 57
    end
    object codigoCtrlCaption: TcxLabel
      Left = 20
      Top = 9
      TabStop = False
      Caption = 'N'#186' de operaci'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 548
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      735
      36)
    Height = 36
    Width = 735
    object Panel2: TcxGroupBox
      Left = 240
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
    Height = 512
    Width = 725
    object cxPageControl1: TcxPageControl
      Left = 2
      Top = 2
      Width = 721
      Height = 508
      Align = alClient
      TabOrder = 0
      TabStop = False
      Properties.ActivePage = cxTabSheet1
      Properties.CustomButtons.Buttons = <>
      ClientRectBottom = 504
      ClientRectLeft = 4
      ClientRectRight = 717
      ClientRectTop = 28
      object cxTabSheet1: TcxTabSheet
        Caption = 'Carga'
        ImageIndex = 0
        DesignSize = (
          713
          476)
        object CodigoNavieraCtrl: TcxDBTextEdit
          Left = 137
          Top = 3
          DescriptionLabel = cxLabel14
          DataBinding.DataField = 'CodigoNaviera'
          DataBinding.DataSource = DataSource
          Properties.Required = True
          Properties.OnQueryRequest = CompaniaCtrlPropertiesQueryRequest
          Properties.OnEditRequest = CompaniaCtrlPropertiesEditRequest
          Properties.TextEditPad = tpLeftZero
          Properties.PadAlways = True
          Properties.OnValidate = CompaniaCtrlPropertiesValidate
          TabOrder = 0
          Width = 35
        end
        object Label1: TcxLabel
          Left = 9
          Top = 6
          TabStop = False
          Caption = 'Naviera'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object cxLabel1: TcxLabel
          Left = 9
          Top = 61
          TabStop = False
          Caption = 'Tipo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object TipoCtrl: TcxDBIndexedComboBox
          Left = 137
          Top = 57
          DataBinding.DataField = 'Tipo'
          DataBinding.DataSource = DataSource
          Properties.DropDownListStyle = lsFixedList
          Properties.Items.Strings = (
            '20 pies'
            '40 pies')
          TabOrder = 2
          Width = 73
        end
        object cxLabel2: TcxLabel
          Left = 9
          Top = 87
          TabStop = False
          Caption = 'Destino'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object DestinoCtrl: TcxDBTextEdit
          Left = 137
          Top = 84
          DataBinding.DataField = 'Destino'
          DataBinding.DataSource = DataSource
          TabOrder = 3
          Width = 224
        end
        object cxGroupBox1: TcxGroupBox
          Left = 1
          Top = 112
          Anchors = [akLeft, akTop, akRight]
          PanelStyle.Active = True
          TabOrder = 4
          Height = 131
          Width = 709
          object cxLabel6: TcxLabel
            Left = 8
            Top = 64
            TabStop = False
            Caption = 'Lugar de origen'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object LugarOrigenCtrl: TcxDBTextEdit
            Left = 136
            Top = 61
            DataBinding.DataField = 'LugarOrigen'
            DataBinding.DataSource = DataSource
            TabOrder = 3
            Width = 221
          end
          object cxLabel8: TcxLabel
            Left = 8
            Top = 8
            TabStop = False
            Caption = 'Fecha de carga'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object FechaCargaCtrl: TcxDBDateEdit
            Left = 136
            Top = 5
            DataBinding.DataField = 'FechaCarga'
            DataBinding.DataSource = DataSource
            TabOrder = 0
            Width = 100
          end
          object cxLabel9: TcxLabel
            Left = 8
            Top = 37
            TabStop = False
            Caption = 'Plataforma'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object PlataformaCtrl: TcxDBIndexedComboBox
            Left = 136
            Top = 33
            DataBinding.DataField = 'Plataforma'
            DataBinding.DataSource = DataSource
            Properties.Alignment.Horz = taLeftJustify
            Properties.DropDownListStyle = lsFixedList
            Properties.Items.Strings = (
              'Indiferente'
              'Corta'
              'Larga')
            TabOrder = 1
            Width = 90
          end
          object cxLabel10: TcxLabel
            Left = 370
            Top = 64
            TabStop = False
            Caption = 'Lugar de destino'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object LugarDestinoCtrl: TcxDBTextEdit
            Left = 475
            Top = 61
            DataBinding.DataField = 'LugarDestino'
            DataBinding.DataSource = DataSource
            TabOrder = 4
            Width = 221
          end
          object cxLabel7: TcxLabel
            Left = 8
            Top = 91
            TabStop = False
            Caption = 'N'#186' de contenedor'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object NumeroContenedorCtrl: TcxDBTextEdit
            Left = 136
            Top = 90
            DataBinding.DataField = 'NumeroContenedor'
            DataBinding.DataSource = DataSource
            TabOrder = 5
            Width = 221
          end
          object cxLabel11: TcxLabel
            Left = 370
            Top = 93
            TabStop = False
            Caption = 'Precinto'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object PrecintoCtrl: TcxDBTextEdit
            Left = 475
            Top = 90
            DataBinding.DataField = 'Precinto'
            DataBinding.DataSource = DataSource
            TabOrder = 6
            Width = 221
          end
          object cxLabel22: TcxLabel
            Left = 370
            Top = 37
            TabStop = False
            Caption = 'Peso'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object PesoCtrl: TcxDBCurrencyEdit
            Left = 475
            Top = 33
            DataBinding.DataField = 'Peso'
            DataBinding.DataSource = DataSource
            Properties.DecimalPlaces = 0
            Properties.DisplayFormat = ',0;-,0'
            TabOrder = 2
            Width = 74
          end
          object cxLabel23: TcxLabel
            Left = 555
            Top = 37
            TabStop = False
            Caption = 'Kg.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
        end
        object cxLabel14: TcxLabel
          Left = 221
          Top = 6
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 486
        end
        object cxLabel16: TcxLabel
          Left = 9
          Top = 33
          TabStop = False
          Caption = 'Orden naviera'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object OrdenNavieraCtrl: TcxDBTextEdit
          Left = 137
          Top = 30
          DataBinding.DataField = 'OrdenNaviera'
          DataBinding.DataSource = DataSource
          TabOrder = 1
          Width = 143
        end
        object cxGroupBox2: TcxGroupBox
          Left = 1
          Top = 268
          Anchors = [akLeft, akTop, akRight, akBottom]
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 10
          Height = 205
          Width = 709
          object TableViewManager: TGridTableViewController
            Left = 669
            Top = 2
            Align = alRight
            Enabled = False
            PanelStyle.Active = True
            Style.BorderStyle = ebsNone
            Style.TransparentBorder = False
            TabOrder = 0
            TableView = GridView
            ShiftRecords = True
            UseGridFilterBox = False
            Height = 201
            Width = 38
          end
          object Grid: TcxGrid
            Left = 2
            Top = 2
            Width = 667
            Height = 201
            Align = alClient
            BorderStyle = cxcbsNone
            TabOrder = 1
            object GridView: TcxGridDBTableView
              Tag = 619710040
              Navigator.Buttons.CustomButtons = <>
              ScrollbarAnnotations.CustomAnnotations = <>
              DataController.DataSource = CargaDataSource
              DataController.KeyFieldNames = 'NroLinea'
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <
                item
                  Kind = skSum
                  FieldName = 'Importe'
                end>
              DataController.Summary.SummaryGroups = <>
              OptionsBehavior.PostponedSynchronization = False
              OptionsBehavior.FocusCellOnTab = True
              OptionsBehavior.FocusFirstCellOnNewRecord = True
              OptionsBehavior.FocusCellOnCycle = True
              OptionsBehavior.PullFocusing = True
              OptionsCustomize.ColumnFiltering = False
              OptionsCustomize.ColumnGrouping = False
              OptionsCustomize.ColumnHidingOnGrouping = False
              OptionsCustomize.ColumnMoving = False
              OptionsCustomize.ColumnSorting = False
              OptionsData.Appending = True
              OptionsData.DeletingConfirmation = False
              OptionsSelection.InvertSelect = False
              OptionsView.ColumnAutoWidth = True
              OptionsView.FooterAutoHeight = True
              OptionsView.GroupByBox = False
              OptionsView.Indicator = True
              object GridViewCodigoFabrica: TcxGridDBColumn
                Caption = 'F'#225'brica'
                DataBinding.FieldName = 'CodigoFabrica'
                PropertiesClassName = 'TcxTextEditProperties'
                Properties.Required = True
                Properties.OnQueryRequest = GridViewCodigoFabricaPropertiesQueryRequest
                Properties.OnEditRequest = GridViewCodigoFabricaPropertiesEditRequest
                Properties.OnValidate = GridViewCodigoFabricaPropertiesValidate
                Width = 60
              end
              object GridViewNombre: TcxGridDBColumn
                DataBinding.FieldName = 'Nombre'
                Options.Editing = False
                Options.Focusing = False
                Width = 295
              end
              object GridViewReferencia: TcxGridDBColumn
                DataBinding.FieldName = 'Referencia'
                Width = 177
              end
              object GridViewHora: TcxGridDBColumn
                DataBinding.FieldName = 'Hora'
                PropertiesClassName = 'TcxTimeEditProperties'
                Properties.TimeFormat = tfHourMin
                Width = 109
              end
            end
            object GridLevel: TcxGridLevel
              GridView = GridView
            end
          end
        end
        object cxLabel5: TcxLabel
          Left = 7
          Top = 249
          TabStop = False
          Caption = 'Puntos de carga'
          Style.TextColor = clGreen
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
      end
      object OperadoresTab: TcxTabSheet
        Caption = 'Operadores'
        ImageIndex = 2
        DesignSize = (
          713
          476)
        object cxLabel12: TcxLabel
          Left = 9
          Top = 13
          TabStop = False
          Caption = 'Transportista'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object CodigoTransportistaCtrl: TcxDBTextEdit
          Left = 137
          Top = 10
          DescriptionLabel = cxLabel13
          DataBinding.DataField = 'CodigoTransportista'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = CodigoTransportistaCtrlPropertiesQueryRequest
          Properties.OnEditRequest = CodigoTransportistaCtrlPropertiesEditRequest
          Properties.TextEditPad = tpLeftZero
          Properties.OnValidate = CodigoTransportistaCtrlPropertiesValidate
          TabOrder = 1
          Width = 33
        end
        object cxLabel13: TcxLabel
          Left = 197
          Top = 13
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 15
          Width = 513
        end
        object cxLabel15: TcxLabel
          Left = 9
          Top = 158
          TabStop = False
          Caption = 'Situaci'#243'n de la carga'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object SituacionCargaCtrl: TcxDBRadioGroup
          Left = 137
          Top = 154
          Alignment = alRightCenter
          DataBinding.DataField = 'SituacionCarga'
          DataBinding.DataSource = DataSource
          Properties.Columns = 4
          Properties.Items = <
            item
              Caption = 'Sin asignar'
              Value = '0'
            end
            item
              Caption = 'Asignado'
              Value = '1'
            end
            item
              Caption = 'Buz'#243'n'
              Value = '2'
            end
            item
              Caption = 'Terminado'
              Value = '3'
            end>
          Style.BorderStyle = ebsNone
          TabOrder = 6
          Height = 30
          Width = 388
        end
        object EditarAlbaranCompraButton: TgBitBtn
          Left = 280
          Top = 89
          Width = 85
          Height = 28
          Caption = 'Crear'
          Enabled = True
          OptionsImage.ImageIndex = 56
          OptionsImage.Images = ApplicationContainer.ButtonImageList
          OptionsImage.Margin = 4
          OptionsImage.Spacing = 5
          TabOrder = 4
          OnClick = EditarAlbaranCompraButtonClick
          GlyphBitmap = gmAddForm
        end
        object EditarAlbaranVentaButton: TgBitBtn
          Left = 280
          Top = 121
          Width = 85
          Height = 28
          Caption = 'Crear'
          Enabled = True
          OptionsImage.ImageIndex = 56
          OptionsImage.Images = ApplicationContainer.ButtonImageList
          OptionsImage.Margin = 4
          OptionsImage.Spacing = 5
          TabOrder = 5
          OnClick = EditarAlbaranVentaButtonClick
          GlyphBitmap = gmAddForm
        end
        object cxLabel19: TcxLabel
          Left = 9
          Top = 40
          TabStop = False
          Caption = 'Cliente'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object CodigoClienteCtrl: TcxDBTextEdit
          Left = 137
          Top = 37
          DescriptionLabel = cxLabel20
          DataBinding.DataField = 'CodigoCliente'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = CodigoClienteCtrlPropertiesQueryRequest
          Properties.OnEditRequest = CodigoClienteCtrlPropertiesEditRequest
          Properties.TextEditPad = tpLeftZero
          Properties.OnValidate = CodigoClienteCtrlPropertiesValidate
          TabOrder = 2
          Width = 46
        end
        object cxLabel20: TcxLabel
          Left = 197
          Top = 37
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 15
          Width = 513
        end
        object cxLabel17: TcxLabel
          Left = 9
          Top = 93
          TabStop = False
          Caption = 'Albar'#225'n de compra'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object cxLabel18: TcxLabel
          Left = 9
          Top = 125
          TabStop = False
          Caption = 'Albar'#225'n de venta'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object cxLabel21: TcxLabel
          Left = 9
          Top = 67
          TabStop = False
          Caption = 'Referencia cliente'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object ReferenciaClienteCtrl: TcxDBTextEdit
          Left = 137
          Top = 64
          CaptionLabel = cxLabel21
          DataBinding.DataField = 'ReferenciaCliente'
          DataBinding.DataSource = DataSource
          TabOrder = 3
          Width = 141
        end
        object ProveedorAlbaranCompraBox: TcxLabel
          Left = 137
          Top = 93
          Hint = 
            'Entregas a cuenta anotadas en los pedidos incluidos en este alba' +
            'r'#225'n.'
          TabStop = False
          AutoSize = False
          ParentShowHint = False
          ShowHint = True
          Style.BorderStyle = ebsSingle
          Style.Edges = [bBottom]
          Style.LookAndFeel.NativeStyle = False
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.NativeStyle = False
          Transparent = True
          Height = 21
          Width = 38
        end
        object SerieAlbaranCompraBox: TcxLabel
          Left = 181
          Top = 93
          Hint = 
            'Entregas a cuenta anotadas en los pedidos incluidos en este alba' +
            'r'#225'n.'
          TabStop = False
          AutoSize = False
          ParentShowHint = False
          ShowHint = True
          Style.BorderStyle = ebsSingle
          Style.Edges = [bBottom]
          Style.LookAndFeel.NativeStyle = False
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.NativeStyle = False
          Transparent = True
          Height = 21
          Width = 19
        end
        object NumeroAlbaranCompraBox: TcxLabel
          Left = 206
          Top = 93
          Hint = 
            'Entregas a cuenta anotadas en los pedidos incluidos en este alba' +
            'r'#225'n.'
          TabStop = False
          AutoSize = False
          ParentShowHint = False
          ShowHint = True
          Style.BorderStyle = ebsSingle
          Style.Edges = [bBottom]
          Style.LookAndFeel.NativeStyle = False
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.NativeStyle = False
          Transparent = True
          Height = 21
          Width = 63
        end
        object SerieAlbaranVentaBox: TcxLabel
          Left = 181
          Top = 123
          Hint = 
            'Entregas a cuenta anotadas en los pedidos incluidos en este alba' +
            'r'#225'n.'
          TabStop = False
          AutoSize = False
          ParentShowHint = False
          ShowHint = True
          Style.BorderStyle = ebsSingle
          Style.Edges = [bBottom]
          Style.LookAndFeel.NativeStyle = False
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.NativeStyle = False
          Transparent = True
          Height = 21
          Width = 19
        end
        object NumeroAlbaranVentaBox: TcxLabel
          Left = 206
          Top = 123
          Hint = 
            'Entregas a cuenta anotadas en los pedidos incluidos en este alba' +
            'r'#225'n.'
          TabStop = False
          AutoSize = False
          ParentShowHint = False
          ShowHint = True
          Style.BorderStyle = ebsSingle
          Style.Edges = [bBottom]
          Style.LookAndFeel.NativeStyle = False
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.NativeStyle = False
          Transparent = True
          Height = 21
          Width = 63
        end
      end
      object cxTabSheet2: TcxTabSheet
        Caption = 'Observaciones'
        ImageIndex = 1
        inline TAnnotationFrame1: TAnnotationFrame
          Left = 0
          Top = 0
          Width = 713
          Height = 476
          Align = alClient
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          ExplicitWidth = 713
          ExplicitHeight = 476
          inherited AnnotationPanel: TcxGroupBox
            ExplicitWidth = 713
            ExplicitHeight = 444
            Height = 444
            Width = 713
            inherited AnnotationRichEdit: TcxDBRichEdit
              DataBinding.DataField = 'Observaciones'
              DataBinding.DataSource = DataSource
              ExplicitWidth = 709
              ExplicitHeight = 399
              Height = 399
              Width = 709
            end
            inherited Ruler: TfrxRuler
              Width = 709
              ExplicitWidth = 709
            end
          end
          inherited ButtonsBar: TcxGroupBox
            ExplicitWidth = 713
            Width = 713
            inherited FontNameComboBox: TcxFontNameComboBox
              ExplicitHeight = 28
            end
            inherited FontSizeComboBox: TcxComboBox
              ExplicitHeight = 28
            end
          end
        end
      end
    end
  end
  object FormManager: TgxFormManager
    Dataset = DocumentoControlMercanciasTable
    FirstKeyControl = NroOperacionCtrl
    FirstDataControl = CodigoNavieraCtrl
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnCopyCurrentRecord = FormManagerCopyCurrentRecord
    OnReportRequest = FormManagerReportRequest
    OnReportFormRequest = FormManagerReportFormRequest
    OnGetAccessLevel = FormManagerGetAccessLevel
    OnUpdateButtonsState = FormManagerUpdateButtonsState
    Left = 610
    Top = 2
  end
  object DocumentoControlMercanciasTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    BeforePost = DocumentoControlMercanciasTableBeforePost
    BeforeDelete = DocumentoControlMercanciasTableBeforeDelete
    OnNewRecord = DocumentoControlMercanciasTableNewRecord
    TableName = 'DocumentoControlMercancias'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    AutoIncFieldName = 'NroOperacion'
    OnSetKey = DocumentoControlMercanciasTableSetKey
    OnRecordChanged = DocumentoControlMercanciasTableRecordChanged
    OnUpdateState = DocumentoControlMercanciasTableUpdateState
    OnGetAutoIncValue = DocumentoControlMercanciasTableGetAutoIncValue
    Left = 578
    Top = 2
    object DocumentoControlMercanciasTableEjercicio: TSmallintField
      FieldName = 'Ejercicio'
      Required = True
    end
    object DocumentoControlMercanciasTableNroOperacion: TIntegerField
      FieldName = 'NroOperacion'
      Required = True
    end
    object DocumentoControlMercanciasTableTipo: TSmallintField
      FieldName = 'Tipo'
    end
    object DocumentoControlMercanciasTableCodigoNaviera: TWideStringField
      FieldName = 'CodigoNaviera'
      Size = 2
    end
    object DocumentoControlMercanciasTableDestino: TWideStringField
      FieldName = 'Destino'
      Size = 30
    end
    object DocumentoControlMercanciasTableFechaCarga: TDateField
      FieldName = 'FechaCarga'
    end
    object DocumentoControlMercanciasTablePlataforma: TSmallintField
      FieldName = 'Plataforma'
    end
    object DocumentoControlMercanciasTableLugarOrigen: TWideStringField
      FieldName = 'LugarOrigen'
      Size = 40
    end
    object DocumentoControlMercanciasTableLugarDestino: TWideStringField
      FieldName = 'LugarDestino'
      Size = 40
    end
    object DocumentoControlMercanciasTablePeso: TBCDField
      FieldName = 'Peso'
      Precision = 16
    end
    object DocumentoControlMercanciasTableNumeroContenedor: TWideStringField
      FieldName = 'NumeroContenedor'
      FixedChar = True
      Size = 60
    end
    object DocumentoControlMercanciasTablePrecinto: TWideStringField
      FieldName = 'Precinto'
      FixedChar = True
      Size = 40
    end
    object DocumentoControlMercanciasTableCodigoCliente: TWideStringField
      FieldName = 'CodigoCliente'
      Size = 5
    end
    object DocumentoControlMercanciasTableReferenciaCliente: TWideStringField
      FieldName = 'ReferenciaCliente'
      Size = 40
    end
    object DocumentoControlMercanciasTableCodigoTransportista: TWideStringField
      FieldName = 'CodigoTransportista'
      Size = 2
    end
    object DocumentoControlMercanciasTableOrdenNaviera: TWideStringField
      FieldName = 'OrdenNaviera'
      Size = 40
    end
    object DocumentoControlMercanciasTableSituacionCarga: TSmallintField
      FieldName = 'SituacionCarga'
    end
    object DocumentoControlMercanciasTableNroOperacionCompra: TIntegerField
      FieldName = 'NroOperacionCompra'
    end
    object DocumentoControlMercanciasTableNroOperacionVenta: TIntegerField
      FieldName = 'NroOperacionVenta'
    end
    object DocumentoControlMercanciasTableObservaciones: TWideMemoField
      FieldName = 'Observaciones'
      BlobType = ftWideMemo
    end
  end
  object DataSource: TDataSource
    DataSet = DocumentoControlMercanciasTable
    Left = 546
    Top = 2
  end
  object MovimientoTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    Left = 578
    Top = 36
  end
  object CargaTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    OnCalcFields = CargaTableCalcFields
    TableName = 'Carga'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    MasterFields = 'Ejercicio;NroOperacion'
    MasterSource = DataSource
    AutoIncFieldName = 'NroLinea'
    MasterRelation = mrTied
    Left = 506
    Top = 4
    object CargaTableEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object CargaTableNroOperacion: TIntegerField
      FieldName = 'NroOperacion'
    end
    object CargaTableNroLinea: TSmallintField
      FieldName = 'NroLinea'
    end
    object CargaTableCodigoFabrica: TWideStringField
      FieldName = 'CodigoFabrica'
      Size = 4
    end
    object CargaTableNombre: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'Nombre'
      Size = 40
      Calculated = True
    end
    object CargaTableReferencia: TWideStringField
      FieldName = 'Referencia'
      Size = 40
    end
    object CargaTableHora: TTimeField
      FieldName = 'Hora'
    end
  end
  object CargaDataSource: TDataSource
    DataSet = CargaTable
    Enabled = False
    Left = 474
    Top = 6
  end
end
