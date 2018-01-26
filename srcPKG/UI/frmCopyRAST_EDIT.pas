unit frmCopyRAST_EDIT;

{$mode objfpc}{$H+}

interface

uses
    Classes, SysUtils, FileUtil, Forms, Controls;

type

 tFrmCopyRastEDIT=class(TFrame)
  private
   _ctrl_OnChange_lockCntr_:integer;
  protected
    function  _ctrl_OnChange_LOCKED_:boolean;
    procedure _ctrl_OnChange_LOCK_(const value:boolean);
  protected
    procedure _ctrl_Enabled_SET_(const value:boolean); virtual; {$ifOpt D-}abstract;{$endIf}
    procedure _ctrl_validate_;                         virtual; {$ifOpt D-}abstract;{$endIf}
    procedure _ctrl_eventSet_onChange_;                virtual; {$ifOpt D-}abstract;{$endIf}
    procedure _ctrl_eventClr_onChange_;                virtual; {$ifOpt D-}abstract;{$endIf}

  protected
    procedure Constraints_reSet;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  end;

implementation

{$R *.lfm}

//------------------------------------------------------------------------------

procedure tFrmCopyRastEDIT.AfterConstruction;
begin
    inherited;
    //---
   _ctrl_eventClr_onChange_;
   _ctrl_OnChange_lockCntr_:=0;
    //---
   _ctrl_Enabled_SET_(false);
end;

procedure tFrmCopyRastEDIT.BeforeDestruction;
begin
   _ctrl_eventClr_onChange_;
    //---
    inherited;
end;

//------------------------------------------------------------------------------

// проверка: события onChange контролов ЗАБЛОКИРОВАНЫ
function tFrmCopyRastEDIT._ctrl_OnChange_LOCKED_:boolean;
begin
    result:=_ctrl_OnChange_lockCntr_<>0;
end;

// (Раз)Блокирование события onChange контролов.
// @prm Value true - БЛОКИРОВАТЬ события; false - Разблокировать
procedure tFrmCopyRastEDIT._ctrl_OnChange_LOCK_(const value:boolean);
begin
    if value
    then inc(_ctrl_OnChange_lockCntr_)
    else dec(_ctrl_OnChange_lockCntr_);
    //---
    if _ctrl_OnChange_lockCntr_>0
    then _ctrl_eventClr_onChange_
    else _ctrl_eventSet_onChange_;
end;


//------------------------------------------------------------------------------

{$ifOpt D+}
procedure tFrmCopyRastEDIT._ctrl_Enabled_SET_(const value:boolean);
begin
    Assert(FALSE,'method "'+ClassName+'._ctrl_Enabled_SET_" is not implemented');
end;
{$endIf}

//------------------------------------------------------------------------------

{$ifOpt D+}
procedure tFrmCopyRastEDIT._ctrl_validate_;
begin
    Assert(FALSE,'method "'+ClassName+'._cnfg_validate_" is not implemented');
end;
{$endIf}

// УСТАНОВИТЬ события onChange для контролов
{$ifOpt D+}
procedure tFrmCopyRastEDIT._ctrl_eventSet_onChange_;
begin
    Assert(FALSE,'method "'+ClassName+'._ctrl_eventSet_OnChange_" is not implemented');
end;
{$endIf}

// ОЧИСТИТЬ события onChange для контролов
{$ifOpt D+}
procedure tFrmCopyRastEDIT._ctrl_eventClr_onChange_;
begin
    Assert(FALSE,'method "'+ClassName+'._ctrl_eventClr_OnChange_" is not implemented');
end;
{$endIf}

//------------------------------------------------------------------------------

procedure tFrmCopyRastEDIT.Constraints_reSet;
var MinWidth, MinHeight, MaxWidth, MaxHeight: TConstraintSize;
begin
    MinWidth :=Constraints.MinWidth;
    MinHeight:=Constraints.MinHeight;
    MaxWidth :=Constraints.MaxWidth;
    MaxHeight:=Constraints.MaxHeight;
    ConstrainedResize(MinWidth,MinHeight,MaxWidth,MaxHeight);
    Constraints.MinWidth :=MinWidth;
    Constraints.MinHeight:=MinHeight;
    Constraints.MaxWidth :=MaxWidth;
    Constraints.MaxHeight:=MaxHeight;
end;

end.

