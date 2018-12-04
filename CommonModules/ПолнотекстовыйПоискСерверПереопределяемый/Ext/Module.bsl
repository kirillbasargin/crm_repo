﻿#Область ПрограммныйИнтерфейс

// Позволяет внести изменения в дерево с разделами полнотекстового поиска, отображаемого при выборе области поиска.
// По умолчанию дерево разделов формируется на основании состава подсистем конфигурации.
// Структура дерева описана в форме Обработка.ПолнотекстовыйПоискВДанных.Форма.ВыборОбластиПоиска.
// Все колонки, неуказанные в параметрах, будут автоматически рассчитаны.
// При необходимости построить дерево разделов самостоятельно требуется сохранить состав колонок.
//
// Параметры:
//   РазделыПоиска - ДеревоЗначений - области поиска. Содержит колонки:
//       ** Раздел   - Строка   - Представление раздела: подсистемы или объекта метаданных.
//       ** Картинка - Картинка - Картинка раздела, рекомендуется только для корневых разделов.
//       ** ОбъектМД - СправочникСсылка.ИдентификаторыОбъектовМетаданных - Задается только для объектов метаданных,
//                     для разделов остается пустым.
// Пример:
//
//	НовыйРаздел = РазделыПоиска.Строки.Добавить();
//	НовыйРаздел.Раздел = "Главное";
//	НовыйРаздел.Картинка = БиблиотекаКартинок._ДемоРазделГлавное;
//	
//	ОбъектМетаданных = Метаданные.Документы._ДемоСчетНаОплатуПокупателю;
//	
//	Если ПравоДоступа("Просмотр", ОбъектМетаданных)
//		И ОбщегоНазначения.ОбъектМетаданныхДоступенПоФункциональнымОпциям(ОбъектМетаданных) Тогда 
//		
//		НовыйОбъектРаздела = НовыйРаздел.Строки.Добавить();
//		НовыйОбъектРаздела.Раздел = ОбъектМетаданных.ПредставлениеСписка;
//		НовыйОбъектРаздела.ОбъектМД = ОбщегоНазначения.ИдентификаторОбъектаМетаданных(ОбъектМетаданных);
//	КонецЕсли;
//
Процедура ПриПолученииРазделовПолнотекстовогоПоиска(РазделыПоиска) Экспорт
	
	
	
КонецПроцедуры

#КонецОбласти