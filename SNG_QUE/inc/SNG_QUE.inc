/*************************************************************************************************\
* ������������: ������ ��ꥪ� ࠡ��� ��।�                                                     *
* ������/�����: ��।� ��室��� ᮮ�饭��                                                      *
* �ਬ�砭��:  ����⠭��                                                                          *
*                                                                                                 *
* ��� ࠡ���  |�����         |���    |�ᯮ���⥫�              |�஥��                           *
* ----------------------------------------------------------------------------------------------- *

\*************************************************************************************************/

#ifnDef _QUE_INC_INCLUDED_
#define _QUE_INC_INCLUDED_
const
// ���� Status ⠡���� QUE_EntriesForReview
coPreQUE_AwaitProcessJSONgenerate    = 0; //  ������� ��ࠡ�⪨ ��� �ନ஢���� JSON
coPreQUE_WaitForRelatedRcrdsToInsert = 1; //  ������� ��⠢�� �易���� ����ᥩ
coPreQUE_ReadyToTransferToQueue      = 2; //  ��⮢� � ��।�� � ��।� (JSON ��ନ஢��)
coPreQUE_AwaitProcessRelatedRcrd     = 3; //  ������� �����樨 JSON � �易���� ������� (JSON ��ନ஢��)
coPreQUE_ErrorGenerateJSON           = 4; //  �訡�� �� �����樨 JSON
coPreQUE_SuccessTransferToQueue      = 5; //  �ᯥ譮 ��।��� � ��।�
coPreQUE_ErrorTransferToQueue        = 6; //  �訡�� ��।�� � ��।�
coPreQUE_ErrorFindInstanceInReciept  = 7; //  ��������� ����� �� �����ᠭ �� ���譨� ��⥬�
coPreQUE_SkipDuplicate               = 8; //  �ய�饭, �.�. ���� ����ࠡ�⠭�� �㡫�

// ���� Status ⠡���� QUE_EntriesForReview  QUE_OUT
//coQUE_  = 0;
coQUE_ReadyTransfToExtSystem         = 0; //  ��⮢� � ��।�� �� ������ ��⥬�
coQUE_AwaitRelatRecordToInsQue       = 1; //  ������� ��⠢�� �易���� ����ᥩ � ��।�
coQUE_ErrorTransToExtSystem          = 2; //  �訡�� ��।�� �� ������ ��⥬�
coQUE_SuccessTransToExtSystem        = 3; //  �ᯥ譮 ��।���
coQUE_NotAllPoolRcrdTransToExtSystem = 4; //  �� �� ����� �� �㫠 ��।��� �� ������ ��⥬�
coQUE_ErrorFindInstanceInReciept     = 5; //  ��������� ����� �� �����ᠭ �� ���譨� ��⥬�
coQUE_ErrButWillContinueTryToSend    = 6; //  �訡�� ��।��, �� �� �㤥� �஡�����
coQUE_TryToSend                      = 7; //  ��ࠡ��뢠���� ᥩ��
coQUE_SkipDuplicate                  = 8; //  �ய�饭, �.�. ���� ����ࠡ�⠭�� �㡫�

coQUE_TypeEvent_Insert = 'INSERT'; // ����⨥ ��⠢��
coQUE_TypeEvent_Delete = 'DELETE'; // ����⨥ ����������
coQUE_TypeEvent_Update = 'UPDATE'; // ����⨥ 㤠�����

coMaxTryCount = 5;


coQUE_INCOME_ReadyToProcess  = 0; // ��⮢� � ��ࠡ�⪥
coQUE_INCOME_Processing      = 1; // ��ࠡ��뢠����
coQUE_INCOME_Error           = 2; // �訡�� ��ࠡ�⪨
coQUE_INCOME_Success         = 3; // �ᯥ譮 ��ࠡ�⠭�
coQUE_INCOME_InvalidIdQueue  = 4; // �����४�� �����䨪��� ��।�
coQUE_INCOME_NotFoundQueById = 5; // �� ������� ������ ��।� �� �����䨪����

end;

type
  TResultPutMessageToIncomeQueue = record
    Code     : string;
    Message  : string;
    ID_QUEUE : string[36];
  end;

type
  TResultGetStatusMessageInIncomeQueue = record
    status      : string;
    status_code : string;
    Body        : widestring[2097151];
    BodyBase64  : widestring[2097151];
  end;


#end