" Author: lymslive
" xml completion for tdr_xml file
" Last change: 2016-08
"
" 用于 tdr xml 补全，<C-x><C-O> 模式
" 需先执行以下命令：
" XMLns dmlttdr

let g:xmldata_dmlttdr =
    \{
    \ 'vimxmlroot' : ['metalib'],
    \ 'metalib' : [ ['macro', 'macrosgroup', 'struct', 'union'],
    \               {'tagsetversion':[1], 'id':[], 'name':[], 'cname':[], 'version':[], 'desc':[]}
    \             ],
    \
    \ 'macro'   : [ [],
    \               {'value':[], 'id':[], 'name':[], 'cname':[], 'version':[], 'desc':[]}
    \             ],
    \
    \ 'macrosgroup'  : [ ['macro'],
    \               {'id':[], 'name':[], 'cname':[], 'version':[], 'desc':[]}
    \             ],
    \
    \ 'struct'  : [ ['entry'],
    \               {'size':[], 'align':[1], 'versionindicator':[], 'sizeinof':['tinyuint', 'smalluint', 'uint'],
    \                'sortkey':[], 'primarykey':[], 'splittablefactor':[], 'splittablekey':[], 'splicttablerule':['modulebyfactor'],
    \                'dependonstruct':[], 'uniqueentryname':['true', 'false'], 'strictinput':['true', 'false'],
    \                'id':[], 'name':[], 'cname':[], 'version':[], 'desc':[]}
    \             ],
    \
    \ 'entry'   : [ [],
    \               {'type':['byte', 'char', 'tinyint', 'tinyuint', 'smallint', 'smalluint', 'int', 'uint', 'bigint', 'biguint', 'float', 'double', 'date', 'time', 'datetime', 'string', 'wchar', 'wstring', 'ip', 'void'], 
    \                'bindmacrosgroup':[], 'size':[], 'count':[], 'refer':[],
    \                'defaultvalue':[], 'sizeinof':['tinyuint', 'smalluint', 'uint'],
    \                'sortmethod':['No', 'Asc', 'Desc'],
    \                'io':['nolimit', 'noinput', 'nooutput', 'noio'],
    \                'select':[], 'customattr':[],
    \                'unique':['false', 'true'], 'notnull':['false', 'true'], 
    \                'autoincrement':['false', 'true'], 
    \                'extendtotable':['false', 'true'], 'createnewtable':['false', 'true'], 
    \                'id':[], 'name':[], 'cname':[], 'version':[], 'desc':[]}
    \             ],
    \
    \ 'union'   : [ ['entry'],
    \               {'minid':[], 'maxid':[],
    \                'id':[], 'name':[], 'cname':[], 'version':[], 'desc':[]}
    \             ]
    \}
