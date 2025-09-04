inherited frxPDFExportDialog: TfrxPDFExportDialog
  Left = 758
  Top = 291
  ClientHeight = 561
  ClientWidth = 487
  Font.Height = -12
  OnKeyDown = nil
  ExplicitWidth = 503
  ExplicitHeight = 600
  TextHeight = 15
  inherited PageControl1: TcxPageControl
    Tag = 107
    Width = 481
    Height = 515
    Anchors = [akLeft, akTop, akBottom]
    ExplicitWidth = 481
    ExplicitHeight = 515
    ClientRectBottom = 511
    ClientRectRight = 477
    ClientRectTop = 26
    inherited ExportPage: TcxTabSheet
      ExplicitTop = 26
      ExplicitWidth = 473
      ExplicitHeight = 485
      inherited GroupPageRange: TcxGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 3
        ExplicitLeft = 3
        ExplicitTop = 3
        ExplicitWidth = 467
        ExplicitHeight = 137
        Height = 137
        Width = 467
        inherited DescrL: TcxLabel
          Top = 96
          ExplicitTop = 97
          ExplicitWidth = 436
          ExplicitHeight = 36
          Height = 36
          Width = 436
        end
        inherited AllRB: TcxRadioButton
          ExplicitWidth = 32
          ExplicitHeight = 19
        end
        inherited CurPageRB: TcxRadioButton
          ExplicitWidth = 87
          ExplicitHeight = 19
        end
        inherited PageNumbersRB: TcxRadioButton
          ExplicitWidth = 52
          ExplicitHeight = 19
        end
        inherited PageNumbersE: TcxTextEdit
          Left = 136
          ExplicitLeft = 136
          ExplicitHeight = 23
        end
      end
      inherited GroupQuality: TcxGroupBox
        Top = 146
        ExplicitTop = 137
        ExplicitWidth = 467
        ExplicitHeight = 258
        Height = 249
        Width = 467
        object Label2: TcxLabel
          Tag = 8602
          Left = 12
          Top = 149
          Caption = 'JPEG Quality'
          TabOrder = 11
          Transparent = True
        end
        object PDFStandardLabel: TcxLabel
          Tag = 8710
          Left = 12
          Top = 27
          Caption = 'PDF Standard:'
          TabOrder = 12
          Transparent = True
        end
        object PDFVersionLabel: TcxLabel
          Tag = 8711
          Left = 12
          Top = 52
          Caption = 'PDF Version:'
          TabOrder = 13
          Transparent = True
        end
        object FontGLB: TcxLabel
          Left = 29
          Top = 199
          Caption = 'S'#237'mbolos'
          TabOrder = 14
          Transparent = True
        end
        object PDFStandardComboBox: TcxComboBox
          Left = 136
          Top = 24
          TabOrder = 0
          Width = 117
        end
        object PDFVersionComboBox: TcxComboBox
          Left = 136
          Top = 49
          TabOrder = 1
          Width = 117
        end
        object CompressedCB: TcxCheckBox
          Tag = 8712
          Left = 14
          Top = 83
          Caption = 'Compressed'
          Style.TransparentBorder = False
          TabOrder = 2
          Transparent = True
        end
        object EmbeddedCB: TcxCheckBox
          Tag = 8702
          Left = 14
          Top = 103
          Caption = 'Embedded fonts'
          State = cbsChecked
          Style.TransparentBorder = False
          TabOrder = 3
          Transparent = True
        end
        object PrintOptCB: TcxCheckBox
          Left = 212
          Top = 83
          Caption = 'Optimizado para impresi'#243'n'
          Style.TransparentBorder = False
          TabOrder = 5
          Transparent = True
        end
        object OutlineCB: TcxCheckBox
          Tag = 8704
          Left = 212
          Top = 103
          Caption = 'Outline'
          State = cbsChecked
          Style.TransparentBorder = False
          TabOrder = 6
          Transparent = True
        end
        object BackgrCB: TcxCheckBox
          Tag = 8705
          Left = 14
          Top = 123
          Caption = 'Background'
          State = cbsChecked
          Style.TransparentBorder = False
          TabOrder = 4
          Transparent = True
        end
        object TransparentCB: TcxCheckBox
          Tag = 8709
          Left = 212
          Top = 123
          Caption = 'Transparency'
          Style.TransparentBorder = False
          TabOrder = 7
          Transparent = True
        end
        object IFormsCB: TcxCheckBox
          Left = 14
          Top = 177
          Hint = 'Formularios interactivos'
          Caption = 'Formularios interactivos'
          Style.TransparentBorder = False
          TabOrder = 9
          Transparent = True
          OnClick = IFormsCBClick
        end
        object QualityEdit: TcxTextEdit
          Left = 136
          Top = 148
          TabOrder = 8
          Text = '100'
          Width = 53
        end
        object FSubsetED: TcxTextEdit
          Left = 136
          Top = 198
          TabOrder = 10
          Width = 117
        end
      end
      inherited SaveToGroupBox: TcxGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 401
        ExplicitLeft = 3
        ExplicitTop = 401
        ExplicitWidth = 467
        Width = 467
        inherited FiltersNameCB: TcxComboBox
          ExplicitWidth = 457
          ExplicitHeight = 23
          Width = 457
        end
        inherited OpenCB: TcxCheckBox
          Style.TransparentBorder = False
          ExplicitWidth = 110
          ExplicitHeight = 19
        end
      end
    end
    object InfoPage: TcxTabSheet
      Tag = 8972
      Caption = 'Information'
      ImageIndex = 1
      object DocInfoGB: TcxGroupBox
        Tag = 8971
        AlignWithMargins = True
        Left = 3
        Top = 3
        Align = alTop
        Caption = 'Document information'
        TabOrder = 0
        Height = 196
        Width = 467
        object TitleL: TcxLabel
          Tag = 8973
          Left = 12
          Top = 23
          Caption = 'Title'
          TabOrder = 6
          Transparent = True
        end
        object AuthorL: TcxLabel
          Tag = 8974
          Left = 12
          Top = 48
          Caption = 'Author'
          TabOrder = 7
          Transparent = True
        end
        object SubjectL: TcxLabel
          Tag = 8975
          Left = 12
          Top = 73
          Caption = 'Subject'
          TabOrder = 8
          Transparent = True
        end
        object KeywordsL: TcxLabel
          Tag = 8976
          Left = 12
          Top = 98
          Caption = 'Keywords'
          TabOrder = 9
          Transparent = True
        end
        object CreatorL: TcxLabel
          Tag = 8977
          Left = 12
          Top = 123
          Caption = 'Creator'
          TabOrder = 10
          Transparent = True
        end
        object ProducerL: TcxLabel
          Tag = 8978
          Left = 12
          Top = 148
          Caption = 'Producer'
          TabOrder = 11
          Transparent = True
        end
        object TitleE: TcxTextEdit
          Left = 108
          Top = 22
          TabOrder = 0
          Width = 152
        end
        object AuthorE: TcxTextEdit
          Left = 108
          Top = 47
          TabOrder = 1
          Width = 152
        end
        object SubjectE: TcxTextEdit
          Left = 108
          Top = 72
          TabOrder = 2
          Width = 152
        end
        object KeywordsE: TcxTextEdit
          Left = 108
          Top = 97
          TabOrder = 3
          Width = 152
        end
        object CreatorE: TcxTextEdit
          Left = 108
          Top = 122
          TabOrder = 4
          Width = 152
        end
        object ProducerE: TcxTextEdit
          Left = 108
          Top = 147
          TabOrder = 5
          Width = 152
        end
      end
    end
    object SecurityPage: TcxTabSheet
      Tag = 8962
      Caption = 'Security'
      ImageIndex = 2
      object SecGB: TcxGroupBox
        Tag = 8979
        AlignWithMargins = True
        Left = 3
        Top = 3
        Align = alTop
        Caption = 'Authentification'
        TabOrder = 1
        Height = 92
        Width = 467
        object OwnPassL: TcxLabel
          Tag = 8964
          Left = 12
          Top = 23
          Caption = 'Owner password'
          TabOrder = 2
          Transparent = True
        end
        object UserPassL: TcxLabel
          Tag = 8965
          Left = 13
          Top = 48
          Caption = 'User password'
          TabOrder = 3
          Transparent = True
        end
        object OwnPassE: TcxTextEdit
          Left = 177
          Top = 22
          TabOrder = 0
          Width = 116
        end
        object UserPassE: TcxTextEdit
          Left = 177
          Top = 47
          TabOrder = 1
          Width = 116
        end
      end
      object PermGB: TcxGroupBox
        Tag = 8980
        AlignWithMargins = True
        Left = 3
        Top = 101
        Align = alTop
        Caption = 'Permissions'
        TabOrder = 0
        Height = 145
        Width = 467
        object PrintCB: TcxCheckBox
          Tag = 8966
          Left = 12
          Top = 25
          Caption = 'Print the document'
          State = cbsChecked
          Style.TransparentBorder = False
          TabOrder = 0
          Transparent = True
        end
        object ModCB: TcxCheckBox
          Tag = 8967
          Left = 12
          Top = 49
          Caption = 'Modify the document'
          State = cbsChecked
          Style.TransparentBorder = False
          TabOrder = 1
          Transparent = True
        end
        object CopyCB: TcxCheckBox
          Tag = 8968
          Left = 12
          Top = 72
          Caption = 'Copy of text and graphics'
          State = cbsChecked
          Style.TransparentBorder = False
          TabOrder = 2
          Transparent = True
        end
        object AnnotCB: TcxCheckBox
          Tag = 8969
          Left = 12
          Top = 95
          Caption = 'Add or modify text annotations'
          State = cbsChecked
          Style.TransparentBorder = False
          TabOrder = 3
          Transparent = True
        end
      end
    end
    object ViewerPage: TcxTabSheet
      Tag = 8981
      Caption = 'Viewer'
      ImageIndex = 3
      object ViewerGB: TcxGroupBox
        Tag = 8982
        AlignWithMargins = True
        Left = 3
        Top = 3
        Align = alTop
        Caption = 'Viewer preferences'
        TabOrder = 0
        Height = 191
        Width = 467
        object HideToolbarCB: TcxCheckBox
          Tag = 8983
          Left = 12
          Top = 28
          Caption = 'Hide toolbar'
          Style.TransparentBorder = False
          TabOrder = 0
          Transparent = True
        end
        object HideMenubarCB: TcxCheckBox
          Tag = 8984
          Left = 12
          Top = 52
          Caption = 'Hide menubar'
          Style.TransparentBorder = False
          TabOrder = 1
          Transparent = True
        end
        object HideWindowUICB: TcxCheckBox
          Tag = 8985
          Left = 12
          Top = 76
          Caption = 'Hide window user interface'
          Style.TransparentBorder = False
          TabOrder = 2
          Transparent = True
        end
        object FitWindowCB: TcxCheckBox
          Tag = 8986
          Left = 12
          Top = 100
          Caption = 'Fit window'
          Style.TransparentBorder = False
          TabOrder = 3
          Transparent = True
        end
        object CenterWindowCB: TcxCheckBox
          Tag = 8987
          Left = 12
          Top = 124
          Caption = 'Center window'
          Style.TransparentBorder = False
          TabOrder = 4
          Transparent = True
        end
        object PrintScalingCB: TcxCheckBox
          Tag = 8988
          Left = 12
          Top = 148
          Caption = 'Print scaling'
          Style.TransparentBorder = False
          TabOrder = 5
          Transparent = True
        end
      end
    end
    object SignaturePage: TcxTabSheet
      Tag = 8716
      Caption = 'Signature'
      ImageIndex = 4
      object SignatureDataGB: TcxGroupBox
        Tag = 8725
        AlignWithMargins = True
        Left = 3
        Top = 3
        Align = alTop
        Caption = 'Datos de la firma'
        TabOrder = 0
        Height = 116
        Width = 467
        object LocationL: TcxLabel
          Left = 12
          Top = 23
          Caption = 'Lugar'
          TabOrder = 3
          Transparent = True
        end
        object ReasonL: TcxLabel
          Left = 12
          Top = 48
          Caption = 'Motivo'
          TabOrder = 4
          Transparent = True
        end
        object ContactL: TcxLabel
          Left = 13
          Top = 73
          Caption = 'Contacto'
          TabOrder = 5
          Transparent = True
        end
        object LocationE: TcxTextEdit
          Left = 115
          Top = 22
          TabOrder = 0
          Width = 152
        end
        object ReasonE: TcxTextEdit
          Left = 115
          Top = 47
          TabOrder = 1
          Width = 152
        end
        object ContactE: TcxTextEdit
          Left = 115
          Top = 72
          TabOrder = 2
          Width = 152
        end
      end
      object CertificateGB: TcxGroupBox
        Tag = 8722
        AlignWithMargins = True
        Left = 3
        Top = 125
        Align = alTop
        Caption = 'Certificado'
        TabOrder = 1
        Transparent = True
        Height = 103
        Width = 467
        object CertificateFileL: TcxLabel
          Left = 12
          Top = 30
          Caption = 'Fichero:'
          TabOrder = 2
          Transparent = True
        end
        object CertificatePasswordL: TcxLabel
          Left = 12
          Top = 55
          Caption = 'Palabra de paso'
          TabOrder = 3
          Transparent = True
        end
        object CertificateFileE: TcxTextEdit
          Left = 115
          Top = 29
          TabOrder = 0
          Width = 199
        end
        object CertificatePasswordE: TcxTextEdit
          Left = 115
          Top = 54
          TabOrder = 1
          Width = 152
        end
        object CertificateFileB: TcxButton
          Left = 320
          Top = 24
          Width = 112
          Height = 33
          Caption = 'Seleccionar ...'
          OptionsImage.Glyph.SourceDPI = 96
          OptionsImage.Glyph.SourceHeight = 18
          OptionsImage.Glyph.SourceWidth = 18
          OptionsImage.Glyph.Data = {
            3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554
            462D38223F3E0D0A3C7376672076657273696F6E3D22312E31222069643D224C
            617965725F312220786D6C6E733D22687474703A2F2F7777772E77332E6F7267
            2F323030302F7376672220786D6C6E733A786C696E6B3D22687474703A2F2F77
            77772E77332E6F72672F313939392F786C696E6B2220783D223070782220793D
            22307078222077696474683D223234707822206865696768743D223234707822
            2076696577426F783D223020302032342032342220656E61626C652D6261636B
            67726F756E643D226E6577203020302032342032342220786D6C3A7370616365
            3D227072657365727665223E262331303B20203C672069643D2269636F6E2220
            786D6C3A73706163653D227072657365727665223E262331333B262331303B3C
            7061746820643D224D392E383037372C332E363238384C382E353838332C322E
            3430393443382E333236322C322E313437332C372E393730372C322C372E362C
            3248312E3938373543312E343432312C322C312C322E343432312C312C322E39
            3837355632316C342C2D316C31362C2D39563563302C2D302E353532332C2D30
            2E343832322C2D312C2D312E303334352C2D31682D392E323631364331302E33
            3637382C342C31302E303435342C332E383636352C392E383037372C332E3632
            38387A222066696C6C3D2223433138463336222F3E0D0A3C7265637420783D22
            332220793D2236222077696474683D22313622206865696768743D2231312E31
            222066696C6C3D2223463646374642222F3E0D0A3C7061746820643D224D332E
            363039362C392E373038334C312E303331342C32302E3838303743302E383939
            322C32312E343533332C312E333334312C32322C312E393231382C3232683137
            2E3538353863302E343235352C302C302E373934372C2D302E323933372C302E
            383930342C2D302E373038336C322E353738322C2D31312E313732344332332E
            313038332C392E353436372C32322E363733352C392C32322E303835382C3948
            342E3543342E303734352C392C332E373035332C392E323933372C332E363039
            362C392E373038337A222066696C6C3D2223463642423433222F3E0D0A3C7061
            746820643D224D32322E303835382C39682D332E333438316C2D382E3438352C
            313368392E3235343963302E343235352C302C302E373934372C2D302E323732
            372C302E383930342C2D302E363537376C322E353738322C2D31312E33303239
            4332332E313038332C392E353037362C32322E363733352C392C32322E303835
            382C397A222066696C6C3D222343313846333622206F7061636974793D22302E
            32222F3E0D0A093C2F673E0D0A3C2F7376673E0D0A}
          OptionsImage.Margin = 6
          TabOrder = 4
          OnClick = CertificateFileBClick
        end
      end
    end
  end
  inherited ButtonsGroupBox: TcxGroupBox
    Top = 521
    ExplicitTop = 521
    ExplicitWidth = 487
    Width = 487
    inherited CancelB: TcxButton
      Left = 392
      ExplicitLeft = 392
    end
    inherited OkB: TcxButton
      Left = 296
      ExplicitLeft = 296
    end
  end
  object CertificateOD: TOpenDialog
    Filter = 
      'Todos los certificados soportados|*.pfx;*.p12|Fichero de certifi' +
      'cado PFX|*.pfx|Fichero de certificado P12|*.p12'
    Left = 418
    Top = 47
  end
end
