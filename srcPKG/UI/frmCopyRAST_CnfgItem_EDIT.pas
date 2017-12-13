unit frmCopyRAST_CnfgItem_EDIT;

{$mode objfpc}{$H+}

interface

uses
    Classes, SysUtils, FileUtil, Forms, Controls;

type

 mFrmCopyRAST_CnfgItemEDIT_onChange=procedure(const Sender:tObject; const itemGnfg:pointer) of object;

 tFrmCopyRAST_CnfgItemEDIT=class(TFrame)
  private
   _item_:pointer;
   _item_onChange_:mFrmCopyRAST_CnfgItemEDIT_onChange;
   _ctrl_OnChange_lockCounter_:integer;
  protected
    procedure _CNFG_do_OnCHANGE_;
  protected
    function  _itemCNFG_GET_:pointer;
    procedure _itemCNFG_SET_(const value:pointer);
  protected
    procedure _cnfg_itmCLEAN_(const item:pointer);     virtual;
    procedure _cnfg_nil2ctrl_;                         virtual; {$ifOpt D-}abstract;{$endIf}
    procedure _cnfg_itm2ctrl_(const item:pointer);     virtual; {$ifOpt D-}abstract;{$endIf}
    procedure _cnfg_ctrl2itm_(const item:pointer);     virtual; {$ifOpt D-}abstract;{$endIf}
  protected
    procedure _ctrl_Enabled_SET_(const value:boolean); virtual; {$ifOpt D-}abstract;{$endIf}
    procedure _ctrl_validate_;                         virtual; {$ifOpt D-}abstract;{$endIf}
    procedure _ctrl_eventSet_onChange_;                virtual; {$ifOpt D-}abstract;{$endIf}
    procedure _ctrl_eventClr_onChange_;                virtual; {$ifOpt D-}abstract;{$endIf}
  protected
    function  _ctrl_OnChange_LOCKED_:boolean;
    procedure _ctrl_OnChange_setLOCK_(const value:boolean);
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  public
    property ItemCNFG:pointer read _itemCNFG_GET_ write _itemCNFG_SET_;
    property ItemCNFG_OnChange:mFrmCopyRAST_CnfgItemEDIT_onChange read _item_onChange_ write _item_onChange_;
  end;

implementation

{$R *.lfm}

procedure tFrmCopyRAST_CnfgItemEDIT.AfterConstruction;
begin
    inherited;
    //-------
   _item_:=nil;
   _ctrl_eventClr_onChange_;
   _ctrl_OnChange_lockCounter_:=0;
   _cnfg_nil2ctrl_;
   _ctrl_validate_;
   _ctrl_Enabled_SET_(false);
end;

procedure tFrmCopyRAST_CnfgItemEDIT.BeforeDestruction;
begin
   _ctrl_eventClr_onChange_;
   _cnfg_nil2ctrl_;
    if Assigned(_item_) then _cnfg_itmCLEAN_(_item_);
    //-------
    inherited;
end;

//------------------------------------------------------------------------------

function tFrmCopyRAST_CnfgItemEDIT._itemCNFG_GET_:pointer;
begin
    result:=_item_;
end;

procedure tFrmCopyRAST_CnfgItemEDIT._itemCNFG_SET_(const value:pointer);
begin
    // ПОЛНОСТЬЮ блокируем реакцию на изменение
   _ctrl_eventClr_onChange_;
   _ctrl_OnChange_lockCounter_:=0;
   _ctrl_OnChange_setLOCK_(TRUE);
    // чистим и ставим новове
    if Assigned(_item_) then _cnfg_itmCLEAN_(_item_);
   _item_:=value;
    // пропихиваем в КОНТРОЛЫ
    if Assigned(_item_) then begin
        _cnfg_itm2ctrl_(_item_);
        _ctrl_validate_;
        _ctrl_eventSet_onChange_;
        _ctrl_Enabled_SET_(true);
    end
    else begin
       _cnfg_nil2ctrl_;
       _ctrl_validate_;
       _ctrl_Enabled_SET_(false);
    end;
    // разрешаем реакцию на изменения
   _ctrl_OnChange_setLOCK_(false);
end;

//------------------------------------------------------------------------------

procedure tFrmCopyRAST_CnfgItemEDIT._CNFG_do_OnCHANGE_;
begin
    if Assigned(_item_)and
       Assigned(_item_onChange_)and
      (not _ctrl_OnChange_LOCKED_)
    then begin
       _cnfg_ctrl2itm_(_item_);      //< копируем
       _item_onChange_(self,_item_); //< отправляем выше
    end;
end;

//------------------------------------------------------------------------------

{$ifOpt D+}
procedure tFrmCopyRAST_CnfgItemEDIT._ctrl_Enabled_SET_(const value:boolean);
begin
    Assert(FALSE,'method "'+ClassName+'._ctrl_Enabled_SET_" is not implemented');
end;
{$endIf}

//------------------------------------------------------------------------------

{$ifOpt D+}
procedure tFrmCopyRAST_CnfgItemEDIT._ctrl_validate_;
begin
    Assert(FALSE,'method "'+ClassName+'._cnfg_validate_" is not implemented');
end;
{$endIf}

// УСТАНОВИТЬ события onChange для контролов
{$ifOpt D+}
procedure tFrmCopyRAST_CnfgItemEDIT._ctrl_eventSet_onChange_;
begin
    Assert(FALSE,'method "'+ClassName+'._ctrl_eventSet_OnChange_" is not implemented');
end;
{$endIf}

// ОЧИСТИТЬ события onChange для контролов
{$ifOpt D+}
procedure tFrmCopyRAST_CnfgItemEDIT._ctrl_eventClr_onChange_;
begin
    Assert(FALSE,'method "'+ClassName+'._ctrl_eventClr_OnChange_" is not implemented');
end;
{$endIf}

//------------------------------------------------------------------------------

// очистить содержимое при необходимости
procedure tFrmCopyRAST_CnfgItemEDIT._cnfg_itmCLEAN_(const item:pointer);
begin
    {$ifOpt D+}
    //Assert(Assigned(item)); //< чисто погасить сообщение `warn-5024`
    {$endIf}
end;

// установить ПУСТЫЕ значения
{$ifOpt D+}
procedure tFrmCopyRAST_CnfgItemEDIT._cnfg_nil2ctrl_;
begin
    Assert(FALSE,'method "'+ClassName+'._cnfg_nil2ctrl_" is not implemented');
end;
{$endIf}

// копирование данных в контролы
{$ifOpt D+}
procedure tFrmCopyRAST_CnfgItemEDIT._cnfg_itm2ctrl_(const item:pointer);
begin
    Assert(Assigned(item)); //< чисто погасить сообщение `warn-5024`
    Assert(FALSE,'method "'+ClassName+'._cnfg_itm2ctrl_" is not implemented');
end;
{$endIf}

// копирование данных из контролов
{$ifOpt D+}
procedure tFrmCopyRAST_CnfgItemEDIT._cnfg_ctrl2itm_(const item:pointer);
begin
    Assert(Assigned(item)); //< чисто погасить сообщение `warn-5024`
    Assert(FALSE,'method "'+ClassName+'._cnfg_ctrl2itm_" is not implemented');
end;
{$endIf}

//------------------------------------------------------------------------------

// проверка: события onChange контролов ЗАБЛОКИРОВАНЫ
function tFrmCopyRAST_CnfgItemEDIT._ctrl_OnChange_LOCKED_:boolean;
begin
    result:=_ctrl_OnChange_lockCounter_<>0;
end;

// (Раз)Блокирование события onChange контролов.
// @prm Value true - БЛОКИРОВАТЬ события; false - Разблокировать
procedure tFrmCopyRAST_CnfgItemEDIT._ctrl_OnChange_setLOCK_(const value:boolean);
begin
    if value
    then inc(_ctrl_OnChange_lockCounter_)
    else dec(_ctrl_OnChange_lockCounter_);
    //---
    if _ctrl_OnChange_lockCounter_>0
    then _ctrl_eventClr_onChange_
    else _ctrl_eventSet_onChange_;
end;

end.

