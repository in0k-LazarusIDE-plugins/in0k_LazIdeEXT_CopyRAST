unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  in0k_lazIdeSRC_CopyRAST_srcTree,
  in0k_lazIdeSRC_CopyRAST_srcTree_Nodes,
  in0k_lazIdeSRC_CopyRAST_srcTree_HandlerReNAMEs,

  makeTest_copyRastOBJ,
  //
  cmpCopyRAST_srcTree_approvedFiles,
  cmpCopyRAST_srcTree_approvedNAMEs,
  //
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Panel1: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    approvedFILEs:tCmpCopyRAST_srcTree_approvedFILEs;
    approvedNAMEs:tCmpCopyRAST_srcTree_approvedNAMEs;
  protected
    procedure _GO_reNAMEs_;
  public
    first:tCopyRastNODE_ROOT;




  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
    first:=makeTest_objCopyRAST;

    approvedFILEs:=tCmpCopyRAST_srcTree_approvedFILEs.Create(self);
    with approvedFILEs do begin
        Parent:=self;
        Align :=alLeft;
        //
        AnchorSide[akRight].Control:=Panel1;
        AnchorSide[akRight].Side   :=asrLeft;
        //
        Anchors:=Anchors+[akRight];
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
    end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
    _GO_reNAMEs_;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
end;

procedure TForm1.FormResize(Sender: TObject);
begin
    Panel1.Left:=(Form1.Width-panel1.Width) div 2;;
end;

//------------------------------------------------------------------------------

procedure TForm1._GO_reNAMEs_;
var _builder_:tCopyRastSrcTree_Builder4Package;
var _reNames_:tCopyRastSrcTree_H4ReNAMEs;
    _resRoot_:tCopyRastNODE_ROOT;
begin
   _resRoot_:=tCopyRastNODE_ROOT(approvedNAMEs.Root);
    approvedNAMEs.Root:=nil;
    //---
   _resRoot_.FREE;
    //-------------------------------

   _builder_:=tCopyRastSrcTree_Builder4Package.Create;
   _reNames_:=tCopyRastSrcTree_H4ReNAMEs.Create(_builder_);


   _reNames_.EXECUTE(First,_resRoot_);

   _reNames_.FREE;
   _builder_.FREE;


    approvedNAMEs.Root:=_resRoot_;

end;

end.

