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

unit uzelongprocesssupport;
{$INCLUDE def.inc}


interface
uses sysutils,gzctnrstl,LazLogger;
type
TLPSHandle=integer;
TLPSCounter=integer;
TLPName=string;

TOnLPStartProc=procedure(LPHandle:TLPSHandle;Total:TLPSCounter;LPName:TLPName) of object;
TOnLPProgressProc=procedure(LPHandle:TLPSHandle;Current:TLPSCounter) of object;
TOnLPEndProc=procedure(LPHandle:TLPSHandle;TotalLPTime:TDateTime) of object;
TLPInfo=record
              LPTotal:TLPSCounter;
              LPName:TLPName;
              LPContext:Pointer;
              LPUseCounter:Integer;
              LPTime:TDateTime;
        end;
TLPInfoVector=TMyVector<TLPInfo>;
PTLPInfo=^TLPInfo;
TOnLPStartProcVector=TMyVector<TOnLPStartProc>;
TOnLPProgressProcVector=TMyVector<TOnLPProgressProc>;
TOnLPEndProcVector=TMyVector<TOnLPEndProc>;

TZELongProcessSupport=class
                       private
                       {type
                         PTLPInfo=TLPInfoVector.PT;}
                       var
                         LPInfoVector:TLPInfoVector;
                         OnLPStartProcVector:TOnLPStartProcVector;
                         OnLPProgressProcVector:TOnLPProgressProcVector;
                         OnLPEndProcVector:TOnLPEndProcVector;
                         ActiveProcessCount:Integer;
                         procedure DoStartLongProcess(plpi:PTLPInfo;LPHandle:TLPSHandle);
                         procedure DoProgressLongProcess(plpi:PTLPInfo;LPHandle:TLPSHandle;Current:TLPSCounter);
                         procedure DoEndLongProcess(plpi:PTLPInfo;LPHandle:TLPSHandle);

                       public
                         function StartLongProcess(Total:TLPSCounter;LPName:TLPName;Context:pointer):TLPSHandle;
                         procedure ProgressLongProcess(LPHandle:TLPSHandle;Current:TLPSCounter);
                         procedure EndLongProcess(LPHandle:TLPSHandle);

                         procedure AddOnLPStartHandler(proc:TOnLPStartProc);
                         procedure AddOnLPProgressHandler(proc:TOnLPProgressProc);
                         procedure AddOnLPEndHandler(proc:TOnLPEndProc);
                         constructor Create;
                         destructor Destroy;override;
                       end;
var
  LPS:TZELongProcessSupport;
implementation
procedure TZELongProcessSupport.DoStartLongProcess(plpi:PTLPInfo;LPHandle:TLPSHandle);
var
  i:integer;
begin
  for i:=0 to OnLPStartProcVector.size-1 do
   OnLPStartProcVector[i](LPHandle,plpi^.LPTotal,plpi^.LPName);
end;
procedure TZELongProcessSupport.DoProgressLongProcess(plpi:PTLPInfo;LPHandle:TLPSHandle;Current:TLPSCounter);
var
  i:integer;
begin
  for i:=0 to OnLPStartProcVector.size-1 do
   OnLPProgressProcVector[i](LPHandle,Current);
end;
procedure TZELongProcessSupport.DoEndLongProcess(plpi:PTLPInfo;LPHandle:TLPSHandle);
var
  i:integer;
begin
  for i:=0 to OnLPStartProcVector.size-1 do
   OnLPEndProcVector[i](LPHandle,plpi^.LPTime);
end;
function TZELongProcessSupport.StartLongProcess(Total:TLPSCounter;LPName:TLPName;Context:pointer):TLPSHandle;
var
  LPI:TLPInfo;
  PLPI:PTLPInfo;
begin
  if Context<>nil then
  if LPInfoVector.Size>0 then
  begin
    result:=LPInfoVector.Size-1;
    PLPI:=LPInfoVector.mutable{$IFDEF DELPHI}({$ENDIF}{$IFNDEF DELPHI}[{$ENDIF}result{$IFNDEF DELPHI}]{$ENDIF}{$IFDEF DELPHI}){$ENDIF};
    if Context=PLPI^.LPContext then
    begin
      inc(PLPI^.LPUseCounter);
      exit;
    end;
  end;
  LPI.LPName:=LPName;
  LPI.LPTotal:=Total;
  LPI.LPContext:=Context;
  LPI.LPUseCounter:=0;
  LPInfoVector.PushBack(LPI);

  inc(ActiveProcessCount);
  result:=LPInfoVector.Size-1;
  PLPI:=LPInfoVector.mutable{$IFDEF DELPHI}({$ENDIF}{$IFNDEF DELPHI}[{$ENDIF}result{$IFNDEF DELPHI}]{$ENDIF}{$IFDEF DELPHI}){$ENDIF};
  PLPI^.LPTime:=now;
  DoStartLongProcess(PLPI,result);
end;
procedure TZELongProcessSupport.ProgressLongProcess(LPHandle:TLPSHandle;Current:TLPSCounter);
var
  PLPI:PTLPInfo;
begin
  PLPI:=LPInfoVector.mutable{$IFDEF DELPHI}({$ENDIF}{$IFNDEF DELPHI}[{$ENDIF}LPHandle{$IFNDEF DELPHI}]{$ENDIF}{$IFDEF DELPHI}){$ENDIF};
  DoProgressLongProcess(PLPI,LPHandle,Current);
end;
procedure TZELongProcessSupport.EndLongProcess(LPHandle:TLPSHandle);
var
  PLPI:PTLPInfo;
begin
  PLPI:=LPInfoVector.mutable{$IFDEF DELPHI}({$ENDIF}{$IFNDEF DELPHI}[{$ENDIF}LPHandle{$IFNDEF DELPHI}]{$ENDIF}{$IFDEF DELPHI}){$ENDIF};
  if PLPI^.LPUseCounter>0 then
  begin
    dec(PLPI^.LPUseCounter);
    exit;
  end;
  PLPI^.LPTime:=now-PLPI^.LPTime;

  DoEndLongProcess(PLPI,LPHandle);

  PLPI^.LPName:='';
  dec(ActiveProcessCount);
  if ActiveProcessCount=0 then
                              LPInfoVector.clear;
end;
procedure TZELongProcessSupport.AddOnLPStartHandler(proc:TOnLPStartProc);
begin
  OnLPStartProcVector.pushback(proc);
end;
procedure TZELongProcessSupport.AddOnLPProgressHandler(proc:TOnLPProgressProc);
begin
  OnLPProgressProcVector.pushback(proc);
end;
procedure TZELongProcessSupport.AddOnLPEndHandler(proc:TOnLPEndProc);
begin
  OnLPEndProcVector.pushback(proc);
end;
constructor TZELongProcessSupport.Create;
begin
  inherited;
  LPInfoVector:=TLPInfoVector.create;
  OnLPStartProcVector:=TOnLPStartProcVector.create;
  OnLPProgressProcVector:=TOnLPProgressProcVector.create;
  OnLPEndProcVector:=TOnLPEndProcVector.create;
  ActiveProcessCount:=0;
end;
destructor TZELongProcessSupport.Destroy;
begin
  LPInfoVector.destroy;
  OnLPStartProcVector.destroy;
  OnLPProgressProcVector.destroy;
  OnLPEndProcVector.destroy;
  inherited;
end;
initialization
  LPS:=TZELongProcessSupport.Create;
finalization
  debugln('{I}[UnitsFinalization] Unit "',{$INCLUDE %FILE%},'" finalization');
  LPS.destroy;
end.
