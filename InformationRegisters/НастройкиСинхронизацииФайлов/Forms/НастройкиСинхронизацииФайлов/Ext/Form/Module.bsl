﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	УстановитьУсловноеОформление();
	
	Если Параметры.Свойство("ВладелецФайла") Тогда
		ТекущийВладелецФайла = ОбщегоНазначения.ИдентификаторОбъектаМетаданных(ТипЗнч(Параметры.ВладелецФайла));
		ВладелецФайла        = Параметры.ВладелецФайла;
	КонецЕсли;
	
	ЗаполнитьТипыОбъектовВДеревеЗначений();
	
	АвтоматическиСинхронизироватьФайлы       = АвтоматическаяСинхронизацияВключена();
	
	Элементы.Расписание.Заголовок            = ТекущееРасписание();
	Элементы.Расписание.Доступность          = АвтоматическиСинхронизироватьФайлы;
	Элементы.НастроитьРасписание.Доступность = АвтоматическиСинхронизироватьФайлы;
	
	Если ОбщегоНазначения.РазделениеВключено() Тогда
		Элементы.НастроитьРасписание.Видимость = Ложь;
		Элементы.Расписание.Видимость          = Ложь;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура АвтоматическиСинхронизироватьФайлыПриИзменении(Элемент)
	
	УстановитьПараметрРегламентногоЗадания("Использование", АвтоматическиСинхронизироватьФайлы);
	Элементы.Расписание.Доступность = АвтоматическиСинхронизироватьФайлы;
	Элементы.НастроитьРасписание.Доступность = АвтоматическиСинхронизироватьФайлы;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыДеревоОбъектовМетаданных

&НаКлиенте
Процедура ДеревоОбъектовМетаданныхСинхронизироватьПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.ДеревоОбъектовМетаданных.ТекущиеДанные;
	Модифицированность = Истина;
	
	Если Не ЗначениеЗаполнено(ТекущиеДанные.УчетнаяЗапись) Тогда
		ТекущиеДанные.Синхронизировать = Ложь;
		ОткрытьФормуНастроек();
		Возврат;
	КонецЕсли;
	
	Если ТекущиеДанные.ПолучитьЭлементы().Количество() > 1 Тогда
		УстановитьЗначениеСинхронизацииПодчиненнымОбъектам(ТекущиеДанные.Синхронизировать);
	Иначе
		ЗаписатьТекущиеНастройки();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ДеревоОбъектовМетаданныхПриАктивизацииСтроки(Элемент)
	
	ТекущиеДанные = Элементы.ДеревоОбъектовМетаданных.ТекущиеДанные;
	
	Если ТекущиеДанные <> Неопределено Тогда
		ЕстьНастройки = ЗначениеЗаполнено(ТекущиеДанные.УчетнаяЗапись);
		Элементы.ДеревоОбъектовМетаданныхКонтекстноеМенюУдалить.Доступность                        = ЕстьНастройки;
		Элементы.ФормаДеревоОбъектовМетаданныхУдалить.Доступность                                  = ЕстьНастройки;
		Элементы.ФормаИзменитьНастройкуСинхронизации.Доступность                                   = ЕстьНастройки;
		Элементы.ДеревоОбъектовМетаданныхКонтекстноеМенюИзменитьНастройкуСинхронизации.Доступность = ЕстьНастройки;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ДеревоОбъектовМетаданныхВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ОткрытьФормуНастроек();
	
КонецПроцедуры

&НаКлиенте
Процедура ДеревоОбъектовМетаданныхПравилоОтбораНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ОткрытьФормуНастроек();
	
КонецПроцедуры

&НаКлиенте
Процедура ДеревоОбъектовМетаданныхПередУдалением(Элемент, Отказ)
	
	Отказ = Истина;
	
	ТекстВопроса = НСтр("ru = 'Удаление настройки приведет к прекращению синхронизации 
		|по заданным в ней правилам. Продолжить?'");
		
	ОписаниеОповещения = Новый ОписаниеОповещения("УдалитьНастройкуЗавершение", ЭтотОбъект);
	ПоказатьВопрос(ОписаниеОповещения, ТекстВопроса, РежимДиалогаВопрос.ДаНет, , КодВозвратаДиалога.Нет, НСтр("ru = 'Предупреждение'"));
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура НастроитьРасписание(Команда)
	ДиалогРасписания = Новый ДиалогРасписанияРегламентногоЗадания(ТекущееРасписание());
	ОписаниеОповещения = Новый ОписаниеОповещения("НастроитьРасписаниеЗавершение", ЭтотОбъект);
	ДиалогРасписания.Показать(ОписаниеОповещения);
КонецПроцедуры

&НаКлиенте
Процедура СинхронизацияЭлемента(Команда)
	
	СтрокаДерева = Элементы.ДеревоОбъектовМетаданных.ТекущиеДанные;
	Если Не СтрокаДерева.ВозможностьДетализации Тогда
		ТекстСообщения = НСтр("ru = 'Добавление настройки возможно только для иерархических справочников'");
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения);
		Возврат;
	КонецЕсли;
	
	ПараметрыФормыВыбора = Новый Структура;
	
	ПараметрыФормыВыбора.Вставить("ВыборГруппИЭлементов", ИспользованиеГруппИЭлементов.ГруппыИЭлементы);
	ПараметрыФормыВыбора.Вставить("ЗакрыватьПриВыборе", Истина);
	ПараметрыФормыВыбора.Вставить("ЗакрыватьПриЗакрытииВладельца", Истина);
	ПараметрыФормыВыбора.Вставить("МножественныйВыбор", Истина);
	ПараметрыФормыВыбора.Вставить("РежимВыбора", Истина);
	
	ПараметрыФормыВыбора.Вставить("РежимОткрытияОкна", РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	ПараметрыФормыВыбора.Вставить("ВыборГрупп", Истина);
	ПараметрыФормыВыбора.Вставить("ВыборГруппПользователей", Истина);
	
	ПараметрыФормыВыбора.Вставить("РасширенныйПодбор", Истина);
	ПараметрыФормыВыбора.Вставить("ЗаголовокФормыПодбора", НСтр("ru = 'Подбор элементов настроек'"));
	
	// Исключим из списка выбора уже существующие настройки.
	СуществующиеНастройки = СтрокаДерева.ПолучитьЭлементы();
	ФиксированныеНастройки = Новый НастройкиКомпоновкиДанных;
	ЭлементНастройки = ФиксированныеНастройки.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ЭлементНастройки.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Ссылка");
	ЭлементНастройки.ВидСравнения = ВидСравненияКомпоновкиДанных.НеВСписке;
	СписокСуществующих = Новый Массив;
	Для Каждого Настройка Из СуществующиеНастройки Цикл
		СписокСуществующих.Добавить(Настройка.ВладелецФайла);
	КонецЦикла;
	ЭлементНастройки.ПравоеЗначение = СписокСуществующих;
	ЭлементНастройки.Использование = Истина;
	ЭлементНастройки.РежимОтображения = РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный;
	ПараметрыФормыВыбора.Вставить("ФиксированныеНастройки", ФиксированныеНастройки);
	
	ОткрытьФорму(ПутьФормыВыбора(СтрокаДерева.ВладелецФайла), ПараметрыФормыВыбора, Элементы.ДеревоОбъектовМетаданных);
	
КонецПроцедуры

&НаКлиенте
Процедура Синхронизировать(Команда)
	
	ПрерватьФоновоеЗадание();
	ЗапуститьРегламентноеЗадание();
	УстановитьВидимостьКомандыСинхронизировать();
	ПодключитьОбработчикОжидания("ПроверитьВыполнениеФоновогоЗадания", 2, Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура ИзменитьНастройкуСинхронизации(Команда)
	
	ОткрытьФормуНастроек();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура НастроитьРасписаниеЗавершение(Расписание, ДополнительныеПараметры) Экспорт
	
	Если Расписание = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	УстановитьПараметрРегламентногоЗадания("Расписание", Расписание);
	Элементы.Расписание.Заголовок = Расписание;
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьТипыОбъектовВДеревеЗначений()
	
	НастройкиСинхронизации = РегистрыСведений.НастройкиСинхронизацииФайлов.ТекущиеНастройкиСинхронизации();
	
	ДеревоОМ = РеквизитФормыВЗначение("ДеревоОбъектовМетаданных");
	ДеревоОМ.Строки.Очистить();
	
	МетаданныеСправочники = Метаданные.Справочники;
	
	ТаблицаТипов = Новый ТаблицаЗначений;
	ТаблицаТипов.Колонки.Добавить("ВладелецФайла");
	ТаблицаТипов.Колонки.Добавить("ТипВладельцаФайла");
	ТаблицаТипов.Колонки.Добавить("ЭтоФайл", Новый ОписаниеТипов("Булево"));
	ТаблицаТипов.Колонки.Добавить("ВозможностьДетализации", Новый ОписаниеТипов("Булево"));
	
	ВидИерархииГруппИЭлементов = Метаданные.СвойстваОбъектов.ВидИерархии.ИерархияГруппИЭлементов;
	
	МассивИсключений = РаботаСФайламиСлужебный.ПриОпределенииОбъектовИсключенияСинхронизацииФайлов();
	
	Для Каждого Справочник Из МетаданныеСправочники Цикл
		
		Если Справочник.Реквизиты.Найти("ВладелецФайла") <> Неопределено Тогда
			
			ТипыВладельцевФайлов = Справочник.Реквизиты.ВладелецФайла.Тип.Типы();
			Для Каждого ТипВладельца Из ТипыВладельцевФайлов Цикл
				
				МетаданныеВладельца = Метаданные.НайтиПоТипу(ТипВладельца);
				Если МассивИсключений.Найти(МетаданныеВладельца) <> Неопределено Тогда
					Продолжить;
				КонецЕсли;
				
				НоваяСтрока                        = ТаблицаТипов.Добавить();
				НоваяСтрока.ВладелецФайла          = ТипВладельца;
				НоваяСтрока.ТипВладельцаФайла      = Справочник;
				НоваяСтрока.ВозможностьДетализации = Истина;
				НоваяСтрока.ЭтоФайл                = Не СтрЗаканчиваетсяНа(Справочник.Имя, "ПрисоединенныеФайлы");
				
			КонецЦикла;
			
		КонецЕсли;
		
	КонецЦикла;
	
	ВсеСправочники     = Справочники.ТипВсеСсылки();
	ВсеДокументы       = Документы.ТипВсеСсылки();
	Узлы = Новый Соответствие;
	
	Для Каждого Тип Из ТаблицаТипов Цикл
		НастройкаИмеетГлобальныеПравила = Ложь;
		Если ВсеСправочники.СодержитТип(Тип.ВладелецФайла) Тогда
			Если Узлы["Справочники"] = Неопределено Тогда
				УзелСправочники = ДеревоОМ.Строки.Добавить();
				УзелСправочники.СинонимНаименованияОбъекта = НСтр("ru = 'Справочники'");
				Узлы.Вставить("Справочники", УзелСправочники);
			КонецЕсли;
			НоваяСтрокаТаблицы = Узлы["Справочники"].Строки.Добавить();
		ИначеЕсли ВсеДокументы.СодержитТип(Тип.ВладелецФайла) Тогда
			
			Если Узлы["Документы"] = Неопределено Тогда
				УзелДокументы = ДеревоОМ.Строки.Добавить();
				УзелДокументы.СинонимНаименованияОбъекта = НСтр("ru = 'Документы'");
				Узлы.Вставить("Документы", УзелДокументы);
			КонецЕсли;
			НоваяСтрокаТаблицы = Узлы["Документы"].Строки.Добавить();
		ИначеЕсли БизнесПроцессы.ТипВсеСсылки().СодержитТип(Тип.ВладелецФайла) Тогда
			
			Если Узлы["БизнесПроцессы"] = Неопределено Тогда
				УзелБизнесПроцессы = ДеревоОМ.Строки.Добавить();
				УзелБизнесПроцессы.СинонимНаименованияОбъекта = НСтр("ru = 'Бизнес-процессы'");
				Узлы.Вставить("БизнесПроцессы", УзелБизнесПроцессы);
			КонецЕсли;
			НоваяСтрокаТаблицы = Узлы["БизнесПроцессы"].Строки.Добавить();
		КонецЕсли;
		
		ИдентификаторОбъекта = ОбщегоНазначения.ИдентификаторОбъектаМетаданных(Тип.ВладелецФайла);
		Отбор = Новый Структура("ВладелецФайла, ЭтоФайл", ИдентификаторОбъекта, Тип.ЭтоФайл);
		ДетализированныеНастройки = НастройкиСинхронизации.НайтиСтроки(Отбор);
		Если ДетализированныеНастройки.Количество() > 1 Тогда
			НастройкаИмеетГлобальныеПравила = Истина;
			Для Каждого Настройка Из ДетализированныеНастройки Цикл
				ПравилоОтбора                               = Настройка.ПравилоОтбора.Получить();
				ДетализированнаяНастройка                   = НоваяСтрокаТаблицы.Строки.Добавить();
				ДетализированнаяНастройка.ВладелецФайла     = Настройка.ВладелецФайла;
				ДетализированнаяНастройка.ТипВладельцаФайла = Настройка.ТипВладельцаФайла;
				
				ЕстьПравилоОтбора = Ложь;
				Если ПравилоОтбора <> Неопределено Тогда
					ЕстьПравилоОтбора = ПравилоОтбора.Отбор.Элементы.Количество() > 0;
				КонецЕсли;
				
				Если Не ПустаяСтрока(Настройка.Наименование) Тогда
					ДетализированнаяНастройка.СинонимНаименованияОбъекта = Настройка.Наименование;
				Иначе
					ДетализированнаяНастройка.СинонимНаименованияОбъекта = Настройка.ВладелецФайла.Синоним;
				КонецЕсли;
				
				ДетализированнаяНастройка.Синхронизировать = Настройка.Синхронизировать;
				ДетализированнаяНастройка.УчетнаяЗапись    = Настройка.УчетнаяЗапись;
				ДетализированнаяНастройка.ЭтоФайл          = Настройка.ЭтоФайл;
				ДетализированнаяНастройка.ПравилоОтбора    =
					?(ЕстьПравилоОтбора, НСтр("ru = 'Выбранные файлы'"), НСтр("ru = 'Все файлы'"));
				
			КонецЦикла;
		КонецЕсли;
		
		ИдентификаторОбъекта = ОбщегоНазначения.ИдентификаторОбъектаМетаданных(Тип.ВладелецФайла);
		Отбор = Новый Структура("ИдентификаторВладельца, ЭтоФайл", ИдентификаторОбъекта, Тип.ЭтоФайл);
		ДетализированныеНастройки = НастройкиСинхронизации.НайтиСтроки(Отбор);
		Если ДетализированныеНастройки.Количество() > 0 Тогда
			Для Каждого Настройка Из ДетализированныеНастройки Цикл
				ПравилоОтбора                               = Настройка.ПравилоОтбора.Получить();
				ДетализированнаяНастройка                   = НоваяСтрокаТаблицы.Строки.Добавить();
				ДетализированнаяНастройка.ВладелецФайла     = Настройка.ВладелецФайла;
				ДетализированнаяНастройка.ТипВладельцаФайла = Настройка.ТипВладельцаФайла;
				
				ЕстьПравилоОтбора = Ложь;
				Если ПравилоОтбора <> Неопределено Тогда
					ЕстьПравилоОтбора = ПравилоОтбора.Отбор.Элементы.Количество() > 0;
				КонецЕсли;
				
				Если Не ПустаяСтрока(Настройка.Наименование) Тогда
					ДетализированнаяНастройка.СинонимНаименованияОбъекта = Настройка.Наименование;
				Иначе
					ДетализированнаяНастройка.СинонимНаименованияОбъекта = Настройка.ВладелецФайла;
				КонецЕсли;
				
				ЕстьПравилоОтбора = Ложь;
				Если ПравилоОтбора <> Неопределено Тогда
					ЕстьПравилоОтбора = ПравилоОтбора.Отбор.Элементы.Количество() > 0;
				КонецЕсли;
				
				ДетализированнаяНастройка.Синхронизировать = Настройка.Синхронизировать;
				ДетализированнаяНастройка.УчетнаяЗапись    = Настройка.УчетнаяЗапись;
				ДетализированнаяНастройка.ЭтоФайл          = Настройка.ЭтоФайл;
				ДетализированнаяНастройка.ПравилоОтбора    =
					?(ЕстьПравилоОтбора, НСтр("ru = 'Выбранные файлы'"), НСтр("ru = 'Все файлы'"));
				
			КонецЦикла;
		КонецЕсли;
		
		МетаданныеОбъекта = Метаданные.НайтиПоТипу(Тип.ВладелецФайла);
		НоваяСтрокаТаблицы.ВладелецФайла = ОбщегоНазначения.ИдентификаторОбъектаМетаданных(Тип.ВладелецФайла);
		НоваяСтрокаТаблицы.ТипВладельцаФайла = ОбщегоНазначения.ИдентификаторОбъектаМетаданных(Тип.ТипВладельцаФайла);
		НоваяСтрокаТаблицы.СинонимНаименованияОбъекта = МетаданныеОбъекта.Синоним;
		НоваяСтрокаТаблицы.ЭтоФайл = Тип.ЭтоФайл;
		НоваяСтрокаТаблицы.ВозможностьДетализации = Тип.ВозможностьДетализации;
		
		Если Не НастройкаИмеетГлобальныеПравила Тогда
			
			Отбор = Новый Структура("ВладелецФайла, ЭтоФайл", НоваяСтрокаТаблицы.ВладелецФайла, НоваяСтрокаТаблицы.ЭтоФайл);
			НайденныеНастройки = НастройкиСинхронизации.НайтиСтроки(Отбор);
			
			Если НайденныеНастройки.Количество() > 0 Тогда
				
				ПравилоОтбора = НайденныеНастройки[0].ПравилоОтбора.Получить();
				
				НоваяСтрокаТаблицы.Синхронизировать = НайденныеНастройки[0].Синхронизировать;
				НоваяСтрокаТаблицы.УчетнаяЗапись =    НайденныеНастройки[0].УчетнаяЗапись;
				Если ПравилоОтбора <> Неопределено И ПравилоОтбора.Отбор.Элементы.Количество() > 0 Тогда
					НоваяСтрокаТаблицы.ПравилоОтбора = ?(ПустаяСтрока(НайденныеНастройки[0].Наименование), НСтр("ru = 'Выбранные файлы'"), НайденныеНастройки[0].Наименование);
				Иначе
					НоваяСтрокаТаблицы.ПравилоОтбора = НСтр("ru = 'Все файлы'");
				КонецЕсли;
				
			Иначе
				
				НоваяСтрокаТаблицы.Синхронизировать = Перечисления.ВариантыОчисткиФайлов.НеОчищать;
				НоваяСтрокаТаблицы.ПравилоОтбора = НСтр("ru = 'Все файлы'");
				
			КонецЕсли;
			
		КонецЕсли;
	КонецЦикла;
	
	Для Каждого УзелВерхнегоУровня Из ДеревоОМ.Строки Цикл
		УзелВерхнегоУровня.Строки.Сортировать("СинонимНаименованияОбъекта");
	КонецЦикла;
	ЗначениеВРеквизитФормы(ДеревоОМ, "ДеревоОбъектовМетаданных");
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаписатьТекущиеНастройки()
	
	ТекущиеДанные = Элементы.ДеревоОбъектовМетаданных.ТекущиеДанные;
	ЗаписатьТекущиеНастройкиПоОбъекту(
		ТекущиеДанные.ВладелецФайла,
		ТекущиеДанные.ТипВладельцаФайла,
		ТекущиеДанные.Синхронизировать,
		ТекущиеДанные.УчетнаяЗапись,
		ТекущиеДанные.ЭтоФайл);
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьНастройкиОтбора(ВыбранноеЗначение, ДополнительныеПараметры) Экспорт
	
	Если ВыбранноеЗначение = Неопределено Тогда
		Возврат
	КонецЕсли;
	
	СтрокаВладелец = ДеревоОбъектовМетаданных.НайтиПоИдентификатору(ДополнительныеПараметры.Идентификатор);
	
	Если СтрокаВладелец.ВладелецФайла <> ВыбранноеЗначение.ВладелецФайла Тогда
		ЭлементВладелец   = СтрокаВладелец.ПолучитьЭлементы();
		ОбновляемаяСтрока = ЭлементВладелец.Добавить();
		Если НЕ ВыбранноеЗначение.НоваяНастройка Тогда
			СтрокаВладелец.Синхронизировать = Ложь;
		КонецЕсли;
		ЗаписатьТекущиеНастройки();
	Иначе
		ОбновляемаяСтрока = СтрокаВладелец;
	КонецЕсли;
	
	ЗаполнитьЗначенияСвойств(ОбновляемаяСтрока, ВыбранноеЗначение);
	
	Если ВыбранноеЗначение.ЕстьПравилоОтбора Тогда
		ОбновляемаяСтрока.ПравилоОтбора =
			?( ЗначениеЗаполнено(ВыбранноеЗначение.Наименование), ВыбранноеЗначение.Наименование, НСтр("ru = 'Выбранные файлы'"));
	Иначе
		ОбновляемаяСтрока.ПравилоОтбора = НСтр("ru = 'Все файлы'");
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьЗначениеСинхронизацииПодчиненнымОбъектам(Знач Синхронизировать)
	
	Для Каждого ИдентификаторСтроки Из Элементы.ДеревоОбъектовМетаданных.ВыделенныеСтроки Цикл
		ЭлементДерева = ДеревоОбъектовМетаданных.НайтиПоИдентификатору(ИдентификаторСтроки);
		Если ЭлементДерева.ПолучитьРодителя() = Неопределено Тогда 
			Для Каждого ПодчиненныйЭлементДерева Из ЭлементДерева.ПолучитьЭлементы() Цикл
				УстановитьЗначениеСинхронизацииОбъекта(ПодчиненныйЭлементДерева, Синхронизировать);
			КонецЦикла;
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьЗначениеСинхронизацииОбъекта(ВыбранныйОбъект, Знач Синхронизировать)
	
	ВыбранныйОбъект.Синхронизировать = Синхронизировать;
	ЗаписатьТекущиеНастройкиПоОбъекту(
		ВыбранныйОбъект.ВладелецФайла,
		ВыбранныйОбъект.ТипВладельцаФайла,
		Синхронизировать,
		ВыбранныйОбъект.УчетнаяЗапись,
		ВыбранныйОбъект.ЭтоФайл);
	
КонецПроцедуры

&НаСервере
Процедура ЗаписатьТекущиеНастройкиПоОбъекту(ВладелецФайла, ТипВладельцаФайла, Синхронизировать, УчетнаяЗапись, ЭтоФайл)
	
	Настройка                   = РегистрыСведений.НастройкиСинхронизацииФайлов.СоздатьМенеджерЗаписи();
	Настройка.ВладелецФайла     = ВладелецФайла;
	Настройка.ТипВладельцаФайла = ТипВладельцаФайла;
	Настройка.Синхронизировать  = Синхронизировать;
	Настройка.УчетнаяЗапись     = УчетнаяЗапись;
	Настройка.ЭтоФайл           = ЭтоФайл;
	Настройка.Записать();
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьФормуНастроек()
	
	ТекущиеДанные = Элементы.ДеревоОбъектовМетаданных.ТекущиеДанные;
	
	Если Не ЗначениеЗаполнено(ТекущиеДанные.ВладелецФайла)
		Или Не ЗначениеЗаполнено(ТекущиеДанные.ТипВладельцаФайла) Тогда
		Возврат;
	КонецЕсли;
	
	Отбор = Новый Структура;
	Отбор.Вставить("ВладелецФайла",     ТекущиеДанные.ВладелецФайла);
	Отбор.Вставить("ТипВладельцаФайла", ТекущиеДанные.ТипВладельцаФайла);
	Отбор.Вставить("УчетнаяЗапись",     ТекущиеДанные.УчетнаяЗапись);
	
	Если ЗначениеЗаполнено(ТекущиеДанные.УчетнаяЗапись) Тогда
		
		ТипЗначения = Тип("РегистрСведенийКлючЗаписи.НастройкиСинхронизацииФайлов");
		ПараметрыЗаписи = Новый Массив(1);
		ПараметрыЗаписи[0] = Отбор;
		
		КлючЗаписи = Новый(ТипЗначения, ПараметрыЗаписи);
		
		ПараметрыЗаписи = Новый Структура;
		ПараметрыЗаписи.Вставить("Ключ", КлючЗаписи);
	Иначе
		ПараметрыЗаписи = Отбор;
		ПараметрыЗаписи.Вставить("ЭтоФайл", ТекущиеДанные.ЭтоФайл);
	КонецЕсли;
	
	ДополнительныеПараметры = Новый Структура();
	
	Если ТекущиеДанные.ВозможностьДетализации Тогда
		ДополнительныеПараметры.Вставить("Идентификатор", ТекущиеДанные.ПолучитьИдентификатор());
	Иначе
		ДополнительныеПараметры.Вставить("Идентификатор", ТекущиеДанные.ПолучитьРодителя().ПолучитьИдентификатор());
	КонецЕсли;
	
	Оповещение = Новый ОписаниеОповещения("УстановитьНастройкиОтбора", ЭтотОбъект, ДополнительныеПараметры);
	ОткрытьФорму("РегистрСведений.НастройкиСинхронизацииФайлов.Форма.ФормаЗаписиНастройки", ПараметрыЗаписи, ЭтотОбъект,,,, Оповещение);
	
КонецПроцедуры

&НаСервере
Функция ПутьФормыВыбора(ВладелецФайла)
	
	ОбъектМетаданных = ОбщегоНазначения.ОбъектМетаданныхПоИдентификатору(ВладелецФайла);
	Возврат ОбъектМетаданных.ПолноеИмя() + ".ФормаВыбора";
	
КонецФункции

&НаСервере
Функция ОчиститьДанныеНастройки()
	
	ПараметрыВызоваСервера = Новый Структура();
	
	ПараметрыВыполненияВФоне = ДлительныеОперации.ПараметрыВыполненияВФоне(ЭтотОбъект.УникальныйИдентификатор);
	ПараметрыВыполненияВФоне.НаименованиеФоновогоЗадания = НСтр("ru = 'Подсистема Работа с файлам: Отключение синхронизации файлов с облачным сервисом'");
	
	ФоновоеЗадание = ДлительныеОперации.ВыполнитьВФоне("РаботаСФайламиСлужебный.ОсвободитьЗахваченныеФайлыФон",
		ПараметрыВызоваСервера, ПараметрыВыполненияВФоне);
	
	Возврат ФоновоеЗадание;
	
КонецФункции

&НаКлиенте
Процедура ОчиститьДанныеНастройкиЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если ТипЗнч(Результат) <> Тип("Структура") ИЛИ НЕ Результат.Свойство("Статус") ИЛИ Результат.Статус <> "Выполнено" Тогда
		Возврат;
	КонецЕсли;
	
	ОчиститьДанныеНастройкиНаСервере(ДополнительныеПараметры.ТекущаяСтрока);
	
КонецПроцедуры

&НаКлиенте
Процедура УдалитьНастройкуЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = КодВозвратаДиалога.Да Тогда
		
		НастройкаДляУдаления = ДеревоОбъектовМетаданных.НайтиПоИдентификатору(Элементы.ДеревоОбъектовМетаданных.ТекущаяСтрока);
		НастройкаДляУдаления.Синхронизировать = Ложь;
		УстановитьЗначениеСинхронизацииПодчиненнымОбъектам(Ложь);
		ЗаписатьТекущиеНастройки();
		
		ДополнительныеПараметрыВызова = Новый Структура();
		ДополнительныеПараметрыВызова.Вставить("ТекущаяСтрока", Элементы.ДеревоОбъектовМетаданных.ТекущаяСтрока);
		
		ФоновоеЗадание = ОчиститьДанныеНастройки();
		НастройкиОжидания                                = ДлительныеОперацииКлиент.ПараметрыОжидания(ЭтотОбъект);
		НастройкиОжидания.ВыводитьОкноОжидания           = Истина;
		Обработчик = Новый ОписаниеОповещения("ОчиститьДанныеНастройкиЗавершение", ЭтотОбъект, ДополнительныеПараметрыВызова);
		ДлительныеОперацииКлиент.ОжидатьЗавершение(ФоновоеЗадание, Обработчик, НастройкиОжидания);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СоздатьСинхронизациюФайлов(Команда)
	
	СтрокаДерева = Элементы.ДеревоОбъектовМетаданных.ТекущиеДанные;
	Если СтрокаДерева = Неопределено Или СтрокаДерева.ПолучитьРодителя() = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если СтрокаДерева.ВозможностьДетализации Тогда
		ВладелецФайла = СтрокаДерева.ВладелецФайла;
		Идентификатор = СтрокаДерева.ПолучитьИдентификатор();
	Иначе
		ВладелецФайла = СтрокаДерева.ПолучитьРодителя().ВладелецФайла;
		Идентификатор = СтрокаДерева.ПолучитьРодителя().ПолучитьИдентификатор();
	КонецЕсли;
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("ВладелецФайла",     ВладелецФайла);
	ПараметрыФормы.Вставить("ТипВладельцаФайла", СтрокаДерева.ТипВладельцаФайла);
	ПараметрыФормы.Вставить("ЭтоФайл",           СтрокаДерева.ЭтоФайл);
	ПараметрыФормы.Вставить("НоваяНастройка",    Истина);
	ПараметрыФормы.Вставить("Идентификатор",     Идентификатор);
	
	Оповещение = Новый ОписаниеОповещения("УстановитьНастройкиОтбора", ЭтотОбъект, ПараметрыФормы);
	ОткрытьФорму("РегистрСведений.НастройкиСинхронизацииФайлов.Форма.ФормаЗаписиНастройки", ПараметрыФормы, ЭтотОбъект,,,, Оповещение);
	
КонецПроцедуры

&НаКлиенте
Процедура ПрерватьФоновоеЗадание()
	ОтменитьВыполнениеЗадания(ИдентификаторФоновогоЗадания);
	ОтключитьОбработчикОжидания("ПроверитьВыполнениеФоновогоЗадания");
	ТекущееФоновоеЗадание = "";
	ИдентификаторФоновогоЗадания = "";
КонецПроцедуры

&НаСервереБезКонтекста
Процедура ОтменитьВыполнениеЗадания(ИдентификаторФоновогоЗадания)
	Если ЗначениеЗаполнено(ИдентификаторФоновогоЗадания) Тогда
		ДлительныеОперации.ОтменитьВыполнениеЗадания(ИдентификаторФоновогоЗадания);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПроверитьВыполнениеФоновогоЗадания()
	Если ЗначениеЗаполнено(ИдентификаторФоновогоЗадания) И Не ЗаданиеВыполнено(ИдентификаторФоновогоЗадания) Тогда
		ПодключитьОбработчикОжидания("ПроверитьВыполнениеФоновогоЗадания", 5, Истина);
	Иначе
		ИдентификаторФоновогоЗадания = "";
		ТекущееФоновоеЗадание = "";
		УстановитьВидимостьКомандыСинхронизировать();
	КонецЕсли;
КонецПроцедуры

&НаСервереБезКонтекста
Функция ЗаданиеВыполнено(ИдентификаторФоновогоЗадания)
	Возврат ДлительныеОперации.ЗаданиеВыполнено(ИдентификаторФоновогоЗадания);
КонецФункции

&НаСервере
Процедура ЗапуститьРегламентноеЗадание()
	
	РегламентноеЗаданиеМетаданные = Метаданные.РегламентныеЗадания.СинхронизацияФайлов;
	
	Отбор = Новый Структура;
	ИмяМетода = РегламентноеЗаданиеМетаданные.ИмяМетода;
	Отбор.Вставить("ИмяМетода", ИмяМетода);
	Отбор.Вставить("Состояние", СостояниеФоновогоЗадания.Активно);
	ФоновыеЗаданияСинхронизации = ФоновыеЗадания.ПолучитьФоновыеЗадания(Отбор);
	Если ФоновыеЗаданияСинхронизации.Количество() > 0 Тогда
		ИдентификаторФоновогоЗадания = ФоновыеЗаданияСинхронизации[0].УникальныйИдентификатор;
	Иначе
		ПараметрыЗадания = ДлительныеОперации.ПараметрыВыполненияВФоне(УникальныйИдентификатор);
		ПараметрыЗадания.НаименованиеФоновогоЗадания = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru = 'Запуск вручную: %1'"), РегламентноеЗаданиеМетаданные.Синоним);
		РезультатЗадания = ДлительныеОперации.ВыполнитьВФоне(РегламентноеЗаданиеМетаданные.ИмяМетода, Новый Структура, ПараметрыЗадания);
		Если ЗначениеЗаполнено(ИдентификаторФоновогоЗадания) Тогда
			ИдентификаторФоновогоЗадания = РезультатЗадания.ИдентификаторЗадания;
		КонецЕсли;
	КонецЕсли;
	
	ТекущееФоновоеЗадание = "Синхронизация";
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьВидимостьКомандыСинхронизировать()
	
	ПодчиненныеСтраницы = Элементы.СинхронизацияФайлов.ПодчиненныеЭлементы;
	Если ПустаяСтрока(ТекущееФоновоеЗадание) Тогда
		Элементы.СинхронизацияФайлов.ТекущаяСтраница = ПодчиненныеСтраницы.Синхронизация;
	Иначе
		Элементы.СинхронизацияФайлов.ТекущаяСтраница = ПодчиненныеСтраницы.СтатусФоновогоЗадания;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьПараметрРегламентногоЗадания(ИмяПараметра, ЗначениеПараметра)
	
	ПараметрыЗадания = Новый Структура;
	ПараметрыЗадания.Вставить("Метаданные", Метаданные.РегламентныеЗадания.СинхронизацияФайлов);
	Если Не ОбщегоНазначения.РазделениеВключено() Тогда
		ПараметрыЗадания.Вставить("ИмяМетода", Метаданные.РегламентныеЗадания.СинхронизацияФайлов.ИмяМетода);
	КонецЕсли;
	
	УстановитьПривилегированныйРежим(Истина);
	
	СписокЗаданий = РегламентныеЗаданияСервер.НайтиЗадания(ПараметрыЗадания);
	Если СписокЗаданий.Количество() = 0 Тогда
		ПараметрыЗадания.Вставить(ИмяПараметра, ЗначениеПараметра);
		РегламентныеЗаданияСервер.ДобавитьЗадание(ПараметрыЗадания);
	Иначе
		ПараметрыЗадания = Новый Структура(ИмяПараметра, ЗначениеПараметра);
		Для Каждого Задание Из СписокЗаданий Цикл
			РегламентныеЗаданияСервер.ИзменитьЗадание(Задание, ПараметрыЗадания);
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция ПолучитьПараметрРегламентногоЗадания(ИмяПараметра, ЗначениеПоУмолчанию)
	
	ПараметрыЗадания = Новый Структура;
	ПараметрыЗадания.Вставить("Метаданные", Метаданные.РегламентныеЗадания.СинхронизацияФайлов);
	Если Не ОбщегоНазначения.РазделениеВключено() Тогда
		ПараметрыЗадания.Вставить("ИмяМетода", Метаданные.РегламентныеЗадания.СинхронизацияФайлов.ИмяМетода);
	КонецЕсли;
	
	УстановитьПривилегированныйРежим(Истина);
	
	СписокЗаданий = РегламентныеЗаданияСервер.НайтиЗадания(ПараметрыЗадания);
	Для Каждого Задание Из СписокЗаданий Цикл
		Возврат Задание[ИмяПараметра];
	КонецЦикла;
	
	Возврат ЗначениеПоУмолчанию;
	
КонецФункции

&НаСервере
Функция ТекущееРасписание()
	Возврат ПолучитьПараметрРегламентногоЗадания("Расписание", Новый РасписаниеРегламентногоЗадания);
КонецФункции

&НаСервере
Функция АвтоматическаяСинхронизацияВключена()
	Возврат ПолучитьПараметрРегламентногоЗадания("Использование", Ложь);
КонецФункции

&НаСервере
Процедура УстановитьУсловноеОформление()
	
	УсловноеОформление.Элементы.Очистить();
	
	Элемент = УсловноеОформление.Элементы.Добавить();

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных("ДеревоОбъектовМетаданныхСинонимНаименованияОбъекта");

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение  = Новый ПолеКомпоновкиДанных("ДеревоОбъектовМетаданных.Синхронизировать");
	ОтборЭлемента.ВидСравнения   = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Истина;

	Элемент.Оформление.УстановитьЗначениеПараметра("Шрифт", Новый Шрифт(WindowsШрифты.ШрифтДиалоговИМеню, , , Истина, Ложь, Ложь, Ложь));
	
	//
	Элемент = УсловноеОформление.Элементы.Добавить();

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных("ДеревоОбъектовМетаданныхПравилоОтбора");

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ДеревоОбъектовМетаданных.Синхронизировать");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Ложь;

	Элемент.Оформление.УстановитьЗначениеПараметра("Видимость", Ложь);
	
	//
	Элемент = УсловноеОформление.Элементы.Добавить();

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных("ДеревоОбъектовМетаданныхУчетнаяЗапись");

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ДеревоОбъектовМетаданных.Синхронизировать");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Истина;
	
	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ДеревоОбъектовМетаданных.УчетнаяЗапись");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.НеЗаполнено;

	Элемент.Оформление.УстановитьЗначениеПараметра("ОтметкаНезаполненного", Истина);
	
КонецПроцедуры

&НаСервере
Процедура ОчиститьДанныеНастройкиНаСервере(Знач ТекущаяСтрока)
	
	НастройкаДляУдаления = ДеревоОбъектовМетаданных.НайтиПоИдентификатору(ТекущаяСтрока);
	
	Если ЗначениеЗаполнено(НастройкаДляУдаления.УчетнаяЗапись) Тогда
		МенеджерЗаписи                   = РегистрыСведений.НастройкиСинхронизацииФайлов.СоздатьМенеджерЗаписи();
		МенеджерЗаписи.ВладелецФайла     = НастройкаДляУдаления.ВладелецФайла;
		МенеджерЗаписи.ТипВладельцаФайла = НастройкаДляУдаления.ТипВладельцаФайла;
		МенеджерЗаписи.УчетнаяЗапись     = НастройкаДляУдаления.УчетнаяЗапись;
		МенеджерЗаписи.ЭтоФайл           = НастройкаДляУдаления.ЭтоФайл;
		МенеджерЗаписи.Прочитать();
		МенеджерЗаписи.Удалить();
		
		РодительЭлементаНастроек = НастройкаДляУдаления.ПолучитьРодителя();
		Если РодительЭлементаНастроек <> Неопределено Тогда
			// Родительскую настройку удалять из дерева не нужно, достаточно очистить настраиваемые поля.
			НастройкаДляУдаления.ПодПапкаОблачногоСервиса = "";
			НастройкаДляУдаления.ПравилоОтбора            = "";
			НастройкаДляУдаления.Синхронизировать         = Ложь;
			НастройкаДляУдаления.УчетнаяЗапись            = Неопределено;
			Если Не НастройкаДляУдаления.ВозможностьДетализации Тогда
				РодительЭлементаНастроек.ПолучитьЭлементы().Удалить(НастройкаДляУдаления);
			КонецЕсли;
		Иначе
			ДеревоОбъектовМетаданных.ПолучитьЭлементы().Удалить(НастройкаДляУдаления);
		КонецЕсли;
	КонецЕсли;

КонецПроцедуры
#КонецОбласти