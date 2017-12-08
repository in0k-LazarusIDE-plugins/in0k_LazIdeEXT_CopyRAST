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
    procedure _toView_Node_(const cnfg:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule);
    procedure _toView_List_;
  protected
   _tmplList_:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List;
    procedure _tmplList_SET_(const value:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List);
  protected
    function IsCustomDrawn(ATarget: TCustomDrawTarget; AStage: TCustomDrawStage): Boolean;  override;
    //procedure AdvancedCustomDrawItem(Sender: TCustomListView; Item: TListItem; State: TCustomDrawState; Stage: TCustomDrawStage; var DefaultDraw: Boolean); override;
    function CustomDrawSubItem(AItem: TListItem; ASubItem: Integer; AState: TCustomDrawState; AStage: TCustomDrawStage): Boolean; override; //
    function CustomDrawItem(AItem: TListItem; AState: TCustomDrawState; AStage: TCustomDrawStage): Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  public
    property Templates:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List read _tmplList_ write _tmplList_SET_;
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

//------------------------------------------------------------------------------

procedure tCmpCopyRAST_srcTree_nameTemplates._toView_Node_(const cnfg:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule);
var itm:TListItem;
begin
    itm:=self.Items.Add;
    itm.Data:=cnfg;
    //
    itm.SubItems.Add(cnfg.Template);
    itm.SubItems.Add(cnfg.Exchange);
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

end.

