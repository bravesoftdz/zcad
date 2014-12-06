unit tswnd;
{$INCLUDE def.inc}
{$mode objfpc}{$H+}

interface

uses
  selectorwnd,ugdbltypearray,ugdbutil,log,lineweightwnd,colorwnd,ugdbsimpledrawing,zcadsysvars,Classes, SysUtils,
  FileUtil, LResources, Forms, Controls, Graphics, Dialogs,GraphType,
  Buttons, ExtCtrls, StdCtrls, ComCtrls,LCLIntf,lcltype,

  gdbobjectsconstdef,UGDBTextStyleArray,UGDBDescriptor,gdbase,gdbasetypes,varmandef,

  zcadinterface, zcadstrconsts, strproc, shared, UBaseTypeDescriptor,
  imagesmanager, usupportgui, ZListView;

const
     NameColumn=0;
     FontNameColumn=1;
     HeightColumn=2;
     WidthFactorColumn=3;
     ObliqueColumn=4;

     ColumnCount=4+1;

type

  { TTextStylesWindow }

  TTextStylesWindow = class(TForm)
    AddLayerBtn: TSpeedButton;
    DeleteLayerBtn: TSpeedButton;
    Bevel1: TBevel;
    ButtonApplyClose: TBitBtn;
    Button_Apply: TBitBtn;
    LayerDescLabel: TLabel;
    ListView1: TZListView;
    MkCurrentBtn: TSpeedButton;
    procedure Aply(Sender: TObject);
    procedure AplyClose(Sender: TObject);
    procedure LayerAdd(Sender: TObject);
    procedure LayerDelete(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ListView1SelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure MkCurrent(Sender: TObject);
    procedure MaceItemCurrent(ListItem:TListItem);
  private
    changedstamp:boolean;
    PEditor:TPropEditor;
    EditedItem:TListItem;
    { private declarations }
  public
    { public declarations }
    function GetStyleName(Item: TListItem):string;
    {Font name handle procedures}
    function GetFontName(Item: TListItem):string;
    {Height handle procedures}
    function GetHeight(Item: TListItem):string;
    {Wfactor handle procedures}
    function GetWidthFactor(Item: TListItem):string;
    {Oblique handle procedures}
    function GetOblique(Item: TListItem):string;
  end;

var
  TSWindow: TTextStylesWindow;
implementation
uses
    mainwindow;
{$R *.lfm}


{Style name handle procedures}
function TTextStylesWindow.GetStyleName(Item: TListItem):string;
begin
  result:=Tria_AnsiToUtf8(PGDBTextStyle(Item.Data)^.Name);
end;
{Font name handle procedures}
function TTextStylesWindow.GetFontName(Item: TListItem):string;
begin
  result:=PGDBTextStyle(Item.Data)^.pfont^.fontfile;
end;
{Height handle procedures}
function TTextStylesWindow.GetHeight(Item: TListItem):string;
begin
  result:=floattostr(PGDBTextStyle(Item.Data)^.prop.size);
end;
{Wfactor handle procedures}
function TTextStylesWindow.GetWidthFactor(Item: TListItem):string;
begin
  result:=floattostr(PGDBTextStyle(Item.Data)^.prop.wfactor);
end;
{Oblique handle procedures}
function TTextStylesWindow.GetOblique(Item: TListItem):string;
begin
  result:=floattostr(PGDBTextStyle(Item.Data)^.prop.oblique);
end;


procedure TTextStylesWindow.FormCreate(Sender: TObject); // Процедура выполняется при отрисовке окна
begin
IconList.GetBitmap(II_Plus, AddLayerBtn.Glyph);
IconList.GetBitmap(II_Minus, DeleteLayerBtn.Glyph);
IconList.GetBitmap(II_Ok, MkCurrentBtn.Glyph);
ListView1.SmallImages:=IconList;
ListView1.DefaultItemIndex:=II_Ok;

setlength(ListView1.SubItems,ColumnCount);

with ListView1.SubItems[NameColumn] do
begin
     OnGetName:=@GetStyleName;
end;
with ListView1.SubItems[FontNameColumn] do
begin
     OnGetName:=@GetFontName;
end;
with ListView1.SubItems[HeightColumn] do
begin
     OnGetName:=@GetHeight;
end;
with ListView1.SubItems[WidthFactorColumn] do
begin
     OnGetName:=@GetWidthFactor;
end;
with ListView1.SubItems[ObliqueColumn] do
begin
     OnGetName:=@GetOblique;
end;
end;
procedure TTextStylesWindow.MaceItemCurrent(ListItem:TListItem);
begin
     if ListView1.CurrentItem<>ListItem then
     begin
     with PTDrawing(gdb.GetCurrentDWG)^.UndoStack.PushCreateTGChangeCommand(sysvar.dwg.DWG_CTStyle^)^ do
     begin
          SysVar.dwg.DWG_CTStyle^:={gdb.GetCurrentDWG^.LayerTable.GetIndexByPointer}(ListItem.Data);
          ComitFromObj;
     end;
     ListItem.ImageIndex:=II_Ok;
     ListView1.CurrentItem.ImageIndex:=-1;
     ListView1.CurrentItem:=ListItem;
     invalidate;
     end;
end;
procedure TTextStylesWindow.MkCurrent(Sender: TObject);
begin
  if assigned(ListView1.Selected)then
                                     MaceItemCurrent(ListView1.Selected)
                                 else
                                     MessageBox(@rsLayerMustBeSelected[1],@rsWarningCaption[1],MB_OK or MB_ICONWARNING);
end;
procedure TTextStylesWindow.FormShow(Sender: TObject);
var
   pdwg:PTSimpleDrawing;
   ir:itrec;
   plp:PGDBTextStyle;
   li:TListItem;
begin
     ListView1.BeginUpdate;
     ListView1.Clear;
     pdwg:=gdb.GetCurrentDWG;
     if (pdwg<>nil)and(pdwg<>PTSimpleDrawing(BlockBaseDWG)) then
     begin
       plp:=pdwg^.TextStyleTable.beginiterate(ir);
       if plp<>nil then
       repeat
            li:=ListView1.Items.Add;

            li.Data:=plp;

            ListView1.UpdateItem(li,gdb.GetCurrentDWG^.TextStyleTable.GetCurrentTextStyle);

            plp:=pdwg^.TextStyleTable.iterate(ir);
       until plp=nil;
     end;
     ListView1.SortColumn:=1;
     ListView1.SetFocus;
     ListView1.EndUpdate;
end;
procedure TTextStylesWindow.ListView1SelectItem(Sender: TObject; Item: TListItem;Selected: Boolean);
var
   player:PGDBTextStyle;
   pdwg:PTSimpleDrawing;
   inent,inblock:integer;
begin
     if selected then
     begin
          pdwg:=gdb.GetCurrentDWG;
          player:=(Item.Data);
          //countlayer(player,inent,inblock);
          LayerDescLabel.Caption:=Format(rsLayerUsedIn,[player^.Name,inent,inblock]);
     end;
end;

procedure TTextStylesWindow.LayerAdd(Sender: TObject); // Процедура добавления слоя
var
   player,pcreatedlayer:PGDBTextStyle;
   pdwg:PTSimpleDrawing;
   layername:string;
   counter:integer;
   li:TListItem;
   domethod,undomethod:tmethod;
begin
     (*pdwg:=gdb.GetCurrentDWG;
     if assigned(ListView1.Selected)then
                                        player:=(ListView1.Selected.Data)
                                    else
                                        player:=pdwg^.TextStyleTable.GetCurrentTextStyle;

     counter:=0;
     repeat
          inc(counter);
          layername:=inttostr(counter);
          if length(layername)<2 then
                                     layername:='0'+layername;
          layername:='Layer'+layername;
     until pdwg^.LayerTable.getIndex(layername)=-1;

     pdwg^.LayerTable.AddItem(name,pcreatedlayer);
     pcreatedlayer^:=player^;
     pcreatedlayer^.Name:=layername;

     domethod:=tmethod(@pdwg^.LayerTable.AddToArray);
     undomethod:=tmethod(@pdwg^.LayerTable.RemoveFromArray);
     with ptdrawing(GDB.GetCurrentDWG)^.UndoStack.PushCreateTGObjectChangeCommand2(pcreatedlayer,tmethod(domethod),tmethod(undomethod))^ do
     begin
          AfterAction:=false;
          //comit;
     end;


     ListView1.BeginUpdate;
     li:=ListView1.Items.Add;
     li.Data:=pcreatedlayer;
     ListView1.UpdateItem(li,gdb.GetCurrentDWG^.LayerTable.GetCurrentLayer);
     ListView1.SortColumn:=-1;
     ListView1.SortColumn:=1;
     if assigned(ListView1.Selected)then
     begin
         ListView1.Selected.Selected:=false;
         ListView1.Selected:=nil;
     end;
     ListView1.Selected:=li;
     ListView1.EndUpdate;*)
end;

procedure TTextStylesWindow.LayerDelete(Sender: TObject); // Процедура удаления слоя
var
   player:PGDBTextStyle;
   pdwg:PTSimpleDrawing;
   e,b:GDBInteger;
   domethod,undomethod:tmethod;
begin
   (*
  //ShowError(rsNotYetImplemented);
  pdwg:=gdb.GetCurrentDWG;
  if assigned(ListView1.Selected)then
                                     begin
                                     player:=(ListView1.Selected.Data);
                                     //countlayer(player,e,b);
                                     if (e+b)>0 then
                                                  begin
                                                       ShowError(rsUnableDelUsedLayer);
                                                       exit;
                                                  end;

                                     domethod:=tmethod(@pdwg^.LayerTable.RemoveFromArray);
                                     undomethod:=tmethod(@pdwg^.LayerTable.AddToArray);
                                     with ptdrawing(GDB.GetCurrentDWG)^.UndoStack.PushCreateTGObjectChangeCommand2(player,tmethod(domethod),tmethod(undomethod))^ do
                                     begin
                                          AfterAction:=false;
                                          comit;
                                     end;


                                     //pdwg^.LayerTable.eraseobj(player);
                                     ListView1.Items.Delete(ListView1.Items.IndexOf(ListView1.Selected));
                                     LayerDescLabel.Caption:='';
                                     end
                                 else
                                     ShowError(rsLayerMustBeSelected);
   *)
end;

procedure TTextStylesWindow.AplyClose(Sender: TObject);
begin
     close;
end;

procedure TTextStylesWindow.Aply(Sender: TObject);
begin
     if changedstamp then
     begin
           if assigned(UpdateVisibleProc) then UpdateVisibleProc;
           if assigned(redrawoglwndproc)then
                                            redrawoglwndproc;
     end;
end;

procedure TTextStylesWindow.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
     Aply(nil);
end;

end.

