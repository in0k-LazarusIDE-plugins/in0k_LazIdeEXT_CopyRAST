unit in0k_CopyRAST__STAGE_02__cnfg_FILEsAdd;

{$mode objfpc}{$H+}

interface

uses
  CopyRAST_srcTree_4Handler_CNFGs;

type

 tCopyRAST_HandlerCNFGs_reVision__FILEsAdd_node=class(tCopyRAST_srcTree_4Handler_CNFGsNode)
  protected
   _fileName_ :string; //< имя Файла
  public
    property fileName:string read _fileName_ write _fileName_;
  public
    constructor Create;
    destructor DESTROY; override;
  public
    procedure COPY(const Source:tCopyRAST_srcTree_4Handler_CNFGsNode); override;
    function needSAVE:boolean;                                         override;
  end;

 tCopyRAST_HandlerCNFGs_reVision__FILEsAdd_List=class(tCopyRAST_srcTree_4Handler_CNFGsLAIR)
  protected
    function  _item_GET_(Index:Integer):tCopyRAST_HandlerCNFGs_reVision__FILEsAdd_node;
    procedure _item_SET_(Index:Integer; value:tCopyRAST_HandlerCNFGs_reVision__FILEsAdd_node);
  public
    property Items[Index:integer]:tCopyRAST_HandlerCNFGs_reVision__FILEsAdd_node read _item_GET_ write _item_SET_;
    function needSAVE:boolean; override;
  public
    constructor Create;
  end;



implementation

{%region /fold --- node -------------------------------------------------}

constructor tCopyRAST_HandlerCNFGs_reVision__FILEsAdd_node.Create;
begin
   _fileName_ :='';
end;

destructor tCopyRAST_HandlerCNFGs_reVision__FILEsAdd_node.DESTROY;
begin
    inherited;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tCopyRAST_HandlerCNFGs_reVision__FILEsAdd_node.COPY(const Source:tCopyRAST_srcTree_4Handler_CNFGsNode);
begin
    {$ifOpt D+}
    Assert(Assigned(Source));
    Assert(Source is tCopyRAST_HandlerCNFGs_reVision__FILEsAdd_node);
    {$endIf}
   _fileName_ :=tCopyRAST_HandlerCNFGs_reVision__FILEsAdd_node(Source).fileName;
end;

function tCopyRAST_HandlerCNFGs_reVision__FILEsAdd_node.needSAVE:boolean;
begin
    result:= NOT // ОТРИЦАЕМ состояние "НУЛИВОВГО состояния" (не заданного)
             (
                (_fileName_='')
             );
end;

{%endregion    --- node -------------------------------------------------}


{%region /fold --- list -------------------------------------------------}

constructor tCopyRAST_HandlerCNFGs_reVision__FILEsAdd_List.Create;
begin
    inherited;
end;

//------------------------------------------------------------------------------

function tCopyRAST_HandlerCNFGs_reVision__FILEsAdd_List._item_GET_(Index:Integer):tCopyRAST_HandlerCNFGs_reVision__FILEsAdd_node;
begin
    result:=tCopyRAST_HandlerCNFGs_reVision__FILEsAdd_node(inherited _item_GET_(Index));
end;

procedure tCopyRAST_HandlerCNFGs_reVision__FILEsAdd_List._item_SET_(Index:Integer; value:tCopyRAST_HandlerCNFGs_reVision__FILEsAdd_node);
begin
    inherited _item_SET_(Index,value);
end;

//------------------------------------------------------------------------------

function tCopyRAST_HandlerCNFGs_reVision__FILEsAdd_List.needSAVE:boolean;
//var i:integer;
//  tmp:tCopyRAST_HandlerCNFGs_ReNAMEs_macros_node;
begin
    result:=false;
//    for i:=0 to _LAIR_CNT_-1 do begin
//        if Items[i].needSAVE then begin
//            result:=true;
//            Break;
//        end;
//    end;
end;

{%endregion    --- list -------------------------------------------------}


end.

