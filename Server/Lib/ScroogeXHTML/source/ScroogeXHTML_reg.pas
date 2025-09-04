(*
 ------------------------------------------------------------------------------

 ScroogeXHTML 6.4
 RTF to HTML / XHTML converter component for Delphi

 Copyright (c) 1998 - 2013 Michael Justin
 http://www.habarisoft.com/
 ------------------------------------------------------------------------------
*)


(**
 * The Component registration unit
 *)
unit ScroogeXHTML_reg;

interface

(**
 * The Component registration method
 *)
procedure Register;

implementation

uses
  ScroogeXHTML,
  Classes;

procedure Register;
begin
  RegisterComponents('Habarisoft', [TBTScroogeXHTML]);
end;

(** \mainpage RTF to (X)HTML converter
 *
 * \section intro Introduction
 *
 * ScroogeXHTML for Delphi is a component which converts RTF data stored in
 * files, strings or a RichEdit component to HTML 4.01, HTML5 and XHTML.
 * It is fast, easy to customize and use and comes with full source code.
 *
 * \li TSxBase - documentation of properties
 * \li TSxMain - documentation of core conversion method
 * \li TCustomScrooge - documentation of additional conversion methods
 *
 * Additional information:
 * \li \subpage version
 *
 * Copyright (c) 1998-2013 Michael Justin
 * http://www.habarisoft.com/
 *
 * \section warranty Limited Warranty
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS. HABARISOFT DISCLAIMS ALL
 * WARRANTIES RELATING TO THIS SOFTWARE, WHETHER EXPRESS OR IMPLIED, INCLUDING
 * BUT NOT LIMITED TO ANY IMPLIED WARRANTIES OF MERCHANTABILITY OR FITNESS FOR
 * A PARTICULAR PURPOSE. NEITHER HABARISOFT NOR ANYONE ELSE WHO HAS BEEN INVOLVED
 * IN THE CREATION, PRODUCTION, OR DELIVERY OF THIS SOFTWARE SHALL BE LIABLE
 * FOR ANY INDIRECT, CONSEQUENTIAL, OR INCIDENTAL DAMAGES ARISING OUT OF THE
 * USE OR INABILITY TO USE SUCH SOFTWARE, EVEN IF HABARISOFT HAS BEEN ADVISED OF
 * THE POSSIBILITY OF SUCH DAMAGES OR CLAIMS. THE PERSON USING THE SOFTWARE
 * BEARS ALL RISK AS TO THE QUALITY AND PERFORMANCE OF THE SOFTWARE.
 *
 * \section trademarks Trademarks
 *
 * Habari is a registered trademark of Michael Justin and is protected by the laws of Germany and other countries.
 * Embarcadero, the Embarcadero Technologies logos and all other Embarcadero Technologies product or service names are trademarks, servicemarks, and/or registered trademarks of Embarcadero Technologies, Inc.
 * and are protected by the laws of the United States and other countries.
 * Oracle and Java are registered trademarks of Oracle and/or its affiliates.
 * Microsoft, Windows, Windows NT, and/or other Microsoft products referenced herein are either registered trademarks or trademarks of Microsoft Corporation in the United States and/or other countries.
 * Other brands and their products are trademarks of their respective holders.
 *)

 (**
  * \page version Release notes
  *
  * \section s6_4 Version 6.4 (released 2013-06-12)
  *
  * \li SCROOGE_NO_INDENT supresses HTML output indentation
  * \li Tested with Free Pascal 2.6.2
  * \li web demo build with Indy 10.6
  *
  * \page version Release notes
  * \section s6_3 Version 6.3 (released 2012-10-23)
  *
  * \li added support for aligned list items (right, centered, justified)
  * \li fixed WMF picture adapter  
  * \li removed unused code
  * \li removed "Extended RTTI suppression" 
  *
  * \section s6_2 Version 6.2 (released 2012-09-04)
  *
  * \li Free Pascal fix for a bug introduced by "Extended RTTI suppression"
  * \li Deprecated properties and methods in SxBase have been removed
  *
  * \section s6_1 Version 6.1 (released 2012-05-08)
  * \li Extended RTTI (Delphi 2010 and newer) is disabled by default and can be
  *     enabled with the new conditional symbol SX_USE_RTTI
  * \li Deprecated properties and methods in SxBase are commented out
  * \li Documentation generated with doxygen 1.8.0
  * \li Compiles with Free Pascal 2.6.0
  * \li Unicode migration: removed unneccessary string() conversions
  * \li The component appears in the "Habarisoft" palette page now (instead of "BetaTools")
  *
  * \section s6_0 Version 6.0 (released 2011-12-13)
  * \li Fixed compiler warnings
  * \li Fixed package projects
  * \li Removed support for non-Unicode Delphi
  * \li Removed XHTML5 document type
  * \li Conversion returns UTF8String
  *)

end.

