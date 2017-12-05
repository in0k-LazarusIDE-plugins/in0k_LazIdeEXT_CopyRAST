unit in0kLazExt_CopyRAST_srcTree_HandlerReNAMEs_CNFGs;

{$mode objfpc}{$H+}

interface

uses
  contnrs,
  Classes, SysUtils;


type

 tCopyRAST_srcTree_HandlerReNAMEs_CNFGs4NAME=class
  public
    nameNew:string;
    nameCst:boolean;
    pathNew:string;
    pathCst:boolean;
  public
    function  SaveNEED:boolean;
    procedure CLEAR;
  public
    procedure Copy(const Target:tCopyRAST_srcTree_HandlerReNAMEs_CNFGs4NAME);
  public
    destructor DESTROY; override;
  end;



 tCopyRAST_Handler_ReNAMEs_template=class(tCopyRAST_srcTree_HandlerReNAMEs_CNFGs4NAME);

 tCopyRAST_Handler_ReNAMEs_CNFGs4NameLAER=class(TObjectList)
  protected
    function GetItem(Index: Integer): tCopyRAST_Handler_ReNAMEs_template;
    procedure SetItem(Index: Integer; AObject: tCopyRAST_Handler_ReNAMEs_template);
  public
    constructor Create;
    destructor DESTROY; override;
  private
    property OwnsObjects;
  public
    function Add(AObject:tCopyRAST_Handler_ReNAMEs_template): Integer;
    property Items[Index:Integer]:tCopyRAST_Handler_ReNAMEs_template read GetItem write SetItem;
  end;

 tCopyRAST_Handler_ReNAMEs_CNFGs4NameLIST=class(tCopyRAST_Handler_ReNAMEs_CNFGs4NameLAER)
  public
    constructor Create;
  end;




implementation

destructor tCopyRAST_srcTree_HandlerReNAMEs_CNFGs4NAME.DESTROY;
begin
    inherited;
end;

procedure tCopyRAST_srcTree_HandlerReNAMEs_CNFGs4NAME.CLEAR;
begin
    nameNew:='';
    nameCst:=false;
    pathNew:='';
    pathCst:=false;
end;

function tCopyRAST_srcTree_HandlerReNAMEs_CNFGs4NAME.SaveNEED:boolean;
begin
    result:=(nameNew<>'')or(pathNew<>'');
end;

procedure tCopyRAST_srcTree_HandlerReNAMEs_CNFGs4NAME.Copy(const Target:tCopyRAST_srcTree_HandlerReNAMEs_CNFGs4NAME);
begin
    nameNew:=Target.nameNew;
    nameCst:=Target.nameCst;
    pathNew:=Target.pathNew;
    pathCst:=Target.pathCst;
end;

//==============================================================================

constructor tCopyRAST_Handler_ReNAMEs_CNFGs4NameLAER.Create;
begin
    inherited;
    OwnsObjects:=TRUE;
end;

destructor tCopyRAST_Handler_ReNAMEs_CNFGs4NameLAER.DESTROY;
begin
    inherited;
end;

//------------------------------------------------------------------------------

function tCopyRAST_Handler_ReNAMEs_CNFGs4NameLAER.Add(AObject:tCopyRAST_Handler_ReNAMEs_template):Integer;
begin
    result:=inherited Add(AObject);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function tCopyRAST_Handler_ReNAMEs_CNFGs4NameLAER.GetItem(Index: Integer): tCopyRAST_Handler_ReNAMEs_template;
begin
    result:=tCopyRAST_Handler_ReNAMEs_template(inherited GetItem(index));
end;

procedure tCopyRAST_Handler_ReNAMEs_CNFGs4NameLAER.SetItem(Index: Integer; AObject: tCopyRAST_Handler_ReNAMEs_template);
begin
    inherited SetItem(index, AObject);
end;

//==============================================================================

constructor tCopyRAST_Handler_ReNAMEs_CNFGs4NameLIST.Create;
begin
    inherited;
    OwnsObjects:=FALSE;
end;

end.

