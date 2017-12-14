unit cmpCopyRAST_srcTree_nameTemplates;

{$mode objfpc}{$H+}

interface

uses

  Graphics,
  in0kLazExt_CopyRAST_srcTree_HandlerReNAMEs_CNFGs,
  ComCtrls,
  Classes, SysUtils;

type

 mTemplateAPPLAY=function(const rule:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule; var itemName:string):integer of object;


 tCmpCopyRAST_srcTree_nameTemplates=class(TCustomListView)
  protected
    procedure _toView_Item_(const item:TListItem);
    function  _toView_Node_(const cnfg:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule):TListItem;
    procedure _toView_List_;
  protected
    function _clcMoveUp_newINDX_(const testIndx:integer):integer;
    function _clcMoveDW_newINDX_(const testIndx:integer):integer;
  protected
   _templates_:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List;
    procedure _templates_SET_(const value:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List);
    function  _templates_GET_:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List;
  protected
    function  _template_GET_(const item:TListItem):tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule; overload; {$ifOpt D-} inline; {$endIf}
    function  _template_GET_(const indx:integer  ):tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule; overload; {$ifOpt D-} inline; {$endIf}


  private
   _TemplateAPPLAY_:mTemplateAPPLAY;
   _TmpltApplaySTR_:string;
    procedure _TemplateAPPLAY_SET_(const value:mTemplateAPPLAY);
    procedure _TmpltApplaySTR_SET_(const value:string);
  public
    property TemplateAPPLAY_FNK:mTemplateAPPLAY read _TemplateAPPLAY_ write _TemplateAPPLAY_SET_;
    property TemplateAPPLAY_STR:string          read _TmpltApplaySTR_ write _TmpltApplaySTR_SET_;
  private
    procedure _templates_doApplay_;




  protected
    function IsCustomDrawn(ATarget: TCustomDrawTarget; AStage: TCustomDrawStage): Boolean;  override;
    //procedure AdvancedCustomDrawItem(Sender: TCustomListView; Item: TListItem; State: TCustomDrawState; Stage: TCustomDrawStage; var DefaultDraw: Boolean); override;
    function CustomDrawSubItem(AItem: TListItem; ASubItem: Integer; AState: TCustomDrawState; AStage: TCustomDrawStage): Boolean; override; //
    function CustomDrawItem(AItem: TListItem; AState: TCustomDrawState; AStage: TCustomDrawStage): Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
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

constructor tCmpCopyRAST_srcTree_nameTemplates.Create(AOwner: TComponent);
begin
    inherited Create(AOwner);
   // Items.Add(nil,'NEW');
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

destructor tCmpCopyRAST_srcTree_nameTemplates.Destroy;
begin
    inherited;
end;

//--------------------------------------------------------------------------[ ]-

procedure tCmpCopyRAST_srcTree_nameTemplates._templates_SET_(const value:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List);
begin
    self.BeginUpdate;
    //
    Clear;
   _templates_:=value;
   _toView_List_;
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
            tmp:=_template_GET_(i);
            result.Add(tmp);
        end;
    end;
    //
    self.EndUpdate;
end;

//------------------------------------------------------------------------------

function tCmpCopyRAST_srcTree_nameTemplates._template_GET_(const item:TListItem):tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule;
begin
    {$ifOpt d+}
    Assert(Assigned(item));
    {$endIf}
    result:=tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule(item.Data);
end;

function tCmpCopyRAST_srcTree_nameTemplates._template_GET_(const indx:integer):tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule;
begin
    result:=tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule(tObject(Items[indx]));
    if Assigned(result)
    then result:=_template_GET_(TListItem(tObject(result)));
end;

//------------------------------------------------------------------------------

procedure tCmpCopyRAST_srcTree_nameTemplates._toView_Item_(const item:TListItem);
var rule:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule;
begin
    self.BeginUpdate;
    //
    rule:=_template_GET_(item);
    //
    item.SubItems.Clear;
    item.SubItems.Add(rule.Template);
    item.SubItems.Add(rule.Exchange);
    item.SubItems.Add('');
    //
    self.EndUpdate;
end;

function tCmpCopyRAST_srcTree_nameTemplates._toView_Node_(const cnfg:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule):TListItem;
begin
    self.BeginUpdate;
    //
    result:=self.Items.Add;
    result.Data:=cnfg;
   _toView_Item_(result);
    //
    self.EndUpdate;
end;

procedure tCmpCopyRAST_srcTree_nameTemplates._toView_List_;
var i:integer;
  tmp:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule;
begin
    BeginUpdate;
        Clear;
        if Assigned(_templates_) then begin
            for i:=0 to _templates_.Count-1 do begin
                tmp:=_templates_.Items[i];
               _toView_Node_(tmp);
            end;
        end;
    EndUpdate;
end;

{function tCmpCopyRAST_srcTree_nameTemplates.CanEdit(Item: TListItem): Boolean;
begin
    inherited;
    result:=true;
end; }



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
            rule:=_template_GET_(AItem);
            if rule.isInherited_RULE then begin
                self.Canvas.Brush.Color:=clBtnFace;
                self.Canvas.Font.Color:=clGrayText;
            end;
        end;
        //self.Canvas.Font.Color:=clRed;
    end;
end;

function tCmpCopyRAST_srcTree_nameTemplates.CustomDrawItem(AItem: TListItem; AState: TCustomDrawState; AStage: TCustomDrawStage): Boolean;
var rule:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule;
begin        //TCustomDrawState
    result:=inherited;
    if result then begin
        //self.Canvas.Font.Color:=clRed;
        if AStage=cdPrePaint then begin
            rule:=_template_GET_(AItem);
            if rule.isInherited_RULE then begin
                self.Canvas.Brush.Color:=clBtnFace;
            end;
        end;
    end;
end;

//------------------------------------------------------------------------------

function tCmpCopyRAST_srcTree_nameTemplates.itemData(const item:TListItem):tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule;
begin
    result:=_template_GET_(item);
end;

//------------------------------------------------------------------------------

procedure tCmpCopyRAST_srcTree_nameTemplates.Update_Template(const Template:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule);
var item:TListItem;
begin
    item:=self.FindData(0,Template,true,false);
    if Assigned(item) then begin
       _toView_Item_(item)
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
    item:=_toView_Node_(rule);
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
        rule:=_template_GET_(item);
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
    rule:=_template_GET_(item);
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
        rule:=_template_GET_(item);
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
        rule:=_template_GET_(indx);
        if not rule.isInherited_RULE then begin
            result:=indx; //< да ... ставим ВСМЕСТО него
        end
        else begin // там от родителя ... пропускаем их
            result:=0;
            for indx:=indx-1 downto 0 do begin
                rule:=_template_GET_(indx);
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
        rule:=_template_GET_(item);
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
        rule:=_template_GET_(indx);
        if not rule.isInherited_RULE then begin
            result:=indx; //< да ... ставим ВСМЕСТО него
        end
        else begin // там от родителя ... пропускаем их
            result:=Items.Count-1;
            for indx:=indx+1 to Items.Count-1 do begin
                rule:=_template_GET_(indx);
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

procedure tCmpCopyRAST_srcTree_nameTemplates._TemplateAPPLAY_SET_(const value:mTemplateAPPLAY);
begin
   _TemplateAPPLAY_:=value;
   _templates_doApplay_;
end;

procedure tCmpCopyRAST_srcTree_nameTemplates._TmpltApplaySTR_SET_(const value:string);
begin
   _TmpltApplaySTR_:=value;
   _templates_doApplay_;
end;

//------------------------------------------------------------------------------

procedure tCmpCopyRAST_srcTree_nameTemplates._templates_doApplay_;
var I      :integer;
    tmpItem:TListItem;
    tmpRule:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule;
    tmpName:string;
    aResult:integer;
begin
    tmpName:=_TmpltApplaySTR_;
    for i:=0 to self.Items.Count-1 do begin
        tmpItem:=self.Items[i];
        tmpRule:=_template_GET_(tmpItem);
        if Assigned(_TemplateAPPLAY_) then begin
            //tmpItem.SubItems;
            aResult:=_TemplateAPPLAY_(tmpRule,tmpName);
            if aResult=0 then begin
                tmpItem.SubItems.Strings[2]:='';
            end
           else
            if aResult>0 then begin
               tmpItem.SubItems.Strings[2]:=tmpName;
            end;
        end
        else begin
            tmpItem.SubItems.Strings[2]:='';
        end;
    end;
end;


end.

