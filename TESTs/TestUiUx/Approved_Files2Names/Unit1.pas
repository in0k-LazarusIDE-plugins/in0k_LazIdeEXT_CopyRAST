unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  in0k_lazIdeSRC_srcTree_CORE_item,
  in0k_lazIdeSRC_srcTree_item_Globals,

  in0k_lazIdeSRC_srcTree_4Package,

  in0k_lazIdeSRC_CopyRAST_srcTree,
  in0k_lazIdeSRC_CopyRAST_srcTree_Nodes,
  in0k_lazIdeSRC_CopyRAST_srcTree_HandlerReNAMEs,

  makeTest_copyRastOBJ,
  //
  cmpCopyRAST_srcTree_approvedFiles,
  cmpCopyRAST_srcTree_approvedNAMEs,
  //
  cmpCopyRAST_srcTree,
  //

  Classes, SysUtils, XMLConf, FileUtil, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Panel1: TPanel;
    TreeView1: TTreeView;
    XMLConfig1: TXMLConfig;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure TreeView1AdvancedCustomDrawItem(Sender: TCustomTreeView;
      Node: TTreeNode; State: TCustomDrawState; Stage: TCustomDrawStage;
      var PaintImages, DefaultDraw: Boolean);
    procedure TreeView1Click(Sender: TObject);
    procedure TreeView1CustomDrawItem(Sender: TCustomTreeView; Node: TTreeNode;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure TreeView1SelectionChanged(Sender: TObject);
  private
    approvedFILEs:tCmpCopyRAST_srcTree_approvedFILEs;
    approvedNAMEs:tCmpCopyRAST_srcTree_approvedNAMEs;
    procedure TreeView0SelectionChanged(Sender: TObject);
  protected
    procedure _GO_reNAMEs_;
  public
    first:tCopyRastNODE_Root4Package;
    builder:tSrcTree_Builder_4Package;




  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
    builder:=tCopyRastSrcTree_Builder4Package.Create;
    first  :=tCopyRastNODE_Root4Package(makeTest_objCopyRAST(builder));

    approvedFILEs:=tCmpCopyRAST_srcTree_approvedFILEs.Create(self);
    with approvedFILEs do begin
        Parent:=self;
        Align :=alLeft;
        //
        AnchorSide[akRight].Control:=Panel1;
        AnchorSide[akRight].Side   :=asrLeft;
        //
        Anchors:=Anchors+[akRight];
        OnSelectionChanged:=@TreeView0SelectionChanged;
    end;
    //---
    approvedFILEs.Root:=first;
    //---
    approvedNAMEs:=tCmpCopyRAST_srcTree_approvedNAMEs.Create(self);
    with approvedNAMEs do begin
        Parent:=self;
        Align :=alRight;
        //
        AnchorSide[akLeft].Control:=Panel1;
        AnchorSide[akLeft].Side   :=asrRight;
        //
        Anchors:=Anchors+[akLeft];
        //
//        OnClick           :=@TreeView1Click;
        OnSelectionChanged:=@TreeView1SelectionChanged;
    end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
    _GO_reNAMEs_;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
    builder.Free;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
    Panel1.Left:=(Form1.Width-panel1.Width) div 2;;
end;

procedure TForm1.TreeView1AdvancedCustomDrawItem(Sender: TCustomTreeView;
  Node: TTreeNode; State: TCustomDrawState; Stage: TCustomDrawStage;
  var PaintImages, DefaultDraw: Boolean);
begin
//    node.get
end;

procedure TForm1.TreeView1Click(Sender: TObject);
var tmpItem:tSrcTree_item;
    tmpData:pCopyRastNODE_DATA;
begin
{    tmpItem:=tCmpCopyRAST_srcTree(sender).SelectedITEM;
    if Assigned(tmpItem) and isCopyRastNODE(tmpItem) then begin
        tmpData:=CopyRastNODE_DATA(tObject(tmpItem));
        if Assigned(tmpData) then begin
            if Assigned(tmpData^.sideLeft)
            then approvedFILEs.Select(tmpData^.sideLeft)
            else approvedFILEs.Select_4Right(tmpItem)
        end;
    end;}
end;

procedure TForm1.TreeView1CustomDrawItem(Sender: TCustomTreeView;
  Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
begin

end;

procedure TForm1.TreeView0SelectionChanged(Sender: TObject);
begin

end;


procedure TForm1.TreeView1SelectionChanged(Sender: TObject);
var tmpItem:tSrcTree_item;
    tmpData:pCopyRastNODE_DATA;
begin
    tmpItem:=tCmpCopyRAST_srcTree(sender).SelectedITEM;
    if Assigned(tmpItem) and isCopyRastNODE(tmpItem) then begin
        tmpData:=CopyRastNODE_DATA(tObject(tmpItem));
        if Assigned(tmpData) then begin
            if Assigned(tmpData^.sideLeft)
            then approvedFILEs.Select(tmpData^.sideLeft)
            else approvedFILEs.Select_4Right(tmpItem)
        end;
    end;
end;

//------------------------------------------------------------------------------

procedure TForm1._GO_reNAMEs_;
var _reNames_:tCopyRastSrcTree_prcH4ReNAMEs;
    _resRoot_:tSrcTree_ROOT;
begin
   _resRoot_:=tCopyRastNODE_Root4Package(approvedNAMEs.Root);
    approvedNAMEs.Root:=nil;
    //---
   _resRoot_.FREE;
    //-------------------------------

   _reNames_:=tCopyRastSrcTree_prcH4ReNAMEs.Create(builder);
   _reNames_.EXECUTE(First,_resRoot_);
   _reNames_.FREE;

    approvedNAMEs.Root:=_resRoot_;
end;

end.

