unit cmpCopyRAST_srcTree_nameTemplates;

{$mode objfpc}{$H+}

interface

uses

  Graphics,
  in0kLazExt_CopyRAST_srcTree_HandlerReNAMEs_CNFGs,
  ComCtrls,
  Classes, SysUtils;

type

 tCmpCopyRAST_srcTree_nameTemplates=class(TCustomListView)
  protected
    function  _toView_Node_(const cnfg:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule):TListItem;
    procedure _toView_List_;
  protected
   _tmplList_:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List;
    procedure _tmplList_SET_(const value:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List);
    function  _tmplList_GET_:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List;
  protected
    function IsCustomDrawn(ATarget: TCustomDrawTarget; AStage: TCustomDrawStage): Boolean;  override;
    //procedure AdvancedCustomDrawItem(Sender: TCustomListView; Item: TListItem; State: TCustomDrawState; Stage: TCustomDrawStage; var DefaultDraw: Boolean); override;
    function CustomDrawSubItem(AItem: TListItem; ASubItem: Integer; AState: TCustomDrawState; AStage: TCustomDrawStage): Boolean; override; //
    function CustomDrawItem(AItem: TListItem; AState: TCustomDrawState; AStage: TCustomDrawStage): Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  public
    property  Templates:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List read _tmplList_GET_ write _tmplList_SET_;

  protected
    function _getMovwUp_INDX_(const testIndx:integer):integer;
    function _getMovwDW_INDX_(const testIndx:integer):integer;
  public
    function  selected_moveUpCAN:boolean;
    procedure selected_MoveUP;
    function  selected_moveDwCAN:boolean;
    procedure selected_MoveDW;
  public
    function  selected_DeleteCAN:boolean;
    procedure selected_Delete;
    function  new_Cnfg_CreateCAN:boolean;
    procedure new_Cnfg_Create;
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

//------------------------------------------------------------------------------

procedure tCmpCopyRAST_srcTree_nameTemplates._tmplList_SET_(const value:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List);
begin
    self.BeginUpdate;
      Clear;
     _tmplList_:=value;
     _toView_List_;
    self.EndUpdate;
end;

function tCmpCopyRAST_srcTree_nameTemplates._tmplList_GET_:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List;
var i:integer;
  tmp:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule;
begin
    self.BeginUpdate;
    result:=_tmplList_;
    if Assigned(result) then begin
        result.CLEAR(TRUE);
        //---
        for i:=0 to Items.Count-1 do begin
            tmp:=tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule(Items[i].Data);
            result.Add(tmp);
        end;
    end;
    self.EndUpdate;
end;

//------------------------------------------------------------------------------

function tCmpCopyRAST_srcTree_nameTemplates._toView_Node_(const cnfg:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule):TListItem;
begin
    result:=self.Items.Add;
    result.Data:=cnfg;
    //
    result.SubItems.Add(cnfg.Template);
    result.SubItems.Add(cnfg.Exchange);
end;

procedure tCmpCopyRAST_srcTree_nameTemplates._toView_List_;
var i:integer;
  tmp:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule;
begin
    BeginUpdate;
        Clear;
        if Assigned(_tmplList_) then begin
            for i:=0 to _tmplList_.Count-1 do begin
                tmp:=tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule(_tmplList_.Items[i]);
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
            rule:=tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule(AItem.Data);
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
            rule:=tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule(AItem.Data);
            if rule.isInherited_RULE then begin
                self.Canvas.Brush.Color:=clBtnFace;
            end;
        end;
    end;
end;

//------------------------------------------------------------------------------

function tCmpCopyRAST_srcTree_nameTemplates.selected_moveUpCAN:boolean;
var node:TListItem;
    rule:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule;
begin
    result:=false;
    node:=Selected;
    if Assigned(node) then begin
        rule:=tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule(node.Data);
        if not rule.isInherited_RULE then begin
            result:=(0<node.Index);
        end;
    end;
end;

function tCmpCopyRAST_srcTree_nameTemplates._getMovwUp_INDX_(const testIndx:integer):integer;
var rule:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule;
       i:integer;
begin
    if testIndx=1 then result:=0 //< в САМФЙ верх => можно
    else begin
        i:=testIndx-1;
        // проверка ПРЕДЫДУЩЕГО
        rule:=tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule(Items[i].Data);
        if not rule.isInherited_RULE then begin
            result:=i; //< да ... ставим ВСМЕСТО него
        end
        else begin // там от родителя ... пропускаем их
            result:=0;
            for i:=i-1 downto 0 do begin
                rule:=tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule(Items[i].Data);
                if not rule.isInherited_RULE then begin
                    result:=i+1; //< первый НЕ родительский => ПОСЛЕ него
                    BREAK;
                end;
            end;
        end;
    end;
end;

procedure tCmpCopyRAST_srcTree_nameTemplates.selected_MoveUP;
var tmp:integer;
begin
    if not selected_moveUpCAN then exit;
    BeginUpdate;
    //
    tmp:=Selected.Index;
    Items.Move(tmp,_getMovwUp_INDX_(tmp));
    //
    EndUpdate;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function tCmpCopyRAST_srcTree_nameTemplates.selected_moveDwCAN:boolean;
var node:TListItem;
    rule:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule;
begin
    result:=false;
    node:=Selected;
    if Assigned(node) then begin
        rule:=tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule(node.Data);
        if not rule.isInherited_RULE then begin
            result:=(node.Index<Items.Count-1);
        end;
    end;
end;

function tCmpCopyRAST_srcTree_nameTemplates._getMovwDW_INDX_(const testIndx:integer):integer;
var rule:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule;
       i:integer;
begin
    if testIndx=Items.Count-1 then result:=Items.Count //< в САМФЙ низ => можно
    else begin
        i:=testIndx+1;
        // проверка СЛЕДУЮЩЕГО
        rule:=tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule(Items[i].Data);
        if not rule.isInherited_RULE then begin
            result:=i; //< да ... ставим ВСМЕСТО него
        end
        else begin // там от родителя ... пропускаем их
            result:=Items.Count-1;
            for i:=i+1 to Items.Count-1 do begin
                rule:=tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule(Items[i].Data);
                if not rule.isInherited_RULE then begin
                    result:=i-1; //< первый НЕ родительский => ПЕРЕД ним
                    BREAK;
                end;
            end;
        end;
    end;
end;

procedure tCmpCopyRAST_srcTree_nameTemplates.selected_MoveDW;
var tmp:integer;
begin
    if not selected_moveDwCAN then exit;
    BeginUpdate;
    //
    tmp:=Selected.Index;
    Items.Move(tmp,_getMovwDW_INDX_(tmp));
    //
    EndUpdate;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function tCmpCopyRAST_srcTree_nameTemplates.selected_DeleteCAN:boolean;
var node:TListItem;
    rule:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule;
begin
    result:=false;
    node:=Selected;
    if Assigned(node) then begin
        rule:=tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule(node.Data);
        if not rule.isInherited_RULE then begin
            result:=TRUE; //< это НАШ ... его МОЖНО удалить
        end;
    end;
end;

procedure tCmpCopyRAST_srcTree_nameTemplates.selected_Delete;
var node:TListItem;
    rule:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule;
    indx:integer;
begin
    if not selected_DeleteCAN then exit;
    BeginUpdate;
    //
    node:=Selected;
    rule:=tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule(node.Data);
    indx:=_tmplList_.IndexOf(rule);
    //
   _tmplList_.Delete(indx);
    node.Delete;
    //
    EndUpdate;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function tCmpCopyRAST_srcTree_nameTemplates.new_Cnfg_CreateCAN:boolean;
begin
    result:=true;
end;

procedure tCmpCopyRAST_srcTree_nameTemplates.new_Cnfg_Create;
var rule:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule;
    node:TListItem;
begin
    if not new_Cnfg_CreateCAN then exit;
    BeginUpdate;
    //
    rule:=tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule.Create;
    node:=_toView_Node_(rule);
    Selected:=node;
    //
    EndUpdate;
end;

end.

