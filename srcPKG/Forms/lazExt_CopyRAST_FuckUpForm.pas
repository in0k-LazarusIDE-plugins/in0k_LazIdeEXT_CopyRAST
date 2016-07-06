unit lazExt_CopyRAST_FuckUpForm;

{$mode objfpc}{$H+}

interface

uses Forms,
  in0k_lazIdeSRC_FuckUpForm_01;

type

 tLazExt_CopyRAST_FuckUpForm=class(tIn0k_lazIdeSRC_FuckUpForm)
  protected
   _PRNT_:TForm;
  public
    constructor Create(const ParentForm:tForm);
  public
    procedure ParentForm_CLEAR;
  protected //< пользоваьельский
    procedure FuckUP_onCLR; override;
  public
    property Form;
  end;


implementation

constructor tLazExt_CopyRAST_FuckUpForm.Create(const ParentForm:tForm);
begin
    inherited Create;
   _PRNT_:=ParentForm;
end;

procedure tLazExt_CopyRAST_FuckUpForm.ParentForm_CLEAR;
begin
   _PRNT_:=nil;
end;

procedure tLazExt_CopyRAST_FuckUpForm.FuckUP_onCLR;
begin
   if Assigned(_PRNT_) then _PRNT_.Close;
end;

end.

