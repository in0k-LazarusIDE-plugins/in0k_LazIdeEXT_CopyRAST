unit in0kLazExt_CopyRAST_srcTree_HandlerReNAMEs_CNFGs;

{$mode objfpc}{$H+}

interface

uses
  CopyRAST_srcTree_4Handler_CNFGs,

  contnrs,
  Classes, SysUtils;

type //=========================================================================

 tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node=class(tCopyRAST_srcTree_4Handler_CNFGsNode)
  protected
   _nameStated_:string;
   _pathStated_:string;
   _nameCustom_:boolean;
   _pathCustom_:boolean;
  public
    property NameCustom:boolean read _nameCustom_ write _nameCustom_;
    property NameStated:string  read _nameStated_ write _nameStated_;
    property PathCustom:boolean read _pathCustom_ write _pathCustom_;
    property PathStated:string  read _pathStated_ write _pathStated_;
  public
    constructor Create;
    destructor DESTROY; override;
  public
    procedure COPY(const Source:tCopyRAST_srcTree_4Handler_CNFGsNode); override;
    function needSAVE:boolean;                                         override;
  end;

 tCopyRAST_HandlerCNFGs_ReNAMEs_customer_LAER=class(tCopyRAST_srcTree_4Handler_CNFGs)
  protected
    function _CNFG_CRT_:tCopyRAST_srcTree_4Handler_CNFGsNode; override;
  end;

type //=========================================================================

 tCopyRAST_Handler_ReNAMEs_template=class(tCopyRAST_srcTree_4Handler_CNFGsNode)
  protected
   _template_:string;
   _exchange_:string;
  public
    property Template:string read _template_ write _template_;
    property Exchange:string read _exchange_ write _exchange_;
  public
    constructor Create;
    destructor DESTROY; override;
  public
    procedure COPY(const Source:tCopyRAST_srcTree_4Handler_CNFGsNode); override;
    function needSAVE:boolean;                                         override;
  end;

 tCopyRAST_HandlerCNFGs_ReNAMEs_template_List=class(tCopyRAST_srcTree_4Handler_CNFGsLAIR)
  end;

 tCopyRAST_HandlerCNFGs_ReNAMEs_template_LAIR=class(tCopyRAST_srcTree_4Handler_CNFGs)
  protected
    function _CNFG_CRT_:tCopyRAST_srcTree_4Handler_CNFGsNode; override;
  end;

implementation

{%region --- customer ---------------------------------------------------}

constructor tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node.Create;
begin
   _nameCustom_:=false;
   _nameStated_:='';
   _pathCustom_:=false;
   _pathStated_:='';
end;

destructor tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node.DESTROY;
begin
    inherited;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node.COPY(const Source:tCopyRAST_srcTree_4Handler_CNFGsNode);
begin
    {$ifOpt D+}
    Assert(Assigned(Source));
    Assert(Source is tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node);
    {$endIf}
   _nameCustom_:=tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node(Source).NameCustom;
   _nameStated_:=tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node(Source).NameStated;
   _pathCustom_:=tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node(Source).PathCustom;
   _pathStated_:=tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node(Source).PathStated;
end;

function tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node.needSAVE:boolean;
begin
    result:= NOT // ОТРИЦАЕМ состояние "НУЛИВОВГО состояния" (не заданного)
             (
                (_nameStated_='')and(_nameCustom_=false)
                AND
                (_pathStated_='')and(_pathCustom_=false)
             );
end;

//==============================================================================

function tCopyRAST_HandlerCNFGs_ReNAMEs_customer_LAER._CNFG_CRT_:tCopyRAST_srcTree_4Handler_CNFGsNode;
begin
    result:=tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node.Create;
end;

{%endregion}

{%region --- template ---------------------------------------------------}

constructor tCopyRAST_Handler_ReNAMEs_template.Create;
begin
   _template_:='';
   _exchange_:='';
end;

destructor tCopyRAST_Handler_ReNAMEs_template.DESTROY;
begin
    inherited;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tCopyRAST_Handler_ReNAMEs_template.COPY(const Source:tCopyRAST_srcTree_4Handler_CNFGsNode);
begin
    {$ifOpt D+}
    Assert(Assigned(Source));
    Assert(Source is tCopyRAST_Handler_ReNAMEs_template);
    {$endIf}
   _template_:=tCopyRAST_Handler_ReNAMEs_template(Source).Template;
   _exchange_:=tCopyRAST_Handler_ReNAMEs_template(Source).Exchange;
end;

function tCopyRAST_Handler_ReNAMEs_template.needSAVE:boolean;
begin
    result:=(_template_<>'')or(_exchange_<>'');
end;

//==============================================================================

function tCopyRAST_HandlerCNFGs_ReNAMEs_template_LAIR._CNFG_CRT_:tCopyRAST_srcTree_4Handler_CNFGsNode;
begin
    result:=tCopyRAST_HandlerCNFGs_ReNAMEs_template_List.Create;
end;

{%endregion}

end.

