#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Storage.StructuredStorage\Types.ahk" {JET_API_PTR, JET_TABLEID}

struct JET_INSTANCE {
    Value : IntPtr
}
struct JET_SESID {
    Value : IntPtr
}
struct JET_OSSNAPID {
    Value : IntPtr
}
struct JET_LS {
    Value : IntPtr
}
struct JET_INDEXID {
    cbStruct : UInt32
    rgbIndexId : UInt8[16]
}
struct JET_OBJECTINFO {
    cbStruct : UInt32
    objtyp : UInt32
    dtCreate : Float64
    dtUpdate : Float64
    grbit : UInt32
    flags : UInt32
    cRecord : UInt32
    cPage : UInt32
}
struct JET_RECPOS2 {
    cbStruct : UInt32
    centriesLTDeprecated : UInt32
    centriesInRangeDeprecated : UInt32
    centriesTotalDeprecated : UInt32
    centriesLT : Int64
    centriesTotal : Int64
}
struct JET_THREADSTATS2 {
    cbStruct : UInt32
    cPageReferenced : UInt32
    cPageRead : UInt32
    cPagePreread : UInt32
    cPageDirtied : UInt32
    cPageRedirtied : UInt32
    cLogRecord : UInt32
    cbLogRecord : UInt32
    cusecPageCacheMiss : Int64
    cPageCacheMiss : UInt32
}
struct JET_COMMIT_ID {
    signLog : JET_SIGNATURE
    reserved : Int32
    commitId : Int64
}
struct JET_RECSIZE {
    cbData : Int64
    cbLongValueData : Int64
    cbOverhead : Int64
    cbLongValueOverhead : Int64
    cNonTaggedColumns : Int64
    cTaggedColumns : Int64
    cLongValues : Int64
    cMultiValues : Int64
}
struct JET_RECSIZE2 {
    cbData : Int64
    cbLongValueData : Int64
    cbOverhead : Int64
    cbLongValueOverhead : Int64
    cNonTaggedColumns : Int64
    cTaggedColumns : Int64
    cLongValues : Int64
    cMultiValues : Int64
    cCompressedColumns : Int64
    cbDataCompressed : Int64
    cbLongValueDataCompressed : Int64
}
struct JET_PFNSTATUS extends FunctionPointer {
    static Types := [JET_SESID, UInt32, UInt32, Struct.Ptr, Int32]
}
struct JET_RSTMAP_A {
    szDatabaseName : Int8.Ptr
    szNewDatabaseName : Int8.Ptr
}
struct JET_RSTMAP_W {
    szDatabaseName : UInt16.Ptr
    szNewDatabaseName : UInt16.Ptr
}
struct JET_CONVERT_A {
    szOldDll : Int8.Ptr
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            fFlags : UInt32
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct JET_CONVERT_W {
    szOldDll : UInt16.Ptr
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            fFlags : UInt32
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct JET_CALLBACK extends FunctionPointer {
    static Types := [JET_SESID, UInt32, JET_TABLEID, UInt32, Struct.Ptr, Struct.Ptr, Struct.Ptr, JET_API_PTR, Int32]
}
struct JET_SNPROG {
    cbStruct : UInt32
    cunitDone : UInt32
    cunitTotal : UInt32
}
struct JET_DBINFOUPGRADE {
    cbStruct : UInt32
    cbFilesizeLow : UInt32
    cbFilesizeHigh : UInt32
    cbFreeSpaceRequiredLow : UInt32
    cbFreeSpaceRequiredHigh : UInt32
    csecToUpgrade : UInt32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            ulFlags : UInt32
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt32
        }
    }
}
struct JET_OBJECTLIST {
    cbStruct : UInt32
    tableid : JET_TABLEID
    cRecord : UInt32
    columnidcontainername : UInt32
    columnidobjectname : UInt32
    columnidobjtyp : UInt32
    columniddtCreate : UInt32
    columniddtUpdate : UInt32
    columnidgrbit : UInt32
    columnidflags : UInt32
    columnidcRecord : UInt32
    columnidcPage : UInt32
}
struct JET_COLUMNLIST {
    cbStruct : UInt32
    tableid : JET_TABLEID
    cRecord : UInt32
    columnidPresentationOrder : UInt32
    columnidcolumnname : UInt32
    columnidcolumnid : UInt32
    columnidcoltyp : UInt32
    columnidCountry : UInt32
    columnidLangid : UInt32
    columnidCp : UInt32
    columnidCollate : UInt32
    columnidcbMax : UInt32
    columnidgrbit : UInt32
    columnidDefault : UInt32
    columnidBaseTableName : UInt32
    columnidBaseColumnName : UInt32
    columnidDefinitionName : UInt32
}
struct JET_COLUMNDEF {
    cbStruct : UInt32
    columnid : UInt32
    coltyp : UInt32
    wCountry : UInt16
    langid : UInt16
    cp : UInt16
    wCollate : UInt16
    cbMax : UInt32
    grbit : UInt32
}
struct JET_COLUMNBASE_A {
    cbStruct : UInt32
    columnid : UInt32
    coltyp : UInt32
    wCountry : UInt16
    langid : UInt16
    cp : UInt16
    wFiller : UInt16
    cbMax : UInt32
    grbit : UInt32
    szBaseTableName : Int8[256]
    szBaseColumnName : Int8[256]
}
struct JET_COLUMNBASE_W {
    cbStruct : UInt32
    columnid : UInt32
    coltyp : UInt32
    wCountry : UInt16
    langid : UInt16
    cp : UInt16
    wFiller : UInt16
    cbMax : UInt32
    grbit : UInt32
    szBaseTableName : UInt16[256]
    szBaseColumnName : UInt16[256]
}
struct JET_INDEXLIST {
    cbStruct : UInt32
    tableid : JET_TABLEID
    cRecord : UInt32
    columnidindexname : UInt32
    columnidgrbitIndex : UInt32
    columnidcKey : UInt32
    columnidcEntry : UInt32
    columnidcPage : UInt32
    columnidcColumn : UInt32
    columnidiColumn : UInt32
    columnidcolumnid : UInt32
    columnidcoltyp : UInt32
    columnidCountry : UInt32
    columnidLangid : UInt32
    columnidCp : UInt32
    columnidCollate : UInt32
    columnidgrbitColumn : UInt32
    columnidcolumnname : UInt32
    columnidLCMapFlags : UInt32
}
struct JET_COLUMNCREATE_A {
    cbStruct : UInt32
    szColumnName : Int8.Ptr
    coltyp : UInt32
    cbMax : UInt32
    grbit : UInt32
    pvDefault : Struct.Ptr
    cbDefault : UInt32
    cp : UInt32
    columnid : UInt32
    err : Int32
}
struct JET_COLUMNCREATE_W {
    cbStruct : UInt32
    szColumnName : UInt16.Ptr
    coltyp : UInt32
    cbMax : UInt32
    grbit : UInt32
    pvDefault : Struct.Ptr
    cbDefault : UInt32
    cp : UInt32
    columnid : UInt32
    err : Int32
}
struct JET_USERDEFINEDDEFAULT_A {
    szCallback : Int8.Ptr
    pbUserData : UInt8.Ptr
    cbUserData : UInt32
    szDependantColumns : Int8.Ptr
}
struct JET_USERDEFINEDDEFAULT_W {
    szCallback : UInt16.Ptr
    pbUserData : UInt8.Ptr
    cbUserData : UInt32
    szDependantColumns : UInt16.Ptr
}
struct JET_CONDITIONALCOLUMN_A {
    cbStruct : UInt32
    szColumnName : Int8.Ptr
    grbit : UInt32
}
struct JET_CONDITIONALCOLUMN_W {
    cbStruct : UInt32
    szColumnName : UInt16.Ptr
    grbit : UInt32
}
struct JET_UNICODEINDEX {
    lcid : UInt32
    dwMapFlags : UInt32
}
struct JET_UNICODEINDEX2 {
    szLocaleName : UInt16.Ptr
    dwMapFlags : UInt32
}
struct JET_TUPLELIMITS {
    chLengthMin : UInt32
    chLengthMax : UInt32
    chToIndexMax : UInt32
    cchIncrement : UInt32
    ichStart : UInt32
}
struct JET_SPACEHINTS {
    cbStruct : UInt32
    ulInitialDensity : UInt32
    cbInitial : UInt32
    grbit : UInt32
    ulMaintDensity : UInt32
    ulGrowth : UInt32
    cbMinExtent : UInt32
    cbMaxExtent : UInt32
}
struct JET_INDEXCREATE_A {
    cbStruct : UInt32
    szIndexName : Int8.Ptr
    szKey : Int8.Ptr
    cbKey : UInt32
    grbit : UInt32
    ulDensity : UInt32
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    rgconditionalcolumn : JET_CONDITIONALCOLUMN_A.Ptr
    cConditionalColumn : UInt32
    err : Int32
    cbKeyMost : UInt32
    struct _Anonymous1_e__Union {
        union {
            lcid : UInt32
            pidxunicode : JET_UNICODEINDEX.Ptr
        }
    }
    struct _Anonymous2_e__Union {
        union {
            cbVarSegMac : UInt32
            ptuplelimits : JET_TUPLELIMITS.Ptr
        }
    }
}
struct JET_INDEXCREATE_W {
    cbStruct : UInt32
    szIndexName : UInt16.Ptr
    szKey : UInt16.Ptr
    cbKey : UInt32
    grbit : UInt32
    ulDensity : UInt32
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    rgconditionalcolumn : JET_CONDITIONALCOLUMN_W.Ptr
    cConditionalColumn : UInt32
    err : Int32
    cbKeyMost : UInt32
    struct _Anonymous1_e__Union {
        union {
            lcid : UInt32
            pidxunicode : JET_UNICODEINDEX.Ptr
        }
    }
    struct _Anonymous2_e__Union {
        union {
            cbVarSegMac : UInt32
            ptuplelimits : JET_TUPLELIMITS.Ptr
        }
    }
}
struct JET_INDEXCREATE2_A {
    cbStruct : UInt32
    szIndexName : Int8.Ptr
    szKey : Int8.Ptr
    cbKey : UInt32
    grbit : UInt32
    ulDensity : UInt32
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    rgconditionalcolumn : JET_CONDITIONALCOLUMN_A.Ptr
    cConditionalColumn : UInt32
    err : Int32
    cbKeyMost : UInt32
    pSpacehints : JET_SPACEHINTS.Ptr
    struct _Anonymous1_e__Union {
        union {
            lcid : UInt32
            pidxunicode : JET_UNICODEINDEX.Ptr
        }
    }
    struct _Anonymous2_e__Union {
        union {
            cbVarSegMac : UInt32
            ptuplelimits : JET_TUPLELIMITS.Ptr
        }
    }
}
struct JET_INDEXCREATE2_W {
    cbStruct : UInt32
    szIndexName : UInt16.Ptr
    szKey : UInt16.Ptr
    cbKey : UInt32
    grbit : UInt32
    ulDensity : UInt32
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    rgconditionalcolumn : JET_CONDITIONALCOLUMN_W.Ptr
    cConditionalColumn : UInt32
    err : Int32
    cbKeyMost : UInt32
    pSpacehints : JET_SPACEHINTS.Ptr
    struct _Anonymous1_e__Union {
        union {
            lcid : UInt32
            pidxunicode : JET_UNICODEINDEX.Ptr
        }
    }
    struct _Anonymous2_e__Union {
        union {
            cbVarSegMac : UInt32
            ptuplelimits : JET_TUPLELIMITS.Ptr
        }
    }
}
struct JET_INDEXCREATE3_A {
    cbStruct : UInt32
    szIndexName : Int8.Ptr
    szKey : Int8.Ptr
    cbKey : UInt32
    grbit : UInt32
    ulDensity : UInt32
    pidxunicode : JET_UNICODEINDEX2.Ptr
    Anonymous : this._Anonymous_e__Union
    rgconditionalcolumn : JET_CONDITIONALCOLUMN_A.Ptr
    cConditionalColumn : UInt32
    err : Int32
    cbKeyMost : UInt32
    pSpacehints : JET_SPACEHINTS.Ptr
    struct _Anonymous_e__Union {
        union {
            cbVarSegMac : UInt32
            ptuplelimits : JET_TUPLELIMITS.Ptr
        }
    }
}
struct JET_INDEXCREATE3_W {
    cbStruct : UInt32
    szIndexName : UInt16.Ptr
    szKey : UInt16.Ptr
    cbKey : UInt32
    grbit : UInt32
    ulDensity : UInt32
    pidxunicode : JET_UNICODEINDEX2.Ptr
    Anonymous : this._Anonymous_e__Union
    rgconditionalcolumn : JET_CONDITIONALCOLUMN_W.Ptr
    cConditionalColumn : UInt32
    err : Int32
    cbKeyMost : UInt32
    pSpacehints : JET_SPACEHINTS.Ptr
    struct _Anonymous_e__Union {
        union {
            cbVarSegMac : UInt32
            ptuplelimits : JET_TUPLELIMITS.Ptr
        }
    }
}
struct JET_TABLECREATE_A {
    cbStruct : UInt32
    szTableName : Int8.Ptr
    szTemplateTableName : Int8.Ptr
    ulPages : UInt32
    ulDensity : UInt32
    rgcolumncreate : JET_COLUMNCREATE_A.Ptr
    cColumns : UInt32
    rgindexcreate : JET_INDEXCREATE_A.Ptr
    cIndexes : UInt32
    grbit : UInt32
    tableid : JET_TABLEID
    cCreated : UInt32
}
struct JET_TABLECREATE_W {
    cbStruct : UInt32
    szTableName : UInt16.Ptr
    szTemplateTableName : UInt16.Ptr
    ulPages : UInt32
    ulDensity : UInt32
    rgcolumncreate : JET_COLUMNCREATE_W.Ptr
    cColumns : UInt32
    rgindexcreate : JET_INDEXCREATE_W.Ptr
    cIndexes : UInt32
    grbit : UInt32
    tableid : JET_TABLEID
    cCreated : UInt32
}
struct JET_TABLECREATE2_A {
    cbStruct : UInt32
    szTableName : Int8.Ptr
    szTemplateTableName : Int8.Ptr
    ulPages : UInt32
    ulDensity : UInt32
    rgcolumncreate : JET_COLUMNCREATE_A.Ptr
    cColumns : UInt32
    rgindexcreate : JET_INDEXCREATE_A.Ptr
    cIndexes : UInt32
    szCallback : Int8.Ptr
    cbtyp : UInt32
    grbit : UInt32
    tableid : JET_TABLEID
    cCreated : UInt32
}
struct JET_TABLECREATE2_W {
    cbStruct : UInt32
    szTableName : UInt16.Ptr
    szTemplateTableName : UInt16.Ptr
    ulPages : UInt32
    ulDensity : UInt32
    rgcolumncreate : JET_COLUMNCREATE_W.Ptr
    cColumns : UInt32
    rgindexcreate : JET_INDEXCREATE_W.Ptr
    cIndexes : UInt32
    szCallback : UInt16.Ptr
    cbtyp : UInt32
    grbit : UInt32
    tableid : JET_TABLEID
    cCreated : UInt32
}
struct JET_TABLECREATE3_A {
    cbStruct : UInt32
    szTableName : Int8.Ptr
    szTemplateTableName : Int8.Ptr
    ulPages : UInt32
    ulDensity : UInt32
    rgcolumncreate : JET_COLUMNCREATE_A.Ptr
    cColumns : UInt32
    rgindexcreate : JET_INDEXCREATE2_A.Ptr
    cIndexes : UInt32
    szCallback : Int8.Ptr
    cbtyp : UInt32
    grbit : UInt32
    pSeqSpacehints : JET_SPACEHINTS.Ptr
    pLVSpacehints : JET_SPACEHINTS.Ptr
    cbSeparateLV : UInt32
    tableid : JET_TABLEID
    cCreated : UInt32
}
struct JET_TABLECREATE3_W {
    cbStruct : UInt32
    szTableName : UInt16.Ptr
    szTemplateTableName : UInt16.Ptr
    ulPages : UInt32
    ulDensity : UInt32
    rgcolumncreate : JET_COLUMNCREATE_W.Ptr
    cColumns : UInt32
    rgindexcreate : JET_INDEXCREATE2_W.Ptr
    cIndexes : UInt32
    szCallback : UInt16.Ptr
    cbtyp : UInt32
    grbit : UInt32
    pSeqSpacehints : JET_SPACEHINTS.Ptr
    pLVSpacehints : JET_SPACEHINTS.Ptr
    cbSeparateLV : UInt32
    tableid : JET_TABLEID
    cCreated : UInt32
}
struct JET_TABLECREATE4_A {
    cbStruct : UInt32
    szTableName : Int8.Ptr
    szTemplateTableName : Int8.Ptr
    ulPages : UInt32
    ulDensity : UInt32
    rgcolumncreate : JET_COLUMNCREATE_A.Ptr
    cColumns : UInt32
    rgindexcreate : JET_INDEXCREATE3_A.Ptr
    cIndexes : UInt32
    szCallback : Int8.Ptr
    cbtyp : UInt32
    grbit : UInt32
    pSeqSpacehints : JET_SPACEHINTS.Ptr
    pLVSpacehints : JET_SPACEHINTS.Ptr
    cbSeparateLV : UInt32
    tableid : JET_TABLEID
    cCreated : UInt32
}
struct JET_TABLECREATE4_W {
    cbStruct : UInt32
    szTableName : UInt16.Ptr
    szTemplateTableName : UInt16.Ptr
    ulPages : UInt32
    ulDensity : UInt32
    rgcolumncreate : JET_COLUMNCREATE_W.Ptr
    cColumns : UInt32
    rgindexcreate : JET_INDEXCREATE3_W.Ptr
    cIndexes : UInt32
    szCallback : UInt16.Ptr
    cbtyp : UInt32
    grbit : UInt32
    pSeqSpacehints : JET_SPACEHINTS.Ptr
    pLVSpacehints : JET_SPACEHINTS.Ptr
    cbSeparateLV : UInt32
    tableid : JET_TABLEID
    cCreated : UInt32
}
struct JET_OPENTEMPORARYTABLE {
    cbStruct : UInt32
    prgcolumndef : JET_COLUMNDEF.Ptr
    ccolumn : UInt32
    pidxunicode : JET_UNICODEINDEX.Ptr
    grbit : UInt32
    prgcolumnid : UInt32.Ptr
    cbKeyMost : UInt32
    cbVarSegMac : UInt32
    tableid : JET_TABLEID
}
struct JET_OPENTEMPORARYTABLE2 {
    cbStruct : UInt32
    prgcolumndef : JET_COLUMNDEF.Ptr
    ccolumn : UInt32
    pidxunicode : JET_UNICODEINDEX2.Ptr
    grbit : UInt32
    prgcolumnid : UInt32.Ptr
    cbKeyMost : UInt32
    cbVarSegMac : UInt32
    tableid : JET_TABLEID
}
struct JET_RETINFO {
    cbStruct : UInt32
    ibLongValue : UInt32
    itagSequence : UInt32
    columnidNextTagged : UInt32
}
struct JET_SETINFO {
    cbStruct : UInt32
    ibLongValue : UInt32
    itagSequence : UInt32
}
struct JET_RECPOS {
    cbStruct : UInt32
    centriesLT : UInt32
    centriesInRange : UInt32
    centriesTotal : UInt32
}
struct JET_RECORDLIST {
    cbStruct : UInt32
    tableid : JET_TABLEID
    cRecord : UInt32
    columnidBookmark : UInt32
}
struct JET_INDEXRANGE {
    cbStruct : UInt32
    tableid : JET_TABLEID
    grbit : UInt32
}
struct JET_RELOP extends Int32 {
    static JET_relopEquals := 0
    static JET_relopPrefixEquals := 1
    static JET_relopNotEquals := 2
    static JET_relopLessThanOrEqual := 3
    static JET_relopLessThan := 4
    static JET_relopGreaterThanOrEqual := 5
    static JET_relopGreaterThan := 6
    static JET_relopBitmaskEqualsZero := 7
    static JET_relopBitmaskNotEqualsZero := 8
}
struct JET_INDEX_COLUMN {
    columnid : UInt32
    relop : JET_RELOP
    pv : Struct.Ptr
    cb : UInt32
    grbit : UInt32
}
struct JET_INDEX_RANGE {
    rgStartColumns : JET_INDEX_COLUMN.Ptr
    cStartColumns : UInt32
    rgEndColumns : JET_INDEX_COLUMN.Ptr
    cEndColumns : UInt32
}
struct JET_LOGTIME {
    bSeconds : Int8
    bMinutes : Int8
    bHours : Int8
    bDay : Int8
    bMonth : Int8
    bYear : Int8
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    struct _Anonymous1_e__Union {
        union {
            bFiller1 : UInt8
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt8
        }
    }
    struct _Anonymous2_e__Union {
        union {
            bFiller2 : UInt8
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt8
        }
    }
}
struct JET_BKLOGTIME {
    bSeconds : Int8
    bMinutes : Int8
    bHours : Int8
    bDay : Int8
    bMonth : Int8
    bYear : Int8
    Anonymous1 : this._Anonymous1_e__Union
    Anonymous2 : this._Anonymous2_e__Union
    struct _Anonymous1_e__Union {
        union {
            bFiller1 : UInt8
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt8
        }
    }
    struct _Anonymous2_e__Union {
        union {
            bFiller2 : UInt8
            Anonymous : this._Anonymous_e__Struct
        }
        struct _Anonymous_e__Struct {
            _bitfield : UInt8
        }
    }
}
struct JET_LGPOS {
    ib : UInt16
    isec : UInt16
    lGeneration : Int32
}
struct JET_SIGNATURE {
    ulRandom : UInt32
    logtimeCreate : JET_LOGTIME
    szComputerName : Int8[16]
}
struct JET_BKINFO {
    lgposMark : JET_LGPOS
    Anonymous : this._Anonymous_e__Union
    genLow : UInt32
    genHigh : UInt32
    struct _Anonymous_e__Union {
        union {
            logtimeMark : JET_LOGTIME
            bklogtimeMark : JET_BKLOGTIME
        }
    }
}
struct JET_DBINFOMISC {
    ulVersion : UInt32
    ulUpdate : UInt32
    signDb : JET_SIGNATURE
    dbstate : UInt32
    lgposConsistent : JET_LGPOS
    logtimeConsistent : JET_LOGTIME
    logtimeAttach : JET_LOGTIME
    lgposAttach : JET_LGPOS
    logtimeDetach : JET_LOGTIME
    lgposDetach : JET_LGPOS
    signLog : JET_SIGNATURE
    bkinfoFullPrev : JET_BKINFO
    bkinfoIncPrev : JET_BKINFO
    bkinfoFullCur : JET_BKINFO
    fShadowingDisabled : UInt32
    fUpgradeDb : UInt32
    dwMajorVersion : UInt32
    dwMinorVersion : UInt32
    dwBuildNumber : UInt32
    lSPNumber : Int32
    cbPageSize : UInt32
}
struct JET_DBINFOMISC2 {
    ulVersion : UInt32
    ulUpdate : UInt32
    signDb : JET_SIGNATURE
    dbstate : UInt32
    lgposConsistent : JET_LGPOS
    logtimeConsistent : JET_LOGTIME
    logtimeAttach : JET_LOGTIME
    lgposAttach : JET_LGPOS
    logtimeDetach : JET_LOGTIME
    lgposDetach : JET_LGPOS
    signLog : JET_SIGNATURE
    bkinfoFullPrev : JET_BKINFO
    bkinfoIncPrev : JET_BKINFO
    bkinfoFullCur : JET_BKINFO
    fShadowingDisabled : UInt32
    fUpgradeDb : UInt32
    dwMajorVersion : UInt32
    dwMinorVersion : UInt32
    dwBuildNumber : UInt32
    lSPNumber : Int32
    cbPageSize : UInt32
    genMinRequired : UInt32
    genMaxRequired : UInt32
    logtimeGenMaxCreate : JET_LOGTIME
    ulRepairCount : UInt32
    logtimeRepair : JET_LOGTIME
    ulRepairCountOld : UInt32
    ulECCFixSuccess : UInt32
    logtimeECCFixSuccess : JET_LOGTIME
    ulECCFixSuccessOld : UInt32
    ulECCFixFail : UInt32
    logtimeECCFixFail : JET_LOGTIME
    ulECCFixFailOld : UInt32
    ulBadChecksum : UInt32
    logtimeBadChecksum : JET_LOGTIME
    ulBadChecksumOld : UInt32
}
struct JET_DBINFOMISC3 {
    ulVersion : UInt32
    ulUpdate : UInt32
    signDb : JET_SIGNATURE
    dbstate : UInt32
    lgposConsistent : JET_LGPOS
    logtimeConsistent : JET_LOGTIME
    logtimeAttach : JET_LOGTIME
    lgposAttach : JET_LGPOS
    logtimeDetach : JET_LOGTIME
    lgposDetach : JET_LGPOS
    signLog : JET_SIGNATURE
    bkinfoFullPrev : JET_BKINFO
    bkinfoIncPrev : JET_BKINFO
    bkinfoFullCur : JET_BKINFO
    fShadowingDisabled : UInt32
    fUpgradeDb : UInt32
    dwMajorVersion : UInt32
    dwMinorVersion : UInt32
    dwBuildNumber : UInt32
    lSPNumber : Int32
    cbPageSize : UInt32
    genMinRequired : UInt32
    genMaxRequired : UInt32
    logtimeGenMaxCreate : JET_LOGTIME
    ulRepairCount : UInt32
    logtimeRepair : JET_LOGTIME
    ulRepairCountOld : UInt32
    ulECCFixSuccess : UInt32
    logtimeECCFixSuccess : JET_LOGTIME
    ulECCFixSuccessOld : UInt32
    ulECCFixFail : UInt32
    logtimeECCFixFail : JET_LOGTIME
    ulECCFixFailOld : UInt32
    ulBadChecksum : UInt32
    logtimeBadChecksum : JET_LOGTIME
    ulBadChecksumOld : UInt32
    genCommitted : UInt32
}
struct JET_DBINFOMISC4 {
    ulVersion : UInt32
    ulUpdate : UInt32
    signDb : JET_SIGNATURE
    dbstate : UInt32
    lgposConsistent : JET_LGPOS
    logtimeConsistent : JET_LOGTIME
    logtimeAttach : JET_LOGTIME
    lgposAttach : JET_LGPOS
    logtimeDetach : JET_LOGTIME
    lgposDetach : JET_LGPOS
    signLog : JET_SIGNATURE
    bkinfoFullPrev : JET_BKINFO
    bkinfoIncPrev : JET_BKINFO
    bkinfoFullCur : JET_BKINFO
    fShadowingDisabled : UInt32
    fUpgradeDb : UInt32
    dwMajorVersion : UInt32
    dwMinorVersion : UInt32
    dwBuildNumber : UInt32
    lSPNumber : Int32
    cbPageSize : UInt32
    genMinRequired : UInt32
    genMaxRequired : UInt32
    logtimeGenMaxCreate : JET_LOGTIME
    ulRepairCount : UInt32
    logtimeRepair : JET_LOGTIME
    ulRepairCountOld : UInt32
    ulECCFixSuccess : UInt32
    logtimeECCFixSuccess : JET_LOGTIME
    ulECCFixSuccessOld : UInt32
    ulECCFixFail : UInt32
    logtimeECCFixFail : JET_LOGTIME
    ulECCFixFailOld : UInt32
    ulBadChecksum : UInt32
    logtimeBadChecksum : JET_LOGTIME
    ulBadChecksumOld : UInt32
    genCommitted : UInt32
    bkinfoCopyPrev : JET_BKINFO
    bkinfoDiffPrev : JET_BKINFO
}
struct JET_THREADSTATS {
    cbStruct : UInt32
    cPageReferenced : UInt32
    cPageRead : UInt32
    cPagePreread : UInt32
    cPageDirtied : UInt32
    cPageRedirtied : UInt32
    cLogRecord : UInt32
    cbLogRecord : UInt32
}
struct JET_RSTINFO_A {
    cbStruct : UInt32
    rgrstmap : JET_RSTMAP_A.Ptr
    crstmap : Int32
    lgposStop : JET_LGPOS
    logtimeStop : JET_LOGTIME
    pfnStatus : JET_PFNSTATUS
}
struct JET_RSTINFO_W {
    cbStruct : UInt32
    rgrstmap : JET_RSTMAP_W.Ptr
    crstmap : Int32
    lgposStop : JET_LGPOS
    logtimeStop : JET_LOGTIME
    pfnStatus : JET_PFNSTATUS
}
struct JET_ERRCAT extends Int32 {
    static JET_errcatUnknown := 0
    static JET_errcatError := 1
    static JET_errcatOperation := 2
    static JET_errcatFatal := 3
    static JET_errcatIO := 4
    static JET_errcatResource := 5
    static JET_errcatMemory := 6
    static JET_errcatQuota := 7
    static JET_errcatDisk := 8
    static JET_errcatData := 9
    static JET_errcatCorruption := 10
    static JET_errcatInconsistent := 11
    static JET_errcatFragmentation := 12
    static JET_errcatApi := 13
    static JET_errcatUsage := 14
    static JET_errcatState := 15
    static JET_errcatObsolete := 16
    static JET_errcatMax := 17
}
struct JET_ERRINFOBASIC_W {
    cbStruct : UInt32
    errValue : Int32
    errcatMostSpecific : JET_ERRCAT
    rgCategoricalHierarchy : UInt8[8]
    lSourceLine : UInt32
    rgszSourceFile : UInt16[64]
}
struct JET_PFNDURABLECOMMITCALLBACK extends FunctionPointer {
    static Types := [JET_INSTANCE, JET_COMMIT_ID.Ptr, UInt32, Int32]
}
struct JET_INDEXCHECKING extends Int32 {
    static JET_IndexCheckingOff := 0
    static JET_IndexCheckingOn := 1
    static JET_IndexCheckingDeferToOpenTable := 2
    static JET_IndexCheckingMax := 3
}
struct JET_OPERATIONCONTEXT {
    ulUserID : UInt32
    nOperationID : UInt8
    nOperationType : UInt8
    nClientType : UInt8
    fFlags : UInt8
}
struct JET_SETCOLUMN {
    columnid : UInt32
    pvData : Struct.Ptr
    cbData : UInt32
    grbit : UInt32
    ibLongValue : UInt32
    itagSequence : UInt32
    err : Int32
}
struct JET_SETSYSPARAM_A {
    paramid : UInt32
    lParam : JET_API_PTR
    sz : Int8.Ptr
    err : Int32
}
struct JET_SETSYSPARAM_W {
    paramid : UInt32
    lParam : JET_API_PTR
    sz : UInt16.Ptr
    err : Int32
}
struct JET_RETRIEVECOLUMN {
    columnid : UInt32
    pvData : Struct.Ptr
    cbData : UInt32
    cbActual : UInt32
    grbit : UInt32
    ibLongValue : UInt32
    itagSequence : UInt32
    columnidNextTagged : UInt32
    err : Int32
}
struct JET_ENUMCOLUMNID {
    columnid : UInt32
    ctagSequence : UInt32
    rgtagSequence : UInt32.Ptr
}
struct JET_ENUMCOLUMNVALUE {
    itagSequence : UInt32
    err : Int32
    cbData : UInt32
    pvData : Struct.Ptr
}
struct JET_ENUMCOLUMN {
    columnid : UInt32
    err : Int32
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            Anonymous1 : this._Anonymous1_e__Struct
            Anonymous2 : this._Anonymous2_e__Struct
        }
        struct _Anonymous1_e__Struct {
            cEnumColumnValue : UInt32
            rgEnumColumnValue : JET_ENUMCOLUMNVALUE.Ptr
        }
        struct _Anonymous2_e__Struct {
            cbData : UInt32
            pvData : Struct.Ptr
        }
    }
}
struct JET_PFNREALLOC extends FunctionPointer {
    static Types := [Struct.Ptr, Struct.Ptr, UInt32, Struct.Ptr]
}
struct JET_LOGINFO_A {
    cbSize : UInt32 := this.Size
    ulGenLow : UInt32
    ulGenHigh : UInt32
    szBaseName : Int8[4]
}
struct JET_LOGINFO_W {
    cbSize : UInt32 := this.Size
    ulGenLow : UInt32
    ulGenHigh : UInt32
    szBaseName : UInt16[4]
}
struct JET_INSTANCE_INFO_A {
    hInstanceId : JET_INSTANCE
    szInstanceName : Int8.Ptr
    cDatabases : JET_API_PTR
    szDatabaseFileName : Int8.Ptr.Ptr
    szDatabaseDisplayName : Int8.Ptr.Ptr
    szDatabaseSLVFileName_Obsolete : Int8.Ptr.Ptr
}
struct JET_INSTANCE_INFO_W {
    hInstanceId : JET_INSTANCE
    szInstanceName : UInt16.Ptr
    cDatabases : JET_API_PTR
    szDatabaseFileName : UInt16.Ptr.Ptr
    szDatabaseDisplayName : UInt16.Ptr.Ptr
    szDatabaseSLVFileName_Obsolete : UInt16.Ptr.Ptr
}
