
{$C FIXED PRELOAD PERMANENT }
{$R INSTALAR.RES}

uses	Objects, Windows, Strings, OWindows, ODialogs, ToolBar, Win31;


const  cm_Bar           = 1;
       wm_process       = 100;
       id_init          = 99;

Type   string80 = string[ 80 ];

       PMainApplication = ^TMainApplication;
       TMainApplication = object( TApplication )
          Procedure InitMainWindow; virtual;
          end;

        PMainWindow  = ^TMainWindow;
        TMainWindow  = object( TWindow )


          constructor init( aTitle : PChar );

          procedure getWindowClass( var AWndClass: TWndClass ); virtual id_internal + 12;
          function  getClassName : pChar;                       virtual id_internal + 10;
          Procedure setupWindow;                                virtual id_internal + 13;
          Procedure WMCommand( var Msg : TMessage );            virtual wm_First + wm_Command;
          end;

         pchargeDlg = ^chargeDlg;
         chargeDlg  = object( TDialog )
           constructor init;
           destructor done; virtual;
           procedure  WMProcess( var msg : tMessage ); virtual wm_first + wm_process;
           procedure  setupWindow; virtual id_internal + 13;
           function copyFile( source, target : string80; notifyIfAbsent, overWrite : boolean ) : boolean;
           end;

Var	aplication     : TMainApplication;
        mainWndHandle  : hWnd;
        chargeDlgPtr   : PchargeDlg;


procedure TMainApplication.initMainWindow;
begin
     mainWindow := new( pMainWindow, init( 'Cargador de GESTWIN' ) );
end;

constructor TMainWindow.init( ATitle : PChar );
begin
     inherited Init( nil, ATitle );
     With Attr do
       begin
       Style := ws_PopupWindow;
       X     := 0;
       Y     := 0;
       W     := 0;
       H     := 0;
       end;
end;

procedure TMainWindow.setupWindow;
begin
     inherited setupWindow;
     postMessage( HWindow, wm_command, id_init, 0 );
end;

Procedure TMainWindow.getWindowClass( var AWndClass : TWndClass );
begin
     inherited getWindowClass( aWndClass );
     aWndClass.hbrBackground := color_AppWorkSpace + 1;
     aWndClass.hIcon         := 0;
     aWndClass.hIcon         := loadIcon( hInstance, 'ICON' );
end;

function TMainWindow.getClassName : pChar;
begin
     getClassName := 'GWCharger';
end;

procedure TMainWindow.WMCommand( var Msg : TMessage );

Var   r          : tRect;
      st         : string;
      cmRes,
      cmPos      : byte;

begin
     case msg.wParam of
        id_init  : begin
                   chargeDlgPtr := new( pchargeDlg, init );
                   application^.execDialog( chargeDlgPtr );
                   end;
       end;
   defWndProc( msg );
end;

{ chargeDlg ------------------------------------------------------------------------------- }

constructor chargeDlg.init;
begin
     inherited init( nil, 'B_CHR' );
end;

destructor chargeDlg.done;
begin
     inherited done;
     chargeDlgPtr := nil;
end;

procedure chargeDlg.setupWindow;
begin
     inherited setupWindow;
     postMessage( hWindow, wm_process, 0, 0 );
end;

procedure  chargeDlg.WMProcess( var msg : tMessage );

Var   unidadOrigen  : string[ 2 ];
      pathDestino   : string[ 80 ];
      strC          : array[ 0..80 ] of char;

begin
     unidadOrigen := copy( paramStr( 0 ), 1, 2 );
     unidadOrigen[ 1 ] := upcase( unidadOrigen[ 1 ] );
     If   not ( unidadOrigen[ 1 ] in [ 'A', 'B' ] )
     then unidadOrigen := 'A:';

     getWindowsDirectory( strC, 80 );
     pathDestino := strPas( strC );

     If   copyFile( unidadOrigen + '\GWINST.EXE', pathDestino + '\GWINST.EXE', true, true )  and
          copyFile( unidadOrigen + '\BWCC.~DL',   pathDestino + '\BWCC.DLL',   true, false )
     then begin
          strPCopy( strC, pathDestino + '\GWINST.EXE ' + unidadOrigen );
          winExec( strC, sw_show );
          end;

     postQuitMessage( 0 );
end;

function chargeDlg.copyFile( source,
                             target          : string80;
                             notifyIfAbsent,
                             overWrite       : boolean ) : boolean;

Const bufferSize   = 4096;

Var   sourceFile,
      targetFile   : file;
      readBytes,
      writeBytes   : word;
      buf          : array[ 1..bufferSize ] of char;
      result       : integer;
      correct,
      wildCards    : boolean;
      strC         : array[ 0..80 ] of char;

begin

     correct := false;

     assign( targetFile, target );
     reset( targetFile, 1 );
     result := IoResult;
     If   result=0
     then begin
          close( targetFile );
          If   not overWrite
          then exit;
          end;

     assign( sourceFile, source );
     reset( sourceFile, 1 );
     result := IoResult;
     If   result=0
     then begin
          rewrite( targetFile, 1 );
          repeat
            blockRead( sourceFile, buf, bufferSize, readBytes );
            blockWrite( targetFile, buf, readBytes, writeBytes );
          until ( readBytes=0 ) or ( writeBytes<>readBytes );
          close( sourceFile );
          close( targetFile );
          correct := true;
          end
     else If   notifyIfAbsent
          then messageBox( hWindow, 'Fichero no encontrado', 'ERROR', mb_iconStop or mb_ok );

     copyFile := correct;
end;

begin
     aplication.init( 'GESTWIN' );
     aplication.run;
     aplication.done;
end.
