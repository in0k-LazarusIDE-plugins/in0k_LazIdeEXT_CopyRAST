unit Unit1;

{$mode objfpc}{$H+}

interface

uses makeTest_copyRastOBJ,
  in0k_lazIdeSRC_CopyRAST_srcTree,
  cmpCopyRAST_srcTree,
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    TreeView1: TTreeView;
    procedure FormCreate(Sender: TObject);
    procedure TreeView1AdvancedCustomDrawItem(Sender: TCustomTreeView;
      Node: TTreeNode; State: TCustomDrawState; Stage: TCustomDrawStage;
      var PaintImages, DefaultDraw: Boolean);
    procedure TreeView1CustomDrawItem(Sender: TCustomTreeView; Node: TTreeNode;
      State: TCustomDrawState; var DefaultDraw: Boolean);
  private
    procedure _paint_redLine_(Sender:TCustomTreeView; Node:TTreeNode);
    procedure _paint_grayTXT_(Sender:TCustomTreeView; Node:TTreeNode);

  public
    cmpCopyRAST:tCmpCopyRAST_srcTree;
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
var builder:tCopyRastSrcTree_Builder4Package;
begin
    builder:=tCopyRastSrcTree_Builder4Package.Create;
    //---
    cmpCopyRAST:=tCmpCopyRAST_srcTree.Create(self);
    with cmpCopyRAST do begin
        Parent:=self;
        Align:=alClient;
        Root:=makeTest_objCopyRAST(builder);
    end;
    //---
    builder.FREE;
end;


procedure TForm1._paint_redLine_(Sender:TCustomTreeView; Node:TTreeNode);
var rect:tRect;
begin
    rect:=Node.DisplayRect(true);
    rect.Top:=rect.Top+(rect.Bottom-rect.Top)div 2;
    //
    sender.Canvas.Pen.Color:=clRed;
    sender.Canvas.Line(Rect.Left,rect.Top, rect.Right,rect.Top);
end;

procedure TForm1._paint_grayTXT_(Sender:TCustomTreeView; Node:TTreeNode);
var rect:tRect;
begin
    rect:=Node.DisplayRect(true);
    //
    sender.Canvas.Font.Color:=clRed;
    sender.Canvas.TextRect(Rect,rect.Left,rect.top,Node.Text);
    //sender.Canvas.Line(Rect.Left,rect.Top, rect.Right,rect.Top);
end;



procedure TForm1.TreeView1AdvancedCustomDrawItem(Sender: TCustomTreeView;
  Node: TTreeNode; State: TCustomDrawState; Stage: TCustomDrawStage;
  var PaintImages, DefaultDraw: Boolean);
begin
    case Stage of
      cdPrePaint: begin
          sender.Canvas.Font.Color:=clGray;
          // _paint_grayTXT_(Sender,Node);
          DefaultDraw:=true;
      end;
      cdPostPaint: begin
          //sender.Canvas.Font.Color:=clGray;
         _paint_grayTXT_(Sender,Node);
         _paint_redLine_(Sender,Node);
          DefaultDraw:=true;
      end;
      cdPreErase: begin
          sender.Canvas.Font.Color:=clGray;
          DefaultDraw:=true;
      end;
      cdPostErase: begin
          sender.Canvas.Font.Color:=clGray;
          DefaultDraw:=true;
      end;
    end;
    //SetTextColor(sender.Canvas.Handle,clGray) ;
end;

procedure TForm1.TreeView1CustomDrawItem(Sender: TCustomTreeView;
  Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
      sender.Canvas.Font.Color:=clGray;
     _paint_grayTXT_(Sender,Node);
      DefaultDraw:=FALSE;
end;

end.

