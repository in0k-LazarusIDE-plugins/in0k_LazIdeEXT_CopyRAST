unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  in0k_lazIdeSRC_srcTree_CORE_item,
  in0k_lazIdeSRC_srcTree_item_Globals,

  in0k_lazIdeSRC_srcTree_FNK_baseDIR_FND,
  in0k_lazIdeSRC_srcTree_FNK_fsFLDR_FND,

  in0kLazExt_CopyRAST_srcTree_HandlerReNAMEs_CNFGs,

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
    ListView1: TListView;
    StringGrid1: TStringGrid;
    XMLConfig1: TXMLConfig;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure ListView1Editing(Sender: TObject; Item: TListItem;
      var AllowEdit: Boolean);
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
  public
    destructor DESTROY; override;
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
var s:string;
  tmp:tCopyRAST_HandlerCNFGs_ReNAMEs_template_node;
  asd:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List;
  itm:tSrcTree_item;
begin
    inherited;
    builder:=tCopyRastSrcTree_Builder4Package.Create;
    reNames:=tCopyRastSrcTree_prcH4ReNAMEs.Create(builder);

    first  :=tCopyRastNODE_Root4Package(makeTest_objCopyRAST(builder));

    reNames.ROOT_old:=first;




    frmApprovedFILEs2NAMEs1.Handler:=reNames;


    s:=ChangeFileExt(ParamStr(0),'.xml');
    XMLConfig1.Filename:=(s);
    reNames.CNFGs_LOAD(XMLConfig1);

    {asd:=tCopyRAST_HandlerCNFGs_ReNAMEs_template_List.Create;
    tmp:=tCopyRAST_HandlerCNFGs_ReNAMEs_template_node.Create;
    tmp.Template:='^in0k_lazIdeSRC_(\w+)(\.pas)$';
    tmp.Exchange:='asdf$1$2';
    asd.Add(tmp);
    tmp:=tCopyRAST_HandlerCNFGs_ReNAMEs_template_node.Create;
    tmp.Template:='^inasdfasdf0k_lazIdeSRC_(\w+)(\.pas)$';
    tmp.Exchange:='afffffffsdf$1$2';
    asd.Add(tmp);

    reNames.CNFG_template_SET( SrcTree_fndFsFLDR(first,'D:\!PROGECTs\!in0k\in0k_LazIdeEXT_CopyRAST\srcPKG\OperationNODEs'),asd);
    asd.FREE;    }
    //cnfg:=TXMLConfig.Create(Self);//(s);
    //cnfg.LoadFromFile(s);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
    _GO_reNAMEs_;
end;


destructor TForm1.DESTROY;
begin
    inherited;
    reNames.FREE;
    builder.FREE;
    first.FREE;
end;

procedure TForm1.FormDestroy(Sender: TObject);
var s:string;
begin
    reNames.CNFGs_SAVE(XMLConfig1);
    //s:=ChangeFileExt(ParamStr(0),'.xml');
    XMLConfig1.Flush;

    frmApprovedFILEs2NAMEs1.Handler:=nil;

    frmApprovedFILEs2NAMEs1.FREE;
    frmApprovedFILEs2NAMEs1:=nil;


    //cnfg.SaveToFile(S);
    //cnfg.Flush;
    //cnfg.FREE;
    //---
    inherited;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
    //Panel1.Left:=(Form1.Width-panel1.Width) div 2;;
end;

procedure TForm1.ListView1Editing(Sender: TObject; Item: TListItem;
  var AllowEdit: Boolean);
begin
   AllowEdit:=true;
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

