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
       message('� ����� ���� ᯥ�䨪���, 㤠����� ����������',error);
       stop;abort;exit
     }
  }
 if message('�������?',YesNo)<>cmYes  {
   abort; exit;
  }
  delete Current #table;
}
end; //TableEvent table #table
#end




window winEditQRY_INST_FLD_LVL '������஢���� �������� ���������� ����� JSON';
browse brEditQRY_INST_FLD_LVL;
 table QRY_INST_FLD_LVL;
  Fields
//   QRY_INST_FLD_LVL.level         '�஢���','����������' : [3], NoProtect, NoPickButton;
   QRY_INST_FLD_LVL.fld_json_name '�����','JSON'          : [8], NoProtect, NoPickButton;
   QRY_INST_FLD_LVL.Description   '���ᠭ��',''            : [12], NoProtect, NoPickButton;
   QRY_INST_FLD_LVL_UP.fld_json_name '�����','����⥫�'   : [8], Protect, PickButton;
   QRY_INST_FLD_LVL_UP.Description   '���ᠭ��','����⥫�' : [12], Protect, PickButton;
end;
end;



window wintFields '�롮� ���� ⠡���', cyan;
browse brwintFields;
 table tFields;
  Fields
//   tFields.SYSNAMETBL '������','��⥬���'    : [8], Protect, NoPickButton;
   tFields.NAMETBL    '������','� �����'    : [8], Protect, NoPickButton;
   tFields.NAME       '����'      :[10], Protect, NoPickButton;
   tFields.TITLE      '���ᠭ��'  :[15], Protect, NoPickButton;
   tFields.DATATYPE   '��� ������'   : [4], Protect, NoPickButton;
end;
end;
windowevent wintFields ;
 cmdefault: {
   closewindowex(wintFields, cmDefault)
 }
end;



Window wnQRY_INSTANCE_Edit '������஢���� ������� �����' ;
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
     cmValue1,[singleLine],,;
     cmValue2,[singleLine],,;
<<
`���` .@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  ������.@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@   <.�஢�� ����������.>
`������������`.@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@   <. �஢���� ����� .>
`���ᠭ��`.@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
`��୥��� ⠡��� �����:`                                                                      [.] - �������� ����� 蠡����`
    `������������`.@@@@@@@@@@@@@@@@@@@@@@@@@@@ `���ᠭ��`.@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
>>
    end;//Screen ScrQRY_getParameter


 formatsGroup panInstWithOutTmplt;
  Show at (,6,,);
  //---------------------------------------------
   Screen ScrQRY_TMPLT_Edit_panel(,,Sci178Esc);
    Show at (,6,,6) Fixed_y;
<<
  `���� � �����`
>>
   end;

  //---------------------------------------------
   Browse brQRY_TMPLTSP;
    Show at (,7,,20);
   Table QRY_INST_FLD;
    Fields
//     QRY_INST_FLD_LVL_FLD.level         '�஢���','���稭������' : [1] , Protect,PickButton;
     QRY_INST_FLD_LVL_FLD.fld_json_name '�஢���','��������'      : [3] , Protect,PickButton,#colorneed(not isvalidall(tnQRY_INST_FLD_LVL_FLD));
     QRY_INST_FLD_LVL_FLD.Description '�஢���','���ᠭ��'      : [3] , Protect,PickButton,#colorneed(not isvalidall(tnQRY_INST_FLD_LVL_FLD));
     //QRY_INST_FLD.TableName     '������','����'    : [5] , Protect,PickButton;
     QRY_INST_FLD.FieldName     '����',''        : [5] , NoProtect,PickButton, #colorneed(trim(QRY_INST_FLD.FieldName)='');
//     QRY_INST_FLD.FieldSynonim  '����','ᨭ����' : [5] , NoProtect,NoPickButton, #colorneed(trim(QRY_INST_FLD.FieldSynonim)='');
     QRY_INST_FLD.FieldJSON     '����','JSON'    : [5] , NoProtect,NoPickButton, #colorneed(trim(QRY_INST_FLD.FieldJSON)='');
     QRY_INST_FLD.PostFunction  '����','�㭪��' : [5] , NoProtect,PickButton;
     QRY_INST_FLD.Description   '���ᠭ��',''    : [5] , NoProtect,NoPickButton;
   end;//Browse brNormPercent

    text QRY_INST.AddWhereTerms '����� where �������⥫쭮 � 蠡����' ;
        show at ( ,21,,);
  end;  // formatsGroup panInstWithTmplt;


formatsGroup panInstWithTmplt;
  Show at (,6,,);

   Screen ScrQRY_INST_Edit_panel_with(,,Sci178Esc);
    Show at (,6,59,6) Fixed_y;
<<
  `���� � �����`
>>
   end;

  //---------------------------------------------
   Browse brQRY_INSTSP_with;
    Show at (,7,59,20);
   Table QRY_INST_FLD;
    Fields
//     QRY_INST_FLD_LVL_FLD.level         '�஢���','���稭������' : [1] , Protect,PickButton;
     QRY_INST_FLD_LVL_FLD.fld_json_name '�஢���','��������'    : [3] , Protect,PickButton,#colorneed(not isvalidall(tnQRY_INST_FLD_LVL_FLD));
     QRY_INST_FLD_LVL_FLD.Description '�஢���','���ᠭ��'      : [3] , Protect,PickButton,#colorneed(not isvalidall(tnQRY_INST_FLD_LVL_FLD));
     //QRY_INST_FLD.TableName     '������','����'    : [5] , Protect,PickButton;
     QRY_INST_FLD.FieldName     '����',''        : [5] , NoProtect,PickButton, #colorneed(trim(QRY_INST_FLD.FieldName)='');
//     QRY_INST_FLD.FieldSynonim  '����','ᨭ����' : [5] , NoProtect,NoPickButton, #colorneed(trim(QRY_INST_FLD.FieldSynonim)='');
     QRY_INST_FLD.FieldJSON     '����','JSON'    : [5] , NoProtect,NoPickButton, #colorneed(trim(QRY_INST_FLD.FieldJSON)='');
     QRY_INST_FLD.PostFunction  '����','�㭪��' : [5] , NoProtect,PickButton;
     QRY_INST_FLD.Description   '���ᠭ��',''    : [5] , NoProtect,NoPickButton;
   end;//Browse brNormPercent

    text QRY_INST.AddWhereTerms '����� where �������⥫쭮 � 蠡����';
        show at ( ,21,59,);

  //---------------------------------------------
  Screen ScrQRY_TMPLT_Edit_panel_with(,,Sci178Esc);
  Show at (60,6,,6) Fixed_y;
<<
  `���楯�� ⠡��� JOIN �� 蠡����`
>>
  end;
  //---------------------------------------------
  Browse brQRY_TMPLTSP_with;
    Show at (60,7,,20);
  Table QRY_INST_TMPLTSP;
  Fields
    QRY_INST_TMPLTSP.npp            '�','�/�' : [1] , Protect, NoPickButton;
    QRY_INST_TMPLTSP.join_type      '⨯ �裡' : [5] , Protect, NoPickButton;
    TblINST_TMPLTSP.XF$NAME         '������','��⥬���' : [9] , Protect, NoPickButton;
    QRY_INST_TMPLTSP.SynonimName    '������������','ᨭ�����'   : [9] , Protect, NoPickButton;
    'on'                             '',''  : [1] , Skip;
    QRY_INST_TMPLTSP.JoinTerms      '���楯��','�᫮���'  : [20] , Protect, NoPickButton;
    QRY_INST_TMPLTSP.Description    '���ᠭ��'            : [10] , Protect, NoPickButton;
  end;//Browse brNormPercent

    text QRY_INST_TMPLT.WhereTerms '����� where �� 蠡����': Protect;
     show at ( 60,21,,);

 end; // formatsGroup panInstWithOutTmplt;

end; // window

browse brQRY_INST;
 table QRY_INST;
  Fields
  QRY_INST.code        '���'          : [3] , Protect, nopickbutton, #colorneed(QRY_INST.CODE='');
  QRY_INST.NAME        '������������' : [10] , Protect, nopickbutton, #colorneed(QRY_INST.name='');
  QRY_INST.Description '���ᠭ��'     : [10] , Protect, nopickbutton;
  QRY_INST_TMPLT.code  '������','���'          : [3]  , Protect, nopickbutton, #colorneed(QRY_INST_TMPLT.CODE='');
  QRY_INST_TMPLT.NAME  '������','������������' : [10] , Protect, nopickbutton, #colorneed(QRY_INST_TMPLT.name='');
  TblINST.XF$NAME      '��୥���','⠡���'    : [10] , Protect, nopickbutton, #colorneed(QRY_INST_TMPLT.TABLECODE =0);
end;

#tableeventtable(QRY_INST)
#tableeventtable(QRY_INST_FLD)
#tableeventtable(QRY_INST_FLD_LVL)

windowevent wnQRY_INSTANCE_Edit;
cmValue1:{
  RunWindowModal(winEditQRY_INST_FLD_LVL);
}
cmValue2:{
  var iQRY_OUT : QRY_OUT new;
  var _err : string = '';
  if getfirst QRY_INST_TMPLT <> tsOK {
   message('�� 㪠��� 蠡���',error);
  }

  if not iQRY_OUT.TestQueryInstance(QRY_INST.code, _err) {
  var __log : string = iQRY_OUT.GetLogFile;
   message('�訡�� ����஥��� �����' +
    + ''#13'' + '���ଠ�� � ����'+
    + ''#13'' +__log,error);
      PutFileToClient(__log,false);
   }
  else {
   message('����� ���४��');
  }
}

end;
