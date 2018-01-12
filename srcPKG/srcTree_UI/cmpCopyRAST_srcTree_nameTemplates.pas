unit cmpCopyRAST_srcTree_nameTemplates;

{$mode objfpc}{$H+}

interface

uses
  in0k_lazIdeSRC_srcTree_CORE_item,
  in0k_CopyRAST_srcTree_ITEMs,


  Graphics,  LCLType,
  in0kLazExt_CopyRAST_srcTree_HandlerReNAMEs_CNFGs,
  ComCtrls,
  Classes, SysUtils;

type

 mTemplateAPPLAY=function(const srcItem:tSrcTree_item; const srcName:string; const rule:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule; out outName:string):integer of object;

 tCmpCopyRAST_srcTree_nameTemplates=class(TCustomListView)
  private
   _clmn_RegExpr_ID_:Integer;
    procedure _clmn_RegExpr_CRT_;
  private
    procedure _CLMNs_CLR_;
    procedure _CLMNs_CRT_;
  protected
    function  _view_rule_GET_(const item:TListItem):tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule;             overload; {$ifOpt D-} inline; {$endIf}
    function  _view_rule_GET_(const indx:integer  ):tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule;             overload; {$ifOpt D-} inline; {$endIf}
    function  _view_rule_FND_(const rule:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule):TListItem;                       {$ifOpt D-} inline; {$endIf}
  protected
    procedure _view_rule_UPD_(const item:TListItem; const rule:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule); overload; {$ifOpt D-} inline; {$endIf}
    procedure _view_rule_UPD_(const item:TListItem);                                                          overload; {$ifOpt D-} inline; {$endIf}
    function  _view_rule_ADD_(const rule:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule):TListItem;                       {$ifOpt D-} inline; {$endIf}
    procedure _view_list_ADD_(const list:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List);                                 {$ifOpt D-} inline; {$endIf}
  protected
  protected
   _templates_:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List;
    procedure _templates_SET_(const value:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List);
    function  _templates_GET_:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List;
  protected
    function _clcMoveUp_newINDX_(const testIndx:integer):integer;
    function _clcMoveDW_newINDX_(const testIndx:integer):integer;

  protected
    //_mode_Edit_:boolean;
    //procedure _mode_Edit_SET_(const value:boolean);
  protected
   _templateAPPLAY_FNK_:mTemplateAPPLAY;
   _templateAPPLAY_ITM_:tSrcTree_item;
    procedure _templateAPPLAY_Fnk_SET_(const value:mTemplateAPPLAY);
    procedure _templateAPPLAY_Itm_SET_(const value:tSrcTree_item);
  public
    property TemplateAPPLAY_FNK:mTemplateAPPLAY read _templateAPPLAY_FNK_ write _templateAPPLAY_Fnk_SET_;
    property TemplateAPPLAY_ITM:tSrcTree_item   read _templateAPPLAY_ITM_ write _templateAPPLAY_Itm_SET_;
  private
    procedure _templates_doApplay_;




  protected
    procedure Change(AItem: TListItem; AChange: Integer); override;
    procedure DoSelectItem(AItem: TListItem; ASelected: Boolean); override;
    procedure  DoDeletion(AItem:TListItem); override;
    function IsCustomDrawn(ATarget: TCustomDrawTarget; AStage: TCustomDrawStage): Boolean;  override;
    //procedure AdvancedCustomDrawItem(Sender: TCustomListView; Item: TListItem; State: TCustomDrawState; Stage: TCustomDrawStage; var DefaultDraw: Boolean); override;
    function CustomDrawSubItem(AItem: TListItem; ASubItem: Integer; AState: TCustomDrawState; AStage: TCustomDrawStage): Boolean; override; //
    function CustomDrawItem(AItem: TListItem; AState: TCustomDrawState; AStage: TCustomDrawStage): Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    {$ifOpt D+}
    destructor DESTROY; override;
    {$endIf}
  public
    property  Templates:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List read _templates_GET_ write _templates_SET_;
  public
    function  itemData(const item:TListItem):tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule;
  public
    procedure Update_Template(const Template:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule);
  public
    function  new_Cnfg_CreateCAN:boolean;
    procedure new_Cnfg_Create;
    function  selected_DeleteCAN:boolean;
    procedure selected_Delete;
  public
    function  selected_moveUpCAN:boolean;
    procedure selected_MoveUP;
    function  selected_moveDwCAN:boolean;
    procedure selected_MoveDW;
  public
    property OnSelectItem;
  end;

implementation

{%region --- inline TlistView ItemDATA ----------------------------------}

type
_tItemDATA_=class
  private
   _rule_:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule;
  public
    constructor Create(const rule:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule);
    {$ifOpt D+}
    destructor DESTROY; override;
    {$endIf}
  end;

//------------------------------------------------------------------------------

constructor _tItemDATA_.Create(const rule:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule);
begin
   _rule_:=rule;
end;

{$ifOpt D+}
destructor _tItemDATA_.DESTROY;
begin
   _rule_:=nil;
    inherited;
end;
{$endIf}

{%endregion -------------------------------------------------------------------}

constructor tCmpCopyRAST_srcTree_nameTemplates.Create(AOwner: TComponent);
var clmn:TListColumn;
begin
    inherited Create(AOwner);
   // Items.Add(nil,'NEW');

   _CLMNs_CRT_;

    clmn:=Columns.Add;
    with clmn do begin
        Caption:='Template';
        AutoSize:=TRUE;
    end;
    //clmn.Index:=;




    with Columns.Add do begin
        Caption:='Template';
        AutoSize:=TRUE;
    end;
    with Columns.Add do begin
        Caption:='Template';
        AutoSize:=TRUE;
    end;
    with Columns.Add do begin
        Caption:='Template';
        AutoSize:=TRUE;
    end;
    with Columns.Add do begin
        Caption:='Template1';
        AutoSize:=TRUE;
    end;
    with Columns.Add do begin
        Caption:='Template2';
        AutoSize:=TRUE;
    end;
    with Columns.Add do begin
        Caption:='Template3';
        AutoSize:=TRUE;
    end;
    //
    {with Items.Add do begin
        Caption:='sdf';
        Items.Add.Caption:='asdf';
    end;}
    ShowColumnHeaders:=TRUE;
    RowSelect:=true;
    ViewStyle:=vsReport;
end;

{$ifOpt D+}
destructor tCmpCopyRAST_srcTree_nameTemplates.Destroy;
begin
    inherited;
end;
{$endIf}

//--------------------------------------------------------------------------[ ]-

//------------------------------------------------------------------------------

{%region --- _view_rule_GET_ --------------------------------------------}

function tCmpCopyRAST_srcTree_nameTemplates._view_rule_GET_(const item:TListItem):tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule;
begin
    {$ifOpt d+}
    Assert(Assigned(item));
    {$endIf}
    result:=tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule(item.Data);
    {$ifOpt d+}
    Assert(Assigned(result));
    {$endIf}
    result:=_tItemDATA_(tObject(result))._rule_;
end;

function tCmpCopyRAST_srcTree_nameTemplates._view_rule_GET_(const indx:integer):tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule;
begin
    result:=tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule(tObject(Items[indx]));
    if Assigned(result)
    then result:=_view_rule_GET_(TListItem(tObject(result)));
end;

function tCmpCopyRAST_srcTree_nameTemplates._view_rule_FND_(const rule:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule):TListItem;
var i:integer;
begin
    {$ifOpt d+}
    Assert(Assigned(rule));
    {$endIf}
    for i:=0 to Items.Count do begin
        result:=Items[i];
        if _view_rule_GET_(result)=rule
        then BREAK
        else result:=nil;
    end;
end;

{%endregion -------------------------------------------------------------------}

{%region --- _view_xxxx_UPD|ADD_ ----------------------------------------}

procedure tCmpCopyRAST_srcTree_nameTemplates._view_rule_UPD_(const item:TListItem; const rule:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule);
begin
    {$ifOpt D+}
    Assert(Assigned(item));
    Assert(Assigned(rule));
    {$endIf}
    self.BeginUpdate;
    //
    item.SubItems.Clear;
    item.SubItems.Add(rule.Template);
    item.SubItems.Add(rule.Exchange);
    item.SubItems.Add('');
    //
    self.EndUpdate;
end;

procedure tCmpCopyRAST_srcTree_nameTemplates._view_rule_UPD_(const item:TListItem);
var rule:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule;
begin
    {$ifOpt D+}
    Assert(Assigned(item));
    {$endIf}
    rule:=_view_rule_GET_(item);
   _view_rule_UPD_(item,rule);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function tCmpCopyRAST_srcTree_nameTemplates._view_rule_ADD_(const rule:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule):TListItem;
begin
    {$ifOpt D+}
    Assert(Assigned(rule));
    {$endIf}
    self.BeginUpdate;
    //
    result:=self.Items.Add;
    result.Data:=_tItemDATA_.Create(rule);
   _view_rule_UPD_(result,rule);
    //
    self.EndUpdate;
end;


procedure tCmpCopyRAST_srcTree_nameTemplates._view_list_ADD_(const list:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List);
var i:integer;
 rule:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule;
begin
    self.BeginUpdate;
    //
    Clear;
    if Assigned(list) then begin
        for i:=0 to list.Count-1 do begin
            rule:=list.Items[i];
           _view_rule_ADD_(rule);
        end;
    end;
    //
    self.EndUpdate;
end;

{%endregion -------------------------------------------------------------------}

{%region --- _templates_SET|GET_ ----------------------------------------}

procedure tCmpCopyRAST_srcTree_nameTemplates._templates_SET_(const value:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List);
begin
    self.BeginUpdate;
    //
    Clear;
   _templates_:=value;
   _view_list_ADD_(_templates_);
    //
    self.EndUpdate;
end;

function tCmpCopyRAST_srcTree_nameTemplates._templates_GET_:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List;
var i:integer;
  tmp:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule;
begin
    self.BeginUpdate;
    //
    result:=_templates_;
    if Assigned(result) then begin
        // чистим БЕЗ удаления самих объектов
        result.CLEAR(TRUE);
        // заного вставляем по порядку из визуальщины
        for i:=0 to Items.Count-1 do begin
            tmp:=_view_rule_GET_(i);
            result.Add(tmp);
        end;
    end;
    //
    self.EndUpdate;
end;

{%endregion -------------------------------------------------------------------}

//------------------------------------------------------------------------------

{procedure DrawVertLine(X, Y1, Y2: Integer);
begin
  if Y1 > Y2 then
    Exit;
  if TreeLinePenStyle = psPattern then
  begin
    // TODO: implement psPattern support in the LCL
    Y1 := Y1 + VertDelta;
    while Y1 < Y2 do
    begin
      Canvas.Pixels[X, Y1] := TreeLineColor;
      inc(Y1, 2);
    end;
  end
  else
  begin
    Canvas.MoveTo(X, Y1);
    Canvas.LineTo(X, Y2);
  end;
end;}

{procedure DrawHorzLine(Y, X1, X2: Integer);
begin
  if X1 > X2 then
    Exit;
  if TreeLinePenStyle = psPattern then
  begin
    // TODO: implement psPattern support in the LCL
    while X1 < X2 do
    begin
      Canvas.Pixels[X1, Y] := TreeLineColor;
      inc(X1, 2);
    end;
  end
  else
  begin
    Canvas.MoveTo(X1, Y);
    Canvas.LineTo(X2, Y);
  end;
end;}




//------------------------------------------------------------------------------

function tCmpCopyRAST_srcTree_nameTemplates.IsCustomDrawn(ATarget: TCustomDrawTarget; AStage: TCustomDrawStage): Boolean;
begin
    result:=inherited;
    if not result then begin
        if AStage in [cdPrePaint]
        then begin
            result:=true;

            if ATarget in [dtSubItem,dtItem]
            then result:=(ATarget in [dtSubItem,dtItem]);//and(cdPrePaint=AStage);


        end;
        //if ATarget in [dtSubItem,dtItem]
        //then result:=(ATarget in [dtSubItem,dtItem]);//and(cdPrePaint=AStage);
    end;
   // result:=true;
end;

function tCmpCopyRAST_srcTree_nameTemplates.CustomDrawSubItem(AItem: TListItem; ASubItem: Integer; AState: TCustomDrawState; AStage: TCustomDrawStage): Boolean;
var rule:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule;
begin
    result:=inherited;
    if result then begin
        if AStage=cdPrePaint then begin
            rule:=_view_rule_GET_(AItem);
            if NOT rule.Enabled then begin
                self.Canvas.Font.Color:=clGrayText;
            end;
        end;
    end;
end;

function tCmpCopyRAST_srcTree_nameTemplates.CustomDrawItem(AItem: TListItem; AState: TCustomDrawState; AStage: TCustomDrawStage): Boolean;
var rule:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule;
begin        //TCustomDrawState
    result:=inherited;
    if result then begin
        if AStage=cdPrePaint then begin
            rule:=_view_rule_GET_(AItem);
            if rule.isInherited_RULE then begin
                self.Canvas.Brush.Color:=clBtnFace;
            end;
        end;
    end;
end;

//------------------------------------------------------------------------------

procedure tCmpCopyRAST_srcTree_nameTemplates.DoDeletion(AItem:TListItem);
begin
   _tItemDATA_(AItem.Data).FREE;
end;

procedure tCmpCopyRAST_srcTree_nameTemplates.DoSelectItem(AItem: TListItem; ASelected: Boolean);
var lst:TListItem;
    sel:TListItem;
    Fok:TListItem;
begin
   //self.ffla
    sel:=Selected;
    fok:=ItemFocused;

    if (sel=nil)and(fok<>nil) then begin
        inherited;
        // ДЕСЕЛЕКТ
    end
   else
    if (sel=fok)and(sel=AItem) then begin
        inherited;
        // Что-то ВЫБРАЛИ
    end
   else begin
        inherited;
        // мимо кассы ... пропускаем
    end;





 {   lst:=self.ItemFocused;
    if lst=AItem then inherited
    else begin
        lst:=LastSelected;
        if AItem=lst
        then inherited
        else inherited
    end;}
end;

procedure tCmpCopyRAST_srcTree_nameTemplates.Change(AItem: TListItem; AChange: Integer);
begin
    case AChange of
      LVIF_STATE: begin
          inherited;
      end
    else
      begin
          inherited;
      end;
    end;
end;


//------------------------------------------------------------------------------

function tCmpCopyRAST_srcTree_nameTemplates.itemData(const item:TListItem):tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule;
begin
    result:=_view_rule_GET_(item);
end;

//------------------------------------------------------------------------------

procedure tCmpCopyRAST_srcTree_nameTemplates.Update_Template(const Template:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule);
var item:TListItem;
begin
    item:=_view_rule_FND_(Template);
    if Assigned(item) then begin
       _view_rule_UPD_(item,Template);
       _templates_doApplay_;
    end;
end;

//-----------------------------------------------------[ Create Delete Move.. ]-
//
// любые операции можно проыодить ТОЛЬКО с СОБСТВЕННЫМИ строками,
// "родительские" трогать НЕЛЬЗЯ!
//

// проверка: можно создать НОВУЮ строку
function tCmpCopyRAST_srcTree_nameTemplates.new_Cnfg_CreateCAN:boolean;
begin
    if not Assigned(_templates_) then EXIT(false); //< сам список ДОЛЖЕН быть!
    result:=true; //< добавить можно ВСЕГДА
end;

// создать НОВУЮ строку
procedure tCmpCopyRAST_srcTree_nameTemplates.new_Cnfg_Create;
var rule:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule;
    item:TListItem;
begin
    if not new_Cnfg_CreateCAN then exit;
    BeginUpdate;
    //
    rule:=tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule.Create;
    item:=_view_rule_ADD_(rule);
    Selected:=item;
    //
    EndUpdate;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// проверка: можно УДАЛИТЬ выделенную строку
function tCmpCopyRAST_srcTree_nameTemplates.selected_DeleteCAN:boolean;
var rule:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule;
    item:TListItem;
begin
    if not Assigned(_templates_) then EXIT(false); //< сам список ДОЛЖЕН быть!
    result:=false;
    item:=Selected;
    if Assigned(item) then begin
        rule:=_view_rule_GET_(item);
        if not rule.isInherited_RULE then begin
            result:=TRUE; //< это НАШ ... его МОЖНО удалить
        end;
    end;
end;

// УДАЛИТЬ выделенную строку
procedure tCmpCopyRAST_srcTree_nameTemplates.selected_Delete;
var rule:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule;
    item:TListItem;
    indx:integer;
begin
    if not selected_DeleteCAN then exit;
    BeginUpdate;
    //
    item:=Selected;
    rule:=_view_rule_GET_(item);
    indx:=_templates_.IndexOf(rule);
    // УДАЛЯЕМ
   _templates_.Delete(indx); //< данные
    item.Delete;             //< визуальное представление
    //
    EndUpdate;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// проверка: можно сдвинуть выделенную строку ВВЕРХ
function tCmpCopyRAST_srcTree_nameTemplates.selected_moveUpCAN:boolean;
var rule:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule;
    item:TListItem;
begin
    if not Assigned(_templates_) then EXIT(false); //< сам список ДОЛЖЕН быть!
    result:=false;
    item:=Selected;
    if Assigned(item) then begin
        rule:=_view_rule_GET_(item);
        if not rule.isInherited_RULE then begin
            result:=(0<item.Index);
        end;
    end;
end;

// расчитать новый ИНДЕКС при сдвиге вверх
function tCmpCopyRAST_srcTree_nameTemplates._clcMoveUp_newINDX_(const testIndx:integer):integer;
var rule:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule;
    indx:integer;
begin
    if testIndx=1 then result:=0 //< в САМФЙ верх => можно
    else begin
        indx:=testIndx-1;
        // проверка ПРЕДЫДУЩЕГО
        rule:=_view_rule_GET_(indx);
        if not rule.isInherited_RULE then begin
            result:=indx; //< да ... ставим ВСМЕСТО него
        end
        else begin // там от родителя ... пропускаем их
            result:=0;
            for indx:=indx-1 downto 0 do begin
                rule:=_view_rule_GET_(indx);
                if not rule.isInherited_RULE then begin
                    result:=indx+1; //< первый НЕ родительский => ПОСЛЕ него
                    BREAK;
                end;
            end;
        end;
    end;
end;

// сдвинуть выделенную строку ВВЕРХ
procedure tCmpCopyRAST_srcTree_nameTemplates.selected_MoveUP;
var indx:integer;
begin
    if not selected_moveUpCAN then exit;
    BeginUpdate;
    //
    indx:=Selected.Index;
    Items.Move(indx,_clcMoveUp_newINDX_(indx));
    //
    EndUpdate;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// проверка: можно сдвинуть выделенную строку ВНИЗ
function tCmpCopyRAST_srcTree_nameTemplates.selected_moveDwCAN:boolean;
var rule:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule;
    item:TListItem;
begin
    if not Assigned(_templates_) then EXIT(false); //< сам список ДОЛЖЕН быть!
    result:=false;
    item:=Selected;
    if Assigned(item) then begin
        rule:=_view_rule_GET_(item);
        if not rule.isInherited_RULE then begin
            result:=(item.Index<Items.Count-1);
        end;
    end;
end;

// расчитать новый ИНДЕКС при сдвиге вниз
function tCmpCopyRAST_srcTree_nameTemplates._clcMoveDW_newINDX_(const testIndx:integer):integer;
var rule:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule;
    indx:integer;
begin
    if testIndx=Items.Count-1 then result:=Items.Count //< в САМФЙ низ => можно
    else begin
        indx:=testIndx+1;
        // проверка СЛЕДУЮЩЕГО
        rule:=_view_rule_GET_(indx);
        if not rule.isInherited_RULE then begin
            result:=indx; //< да ... ставим ВСМЕСТО него
        end
        else begin // там от родителя ... пропускаем их
            result:=Items.Count-1;
            for indx:=indx+1 to Items.Count-1 do begin
                rule:=_view_rule_GET_(indx);
                if not rule.isInherited_RULE then begin
                    result:=indx-1; //< первый НЕ родительский => ПЕРЕД ним
                    BREAK;
                end;
            end;
        end;
    end;
end;

// сдвинуть выделенную строку ВНИЗ
procedure tCmpCopyRAST_srcTree_nameTemplates.selected_MoveDW;
var indx:integer;
begin
    if not selected_moveDwCAN then exit;
    BeginUpdate;
    //
    indx:=Selected.Index;
    Items.Move(indx,_clcMoveDW_newINDX_(indx));
    //
    EndUpdate;
end;

//==============================================================================

procedure tCmpCopyRAST_srcTree_nameTemplates._templateAPPLAY_Fnk_SET_(const value:mTemplateAPPLAY);
begin
   _templateAPPLAY_FNK_:=value;
   _templates_doApplay_;
end;

procedure tCmpCopyRAST_srcTree_nameTemplates._templateAPPLAY_Itm_SET_(const value:tSrcTree_item);
begin
   _templateAPPLAY_ITM_:=value;
   _templates_doApplay_;
end;

//------------------------------------------------------------------------------

procedure tCmpCopyRAST_srcTree_nameTemplates._templates_doApplay_;
var I      :integer;
    tmpItem:TListItem;
    tmpRule:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule;
    tmpName:string;
    newName:string;
    aResult:integer;
begin
    //self.BeginUpdate;
    for i:=0 to Items.Count-1 do begin
        tmpItem:=self.Items[i];
        tmpItem.SubItems[2]:='';
    end;
    //---
    if NOT (Assigned(_templateAPPLAY_FNK_) and Assigned(_templateAPPLAY_ITM_))then EXIT;
    //---
    tmpName:=_templateAPPLAY_ITM_.ItemNAME;
    for i:=0 to self.Items.Count-1 do begin
        tmpItem:=self.Items[i];
        tmpRule:=_view_rule_GET_(tmpItem);
        if Assigned(_templateAPPLAY_FNK_) then begin
            //tmpItem.SubItems;
            aResult:=_templateAPPLAY_FNK_(_templateAPPLAY_ITM_,tmpName,tmpRule,newName);
            if aResult<>0 then begin
                tmpItem.SubItems.Strings[2]:='';
            end
           else
            if aResult=0 then begin
               tmpItem.SubItems.Strings[2]:=newName;
            end;
        end
        else begin
            tmpItem.SubItems.Strings[2]:='';
        end;
        tmpName:=newName;
    end;
    //
    //self.EndUpdate;
    //Invalidate;
end;

{%region --- про КОЛОНКИ ------------------------------------------------------}

const
 _clmn_ID_notDef_=-1;

procedure tCmpCopyRAST_srcTree_nameTemplates._clmn_RegExpr_CRT_;
var clmn:TListColumn;
begin
    clmn:=Columns.Add;
    with clmn do begin
        Caption:='Template';
        Hint   :='asdfasdfasdf';
        AutoSize:=TRUE;
    end;
end;

//------------------------------------------------------------------------------

procedure tCmpCopyRAST_srcTree_nameTemplates._CLMNs_CLR_;
begin
    self.Columns.Clear;
    //---
   _clmn_RegExpr_ID_:=_clmn_ID_notDef_;
end;

procedure tCmpCopyRAST_srcTree_nameTemplates._CLMNs_CRT_;
begin
   _CLMNs_CLR_;
   _clmn_RegExpr_CRT_;
end;

{%endregion}


end.
