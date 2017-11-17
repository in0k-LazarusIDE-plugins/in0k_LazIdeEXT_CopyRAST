unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  in0k_lazIdeSRC_CopyRAST_srcTree_Nodes,

  makeTest_copyRastOBJ,
  //
  cmpCopyRAST_srcTree_approvedFiles,
  //
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs;

type

  { TForm1 }

  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    approvedFILEs:tCmpCopyRAST_srcTree_approvedFILEs;
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
    end;
    //---
    approvedFILEs.Root:=first;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
end;

end.

