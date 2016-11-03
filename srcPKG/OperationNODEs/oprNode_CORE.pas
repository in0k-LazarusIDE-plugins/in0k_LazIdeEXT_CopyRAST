unit oprNode_CORE;

{$mode objfpc}{$H+}

interface

uses
    Classes, SysUtils;


type

 tOperationNode_CORE=class
  strict private
   _prnt_:tOperationNode_CORE;
   _node_:pointer;
  strict private
   _onOPR_:pointer;
   _onERR_:pointer;
  protected
    procedure do_onOPR(const text:string);
    procedure do_onERR(const text:string);
  end;



implementation

end.

