#declare colorneed (FldCondition)
{Font={BackColor=if(#FldCondition,ColorNeed,0)}}
#end

#declare tableeventtable (table)
TableEvent table #table;
cmSetDefault: {
  if curtable = tnQRY_INST_FLD {
    SelectField(#QRY_INST_FLD.FieldName);
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
  if curtable = tnQRY_INST {
      if isExistSpecINST then  {
       message('У запроса есть спецификация, удаление невозможно',error);
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



window winSelQRY_INST_FLD_LVL 'Выбор поля таблиц', cyan;
browse brselQRY_INST_FLD_LVL;
 table QRY_INST_FLD_LVL;
  Fields
   QRY_INST_FLD_LVL.level         'Уровень','вложенности' : [3], Protect, NoPickButton;
   QRY_INST_FLD_LVL.fld_json_name 'Секция','JSON'         : [8], Protect, NoPickButton;
   QRY_INST_FLD_LVL.Description   'Описание',''           : [12], Protect, NoPickButton;
end;
end;
windowevent winSelQRY_INST_FLD_LVL ;
 cmdefault: {
   closewindowex(winSelQRY_INST_FLD_LVL, cmDefault)
 }
end;

window winEditQRY_INST_FLD_LVL 'Выбор поля таблиц';
browse brEditQRY_INST_FLD_LVL;
 table QRY_INST_FLD_LVL;
  Fields
   QRY_INST_FLD_LVL.level         'Уровень','вложенности' : [3], NoProtect, NoPickButton;
   QRY_INST_FLD_LVL.fld_json_name 'Секция','JSON'         : [8], NoProtect, NoPickButton;
   QRY_INST_FLD_LVL.Description   'Описание',''           : [12], NoProtect, NoPickButton;
end;
end;



window wintFields 'Выбор поля таблиц', cyan;
browse brwintFields;
 table tFields;
  Fields
//   tFields.SYSNAMETBL 'Таблица','системная'    : [8], Protect, NoPickButton;
   tFields.NAMETBL    'Таблица','в запросе'    : [8], Protect, NoPickButton;
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



Window wnQRY_INSTANCE_Edit 'Редактирование экземпляра запроса' ;
  Show at (3,5,120,28);
  //---------------------------------------------
    Screen ScrQRY_INSTANCE_Edit (,,Sci178Esc);
    Show at (,,,5);
    Table QRY_INST;
    Fields
     QRY_INST.CODE        : NoProtect, #colorneed(QRY_INST.CODE='');
     QRY_INST_TMPLT.CODE  : Protect, PickButton, #colorneed(QRY_INST.cTmplt=0h);
     QRY_INST.NAME        : NoProtect, #colorneed(QRY_INST.NAME='');
     QRY_INST.Description : NoProtect;
     ShowpanInstWithOutTmplt : NoProtect;
     TblINST.XF$NAME  : skip;
     TblINST.XF$TITLE : Skip;
    buttons
     cmValue1,,,;
     cmValue2,,,;
<<
`Код` .@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  Шаблон.@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@   <.Уровни вложенности.>
`Наименование`.@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@   <. Проверить запрос .>
`Описание`.@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
`Корневая таблица запроса:`                                                                      [.] - показать данные шаблона`
    `наименование`.@@@@@@@@@@@@@@@@@@@@@@@@@@@ `описание`.@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
>>
    end;//Screen ScrQRY_getParameter


 formatsGroup panInstWithOutTmplt;
  Show at (,6,,);
  //---------------------------------------------
   Screen ScrQRY_TMPLT_Edit_panel(,,Sci178Esc);
    Show at (,6,,6) Fixed_y;
<<
  `Поля в запросе`
>>
   end;

  //---------------------------------------------
   Browse brQRY_TMPLTSP;
    Show at (,7,,20);
   Table QRY_INST_FLD;
    Fields
     QRY_INST_FLD_LVL_FLD.level         'Уровень','подчиненности' : [1] , Protect,PickButton;
     QRY_INST_FLD_LVL_FLD.fld_json_name 'Уровень','название'      : [5] , Protect,PickButton;
     //QRY_INST_FLD.TableName     'Таблица','поле'    : [5] , Protect,PickButton;
     QRY_INST_FLD.FieldName     'Поле',''        : [5] , NoProtect,PickButton;
     QRY_INST_FLD.FieldSynonim  'Поле','синоним' : [5] , NoProtect,NoPickButton;
     QRY_INST_FLD.FieldJSON     'Поле','JSON'    : [5] , NoProtect,NoPickButton;
     QRY_INST_FLD.PostFunction  'Пост','функция' : [5] , NoProtect,NoPickButton;
     QRY_INST_FLD.Description   'Описание',''    : [5] , NoProtect,NoPickButton;
   end;//Browse brNormPercent

    text QRY_INST.AddWhereTerms 'Секция where дополнительно к шаблону' ;
        show at ( ,21,,);
  end;  // formatsGroup panInstWithTmplt;


formatsGroup panInstWithTmplt;
  Show at (,6,,);

   Screen ScrQRY_INST_Edit_panel_with(,,Sci178Esc);
    Show at (,6,59,6) Fixed_y;
<<
  `Поля в запросе`
>>
   end;

  //---------------------------------------------
   Browse brQRY_INSTSP_with;
    Show at (,7,59,20);
   Table QRY_INST_FLD;
    Fields
     QRY_INST_FLD_LVL_FLD.level         'Уровень','подчиненности' : [1] , Protect,PickButton;
     QRY_INST_FLD_LVL_FLD.fld_json_name 'Уровень','название'      : [5] , Protect,PickButton;
//     QRY_INST_FLD.TableName     'Таблица№',''    : [5] , Protect,PickButton;
     QRY_INST_FLD.FieldName     'Поле',''        : [5] , Protect,PickButton;
     QRY_INST_FLD.FieldSynonim  'Поле','синоним' : [5] , NoProtect,NoPickButton;
     QRY_INST_FLD.FieldJSON     'Поле','JSON'    : [5] , NoProtect,NoPickButton;
     QRY_INST_FLD.PostFunction  'Пост','функция' : [5] , NoProtect,NoPickButton;
     QRY_INST_FLD.Description   'Описание',''    : [5] , NoProtect,NoPickButton;
   end;//Browse brNormPercent

    text QRY_INST.AddWhereTerms 'Секция where дополнительно к шаблону';
        show at ( ,21,59,);

  //---------------------------------------------
  Screen ScrQRY_TMPLT_Edit_panel_with(,,Sci178Esc);
  Show at (60,6,,6) Fixed_y;
  <<
  `Подцепки таблиц JOIN из шаблона`
  >>
  end;
  //---------------------------------------------
  Browse brQRY_TMPLTSP_with;
    Show at (60,7,,20);
  Table QRY_INST_TMPLTSP;
  Fields
    QRY_INST_TMPLTSP.npp            '№','п/п' : [1] , Skip;
    QRY_INST_TMPLTSP.join_type      'тип связи' : [6] , Skip;
    TblINST_TMPLTSP.XF$NAME         'Таблица','системная' : [10] , Skip;
    QRY_INST_TMPLTSP.SynonimName    'Наименование','синонима'   : [10] , Skip;
    'on'                       '',''  : [1] , Skip;
    QRY_INST_TMPLTSP.JoinTerms      'Подцепка','условия'  : [20] , Skip;
    QRY_INST_TMPLTSP.Description    'Описание'            : [10] , Skip;
  end;//Browse brNormPercent

    text QRY_INST_TMPLT.WhereTerms 'Секция where из шаблона': Skip;
     show at ( 60,21,,);

 end; // formatsGroup panInstWithOutTmplt;

end; // window

browse brQRY_INST;
 table QRY_INST;
  Fields
  QRY_INST.code        'Код'          : [3] , Protect, nopickbutton, #colorneed(QRY_INST.CODE='');
  QRY_INST.NAME        'Наименование' : [10] , Protect, nopickbutton, #colorneed(QRY_INST.name='');
  QRY_INST.Description 'Описание'     : [10] , Protect, nopickbutton;
  QRY_INST_TMPLT.code  'Шаблон','код'          : [3]  , Protect, nopickbutton, #colorneed(QRY_INST_TMPLT.CODE='');
  QRY_INST_TMPLT.NAME  'Шаблон','наименование' : [10] , Protect, nopickbutton, #colorneed(QRY_INST_TMPLT.name='');
  TblINST.XF$NAME      'Корневая','таблица'    : [10] , Protect, nopickbutton, #colorneed(QRY_INST_TMPLT.TABLECODE =0);
end;

#tableeventtable(QRY_INST)
#tableeventtable(QRY_INST_FLD)
#tableeventtable(QRY_INST_FLD_LVL)

windowevent wnQRY_INSTANCE_Edit;
cmValue1:{
  RunWindowModal(winEditQRY_INST_FLD_LVL);
}
end;
