object RptCpnForm: TRptCpnForm
  Left = 366
  Top = 246
  HelpType = htKeyword
  HelpKeyword = 'l_cpn'
  HelpContext = 1122
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Estado de cambios en el patrimonio neto'
  ClientHeight = 184
  ClientWidth = 480
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
    Height = 143
    Width = 470
    object cxGroupBox1: TcxGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 5
      Align = alClient
      Caption = 'Informaci'#243'n'
      Style.TextStyle = [fsBold]
      TabOrder = 0
      Height = 133
      Width = 460
      object cxLabel1: TcxLabel
        AlignWithMargins = True
        Left = 10
        Top = 22
        Margins.Left = 8
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alClient
        Caption = 
          'Este informe genera el Estado de Cambios en el Patrimonio Neto e' +
          'spec'#237'fico para PYMES que, junto con el Balance de Situaci'#243'n, la ' +
          'Cuenta de P'#233'rdidas y Ganancias y la Memoria son los documentos q' +
          'ue forman parte de las cuentas anuales.'
        Properties.WordWrap = True
        Transparent = True
        Width = 445
      end
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 148
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      480
      36)
    Height = 36
    Width = 480
    object Panel3: TcxGroupBox
      Left = 155
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
    Model = fmReportForm
    ShowQueryOption = False
    OnOkButton = FormManagerOkButton
    Left = 366
    Top = 6
  end
  object Report: TgxReportManager
    FileName = 'dm10\l_cpn'
    HideReportList = False
    SQLItems = <
      item
        Title = 'EstadoCambios'
        SQLText = 
          'CREATE TABLE <TableName> ('#13#10'Nivel SMALLINT,'#13#10'Titulo1 NVARCHAR(12' +
          '0),'#13#10'Titulo2 NVARCHAR(120),'#13#10'Titulo3 NVARCHAR(120),'#13#10'Titulo4 NVA' +
          'RCHAR(120),'#13#10'Titulo5 NVARCHAR(120),'#13#10'Titulo6 NVARCHAR(120),'#13#10'Tit' +
          'ulo7 NVARCHAR(120),'#13#10'Titulo8 NVARCHAR(120),'#13#10'Titulo9 NVARCHAR(12' +
          '0),'#13#10'Titulo10 NVARCHAR(120),'#13#10'Titulo11 NVARCHAR(120),'#13#10'Titulo12 ' +
          'NVARCHAR(120),'#13#10'Titulo13 NVARCHAR(120),'#13#10'Titulo14 NVARCHAR(120),' +
          #13#10'Titulo15 NVARCHAR(120),    '#13#10'Valor1 BCD(16,4),'#13#10'Valor2 BCD(16,' +
          '4),'#13#10'Valor3 BCD(16,4),'#13#10'Valor4 BCD(16,4) ,'#13#10'Valor5 BCD(16,4),'#13#10'V' +
          'alor6 BCD(16,4),'#13#10'Valor7 BCD(16,4),'#13#10'Valor8 BCD(16,4),'#13#10'Valor9 B' +
          'CD(16,4) ,'#13#10'Valor10 BCD(16,4),'#13#10'Valor11 BCD(16,4),'#13#10'Valor12 BCD(' +
          '16,4),'#13#10'Valor13 BCD(16,4),'#13#10'Valor14 BCD(16,4),'#13#10'Valor15 BCD(16,4' +
          ') );'#13#10'  '#13#10
      end>
    ParamsDataset = Data
    ToPrinter = False
    BeforeStart = ReportBeforeStart
    Left = 335
    Top = 36
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 335
    Top = 6
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 302
    Top = 6
  end
end
