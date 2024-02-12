#declare colorneed (FldCondition)
{Font={BackColor=if(#FldCondition,ColorNeed,0)}}
#end

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
      if isExistSpecTMPLT then  {
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


Window wnQRY_TMPLT_Edit 'Редактирование шаблона запроса' ;
Show at (3,5,120,28);
//---------------------------------------------
Screen ScrQRY_TMPLT_Edit (,,Sci178Esc);
Show at (,,,5);
Table QRY_TMPLT;
Fields
 QRY_TMPLT.CODE        : NoProtect, #colorneed(TRIM(QRY_TMPLT.CODE)='');
 QRY_TMPLT.NAME        : NoProtect, #colorneed(TRIM(QRY_TMPLT.NAME)='');
 QRY_TMPLT.Description : NoProtect;
 TblTMPLT.XF$NAME  : Protect, #colorneed(QRY_TMPLT.TABLECODE =0), PickButton;
 TblTMPLT.XF$TITLE : Skip;
buttons
 cmValue1,,,;
<<
`Код` .@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
`Наименование`.@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@   <.Проверить запрос.>
`Описание`.@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
`Корневая таблица запроса:`
    `наименование`.@@@@@@@@@@@@@@@@@@@@@@@@@@@ `описание`.@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
>>
end;//Screen ScrQRY_getParameter

//---------------------------------------------
Screen ScrQRY_TMPLT_Edit_panel(,,Sci178Esc);
Show at (,6,,6) Fixed_y;
<<
`Подцепки таблиц JOIN`
>>
end;

//---------------------------------------------
Browse brQRY_TMPLTSP;
  Show at (,7,,15);
Table QRY_TMPLTSP;
Fields
  QRY_TMPLTSP.npp            '№','п/п' : [1] , NoProtect,NoPickButton;
  QRY_TMPLTSP.join_type      'тип связи' : [6] , NoProtect,NoPickButton, #colorneed(TRIM(QRY_TMPLTSP.join_type)='');
  TblTMPLTSP.XF$NAME         'Таблица','системная' : [10] , Protect, PickButton;
  QRY_TMPLTSP.SynonimName    'Наименование','синонима'   : [10] , NoProtect,NoPickButton;
  'on'                       '',''  : [1] , Skip;
  QRY_TMPLTSP.JoinTerms      'Подцепка','условия'  : [20] , NoProtect,NoPickButton, #colorneed(TRIM(QRY_TMPLTSP.JoinTerms)='');
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

windowevent wnQRY_TMPLT_Edit;
cmValue1:{
  var iQRY_OUT : QRY_OUT new;
  var _err : string = '';
  if not iQRY_OUT.TestQueryTemplate(QRY_TMPLT.nrec, _err) {
//    message(iQRY_OUT.GetLogFile);
  var __log : string = iQRY_OUT.GetLogFile;
   message('Ошибка построения запроса' +
    + ''#13'' + 'информация в логе'+
    + ''#13'' +__log,error);
      PutFileToClient(__log,false);
   }
  else {
   message('Запрос корректный');
  }
}
end;


browse brQRY_TMPLT;
 table QRY_TMPLT;
  Fields
  QRY_TMPLT.code     'Код' : [3] , Protect, nopickbutton, #colorneed(TRIM(QRY_TMPLT.CODE)='');
  QRY_TMPLT.NAME     'Наименование' : [10] , Protect, nopickbutton, #colorneed(TRIM(QRY_TMPLT.name)='');
  TblTMPLT.XF$NAME   'Корневая','таблица' : [10] , Protect, nopickbutton, #colorneed(QRY_TMPLT.TABLECODE =0);
end;

#tableeventtable(QRY_TMPLT)
#tableeventtable(QRY_TMPLTSP)
