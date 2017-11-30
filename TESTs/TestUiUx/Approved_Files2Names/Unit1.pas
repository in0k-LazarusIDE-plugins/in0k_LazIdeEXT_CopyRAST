unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  in0k_lazIdeSRC_srcTree_CORE_item,
  in0k_lazIdeSRC_srcTree_item_Globals,

  in0k_lazIdeSRC_srcTree_FNK_baseDIR_FND,

  in0k_lazIdeSRC_srcTree_4Package,
  lazExt_CopyRAST__xmlConfig,

  lazExt_CopyRAST__xmlConfig_approvedFILEs2NAMEs,

  in0k_lazIdeSRC_CopyRAST_srcTree,
  in0k_lazIdeSRC_CopyRAST_srcTree_Nodes,
  in0kLazExt_CopyRAST_srcTree_HandlerReNAMEs,

  makeTest_copyRastOBJ,
  //
  cmpCopyRAST_srcTree_approvedFiles,
  cmpCopyRAST_srcTree_approvedNAMEs,
  //
  cmpCopyRAST_srcTree, frmCopyRAST_srcTree_approvedFILEs2NAMEs,
  //
  //LazConfigStorage,
  Classes, SysUtils, XMLConf, FileUtil, CheckBoxThemed, ExtendedTabControls,
  Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, ComCtrls, Grids;

type

  { TForm1 }

  TForm1 = class(TForm)
    frmApprovedFILEs2NAMEs1: TfrmApprovedFILEs2NAMEs;
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
    procedure TreeView0SelectionChanged(Sender: TObject);
  protected
    procedure _GO_reNAMEs_;

  protected
    cnfg   :TXMLConfig;
    reNames:tCopyRastSrcTree_prcH4ReNAMEs;


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
var s:string;
begin
    inherited;
    builder:=tCopyRastSrcTree_Builder4Package.Create;
    reNames:=tCopyRastSrcTree_prcH4ReNAMEs.Create(builder);

    first  :=tCopyRastNODE_Root4Package(makeTest_objCopyRAST(builder)); ;

    reNames.ROOT_old:=first;

    frmApprovedFILEs2NAMEs1.Handler:=reNames;


 {   s:=ChangeFileExt(ParamStr(0),'.xml');
    cnfg:=TXMLConfig.Create(self);//(s);
    cnfg.LoadFromFile(s);

    CRxC_aF2N_ROOT_newName__SET(cnfg,'asdasd');



    first  :=tCopyRastNODE_Root4Package(makeTest_objCopyRAST(builder));


    CRxC_aF2N_BASE_newName__SET(cnfg,SrcTree_fndBaseDIR(first).fsPath);

            }
{    approvedFILEs:=tCmpCopyRAST_srcTree_approvedFILEs.Create(self);
    with approvedFILEs do begin
        Parent:=self;
        Align :=alLeft;
        //
        AnchorSide[akRight].Control:=Panel1;
        AnchorSide[akRight].Side   :=asrLeft;
        Anchors:=Anchors+[akRight];
        //
        AnchorSide[akBottom].Control:=Panel2;
        //
        OnSelectionChanged:=@TreeView0SelectionChanged;
    end;  }
    //---
{    approvedFILEs.Root:=first;
    //---
    approvedNAMEs:=tCmpCopyRAST_srcTree_approvedNAMEs.Create(self);
    with approvedNAMEs do begin
        Parent:=self;
        Align :=alRight;
        //
        AnchorSide[akLeft].Control:=Panel1;
        AnchorSide[akLeft].Side   :=asrRight;
        Anchors:=Anchors+[akLeft];
        //
        AnchorSide[akBottom].Control:=Panel2;
        //
//        OnClick           :=@TreeView1Click;
        OnSelectionChanged:=@TreeView1SelectionChanged;
    end;  }
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
    _GO_reNAMEs_;
end;

procedure TForm1.FormDestroy(Sender: TObject);
var s:string;
begin
    first.FREE;
    reNames.FREE;
    builder.FREE;
 {   s:=ChangeFileExt(ParamStr(0),'.xml');
    builder.Free;
    cnfg.SaveToFile(S);
    cnfg.FREE;
                }
end;

procedure TForm1.FormResize(Sender: TObject);
begin
    //Panel1.Left:=(Form1.Width-panel1.Width) div 2;;
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

//------------------------------------------------------------------------------

procedure TForm1._GO_reNAMEs_;
//var _reNames_:tCopyRastSrcTree_prcH4ReNAMEs;
    //_resRoot_:tSrcTree_ROOT;
begin
{   _resRoot_:=tCopyRastNODE_Root4Package(approvedNAMEs.Root);
    approvedNAMEs.Root:=nil;
    //---
   _resRoot_.FREE;
    //-------------------------------

   _reNames_:=tCopyRastSrcTree_prcH4ReNAMEs.Create(builder);
   _reNames_.EXECUTE(First,cnfg,_resRoot_);
   _reNames_.FREE;

    approvedNAMEs.Root:=_resRoot_; }
end;

end.

