{
*****************************************************************************
*                                                                           *
*  This file is part of the ZCAD                                            *
*                                                                           *
*  See the file COPYING.modifiedLGPL.txt, included in this distribution,    *
*  for details about the copyright.                                         *
*                                                                           *
*  This program is distributed in the hope that it will be useful,          *
*  but WITHOUT ANY WARRANTY; without even the implied warranty of           *
*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.                     *
*                                                                           *
*****************************************************************************
}
{
@author(Andrey Zubarev <zamtmn@yandex.ru>) 
}

unit uzepalette;
{$INCLUDE def.inc}
interface
uses uzbtypesbase;
type
{EXPORT+}
  PTRGB=^TRGB;
  TRGB=packed record
            r:GDBByte;(*'Red'*)
            g:GDBByte;(*'Green'*)
            b:GDBByte;(*'Blue'*)
            a:GDBByte;(*'Alpha'*)
      end;
  PTDXFCOLOR=^TDXFCOLOR;
  TDXFCOLOR=packed record
            RGB:TRGB;(*'Color'*)
            name:GDBString;(*'Name'*)
      end;
  PTGDBPaletteColor=^TGDBPaletteColor;
  TGDBPaletteColor=GDBInteger;
  TGDBPalette={$IFNDEF DELPHI}packed {$ENDIF}array[0..255] of TDXFCOLOR;
{EXPORT-}
const
  NotTransparent=0;
  acadpalette:TGDBPalette=(
  (RGB:(r:0;  g:0;  b:0  ;a:NotTransparent);name:''),
  (RGB:(r:255;g:0;  b:0  ;a:NotTransparent);name:'Red'),
  (RGB:(r:255;g:255;b:0  ;a:NotTransparent);name:'Yellow'),
  (RGB:(r:0;  g:255;b:0  ;a:NotTransparent);name:'Green'),
  (RGB:(r:0;  g:255;b:255;a:NotTransparent);name:'Cyan'),
  (RGB:(r:0;  g:0;  b:255;a:NotTransparent);name:'Blue'),
  (RGB:(r:255;g:0;  b:255;a:NotTransparent);name:'Magenta'),
  (RGB:(r:255;g:255;b:255;a:NotTransparent);name:'White'),
  (RGB:(r:128;g:128;b:128;a:NotTransparent);name:''),
  (RGB:(r:192;g:192;b:192;a:NotTransparent);name:''),
  (RGB:(r:255;g:0;  b:0  ;a:NotTransparent);name:''),
  (RGB:(r:255;g:127;b:127;a:NotTransparent);name:''),
  (RGB:(r:204;g:0;  b:0  ;a:NotTransparent);name:''),
  (RGB:(r:204;g:102;b:102;a:NotTransparent);name:''),
  (RGB:(r:153;g:0;  b:0  ;a:NotTransparent);name:''),
  (RGB:(r:153;g:76; b:76 ;a:NotTransparent);name:''),
  (RGB:(r:127;g:0;  b:0  ;a:NotTransparent);name:''),
  (RGB:(r:127;g:63; b:63 ;a:NotTransparent);name:''),
  (RGB:(r:76; g:0;  b:0  ;a:NotTransparent);name:''),
  (RGB:(r:76; g:38; b:38 ;a:NotTransparent);name:''),
  (RGB:(r:255;g:63; b:0  ;a:NotTransparent);name:''),
  (RGB:(r:255;g:159;b:127;a:NotTransparent);name:''),
  (RGB:(r:204;g:51; b:0  ;a:NotTransparent);name:''),
  (RGB:(r:204;g:127;b:102;a:NotTransparent);name:''),
  (RGB:(r:153;g:38; b:0  ;a:NotTransparent);name:''),
  (RGB:(r:153;g:95; b:76 ;a:NotTransparent);name:''),
  (RGB:(r:127;g:31; b:0  ;a:NotTransparent);name:''),
  (RGB:(r:127;g:79; b:63 ;a:NotTransparent);name:''),
  (RGB:(r:76; g:19; b:0  ;a:NotTransparent);name:''),
  (RGB:(r:76; g:47; b:38 ;a:NotTransparent);name:''),
  (RGB:(r:255;g:127;b:0  ;a:NotTransparent);name:''),
  (RGB:(r:255;g:191;b:127;a:NotTransparent);name:''),
  (RGB:(r:204;g:102;b:0  ;a:NotTransparent);name:''),
  (RGB:(r:204;g:153;b:102;a:NotTransparent);name:''),
  (RGB:(r:153;g:76; b:0  ;a:NotTransparent);name:''),
  (RGB:(r:153;g:114;b:76 ;a:NotTransparent);name:''),
  (RGB:(r:127;g:63; b:0  ;a:NotTransparent);name:''),
  (RGB:(r:127;g:95; b:63 ;a:NotTransparent);name:''),
  (RGB:(r:76; g:38; b:0  ;a:NotTransparent);name:''),
  (RGB:(r:76; g:57; b:38 ;a:NotTransparent);name:''),
  (RGB:(r:255;g:191;b:0  ;a:NotTransparent);name:''),
  (RGB:(r:255;g:223;b:127;a:NotTransparent);name:''),
  (RGB:(r:204;g:153;b:0  ;a:NotTransparent);name:''),
  (RGB:(r:204;g:178;b:102;a:NotTransparent);name:''),
  (RGB:(r:153;g:114;b:0  ;a:NotTransparent);name:''),
  (RGB:(r:153;g:133;b:76 ;a:NotTransparent);name:''),
  (RGB:(r:127;g:95; b:0  ;a:NotTransparent);name:''),
  (RGB:(r:127;g:111;b:63 ;a:NotTransparent);name:''),
  (RGB:(r:76; g:57; b:0  ;a:NotTransparent);name:''),
  (RGB:(r:76; g:66; b:38 ;a:NotTransparent);name:''),
  (RGB:(r:255;g:255;b:0  ;a:NotTransparent);name:''),
  (RGB:(r:255;g:255;b:127;a:NotTransparent);name:''),
  (RGB:(r:204;g:204;b:0  ;a:NotTransparent);name:''),
  (RGB:(r:204;g:204;b:102;a:NotTransparent);name:''),
  (RGB:(r:153;g:153;b:0  ;a:NotTransparent);name:''),
  (RGB:(r:153;g:153;b:76 ;a:NotTransparent);name:''),
  (RGB:(r:127;g:127;b:0  ;a:NotTransparent);name:''),
  (RGB:(r:127;g:127;b:63 ;a:NotTransparent);name:''),
  (RGB:(r:76; g:76; b:0  ;a:NotTransparent);name:''),
  (RGB:(r:76; g:76; b:38 ;a:NotTransparent);name:''),
  (RGB:(r:191;g:255;b:0  ;a:NotTransparent);name:''),
  (RGB:(r:223;g:255;b:127;a:NotTransparent);name:''),
  (RGB:(r:153;g:204;b:0  ;a:NotTransparent);name:''),
  (RGB:(r:178;g:204;b:102;a:NotTransparent);name:''),
  (RGB:(r:114;g:153;b:0  ;a:NotTransparent);name:''),
  (RGB:(r:133;g:153;b:76 ;a:NotTransparent);name:''),
  (RGB:(r:95; g:127;b:0  ;a:NotTransparent);name:''),
  (RGB:(r:111;g:127;b:63 ;a:NotTransparent);name:''),
  (RGB:(r:57; g:76; b:0  ;a:NotTransparent);name:''),
  (RGB:(r:66; g:76; b:38 ;a:NotTransparent);name:''),
  (RGB:(r:127;g:255;b:0  ;a:NotTransparent);name:''),
  (RGB:(r:191;g:255;b:127;a:NotTransparent);name:''),
  (RGB:(r:102;g:204;b:0  ;a:NotTransparent);name:''),
  (RGB:(r:153;g:204;b:102;a:NotTransparent);name:''),
  (RGB:(r:76; g:153;b:0  ;a:NotTransparent);name:''),
  (RGB:(r:114;g:153;b:76 ;a:NotTransparent);name:''),
  (RGB:(r:63; g:127;b:0  ;a:NotTransparent);name:''),
  (RGB:(r:95; g:127;b:63 ;a:NotTransparent);name:''),
  (RGB:(r:38; g:76; b:0  ;a:NotTransparent);name:''),
  (RGB:(r:57; g:76; b:38 ;a:NotTransparent);name:''),
  (RGB:(r:63; g:255;b:0  ;a:NotTransparent);name:''),
  (RGB:(r:159;g:255;b:127;a:NotTransparent);name:''),
  (RGB:(r:51; g:204;b:0  ;a:NotTransparent);name:''),
  (RGB:(r:127;g:204;b:102;a:NotTransparent);name:''),
  (RGB:(r:38; g:153;b:0  ;a:NotTransparent);name:''),
  (RGB:(r:95; g:153;b:76 ;a:NotTransparent);name:''),
  (RGB:(r:31; g:127;b:0  ;a:NotTransparent);name:''),
  (RGB:(r:79; g:127;b:63 ;a:NotTransparent);name:''),
  (RGB:(r:19; g:76; b:0  ;a:NotTransparent);name:''),
  (RGB:(r:47; g:76; b:38 ;a:NotTransparent);name:''),
  (RGB:(r:0;  g:255;b:0  ;a:NotTransparent);name:''),
  (RGB:(r:127;g:255;b:127;a:NotTransparent);name:''),
  (RGB:(r:0;  g:204;b:0  ;a:NotTransparent);name:''),
  (RGB:(r:102;g:204;b:102;a:NotTransparent);name:''),
  (RGB:(r:0;  g:153;b:0  ;a:NotTransparent);name:''),
  (RGB:(r:76; g:153;b:76 ;a:NotTransparent);name:''),
  (RGB:(r:0;  g:127;b:0  ;a:NotTransparent);name:''),
  (RGB:(r:63; g:127;b:63 ;a:NotTransparent);name:''),
  (RGB:(r:0;  g:76; b:0  ;a:NotTransparent);name:''),
  (RGB:(r:38; g:76; b:38 ;a:NotTransparent);name:''),
  (RGB:(r:0;  g:255;b:63 ;a:NotTransparent);name:''),
  (RGB:(r:127;g:255;b:159;a:NotTransparent);name:''),
  (RGB:(r:0;  g:204;b:51 ;a:NotTransparent);name:''),
  (RGB:(r:102;g:204;b:127;a:NotTransparent);name:''),
  (RGB:(r:0;  g:153;b:38 ;a:NotTransparent);name:''),
  (RGB:(r:76; g:153;b:95 ;a:NotTransparent);name:''),
  (RGB:(r:0;  g:127;b:31 ;a:NotTransparent);name:''),
  (RGB:(r:63; g:127;b:79 ;a:NotTransparent);name:''),
  (RGB:(r:0;  g:76; b:19 ;a:NotTransparent);name:''),
  (RGB:(r:38; g:76; b:47 ;a:NotTransparent);name:''),
  (RGB:(r:0;  g:255;b:127;a:NotTransparent);name:''),
  (RGB:(r:127;g:255;b:191;a:NotTransparent);name:''),
  (RGB:(r:0;  g:204;b:102;a:NotTransparent);name:''),
  (RGB:(r:102;g:204;b:153;a:NotTransparent);name:''),
  (RGB:(r:0;  g:153;b:76 ;a:NotTransparent);name:''),
  (RGB:(r:76; g:153;b:114;a:NotTransparent);name:''),
  (RGB:(r:0;  g:127;b:63 ;a:NotTransparent);name:''),
  (RGB:(r:63; g:127;b:95 ;a:NotTransparent);name:''),
  (RGB:(r:0;  g:76; b:38 ;a:NotTransparent);name:''),
  (RGB:(r:38; g:76; b:57 ;a:NotTransparent);name:''),
  (RGB:(r:0;  g:255;b:191;a:NotTransparent);name:''),
  (RGB:(r:127;g:255;b:223;a:NotTransparent);name:''),
  (RGB:(r:0;  g:204;b:153;a:NotTransparent);name:''),
  (RGB:(r:102;g:204;b:178;a:NotTransparent);name:''),
  (RGB:(r:0;  g:153;b:114;a:NotTransparent);name:''),
  (RGB:(r:76; g:153;b:133;a:NotTransparent);name:''),
  (RGB:(r:0;  g:127;b:95 ;a:NotTransparent);name:''),
  (RGB:(r:63; g:127;b:111;a:NotTransparent);name:''),
  (RGB:(r:0;  g:76; b:57 ;a:NotTransparent);name:''),
  (RGB:(r:38; g:76; b:66 ;a:NotTransparent);name:''),
  (RGB:(r:0;  g:255;b:255;a:NotTransparent);name:''),
  (RGB:(r:127;g:255;b:255;a:NotTransparent);name:''),
  (RGB:(r:0;  g:204;b:204;a:NotTransparent);name:''),
  (RGB:(r:102;g:204;b:204;a:NotTransparent);name:''),
  (RGB:(r:0;  g:153;b:153;a:NotTransparent);name:''),
  (RGB:(r:76; g:153;b:153;a:NotTransparent);name:''),
  (RGB:(r:0;  g:127;b:127;a:NotTransparent);name:''),
  (RGB:(r:63; g:127;b:127;a:NotTransparent);name:''),
  (RGB:(r:0;  g:76; b:76 ;a:NotTransparent);name:''),
  (RGB:(r:38; g:76; b:76 ;a:NotTransparent);name:''),
  (RGB:(r:0;  g:191;b:255;a:NotTransparent);name:''),
  (RGB:(r:127;g:223;b:255;a:NotTransparent);name:''),
  (RGB:(r:0;  g:153;b:204;a:NotTransparent);name:''),
  (RGB:(r:102;g:178;b:204;a:NotTransparent);name:''),
  (RGB:(r:0;  g:114;b:153;a:NotTransparent);name:''),
  (RGB:(r:76; g:133;b:153;a:NotTransparent);name:''),
  (RGB:(r:0;  g:95; b:127;a:NotTransparent);name:''),
  (RGB:(r:63; g:111;b:127;a:NotTransparent);name:''),
  (RGB:(r:0;  g:57; b:76 ;a:NotTransparent);name:''),
  (RGB:(r:38; g:66; b:76 ;a:NotTransparent);name:''),
  (RGB:(r:0;  g:127;b:255;a:NotTransparent);name:''),
  (RGB:(r:127;g:191;b:255;a:NotTransparent);name:''),
  (RGB:(r:0;  g:102;b:204;a:NotTransparent);name:''),
  (RGB:(r:102;g:153;b:204;a:NotTransparent);name:''),
  (RGB:(r:0;  g:76; b:153;a:NotTransparent);name:''),
  (RGB:(r:76; g:114;b:153;a:NotTransparent);name:''),
  (RGB:(r:0;  g:63; b:127;a:NotTransparent);name:''),
  (RGB:(r:63; g:95; b:127;a:NotTransparent);name:''),
  (RGB:(r:0;  g:38; b:76 ;a:NotTransparent);name:''),
  (RGB:(r:38; g:57; b:76 ;a:NotTransparent);name:''),
  (RGB:(r:0;  g:63; b:255;a:NotTransparent);name:''),
  (RGB:(r:127;g:159;b:255;a:NotTransparent);name:''),
  (RGB:(r:0;  g:51; b:204;a:NotTransparent);name:''),
  (RGB:(r:102;g:127;b:204;a:NotTransparent);name:''),
  (RGB:(r:0;  g:38; b:153;a:NotTransparent);name:''),
  (RGB:(r:76; g:95; b:153;a:NotTransparent);name:''),
  (RGB:(r:0;  g:31; b:127;a:NotTransparent);name:''),
  (RGB:(r:63; g:79; b:127;a:NotTransparent);name:''),
  (RGB:(r:0;  g:19; b:76 ;a:NotTransparent);name:''),
  (RGB:(r:38; g:47; b:76 ;a:NotTransparent);name:''),
  (RGB:(r:0;  g:0;  b:255;a:NotTransparent);name:''),
  (RGB:(r:127;g:127;b:255;a:NotTransparent);name:''),
  (RGB:(r:0;  g:0;  b:204;a:NotTransparent);name:''),
  (RGB:(r:102;g:102;b:204;a:NotTransparent);name:''),
  (RGB:(r:0;  g:0;  b:153;a:NotTransparent);name:''),
  (RGB:(r:76; g:76; b:153;a:NotTransparent);name:''),
  (RGB:(r:0;  g:0;  b:127;a:NotTransparent);name:''),
  (RGB:(r:63; g:63; b:127;a:NotTransparent);name:''),
  (RGB:(r:0;  g:0;  b:76 ;a:NotTransparent);name:''),
  (RGB:(r:38; g:38; b:76 ;a:NotTransparent);name:''),
  (RGB:(r:63; g:0;  b:255;a:NotTransparent);name:''),
  (RGB:(r:159;g:127;b:255;a:NotTransparent);name:''),
  (RGB:(r:51; g:0;  b:204;a:NotTransparent);name:''),
  (RGB:(r:127;g:102;b:204;a:NotTransparent);name:''),
  (RGB:(r:38; g:0;  b:153;a:NotTransparent);name:''),
  (RGB:(r:95; g:76; b:153;a:NotTransparent);name:''),
  (RGB:(r:31; g:0;  b:127;a:NotTransparent);name:''),
  (RGB:(r:79; g:63; b:127;a:NotTransparent);name:''),
  (RGB:(r:19; g:0;  b:76 ;a:NotTransparent);name:''),
  (RGB:(r:47; g:38; b:76 ;a:NotTransparent);name:''),
  (RGB:(r:127;g:0;  b:255;a:NotTransparent);name:''),
  (RGB:(r:191;g:127;b:255;a:NotTransparent);name:''),
  (RGB:(r:102;g:0;  b:204;a:NotTransparent);name:''),
  (RGB:(r:153;g:102;b:204;a:NotTransparent);name:''),
  (RGB:(r:76; g:0;  b:153;a:NotTransparent);name:''),
  (RGB:(r:114;g:76; b:153;a:NotTransparent);name:''),
  (RGB:(r:63; g:0;  b:127;a:NotTransparent);name:''),
  (RGB:(r:95; g:63; b:127;a:NotTransparent);name:''),
  (RGB:(r:38; g:0;  b:76 ;a:NotTransparent);name:''),
  (RGB:(r:57; g:38; b:76 ;a:NotTransparent);name:''),
  (RGB:(r:191;g:0;  b:255;a:NotTransparent);name:''),
  (RGB:(r:223;g:127;b:255;a:NotTransparent);name:''),
  (RGB:(r:153;g:0;  b:204;a:NotTransparent);name:''),
  (RGB:(r:178;g:102;b:204;a:NotTransparent);name:''),
  (RGB:(r:114;g:0;  b:153;a:NotTransparent);name:''),
  (RGB:(r:133;g:76; b:153;a:NotTransparent);name:''),
  (RGB:(r:95; g:0;  b:127;a:NotTransparent);name:''),
  (RGB:(r:111;g:63; b:127;a:NotTransparent);name:''),
  (RGB:(r:57; g:0;  b:76 ;a:NotTransparent);name:''),
  (RGB:(r:66; g:38; b:76 ;a:NotTransparent);name:''),
  (RGB:(r:255;g:0;  b:255;a:NotTransparent);name:''),
  (RGB:(r:255;g:127;b:255;a:NotTransparent);name:''),
  (RGB:(r:204;g:0;  b:204;a:NotTransparent);name:''),
  (RGB:(r:204;g:102;b:204;a:NotTransparent);name:''),
  (RGB:(r:153;g:0;  b:153;a:NotTransparent);name:''),
  (RGB:(r:153;g:76; b:153;a:NotTransparent);name:''),
  (RGB:(r:127;g:0;  b:127;a:NotTransparent);name:''),
  (RGB:(r:127;g:63; b:127;a:NotTransparent);name:''),
  (RGB:(r:76; g:0;  b:76 ;a:NotTransparent);name:''),
  (RGB:(r:76; g:38; b:76 ;a:NotTransparent);name:''),
  (RGB:(r:255;g:0;  b:191;a:NotTransparent);name:''),
  (RGB:(r:255;g:127;b:223;a:NotTransparent);name:''),
  (RGB:(r:204;g:0;  b:153;a:NotTransparent);name:''),
  (RGB:(r:204;g:102;b:178;a:NotTransparent);name:''),
  (RGB:(r:153;g:0;  b:114;a:NotTransparent);name:''),
  (RGB:(r:153;g:76; b:133;a:NotTransparent);name:''),
  (RGB:(r:127;g:0;  b:95 ;a:NotTransparent);name:''),
  (RGB:(r:127;g:63; b:111;a:NotTransparent);name:''),
  (RGB:(r:76; g:0;  b:57 ;a:NotTransparent);name:''),
  (RGB:(r:76; g:38; b:66 ;a:NotTransparent);name:''),
  (RGB:(r:255;g:0;  b:127;a:NotTransparent);name:''),
  (RGB:(r:255;g:127;b:191;a:NotTransparent);name:''),
  (RGB:(r:204;g:0;  b:102;a:NotTransparent);name:''),
  (RGB:(r:204;g:102;b:153;a:NotTransparent);name:''),
  (RGB:(r:153;g:0;  b:76 ;a:NotTransparent);name:''),
  (RGB:(r:153;g:76; b:114;a:NotTransparent);name:''),
  (RGB:(r:127;g:0;  b:63 ;a:NotTransparent);name:''),
  (RGB:(r:127;g:63; b:95 ;a:NotTransparent);name:''),
  (RGB:(r:76; g:0;  b:38 ;a:NotTransparent);name:''),
  (RGB:(r:76; g:38; b:57 ;a:NotTransparent);name:''),
  (RGB:(r:255;g:0;  b:63 ;a:NotTransparent);name:''),
  (RGB:(r:255;g:127;b:159;a:NotTransparent);name:''),
  (RGB:(r:204;g:0;  b:51 ;a:NotTransparent);name:''),
  (RGB:(r:204;g:102;b:127;a:NotTransparent);name:''),
  (RGB:(r:153;g:0;  b:38 ;a:NotTransparent);name:''),
  (RGB:(r:153;g:76; b:95 ;a:NotTransparent);name:''),
  (RGB:(r:127;g:0;  b:31 ;a:NotTransparent);name:''),
  (RGB:(r:127;g:63; b:79 ;a:NotTransparent);name:''),
  (RGB:(r:76; g:0;  b:19 ;a:NotTransparent);name:''),
  (RGB:(r:76; g:38; b:47 ;a:NotTransparent);name:''),
  (RGB:(r:51; g:51; b:51 ;a:NotTransparent);name:''),
  (RGB:(r:91; g:91; b:91 ;a:NotTransparent);name:''),
  (RGB:(r:132;g:132;b:132;a:NotTransparent);name:''),
  (RGB:(r:173;g:173;b:173;a:NotTransparent);name:''),
  (RGB:(r:214;g:214;b:214;a:NotTransparent);name:''),
  (RGB:(r:255;g:255;b:255;a:NotTransparent);name:'')
);
var
  palette: TGDBPalette;
implementation
initialization
  palette:=acadpalette;
end.
