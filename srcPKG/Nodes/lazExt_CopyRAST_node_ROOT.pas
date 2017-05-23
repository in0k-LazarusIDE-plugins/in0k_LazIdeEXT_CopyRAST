unit lazExt_CopyRAST_node_ROOT;

{$mode objfpc}{$H+}

interface

{$define _DEBUG_}

{$i in0k_lazIdeSRC_SETTINGs.inc} //< настройки компанента-Расширения.
//< Можно смело убирать, так как будеть работать только в моей специальной
//< "системе имен и папок" `in0k_LazExt_..`.


uses {$ifDef in0k_lazExt_CopyRAST_wndCORE___DebugLOG}in0k_lazIdeSRC_DEBUG,{$endIf}
     sysutils,  FileUtil, PackageIntf, LazFileUtils, LazIDEIntf, Dialogs, Forms,
                            Classes,
    CodeToolManager, CodeCache,  CustomCodeTool,
    //Dialogs,
     in0k_lazIdeSRC_srcTree_coreFromIDEProcs,
     lazExt_CopyRAST_node,
     lazExt_CopyRAST_node_File,
     lazExt_CopyRAST_node_Folder;

type
 tLazExt_CopyRAST_operation_CORE=class;
 tLazExt_CopyRAST_operation_CORE_twoStep=class;


 f_doOperation=procedure(const Node:tCopyRAST_node; const Operation:tLazExt_CopyRAST_operation_CORE; var exCount,ChCount,ErCount:integer) of object;


 tCopyRAST_ROOT=class(tCopyRAST_node)
  protected
   _operationList_:TList;
  protected
    function  _get_BaseDIR_:tCopyRAST_node_BaseDIR;
    procedure _set_BaseDIR_(const BaseDIR:string);
    function  _get_BaseDIR_PATH_:string;
    function  _get_rltvDIR_(const Folder:tCopyRAST_node_Folder):string;
  protected
    function  _tst_FileSRC_lfmHAVE_(const FileName:string):boolean;
    function  _tst_FileSRC_lfmNAME_(const FileName:string):string;
    function  _tst_FileXXX_haveLFM_(const FileXXX:tCopyRAST_node_File):boolean;
  protected
    function _LazIDE_loadFile_(const node:tCopyRAST_node_FILE):TCodeBuffer;

  protected
    procedure _prepare_fileLFM_fnd8add_(const Folder:tCopyRAST_node_Folder);
    procedure _prepare_fileLFM_fnd8add_;
  protected
    procedure _prepare_fileUSE_fnd8add_(const fullFileName:string);
    procedure _prepare_fileUSE_fnd8add_(const nameLst:TStringList);
    procedure _prepare_fileUSE_fnd8add_(const FileXXX:tCopyRAST_node_File);
    procedure _prepare_fileUSE_fnd8add_(const Folder:tCopyRAST_node_Folder);
    procedure _prepare_fileUSE_fnd8add_;
  protected
    function  _PathFLDR_fnd_(const PathFLDR:string):tCopyRAST_node_Folder;
    function  _PathFLDR_GET_(const PathFLDR:string):tCopyRAST_node_Folder;
  protected
    function  _fileXXXX_fnd_(const Folder:tCopyRAST_node_Folder; const FileName:string):tCopyRAST_node_FILE;
    function  _fileXXXX_fnd_(const FullFileName:string):tCopyRAST_node_FILE;
  protected
    function  _fnd_fileSRC_(const Folder:tCopyRAST_node_Folder; const FileNameWithoutExt:string):tCopyRAST_node;
    procedure _add_SrchPTH_(const SrchPTH:string; const KIND:eCopyRAST_node_SrchPath);
    procedure _add_FileXXX_(const FileXXX:tCopyRAST_node_File);
  protected
    function  _copyRast_txt(const node:tCopyRAST_node_FILE):boolean;
    function  _copyRast_bin(const node:tCopyRAST_node_FILE):boolean;

    function  _copyRast_getOldPATH_(const node:tCopyRAST_node_FILE):string;
    function  _copyRast_getNewPATH_(const node:tCopyRAST_node_FILE; const BaseDir:string):string;
    function  _copyRast_COPY_FILE_ (const node:tCopyRAST_node_FILE; const BaseDir:string):boolean;
    function  _copyRast_COPY_      (const node:tCopyRAST_node;      const BaseDir:string):boolean;

    function  _copyRast_FileUPDATE_File(const node:tCopyRAST_node_FILE):boolean;
    function  _copyRast_FileUPDATE_(const node:tCopyRAST_node):boolean;





  protected
    //function _copyRast_prepare_Target_BaseDIR_(out   BaseDir:string; const Clear:boolean=true):boolean;
    //function _copyRast_prepare_Target_DirTREE_(const BaseDir:string; const Node:tCopyRAST_node):boolean;

  protected
    procedure _CopyRAST_operations_forEach_(const Node:tCopyRAST_node; const Operation:tLazExt_CopyRAST_operation_CORE; FNK:f_doOperation; var exCount,ChCount,ErCount:integer);


    function _CopyRAST_operation_secondStep_NODE_ (const Node:tCopyRAST_node; const Operation:tLazExt_CopyRAST_operation_CORE_twoStep):integer;
    function _CopyRAST_operations_secondStep_     (const Node:tCopyRAST_node; const Operation:tLazExt_CopyRAST_operation_CORE_twoStep):integer;
    procedure _CopyRAST_operation_nodeOneStep_doOperation_(const Node:tCopyRAST_node; const Operation:tLazExt_CopyRAST_operation_CORE; var exCount,ChCount,ErCount:integer);
    procedure _CopyRAST_operation_nodeTwoStep_doOperation_(const Node:tCopyRAST_node; const Operation:tLazExt_CopyRAST_operation_CORE; var exCount,ChCount,ErCount:integer);
    function _CopyRAST_operation_NODE_(const Node:tCopyRAST_node; const Operation:tLazExt_CopyRAST_operation_CORE):boolean;
    function _CopyRAST_operations_    (const Node:tCopyRAST_node; const Operation:tLazExt_CopyRAST_operation_CORE):integer;
  public
    function CopyRAST:boolean; virtual;

  public
    procedure onCreate_makeUp_operationList(const List:tList); virtual;
  public
    constructor Create(const nodeText:string);
    destructor DESTROY; override;
  public
    function Get_TARGET_basePath:string;
    function Get_SOURCE_basePath:string;

    function Get_Source_obj_Name:string; override;
    function Get_Source_dir_Name:string; override;

    function Get_Target_obj_Name:string; override;
    function Get_Target_dir_Name:string; override;

  end;



 tLazExt_CopyRAST_operation_CORE=class
  protected
   _Owner_:tCopyRAST_ROOT;
   _mssge_:string;
  protected
    function _getOperationName_:string; virtual;
    function _getOperationHint_:string; virtual;
    function _get_Message_Text_:string; virtual;
    {$ifdef _DEBUG_}
    function _getMessageOnSKIP_:boolean; virtual;
    {$endIf}
  protected
    function _doOperation_EDIT_(const Node:tCopyRAST_node; const nodeFileName:string):integer;
  public
    function  doOperation_EDIT(const Node:tCopyRAST_node;  const Code:TCodeBuffer; const Tool:TCodeTool):integer; virtual;
  public
    procedure Prepare4Use; virtual; //< так названо, просто для выравнивания ;-)
    function  Is_Possible(const Node:tCopyRAST_node):boolean; virtual;
    function  doOperation(const Node:tCopyRAST_node):integer; virtual;
    //---
    function  makeLogEnds(const Node:tCopyRAST_node):string; virtual;
  public
    constructor Create(const AOwner:tCopyRAST_ROOT);
  end;

 tLazExt_CopyRAST_operation_CORE_twoStep=class(tLazExt_CopyRAST_operation_CORE)
  public
    //    ClearStages

    function secondStep_Is_Possible(const Node:tCopyRAST_node):boolean; virtual;
    function secondStep_doOperation(const Node:tCopyRAST_node):integer; virtual;
  end;


























implementation

{%region --- возня с ДЕБАГОМ -------------------------------------- /fold}
{$if defined(in0k_lazIdeSRC_FuckUpForm___DebugLOG) AND declared(in0k_lazIde_DEBUG)}
    // `in0k_lazIde_DEBUG` - это функция ИНДИКАТОР что используется
    //                       моя "система имен и папок"
    {$define _debugLOG_}     //< типа да ... можно делать ДЕБАГ отметки
{$else}
    {$undef _debugLOG_}
{$endIf}
{%endregion}


constructor tCopyRAST_ROOT.Create(const nodeText:string);
begin
    inherited Create(source_Text);
   _operationList_:=TList.Create;
    onCreate_makeUp_operationList(_operationList_);
end;

destructor tCopyRAST_ROOT.DESTROY;
var i:integer;
  tmp:tLazExt_CopyRAST_operation_CORE;
begin
    for i:=0 to _operationList_.Count-1 do begin
        tmp:=tLazExt_CopyRAST_operation_CORE(_operationList_.Items[i]);
        if Assigned(tmp) then tmp.Free;
    end;
   _operationList_.Clear;
   _operationList_.FREE;
end;

//------------------------------------------------------------------------------

procedure tCopyRAST_ROOT.onCreate_makeUp_operationList(const List:tList);
begin
    //---
end;

//------------------------------------------------------------------------------


// поиск BaseDIR по типу
function tCopyRAST_ROOT._get_BaseDIR_:tCopyRAST_node_BaseDIR;
begin //< оно ДОЛЖНО быть в корне РЕБЕНКОМ
    result:=tCopyRAST_node_BaseDIR(_get_chldFrst_);
    while Assigned(result) do begin
       if TObject(Result) is tCopyRAST_node_BaseDIR then BREAK;
       result:=tCopyRAST_node_BaseDIR(tCopyRAST_node_BaseDIR(result).NodeNEXT);
    end;
end;

// установить BaseDIR
procedure tCopyRAST_ROOT._set_BaseDIR_(const BaseDIR:string);
var tmp:tCopyRAST_node_BaseDIR;
begin
    tmp:=_get_BaseDIR_;
    if not Assigned(tmp) then begin //< еще просто НЕ добавляли
        tmp:=tCopyRAST_node_BaseDIR.Create(BaseDIR);
       _ins_ChldFrst_(tmp);
    end
    else tCopyRAST_ROOT(tmp)._item_Text_:=BaseDIR;
end;

function tCopyRAST_ROOT._get_BaseDIR_PATH_:string;
var tmp:tCopyRAST_node_BaseDIR;
begin
    tmp:=_get_BaseDIR_;
    if Assigned(tmp) then begin
        result:=tmp.source_Text;
    end;
end;

function tCopyRAST_ROOT._get_rltvDIR_(const Folder:tCopyRAST_node_Folder):string;
var baseDir:tCopyRAST_node_BaseDIR;
begin
    result:='';
    baseDir:=_get_BaseDIR_;
    if baseDir<>Folder then begin
        if Folder.NodePRNT=baseDir then result:=''
        else begin
            if Folder.NodePRNT is tCopyRAST_node_Folder then result:=_get_rltvDIR_(tCopyRAST_node_Folder(Folder.NodePRNT))
        end;
        result:=result+DirectorySeparator+Folder.DirNAME;
    end
    else result:='';
end;

//------------------------------------------------------------------------------

// найти или СОЗДАТЬ путь к "ПАПКЕ" от корневой
function tCopyRAST_ROOT._PathFLDR_fnd_(const PathFLDR:string):tCopyRAST_node_Folder;
var prnt:tCopyRAST_node_Folder;
var tmp:tCopyRAST_node;
    fld:string;
begin
    result:=nil;
    prnt:=_get_BaseDIR_;
    if not Assigned(prnt) then EXIT; //< это КАСЯК, обработать как-то надо?
    if 0=CompareFilenames(PathFLDR+PathDelim,prnt.DirPATH) then begin
        result:=prnt;
    end
    else begin
        // исчем РОДИТЕЛЬСКИЙ путь
        fld:=ExtractFileDir(PathFLDR); //< это родительская директория
        if NOT ( (fld='')or(0=CompareFilenames(fld,prnt.DirPATH)) )
        then prnt:=_PathFLDR_fnd_(fld); //< исчем ГЛУБЖЕ, ближе к корню
        if not Assigned(prnt) then EXIT; //< это КАСЯК, обработать как-то надо?
        // исчем в родителе СЕБЯ
        fld:=ExtractFileName(PathFLDR); //< что именно искать будем
        pointer(result):=prnt.NodeCHLD;
        while Assigned(result) do begin
            if TObject(result) is tCopyRAST_node_PathDIR then begin
                if 0=CompareFilenames(fld,result.DirNAME) then begin
                    BREAK; // НАШЛИ
                end;
            end;
            pointer(result):=result.NodeNEXT;
        end;
    end;
end;

// найти или СОЗДАТЬ путь к "ПАПКЕ" от корневой
function tCopyRAST_ROOT._PathFLDR_GET_(const PathFLDR:string):tCopyRAST_node_Folder;
var prnt:tCopyRAST_node_Folder;
var tmp:tCopyRAST_node;
    fld:string;
begin
    result:=nil;
    prnt:=_get_BaseDIR_;
    if not Assigned(prnt) then EXIT; //< это КАСЯК, обработать как-то надо?
    if (PathFLDR='')or(0=CompareFilenames(PathFLDR+PathDelim,prnt.DirPATH)) then begin
        result:=prnt;
    end
    else begin
        // исчем РОДИТЕЛЬСКИЙ путь

        fld:=ExtractFileDir(PathFLDR); //< это родительская директория
        //ShowMessage('fld PARENT:'+fld);
        if NOT ( (fld='')or(0=CompareFilenames(fld,prnt.DirPATH)) )
        then prnt:=_PathFLDR_GET_(fld); //< исчем ГЛУБЖЕ, ближе к корню

        if not Assigned(prnt) then EXIT; //< это КАСЯК, обработать как-то надо?

        // исчем в родителе СЕБЯ
        fld:=ExtractFileName(PathFLDR); //< что именно искать будем
        //ShowMessage('fld SELF:'+fld);
        pointer(result):=prnt.NodeCHLD;
        while Assigned(result) do begin
            if TObject(result) is tCopyRAST_node_PathDIR then begin
                if 0=CompareFilenames(fld,result.DirNAME) then begin
                    BREAK; // НАШЛИ
                end;
            end;
            pointer(result):=result.NodeNEXT;
        end;
        //--- добавим искомый путь
        if not Assigned(result) then begin
            result:=tCopyRAST_node_PathDIR.Create(PathFLDR);
            prnt.ins_ChldLast(result);
            {$ifdef _DEBUG_}DEBUG('_PathFLDR_GET_','CREATE: '+PathFLDR);{$endIf}
        end;
    end;
end;

//------------------------------------------------------------------------------

function tCopyRAST_ROOT._fileXXXX_fnd_(const Folder:tCopyRAST_node_Folder; const FileName:string):tCopyRAST_node_FILE;
begin
    result:=tCopyRAST_node_FILE(Folder.NodeCHLD);
    while Assigned(result) do begin
        if (tCopyRAST_node(result) is tCopyRAST_node_FILE) and
           (0=CompareFilenames(result.FileNAME,FileName)) then begin
            BREAK; // нашли
        end;
        result:=tCopyRAST_node_FILE(result.NodeNEXT);
    end;
end;

function tCopyRAST_ROOT._fileXXXX_fnd_(const FullFileName:string):tCopyRAST_node_FILE;
var prnt:tCopyRAST_node_Folder;
begin
    result:=nil;
    //--- ищем родительскую директорию
    prnt:=_PathFLDR_GET_(ExtractFileDir(FullFileName));
    if not Assigned(prnt) then EXIT;
    //---
    result:=_fileXXXX_fnd_(prnt, ExtractFileName(FullFileName))
end;

// найти файл исходник, с названием
function tCopyRAST_ROOT._fnd_fileSRC_(const Folder:tCopyRAST_node_Folder; const FileNameWithoutExt:string):tCopyRAST_node;
begin
    result:=Folder.NodeCHLD;
    while Assigned(result) do begin
        if (result is tCopyRAST_node_FILE) and
           (0=CompareFilenames(ExtractFileNameWithoutExt(tCopyRAST_node_FILE(result).FileNAME),FileNameWithoutExt)) then begin
            BREAK; // нашли
        end;
        result:=Result.NodeNEXT;
    end;
    if not Assigned(result) then result:=Folder;
end;

// добавить ПУТИ поиска
procedure tCopyRAST_ROOT._add_SrchPTH_(const SrchPTH:string; const KIND:eCopyRAST_node_SrchPath);
var StartPos:Integer;
    singlDir:string;
    FoldrDir:tCopyRAST_node_Folder;
begin
    StartPos:=1;
    singlDir:=GetNextDirectoryInSearchPath(SrchPTH,StartPos);
    while singlDir<>'' do begin
        {todo: чет наверно как-то потестить надо}
        FoldrDir:=_PathFLDR_GET_(singlDir);
        if Assigned(FoldrDir) then begin
            //--- добавим найденному ТИП пути
            FoldrDir.Add_PathType(KIND);
        end;
        //-->
        singlDir:=GetNextDirectoryInSearchPath(SrchPTH,StartPos);
    end;
end;

procedure tCopyRAST_ROOT._add_FileXXX_(const FileXXX:tCopyRAST_node_File);
var prnt:tCopyRAST_node_Folder;
begin
    prnt:=_PathFLDR_GET_(FileXXX.FilePATH);
    if not Assigned(prnt) then begin
        {$ifOpt D+}ShowMessage('ERR: _add_FileXXX_, _get_PathDIR_=nil');{$endif}
        EXIT; //< это КАСЯК, обработать как-то надо?
    end;
    //-
    if FileXXX is tCopyRAST_node_fileMain_CORE
    then tCopyRAST_ROOT(pointer(prnt))._ins_ChldFrst_(FileXXX)
    else begin
        if FileXXX.FileTYPE=pftLFM then begin // вставка ресурсов ОСОБЕННАЯ
            prnt:=tCopyRAST_node_Folder(_fnd_fileSRC_(prnt,ExtractFileNameWithoutExt(FileXXX.FileNAME)));
            if NOT _tst_FileXXX_haveLFM_(tCopyRAST_node_FILE(tCopyRAST_node(prnt))) then begin
                prnt.ins_ChldLast(FileXXX);
                {$ifdef _DEBUG_}DEBUG('_add_FileXXX_','{'+'LFM'+'}'+FileXXX.source_Text);{$endIf}
            end
            else begin
                {todo: чет надо поделать}
                {$ifOpt D+}ShowMessage('ERR: _add_FileXXX_, ???????????=nil');{$endif}
                prnt.ins_ChldLast(FileXXX);
                //EXIT; //< это КАСЯК, обработать как-то надо?
            end;
        end
        else begin
            prnt.ins_ChldLast(FileXXX);
            {$ifdef _DEBUG_}DEBUG('_add_FileXXX_','{'+'}'+FileXXX.source_Text);{$endIf}
        end;
    end;
end;

//------------------------------------------------------------------------------

// файл с таким именем ИМЕЕТ доп файл
function tCopyRAST_ROOT._tst_FileSRC_lfmHAVE_(const FileName:string):boolean;
begin
    result:=FilenameIsPascalSource8HasResources(FileName);
end;

// название доп Файла по имени исходника
function tCopyRAST_ROOT._tst_FileSRC_lfmNAME_(const FileName:string):string;
begin
    result:=FilenameIsPascalSource_getRsrc_Name(FileName);
end;

//----

function tCopyRAST_ROOT._tst_FileXXX_haveLFM_(const FileXXX:tCopyRAST_node_File):boolean;
var tmp:tCopyRAST_node;
begin
    result:=false;
    tmp:=FileXXX.NodeCHLD;
    while Assigned(tmp) do begin
        if (tmp is tCopyRAST_node_FILE)and
           (tCopyRAST_node_FILE(tmp).FileTYPE=pftLFM)and
           (0=CompareFilenames(
               ExtractFileNameWithoutExt(tCopyRAST_node_FILE(tmp).FileNAME),
               ExtractFileNameWithoutExt(                 FileXXX.FileNAME))
           )
        then begin //< мда ... это файл с ресурсами
            result:=TRUE;
            BREAK;
        end;
        //--->
        tmp:=tmp.NodeNEXT;
    end;
end;

//------------------------------------------------------------------------------

procedure tCopyRAST_ROOT._prepare_fileLFM_fnd8add_(const Folder:tCopyRAST_node_Folder);
var tmp:tCopyRAST_node;
    lll:tCopyRAST_node_FILE;
begin
    tmp:=Folder.NodeCHLD;
    while Assigned(tmp) do begin
        if tmp is tCopyRAST_node_Folder then _prepare_fileLFM_fnd8add_(tCopyRAST_node_Folder(tmp))
       else
        if (tmp is tCopyRAST_node_FILE) then begin
            if pftLFM<>tCopyRAST_node_FILE(tmp).FileTYPE then begin
                if (NOT _tst_FileXXX_haveLFM_(tCopyRAST_node_FILE(tmp)))and
                   (_tst_FileSRC_lfmHAVE_(tCopyRAST_node_FILE(tmp).Get_Source_fullName))
                then begin
                    lll:=tCopyRAST_node_FILE.Create(FilenameIsPascalSource_getRsrc_Name(tmp.source_Text),pftLFM);
                   _add_FileXXX_(lll);
                end;
            end;
        end;
        //--->
        tmp:=tmp.NodeNEXT;
    end;
end;

procedure tCopyRAST_ROOT._prepare_fileLFM_fnd8add_;
var tmp:tCopyRAST_node;
begin
    tmp:=NodeCHLD;
    while Assigned(tmp) do begin
        if tmp is tCopyRAST_node_Folder then _prepare_fileLFM_fnd8add_(tCopyRAST_node_Folder(tmp));
        //--->
        tmp:=tmp.NodeNEXT;
    end;
end;

//------------------------------------------------------------------------------

procedure tCopyRAST_ROOT._prepare_fileUSE_fnd8add_(const fullFileName:string);
var fileXXX:tCopyRAST_node_FILE;
begin
    if FileIsInPath(fullFileName,_get_BaseDIR_.DirPATH) then begin
        fileXXX:=_fileXXXX_fnd_(fullFileName);
        if NOT Assigned(fileXXX) then begin
            fileXXX:=tCopyRAST_node_FILE.Create(fullFileName,pftUnit);
           _add_FileXXX_(fileXXX);
           _prepare_fileUSE_fnd8add_(fileXXX);
        end;
    end;
end;

procedure tCopyRAST_ROOT._prepare_fileUSE_fnd8add_(const nameLst:TStringList);
var i:integer;
begin
    for i:=0 to nameLst.Count-1 do begin
       _prepare_fileUSE_fnd8add_(nameLst.Strings[i]);
    end;
end;

procedure tCopyRAST_ROOT._prepare_fileUSE_fnd8add_(const FileXXX:tCopyRAST_node_File);
var
  ExpandedFilename: String;
  CodeBuf: TCodeBuffer;
  var MainUsesSection,ImplementationUsesSection:TStrings;
begin
      // make sure the filename is trimmed and contains a full path
      ExpandedFilename:=CleanAndExpandFilename(FileXXX.source_Text);
      // save changes in source editor to codetools
      LazarusIDE.SaveSourceEditorChangesToCodeCache(nil);

      // load the file
      CodeBuf:=CodeToolBoss.LoadFile(ExpandedFilename,true,false);

      MainUsesSection          :=TStringList.Create;
      ImplementationUsesSection:=TStringList.Create;

      if CodeToolBoss.FindUsedUnitFiles(CodeBuf, MainUsesSection,ImplementationUsesSection) then begin
         _prepare_fileUSE_fnd8add_(TStringList(MainUsesSection));
         _prepare_fileUSE_fnd8add_(TStringList(ImplementationUsesSection));
          //ShowMessage('file:'+LineEnding+FileXXX.source_Text+LineEnding+'inMAIN:'+LineEnding+MainUsesSection.Text+LineEnding+'inIMPL:'+LineEnding+ImplementationUsesSection.Text);
      end
      else begin
          //ShowMessage('file:'+LineEnding+FileXXX.source_Text+LineEnding+'Uses NOT FOUND');
      end;

      MainUsesSection          .FREE;
      ImplementationUsesSection.FREE;
end;

procedure tCopyRAST_ROOT._prepare_fileUSE_fnd8add_(const Folder:tCopyRAST_node_Folder);
var tmp:tCopyRAST_node;
begin
    tmp:=Folder.NodeCHLD;
    while Assigned(tmp) do begin
        if tmp is tCopyRAST_node_Folder then _prepare_fileUSE_fnd8add_(tCopyRAST_node_Folder(tmp))
       else
        if (tmp is tCopyRAST_node_FILE) then _prepare_fileUSE_fnd8add_(tCopyRAST_node_FILE(tmp));
        //--->
        tmp:=tmp.NodeNEXT;
    end;
end;

procedure tCopyRAST_ROOT._prepare_fileUSE_fnd8add_;
var tmp:tCopyRAST_node;
begin
    tmp:=NodeCHLD;
    while Assigned(tmp) do begin
        if tmp is tCopyRAST_node_Folder then _prepare_fileUSE_fnd8add_(tCopyRAST_node_Folder(tmp));
        //--->
        tmp:=tmp.NodeNEXT;
    end;
end;



//------------------------------------------------------------------------------

function tCopyRAST_ROOT._LazIDE_loadFile_(const node:tCopyRAST_node_FILE):TCodeBuffer;
begin
    // save changes in source editor to codetools
    LazarusIDE.SaveSourceEditorChangesToCodeCache(nil);
    // load the file
    result:=CodeToolBoss.LoadFile(node.source_Text,false,false);
end;

//------------------------------------------------------------------------------

function tCopyRAST_ROOT._copyRast_bin(const node:tCopyRAST_node_FILE):boolean;
begin
    result:=FALSE;
end;

function tCopyRAST_ROOT._copyRast_txt(const node:tCopyRAST_node_FILE):boolean;
var cb:TCodeBuffer;
    fs:TFileStream;
begin
    result:=FALSE;
    //---
    cb:=_LazIDE_loadFile_(node);
    if Assigned(cb) then begin
        //fs.Create('D:\'+node.FileNAME,fmCreate);
        //cb.SaveToStream(fs);
        //fs.free;
    end;
end;


//------------------------------------------------------------------------------

function tCopyRAST_ROOT._copyRast_getOldPATH_(const node:tCopyRAST_node_FILE):string;
begin
    result:=node.source_Text;
end;

function tCopyRAST_ROOT._copyRast_getNewPATH_(const node:tCopyRAST_node_FILE; const BaseDir:string):string;
var tmp:tCopyRAST_node;
begin
    result:='';
    //---
    tmp:=node.NodePRNT;
    while Assigned(tmp) do begin
        if tmp is tCopyRAST_node_Folder then begin
            result:=_get_rltvDIR_(tCopyRAST_node_Folder(tmp));
            BREAK;
        end;
        //---
        tmp:=tmp.NodePRNT;
    end;
    //---
    result:=BaseDir+DirectorySeparator+result+DirectorySeparator+node.FileNAME;
end;

function tCopyRAST_ROOT._copyRast_COPY_FILE_(const node:tCopyRAST_node_FILE; const BaseDir:string):boolean;
begin
    node.NewFilePATH:=_copyRast_getNewPATH_(node,BaseDir);
    result:=CopyFile(_copyRast_getOldPATH_(node),node.NewFilePATH{,[cffOverwriteFile,cffPreserveTime]});
    {$ifdef _DEBUG_}
        if Result
        then DEBUG(' ok :'+'_copyRast_COPY_FILE_','"'+_copyRast_getOldPATH_(node)+'"'+'->'+'"'+_copyRast_getNewPATH_(node,BaseDir)+'"')
        else DEBUG(' ER :'+'_copyRast_COPY_FILE_','"'+_copyRast_getOldPATH_(node)+'"'+'->'+'"'+_copyRast_getNewPATH_(node,BaseDir)+'"')
    {$endIf}
end;

function tCopyRAST_ROOT._copyRast_COPY_(const node:tCopyRAST_node; const BaseDir:string):boolean;
var tmp:tCopyRAST_node;
    str:string;
begin // глупо и тупо рекурсией
    tmp:=node;
    if not Assigned(tmp) then tmp:=self;
    //---
    if tmp is tCopyRAST_node_FILE then begin
        result:=_copyRast_COPY_FILE_(tCopyRAST_node_FILE(node),BaseDir);
    end;
    //---
    tmp:=tmp.NodeCHLD;
    while Assigned(tmp) do begin
       _copyRast_COPY_(tmp,BaseDir);
        //--->
        tmp:=tmp.NodeNEXT;
    end;
end;

//------------------------------------------------------------------------------

function tCopyRAST_ROOT._copyRast_FileUPDATE_File(const node:tCopyRAST_node_FILE):boolean;
var Code:TCodeBuffer;
    Tool:TCodeTool;
begin
   DEBUG(node.NewFilePATH);
   try


        // Step 1: load the file and parse it
        Code:=CodeToolBoss.LoadFile(node.NewFilePATH,true,false);
        //if Code=nil then raise Exception.Create('loading failed '+Filename);
        CodeToolBoss.Explore(Code,Tool,false);
        //  if not CodeToolBoss.Explore(Code,Tool,false) then
          //  ...;// parse error ...

        // Step 2: connect the SourceChangeCache
        CodeToolBoss.SourceChangeCache.MainScanner:=Tool.Scanner;



         //Code.


          DEBUG(' ok :'+'_copyRast_FileUPDATE_File',Tool.GetCachedSourceName);
          result:=Tool.RenameSource('asdfasdfasdf',CodeToolBoss.SourceChangeCache);
          if result
          then DEBUG('OKOKOKOK')
          else DEBUG('ERRRRRRR');


           //CodeToolBoss.SourceChangeCache.Replace(gtNone,gtNone,1,1,'qwerqwerqwerqwerqwe');


        //Tool.FindEmptyMethods();


        {

          // Step 3: use Replace to insert and/or delete code
          // The first two parameters are the needed spaces in front and behind the insertion
          // The FromPos,ToPos defines the deleted/replaced range in CleanPos positions.
          // The NewCode is the string of new code. Use '' for a delete.
          if not CodeToolBoss.SourceChangeCache.Replace(gtNone,gtNone,FromPos,ToPos,NewCode) then
            exit; // e.g. source read only or a former Replace has deleted the place
     //     ...do some more Replace...
       //}
          // Step 4: Apply the changes
        //  CodeToolBoss.SourceChangeCache.Apply;
        if not CodeToolBoss.SourceChangeCache.Apply then begin
            {$ifdef _DEBUG_}
                DEBUG(' ER :'+'_copyRast_FileUPDATE_File','CodeToolBoss.SourceChangeCache.Apply');
            {$endIf}
            result:=FALSE;
        end;

        //Code.

        //CodeToolBoss.sa
        {$ifdef _DEBUG_}
            if Result
            then DEBUG(' ok :'+'_copyRast_FileUPDATE_File','ghjk')
            else DEBUG(' ER :'+'_copyRast_FileUPDATE_File','sdf')
        {$endIf}
    except
        result:=FALSE;
        {$ifdef _DEBUG_}
            DEBUG('EXPT:'+'_copyRast_FileUPDATE_File','"'+node.NewFilePATH+'"');
        {$endIf}
    end;
    Code.Save;
end;

function tCopyRAST_ROOT._copyRast_FileUPDATE_(const node:tCopyRAST_node):boolean;
var tmp:tCopyRAST_node;
    str:string;
begin // глупо и тупо рекурсией
    tmp:=node;
    if not Assigned(tmp) then tmp:=self;
    //---
    if tmp is tCopyRAST_node_FILE then begin
        result:=_copyRast_FileUPDATE_File(tCopyRAST_node_FILE(node));
    end;
    //---
    tmp:=tmp.NodeCHLD;
    while Assigned(tmp) do begin
       _copyRast_FileUPDATE_(tmp);
        //--->
        tmp:=tmp.NodeNEXT;
    end;
end;

//------------------------------------------------------------------------------


{function tCopyRAST_ROOT._copyRast_prepare_Target_BaseDIR_(out BaseDir:string; const Clear:boolean=true):boolean;
begin
    if BaseDir='' then BaseDir:=_get_BaseDIR_PATH_+'\CopyRast';
    {$ifdef _DEBUG_}DEBUG('_copyRast_prepare_TargetDIG_','path: '+BaseDir);{$endIf}
    if Clear then begin

        Result:=DeleteDirectory(BaseDir,True);
        if Result then begin
            {$ifdef _DEBUG_}DEBUG(' ok :'+'_copyRast_prepare_TargetDIG_','DeleteDirectory');{$endIf}
            Result:=RemoveDirUTF8(BaseDir);
            if result then begin
                {$ifdef _DEBUG_}DEBUG(' ok :'+'_copyRast_prepare_TargetDIG_','RemoveDirUTF8');{$endIf}
            end;
        end;

        {if RemoveDirUTF8(BaseDir) then begin
            {$ifdef _DEBUG_}DEBUG('_copyRast_prepare_TargetDIG_','RemoveDirUTF8: OK');{$endIf}
        end;}
        if ForceDirectoriesUTF8(BaseDir) then begin
            {$ifdef _DEBUG_}DEBUG(' ok :'+'_copyRast_prepare_TargetDIG_','ForceDirectoriesUTF8');{$endIf}
        end;
    end
    else begin
        {$ifdef _DEBUG_}DEBUG('_copyRast_prepare_TargetDIG_','Clear: FALSE');{$endIf}
    end;
end;}

{function tCopyRAST_ROOT._copyRast_prepare_Target_DirTREE_(const BaseDir:string; const Node:tCopyRAST_node):boolean;
var tmp:tCopyRAST_node;
    str:string;
begin // глупо и тупо рекурсией
    tmp:=node;
    if not Assigned(tmp) then tmp:=self;
    //---
    if tmp is tCopyRAST_node_Folder then begin
        //---
        str:=BaseDir+DirectorySeparator+_get_rltvDIR_(tCopyRAST_node_Folder(tmp));
        if ForceDirectoriesUTF8(str) then begin
            {$ifdef _DEBUG_}DEBUG(' ok :'+'_copyRast_prepare_TargetDIG_','ForceDirectoriesUTF8'+str);{$endIf}
        end
        else begin
            {$ifdef _DEBUG_}DEBUG(' ER :'+'_copyRast_prepare_TargetDIG_','ForceDirectoriesUTF8'+str);{$endIf}
        end;
    end;
    //---
    tmp:=tmp.NodeCHLD;
    while Assigned(tmp) do begin
       _copyRast_prepare_Target_DirTREE_(BaseDir,tmp);
        //--->
        tmp:=tmp.NodeNEXT;
    end;
end;}


function tCopyRAST_ROOT._CopyRAST_operation_secondStep_NODE_(const Node:tCopyRAST_node; const Operation:tLazExt_CopyRAST_operation_CORE_twoStep):integer;
var SecOprRES:integer;
begin
    result:=0;
    if Operation.secondStep_Is_Possible(Node) then begin
        Operation._mssge_:='NOT implemented';
        SecOprRES:=Operation.secondStep_doOperation(node);
        result:=result+SecOprRES;
        if SecOprRES<0 then begin// ОШИБКИ
            {$ifdef _DEBUG_}DEBUG('-ER- secondStep',Operation._get_Message_Text_+' for node^'+node.ClassName);{$endIf}
        end
       else
        if SecOprRES>0 then begin //< НИЧЕГО небыло сделанно
            result:=result+SecOprRES;
            {$ifdef _DEBUG_}DEBUG(' ok  secondStep','changes made '+inttostr(SecOprRES)+'. '+Operation._get_Message_Text_+' for node^'+node.ClassName);{$endIf}
        end
    end
    else begin
        result:=0;
        {$ifdef _DEBUG_}
            if Operation._getMessageOnSKIP_ then DEBUG('SKIP secondStep',Operation._get_Message_Text_+' for node^'+node.ClassName);
        {$endIf}
    end;
    Application.ProcessMessages;
end;

function tCopyRAST_ROOT._CopyRAST_operations_secondStep_(const Node:tCopyRAST_node; const Operation:tLazExt_CopyRAST_operation_CORE_twoStep):integer;
var tmp:tCopyRAST_node;
begin // глупо и тупо рекурсией
    tmp:=node; if not Assigned(tmp) then tmp:=self;
    result:=0;
    //--- себя
    if _CopyRAST_operation_secondStep_NODE_(tmp,Operation)>0 then result:=1;
    //--- пошли по детям
    tmp:=tmp.NodeCHLD;
    while Assigned(tmp) do begin
        result:=result+_CopyRAST_operations_secondStep_(tmp,Operation);
        //--->
        tmp:=tmp.NodeNEXT;
    end;
end;


procedure tCopyRAST_ROOT._CopyRAST_operation_nodeOneStep_doOperation_(const Node:tCopyRAST_node; const Operation:tLazExt_CopyRAST_operation_CORE; var exCount,ChCount,ErCount:integer);
var rslt:integer;
begin
    Operation.Prepare4Use;
    if not Operation.Is_Possible(Node) then begin
        //inc(exCount);
        //{$ifdef _DEBUG_}DEBUG('SKIP',Operation.makeLogEnds(Node));{$endIf}
    end
    else begin
        inc(exCount);
        rslt:=Operation.doOperation(node);
        if rslt>0 then begin
            inc(ChCount,rslt);
            {$ifdef _DEBUG_}DEBUG(' ok ',Operation._mssge_+' <:> '+Operation.makeLogEnds(Node));{$endIf}
        end
       else
        if rslt<0 then begin
            inc(ErCount,-rslt);
            {$ifdef _DEBUG_}DEBUG('-ER-',Operation._mssge_+' <:> '+Operation.makeLogEnds(Node));{$endIf}
        end;
    end;
end;

procedure tCopyRAST_ROOT._CopyRAST_operation_nodeTwoStep_doOperation_(const Node:tCopyRAST_node; const Operation:tLazExt_CopyRAST_operation_CORE; var exCount,ChCount,ErCount:integer);
begin
    Operation.Prepare4Use;
    if not Operation.Is_Possible(Node) then begin
        //inc(exCount);
        //{$ifdef _DEBUG_}DEBUG('SKIP',Operation.makeLogEnds(Node));{$endIf}
    end
    else begin
       _CopyRAST_operations_forEach_(nil,Operation, @_CopyRAST_operation_nodeOneStep_doOperation_, exCount,ChCount,ErCount);
    end;
end;





function tCopyRAST_ROOT._CopyRAST_operation_NODE_(const Node:tCopyRAST_node; const Operation:tLazExt_CopyRAST_operation_CORE):boolean;
var res:integer;
begin
    //Operation.ClearStages;


   { if Operation.Is_Possible(Node) then begin
        result:=TRUE;
        Operation.ClearStages;
        if Operation is tLazExt_CopyRAST_operation_CORE_twoStep then begin
            if Operation.doOperation(node) then begin
                {$ifdef _DEBUG_}DEBUG(' go ',Operation._get_Message_Text_+' for node^'+node.ClassName);{$endIf}
                res:=_CopyRAST_operations_secondStep_(NIL,tLazExt_CopyRAST_operation_CORE_twoStep(Operation));
                {$ifdef _DEBUG_}DEBUG(' ok ','make '+inttostr(res)+' changes. '+Operation._get_Message_Text_+' for node^'+node.ClassName);{$endIf}
            end
            else begin
                {$ifdef _DEBUG_}DEBUG('-ER-',Operation._get_Message_Text_ +' for node^'+node.ClassName);{$endIf}
            end;
        end
        else begin
            if Operation.doOperation(node) then begin
                {$ifdef _DEBUG_}DEBUG(' ok ',Operation._get_Message_Text_+' for node^'+node.ClassName);{$endIf}
            end
            else begin
                {$ifdef _DEBUG_}DEBUG('-ER-',Operation._get_Message_Text_ +' for node^'+node.ClassName);{$endIf}
            end;
        end;
    end
    else begin
        result:=FALSE;
        {$ifdef _DEBUG_}
            if Operation._getMessageOnSKIP_ then DEBUG('SKIP',Operation._get_Message_Text_+' for node^'+node.ClassName);
        {$endIf}
    end;
    Application.ProcessMessages; }
end;

function tCopyRAST_ROOT._CopyRAST_operations_(const Node:tCopyRAST_node; const Operation:tLazExt_CopyRAST_operation_CORE):integer;
var tmp:tCopyRAST_node;
begin // глупо и тупо рекурсией
    tmp:=node; if not Assigned(tmp) then tmp:=self;
    result:=0;
    //--- себя
    if _CopyRAST_operation_NODE_(tmp,Operation) then result:=1;
    //--- пошли по детям
    tmp:=tmp.NodeCHLD;
    while Assigned(tmp) do begin
        result:=result+_CopyRAST_operations_(tmp,Operation);
        //--->
        tmp:=tmp.NodeNEXT;
    end;
end;

procedure tCopyRAST_ROOT._CopyRAST_operations_forEach_(const Node:tCopyRAST_node; const Operation:tLazExt_CopyRAST_operation_CORE; FNK:f_doOperation; var exCount,ChCount,ErCount:integer);
var tmp:tCopyRAST_node;
begin // глупо и тупо рекурсией
    tmp:=node; if not Assigned(tmp) then tmp:=self;
    //--- себя
    FNK(tmp,Operation,exCount,ChCount,ErCount);
    //--- пошли по детям
    tmp:=tmp.NodeCHLD;
    while Assigned(tmp) do begin
       _CopyRAST_operations_forEach_(tmp,Operation,FNK, exCount,ChCount,ErCount);
        tmp:=tmp.NodeNEXT;
    end;
end;



function tCopyRAST_ROOT.CopyRAST:boolean;
var TargetDirPATH:string;

    ExCount:integer; //
    ChCount:integer; //
    ErCount:integer;

var i:integer;
    r:integer;
  tmp:tLazExt_CopyRAST_operation_CORE;
begin
   LazarusIDE.SaveSourceEditorChangesToCodeCache(nil);
   {$ifdef _DEBUG_}DEBUG('CopyRAST START',DateTimeToStr(NOW));{$endIf}
   ExCount:=0;
   ChCount:=0;
   ErCount:=0;
   //--- ну ... поехали ...
   for i:=0 to _operationList_.Count-1 do begin
        tmp:=tLazExt_CopyRAST_operation_CORE(_operationList_.Items[i]);
        if Assigned(tmp) then begin
            //r:=_CopyRAST_operations_(nil,tmp);
            //if r>0 then inc(ChCount,r)
            //else inc(ErCount,r);

           _CopyRAST_operations_forEach_(nil,tmp, @_CopyRAST_operation_nodeOneStep_doOperation_, exCount,ChCount,ErCount);


        end;
    end;
    //--- вот и приЕхали ...
    {$ifdef _DEBUG_}DEBUG('CopyRAST -END-',DateTimeToStr(NOW)+' '+'ExCount='+inttostr(ExCount)+' '+'ChCount='+inttostr(ChCount)+' '+'ErCount='+inttostr(ErCount));{$endIf}
end;



{%region --- tLazExt_CopyRAST_operationNode_CORE ------------------ /fold}

constructor tLazExt_CopyRAST_operation_CORE.Create(const AOwner:tCopyRAST_ROOT);
begin
   _Owner_:=AOwner;
   _mssge_:='NOT implemented';
end;

//------------------------------------------------------------------------------

function tLazExt_CopyRAST_operation_CORE._getOperationName_:string;
begin
    result:=ClassName;
end;

function tLazExt_CopyRAST_operation_CORE._getOperationHint_:string;
begin
    result:=_getOperationName_;
end;

//------------------------------------------------------------------------------

function tLazExt_CopyRAST_operation_CORE._getMessageOnSKIP_:boolean;
begin
    result:=FALSE;
end;

function tLazExt_CopyRAST_operation_CORE._get_Message_Text_:string;
begin
    result:=_mssge_;
end;

//------------------------------------------------------------------------------

// [подготовка] примедение инструмента в ИСХОДНОЕ положение
procedure tLazExt_CopyRAST_operation_CORE.Prepare4Use;//; //< так названо, просто для выравнивания ;-)
begin
   _mssge_:='NOT implemented';
end;


// [проверка] Можно ли применить данную операцию к узлу?
// @prm Node узел, который проверяем
// @ret true данную операцию применять МОЖНО
function tLazExt_CopyRAST_operation_CORE.Is_Possible(const Node:tCopyRAST_node):boolean;
begin
    result:=FALSE;
end;

// [выполнение] Применить данную операцию к узлу.
// @prm Node узел, который проверяем
// @ret 0 изменений нет
// @ret >0 кол-во проведенных изменений
// @ret <0 ОШИБКА при выполнении
function tLazExt_CopyRAST_operation_CORE.doOperation(const Node:tCopyRAST_node):integer;
begin
    result:=0;
end;

function tLazExt_CopyRAST_operation_CORE.makeLogEnds(const Node:tCopyRAST_node):string;
begin
    result:='say '+'"'+self.ClassName+'"'+' for '+'"'+node.Get_Target_fullName+'"';
end;

function tLazExt_CopyRAST_operation_CORE._doOperation_EDIT_(const Node:tCopyRAST_node; const nodeFileName:string):integer;
var Code:TCodeBuffer;
    Tool:TCodeTool;
begin // взято из http://wiki.freepascal.org/Codetools#Usage
    // Step 0: проверим ... он вообще есть? ... он не может не есть
    if NOT FileExistsUTF8(nodeFileName) then begin
       _mssge_:='TARGET NOT exists:'+'"'+nodeFileName+'"';
        EXIT(-1);
    end;
    // Step 1: load the file and parse it
    Code:=CodeToolBoss.LoadFile(nodeFileName,true,false);
    if NOT Assigned(Code) then begin
       _mssge_:='CodeBuffer NOT received:"'+nodeFileName+'" ';
        EXIT(-1);
    end;
    CodeToolBoss.Explore(Code,Tool,false);
    if NOT Assigned(Tool) then begin
       _mssge_:='CodeTool NOT received:"'+nodeFileName+'"';
        EXIT(-1);
    end;
    // Step 2: connect the SourceChangeCache
    CodeToolBoss.SourceChangeCache.MainScanner:=Tool.Scanner;
    // Step 3: EDIT
    result:=doOperation_EDIT(Node,Code,Tool);
    if result<0 then EXIT;
    // Step 4: Apply the changes
    if not CodeToolBoss.SourceChangeCache.EndUpdate then begin
        _mssge_:='CodeToolBoss.SourceChangeCache.EndUpdate ERROR:"'+nodeFileName+'"';
         exit(-1);
    end;
    // Step 5: SAVE the changes
    if NOT code.Save then begin
        _mssge_:='code.Save ERROR:"'+nodeFileName+'" ER';
         exit(-1);
    end;
end;

function tLazExt_CopyRAST_operation_CORE.doOperation_EDIT(const Node:tCopyRAST_node; const Code:TCodeBuffer; const Tool:TCodeTool):integer;
begin
    result:=0;
end;


//------------------------------------------------------------------------------

function tLazExt_CopyRAST_operation_CORE_twoStep.secondStep_Is_Possible(const Node:tCopyRAST_node):boolean;
begin
    result:=FALSE;
end;

function tLazExt_CopyRAST_operation_CORE_twoStep.secondStep_doOperation(const Node:tCopyRAST_node):integer;
begin
    result:=0;
end;

{%endregion}


function tCopyRAST_ROOT.Get_SOURCE_basePath:string;
begin
    result:=_get_BaseDIR_PATH_;
end;

function tCopyRAST_ROOT.Get_TARGET_basePath:string;
begin
    result:=Get_SOURCE_basePath+'\CopyRast';
end;

//------------------------------------

function tCopyRAST_ROOT.Get_Source_obj_Name:string;
begin
    result:=_get_BaseDIR_PATH_;
end;

function tCopyRAST_ROOT.Get_Source_dir_Name:string;
begin
    result:='';
end;

function tCopyRAST_ROOT.Get_Target_dir_Name:string;
begin
    result:=Get_Source_dir_Name;
end;

function tCopyRAST_ROOT.Get_Target_obj_Name:string;
begin
    result:='CopyRast';
end;

end.

