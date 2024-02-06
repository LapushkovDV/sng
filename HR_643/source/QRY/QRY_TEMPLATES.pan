#declare tableeventtable (table)
TableEvent table #table;
cmSetDefault: {
  if curtable = tnQRY_TMPLTSP {
   if getlast QRY_TMPLTSP1 where ((QRY_TMPLT.nrec == QRY_TMPLTSP1.cTmplt
                                           and 0 <<= QRY_TMPLTSP1.npp)) = tsOK {
         set QRY_TMPLTSP.npp := QRY_TMPLTSP1.npp + 1
       }
    SelectField(#TblTMPLTSP.XF$NAME);
    putcommand(cmpick);
  }
}
cmInsertRecord:
{
  Insert Current #table;
}
cmUpdateRecord:
{
  Update Current #table;
}
cmDeleteRecord:
{
  if curtable = tnQRY_TMPLT {
      if isExistSpec then  {
       message('У шаблона есть спецификация, удаление невозможно',error);
       stop;abort;exit
     }
  }
 if message('Удалить?',YesNo)<>cmYes  {
   abort; exit;
  }
  delete Current #table;
}
end; //TableEvent table #table
#end

#declare colorneed (FldCondition)
{Font={BackColor=if(#FldCondition,ColorNeed,0)}}
#end


/*

window wintFields 'Выбор поля таблиц', cyan;
browse brwintFields;
 table tFields;
  Fields
   tFields.SYSNAMETBL 'Таблица','системная'    : [8], Protect, NoPickButton;
   tFields.NAMETBL    'Синоним','в запросе'    : [8], Protect, NoPickButton;
   tFields.NAME       'Поле'      :[10], Protect, NoPickButton;
   tFields.TITLE      'Описание'  :[15], Protect, NoPickButton;
   tFields.DATATYPE   'Тип данных'   : [4], Protect, NoPickButton;
end;
end;
windowevent wintFields ;
 cmdefault: {
   closewindowex(wintFields, cmDefault)
 }
end;
*/

window winSelectSysTable 'Выбор системной таблицы', cyan;
browse brSelectSysTable ;
 table x$files_br;
  Fields
   x$files_br.XF$CODE  'Код'      :[5] , Protect, NoPickButton;
   x$files_br.XF$NAME  'Имя'      :[10], Protect, NoPickButton;
   x$files_br.XF$TITLE 'Описание' :[15], Protect, NoPickButton;
end;
end;
windowevent winSelectSysTable ;
 cmdefault: {
   closewindowex(winSelectSysTable, cmDefault)
 }
end;

Window wnQRY_TMPLT_Edit 'Редактирование шаблона запроса' ;
Show at (3,5,120,28);
//---------------------------------------------
Screen ScrQRY_TMPLT_Edit (,,Sci178Esc);
Show at (,,,6);
Table QRY_TMPLT;
Fields
 QRY_TMPLT.CODE    : NoProtect, #colorneed(QRY_TMPLT.CODE='');
 QRY_TMPLT.NAME    : NoProtect, #colorneed(QRY_TMPLT.NAME='');
 TblTMPLT.XF$NAME  : Protect, #colorneed(QRY_TMPLT.TABLECODE =0), PickButton;
 TblTMPLT.XF$TITLE : Skip;

<<
`Код` .@@@@@@@ `Наименование`.@@@@@@@@@@@@@@@@@@@@@@@

`Корневая таблица запроса:`
    `наименование`.@@@@@@@@@@@@@@@@@@@@@@@@@@@
        `описание`.@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
>>
end;//Screen ScrQRY_getParameter

//---------------------------------------------
Screen ScrQRY_TMPLT_Edit_panel(,,Sci178Esc);
Show at (,7,,7) Fixed_y;
<<
`Подцепки таблиц JOIN`
>>
end;

//---------------------------------------------
Browse brQRY_TMPLTSP;
  Show at (,8,,15);
Table QRY_TMPLTSP;
Fields
  QRY_TMPLTSP.npp            '№','п/п' : [1] , NoProtect,NoPickButton;
  QRY_TMPLTSP.join_type      'тип связи' : [6] , NoProtect,NoPickButton;
  TblTMPLTSP.XF$NAME         'Таблица','системная' : [10] , Protect, PickButton;
  QRY_TMPLTSP.SynonimName    'Наименование','синонима'   : [10] , NoProtect,NoPickButton;
  'on'                       '',''  : [1] , Skip;
  QRY_TMPLTSP.JoinTerms      'Подцепка','условия'  : [20] , NoProtect,NoPickButton;
  QRY_TMPLTSP.Description    'Описание'            : [10] , NoProtect,NoPickButton;
end;//Browse brNormPercent

/*panel pnWhereTerms;
Show at (,16,,16);
Screen ScrWhereTerms(,,Sci178Esc);
Show at (,16,,16) Fixed_y;
<<
`Секция WHERE`
>>
end;

end;
*/
panel panWhereTerms;
 show at ( ,16,,);
 table QRY_TMPLT;
// text memoID=memoDepDesc
 text QRY_TMPLT.WhereTerms 'Секция where';
end;

end;


browse brQRY_TMPLT;
 table QRY_TMPLT;
  Fields
  QRY_TMPLT.code        'Код' : [3] , Protect, nopickbutton, #colorneed(QRY_TMPLT.CODE='');
  QRY_TMPLT.NAME        'Наименование' : [10] , Protect, nopickbutton, #colorneed(QRY_TMPLT.name='');
  TblTMPLT.XF$NAME   'Наименование' : [10] , Protect, nopickbutton, #colorneed(QRY_TMPLT.TABLECODE =0);
end;

#tableeventtable(QRY_TMPLT)
#tableeventtable(QRY_TMPLTSP)
