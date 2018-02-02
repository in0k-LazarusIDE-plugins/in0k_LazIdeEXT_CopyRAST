unit in0k_lazarusIdeSRC_ideMacrosCODE;

{$mode objfpc}{$H+}

interface

uses
  LazUTF8, LazFileUtils,
  MacroIntf,
  Classes,
  Dialogs;

// расшифровать
function ideMacros_deCODE(const value:string):string;

// ЗАШИФРОВАТЬ
function ideMacros_enCODE(const value:string; const Names:tStrings):string;

implementation

const
 _cMacro_OPN_='$(';
 _cMacro_CLS_= ')';

function _name2Macros_(const value:string):string; inline;
begin
    result:=_cMacro_OPN_+value+_cMacro_CLS_;
end;

//------------------------------------------------------------------------------

function ideMacros_deCODE(const value:string):string;
begin
    result:=value;
    IDEMacros.SubstituteMacros(result);
end;

//------------------------------------------------------------------------------

function ideMacros_enCODE(const value:string; const Names:tStrings):string;
var i     :integer;
var mName :string;
    mValue:string;
var iPos  :integer;
begin
    result:=value;
    for i:=0 to Names.Count-1 do begin
        mName :=_name2Macros_(Names.Strings[i]);
        mValue:= ChompPathDelim(ideMacros_deCODE(mName));
        iPos:=UTF8Pos(mValue,result);
        while iPos>0 do begin
            UTF8Delete(result,iPos,length(mValue));
            UTF8Insert(mName,result,iPos);
            //-->
            iPos:=UTF8Pos(mValue,result);
            //ShowMessage(result);
        end;
    end;
end;

end.

