unit in0k_lazIdeSRC_ExpertCORE;

{$mode objfpc}{$H+}

interface

uses IDEIntf, LazIDEIntf;

type

 tIn0k_lazIdeSRC_ExpertCORE=class
  private
    procedure _On_IDE_Close_({%H-}Sender:TObject);
    procedure _Expert_CLEAN_; inline;
    procedure _Expert_SetUP_; inline;
  protected
    procedure LazarusIDE_SetUP; virtual;
    procedure LazarusIDE_CLEAN; virtual;
  PUBLIC
    procedure Expert_SetUP;
  end;

implementation

procedure tIn0k_lazIdeSRC_ExpertCORE._Expert_CLEAN_;
begin
    LazarusIDE.RemoveHandlerOnIDEClose(@_On_IDE_Close_);
    LazarusIDE_CLEAN;
end;

procedure tIn0k_lazIdeSRC_ExpertCORE._Expert_SetUP_;
begin
    LazarusIDE.AddHandlerOnIDEClose(@_On_IDE_Close_);
    LazarusIDE_SetUP;
end;

//------------------------------------------------------------------------------

procedure tIn0k_lazIdeSRC_ExpertCORE._On_IDE_Close_({%H-}Sender:TObject);
begin
   _Expert_CLEAN_;
end;

//------------------------------------------------------------------------------

procedure tIn0k_lazIdeSRC_ExpertCORE.Expert_SetUP;
begin
   _Expert_SetUP_;
end;

//------------------------------------------------------------------------------

procedure tIn0k_lazIdeSRC_ExpertCORE.LazarusIDE_SetUP;
begin

end;

procedure tIn0k_lazIdeSRC_ExpertCORE.LazarusIDE_CLEAN;
begin

end;

end.

