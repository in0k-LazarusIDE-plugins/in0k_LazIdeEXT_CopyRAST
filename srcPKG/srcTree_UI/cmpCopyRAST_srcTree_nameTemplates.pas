unit cmpCopyRAST_srcTree_nameTemplates;

{$mode objfpc}{$H+}

interface

uses

  in0kLazExt_CopyRAST_srcTree_HandlerReNAMEs_CNFGs,
  ComCtrls,
  Classes, SysUtils;

type

 tCmpCopyRAST_srcTree_nameTemplates=class(TCustomListView)
  protected
    procedure _toView_Node_(const cnfg:tCopyRAST_HandlerCNFGs_ReNAMEs_template_node);
    procedure _toView_List_;
  protected
   _tmplList_:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List;
    procedure _tmplList_SET_(const value:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List);
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
    with Items.Add do begin
        Caption:='sdf';
        Items.Add.Caption:='asdf';
    end;
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

procedure tCmpCopyRAST_srcTree_nameTemplates._toView_Node_(const cnfg:tCopyRAST_HandlerCNFGs_ReNAMEs_template_node);
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
  tmp:tCopyRAST_HandlerCNFGs_ReNAMEs_template_node;
begin
    BeginUpdate;
        Clear;
        if Assigned(_tmplList_) then begin
            for i:=0 to _tmplList_.Count-1 do begin
                tmp:=tCopyRAST_HandlerCNFGs_ReNAMEs_template_node(_tmplList_.Items[i]);
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

end.

