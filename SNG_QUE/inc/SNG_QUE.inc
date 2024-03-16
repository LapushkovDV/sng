/*************************************************************************************************\
* Наименование: Базовый объект работы очереди                                                     *
* Контур/Модуль: Очередь исходящих сообщений                                                      *
* Примечание:  константы                                                                          *
*                                                                                                 *
* Вид работы  |Номер         |Дата    |Исполнитель              |Проект                           *
* ----------------------------------------------------------------------------------------------- *

\*************************************************************************************************/

#ifnDef _QUE_INC_INCLUDED_
#define _QUE_INC_INCLUDED_
const
// поле Status таблицы QUE_EntriesForReview
coPreQUE_AwaitProcessJSONgenerate    = 0; //  ожидает обработки для формирования JSON
coPreQUE_WaitForRelatedRcrdsToInsert = 1; //  ожидает вставки связанных записей
coPreQUE_ReadyToTransferToQueue      = 2; //  готова к передаче в очередь (JSON сформирован)
coPreQUE_AwaitProcessRelatedRcrd     = 3; //  ожидает генерации JSON в связанных записях (JSON сформирован)
coPreQUE_ErrorGenerateJSON           = 4; //  ошибка при генерации JSON
coPreQUE_SuccessTransferToQueue      = 5; //  успешно передана в очередь
coPreQUE_ErrorTransferToQueue        = 6; //  ошибка передачи в очередь
coPreQUE_ErrorFindInstanceInReciept  = 7; //  Экземпляр запроса не подписан на внешние системы


// поле Status таблицы QUE_EntriesForReview  QUE_OUT
//coQUE_  = 0;
coQUE_ReadyTransfToExtSystem         = 0; //  готова к передаче во внешнюю систему
coQUE_AwaitRelatRecordToInsQue       = 1; //  ожидает вставки связанных записей в очередь
coQUE_ErrorTransToExtSystem          = 2; //  ошибка передачи во внешнюю систему
coQUE_SuccessTransToExtSystem        = 3; //  успешно передана
coQUE_NotAllPoolRcrdTransToExtSystem = 4; //  не все записи из пула переданы во внешнюю систему
coQUE_ErrorFindInstanceInReciept     = 5; //  Экземпляр запроса не подписан на внешние системы
coQUE_ErrButWillContinueTryToSend    = 6; //  Ошибка передачи, но еще будем пробовать
coQUE_TryToSend                      = 7; //  обрабатывается сейчас

coQUE_TypeEvent_Insert = 'INSERT'; // Событие вставка
coQUE_TypeEvent_Delete = 'DELETE'; // Событие обновление
coQUE_TypeEvent_Update = 'UPDATE'; // Событие удаление

coMaxTryCount = 5;

end;
#end
