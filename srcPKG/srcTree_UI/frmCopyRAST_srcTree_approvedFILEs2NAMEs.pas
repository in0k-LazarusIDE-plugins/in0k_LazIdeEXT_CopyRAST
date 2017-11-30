unit frmCopyRAST_srcTree_approvedFILEs2NAMEs;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, CheckBoxThemed, Forms, Controls, ExtCtrls,
  StdCtrls, cmpCopyRAST_srcTree_approvedFiles,
  cmpCopyRAST_srcTree_approvedNAMEs,
  in0kLazExt_CopyRAST_srcTree_HandlerReNAMEs;

type

 { TfrmApprovedFILEs2NAMEs }

 TfrmApprovedFILEs2NAMEs = class(TFrame)
    CheckBoxThemed2: TCheckBoxThemed;
    CheckBoxThemed3: TCheckBoxThemed;
    Edit1: TEdit;
    Edit2: TEdit;
    pnlMDL: TPanel;
    pnlPRP: TPanel;
    procedure FrameResize(Sender: TObject);
    procedure pnlPRPResize(Sender: TObject);
  private
   _treeL_:tCmpCopyRAST_srcTree_approvedFILEs;
   _treeR_:tCmpCopyRAST_srcTree_approvedNAMEs;
  private
   _HNDLR_:tCopyRastSrcTree_prcH4ReNAMEs;
    procedure _HNDLR_set_(const value:tCopyRastSrcTree_prcH4ReNAMEs);
  public
    constructor Create(AOwner:TComponent); override;
  public
    property Handler:tCopyRastSrcTree_prcH4ReNAMEs read _HNDLR_ write _HNDLR_set_;
  end;

implementation

{$R *.lfm}


constructor TfrmApprovedFILEs2NAMEs.Create(AOwner:TComponent);
begin
    inherited Create(AOwner);
    //---
   _treeL_:=tCmpCopyRAST_srcTree_approvedFILEs.Create(Self);
    with _treeL_ do begin
        Parent:=Self;
        //
        with AnchorSide[akLeft] do begin
            Control:=Self;
            Side   :=asrLeft;
        end;
        with AnchorSide[akTop] do begin
            Control:=Self;
            Side   :=asrTop;
        end;
        with AnchorSide[akRight] do begin
            Control:=pnlMDL;
            Side   :=asrLeft;
        end;
        with AnchorSide[akBottom] do begin
            Control:=pnlPRP;
            Side   :=asrTop;
        end;
        //
        Anchors:=[akTop, akLeft, akRight, akBottom];
    end;
    //---
   _treeR_:=tCmpCopyRAST_srcTree_approvedNAMEs.Create(Self);
    with _treeR_ do begin
        Parent:=Self;
        //
        with AnchorSide[akLeft] do begin
            Control:=pnlMDL;
            Side   :=asrRight;
        end;
        with AnchorSide[akTop] do begin
            Control:=Self;
            Side   :=asrTop;
        end;
        with AnchorSide[akRight] do begin
            Control:=Self;
            Side   :=asrRight;
        end;
        with AnchorSide[akBottom] do begin
            Control:=pnlPRP;
            Side   :=asrTop;
        end;
        //
        Anchors:=[akTop, akLeft, akRight, akBottom];
    end;

end;

//------------------------------------------------------------------------------

procedure TfrmApprovedFILEs2NAMEs._HNDLR_set_(const value:tCopyRastSrcTree_prcH4ReNAMEs);
begin
   _HNDLR_:=value;
   _treeL_.Root:=_HNDLR_.ROOT_old;
   _treeR_.Root:=_HNDLR_.ROOT_NEW;
end;

//------------------------------------------------------------------------------

procedure TfrmApprovedFILEs2NAMEs.FrameResize(Sender: TObject);
begin
    pnlMDL.Left:=(TFrame(Sender).Width-pnlMDL.Width) div 2;
end;

procedure TfrmApprovedFILEs2NAMEs.pnlPRPResize(Sender: TObject);
var w:integer;
begin
    w:=0;
    if w<CheckBoxThemed2.Width then w:=CheckBoxThemed2.Width;
    if w<CheckBoxThemed3.Width then w:=CheckBoxThemed3.Width;
    Edit1.Left:=w+2;
end;

end.

