﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступом.ЗаполнитьНаборыЗначенийДоступа.
Процедура ЗаполнитьНаборыЗначенийДоступа(Таблица) Экспорт
	
	БизнесПроцессыИЗадачиПереопределяемый.ПриЗаполненииНаборовЗначенийДоступа(ЭтотОбъект, Таблица);
	
	Если Таблица.Количество() > 0 Тогда
		Возврат;
	КонецЕсли;
	
	ЗаполнитьНаборыЗначенийДоступаПоУмолчанию(Таблица);
	
КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти

Процедура ПередЗаписью(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
		
	БизнесПроцессыИЗадачиСервер.ПроверитьПраваНаИзменениеСостоянияБизнесПроцесса(ЭтотОбъект);
	
	Если ЗначениеЗаполнено(ГлавнаяЗадача) 
		И ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ГлавнаяЗадача, "БизнесПроцесс") = ЭтотОбъект.Ссылка Тогда
		
		ВызватьИсключение НСтр("ru = 'Собственная задача бизнес-процесса не может быть указана как главная задача.'");
		
	КонецЕсли;
	
	УстановитьПривилегированныйРежим(Истина);
	ГруппаИсполнителейЗадач = ?(ТипЗнч(Исполнитель) = Тип("СправочникСсылка.РолиИсполнителей"), 
		БизнесПроцессыИЗадачиСервер.ГруппаИсполнителейЗадач(Исполнитель, ОсновнойОбъектАдресации, ДополнительныйОбъектАдресации), 
		Исполнитель);
	ГруппаИсполнителейЗадачПроверяющий = ?(ТипЗнч(Проверяющий) = Тип("СправочникСсылка.РолиИсполнителей"), 
		БизнесПроцессыИЗадачиСервер.ГруппаИсполнителейЗадач(Проверяющий, ОсновнойОбъектАдресации, ПланыВидовХарактеристик.ОбъектыАдресацииЗадач.ПустаяСсылка()), 
		Проверяющий);
	УстановитьПривилегированныйРежим(Ложь);
	
КонецПроцедуры

Процедура ПриЗаписи(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Если НЕ ЭтоНовый() И ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Ссылка, "Предмет") <> Предмет Тогда
		ИзменитьПредметЗадач();	
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка)
	
	Если ЭтоНовый() Тогда
		Автор = Пользователи.АвторизованныйПользователь();
		Важность = Перечисления.ВариантыВажностиЗадачи.Обычная;
		Проверяющий = Пользователи.АвторизованныйПользователь();
		Состояние = Перечисления.СостоянияБизнесПроцессов.Активен;
		Если ТипЗнч(ДанныеЗаполнения) = Тип("СправочникСсылка.Пользователи") Тогда
			Исполнитель = ДанныеЗаполнения;
		Иначе
			// Для возможности автоподбора в незаполненном поле Исполнитель.
			Исполнитель = Справочники.Пользователи.ПустаяСсылка();
		КонецЕсли;
	КонецЕсли;
	
	Если ДанныеЗаполнения <> Неопределено И ТипЗнч(ДанныеЗаполнения) <> Тип("Структура") 
		И ДанныеЗаполнения <> Задачи.ЗадачаИсполнителя.ПустаяСсылка() Тогда
		
		Если ТипЗнч(ДанныеЗаполнения) <> Тип("ЗадачаСсылка.ЗадачаИсполнителя") Тогда
			Предмет = ДанныеЗаполнения;
		Иначе
			Предмет = ДанныеЗаполнения.Предмет;
		КонецЕсли;
		
	КонецЕсли;	
	
	БизнесПроцессыИЗадачиСервер.ЗаполнитьГлавнуюЗадачу(ЭтотОбъект, ДанныеЗаполнения);

КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	МассивНепроверяемыхРеквизитов = Новый Массив();
	ОбщегоНазначения.УдалитьНепроверяемыеРеквизитыИзМассива(ПроверяемыеРеквизиты, МассивНепроверяемыхРеквизитов);
КонецПроцедуры

Процедура ПриКопировании(ОбъектКопирования)
	
	НомерИтерации = 0;
	Выполнено = Ложь;
	Подтверждено = Ложь;
	РезультатВыполнения = "";
	ДатаЗавершения = '00010101000000';
	Состояние = Перечисления.СостоянияБизнесПроцессов.Активен;
	
КонецПроцедуры


////////////////////////////////////////////////////////////////////////////////
// Обработчики событий элементов карты маршрута.

Процедура ВыполнитьПриСозданииЗадач(ТочкаМаршрутаБизнесПроцесса, ФормируемыеЗадачи, Отказ)
	
	//НомерИтерации = НомерИтерации + 1;
	Если ТочкаМаршрутаБизнесПроцесса = БизнесПроцессы.СогласованиеЗаявкиНаСделку.ТочкиМаршрута.СогласованиеЮристом
			И Исполнитель = Справочники.РолиИсполнителей.ИпотечныеСпециалисты Тогда 
		Исполнитель = Справочники.РолиИсполнителей.Юристы;
		
		//<729503>, Басаргин (02.11.2017) {
		CRMРаботаСЗаданиямиСервер.СформироватьЗаписиПоСтатусуСделки(Предмет, ТекущаяДата(), "СогласованиеЮриста");
		//<729503> }
				
		Записать();
	КонецЕсли;
	
	// Устанавливаем реквизиты адресации и доп. реквизиты для каждой задачи.
	Для каждого Задача Из ФормируемыеЗадачи Цикл
		
		Задача.Автор = Автор;
		Задача.АвторСтрокой = Строка(Автор);
		Если ТипЗнч(Исполнитель) = Тип("СправочникСсылка.РолиИсполнителей") Тогда
			Задача.РольИсполнителя 			= Исполнитель;
			Задача.ОсновнойОбъектАдресации 	= ОсновнойОбъектАдресации;
			Задача.Исполнитель 				= Неопределено;
		Иначе	
			Задача.Исполнитель 				= Исполнитель;
		КонецЕсли;
		Задача.Наименование 	= НаименованиеЗадачиДляВыполнения(ТочкаМаршрутаБизнесПроцесса);
		Задача.СрокИсполнения 	= СрокИсполненияЗадачиДляВыполнения();
		Задача.Важность 		= Важность;
		Задача.Предмет 			= Предмет;
		
	КонецЦикла;
	
КонецПроцедуры

Процедура ВыполнитьПередСозданиемЗадач(ТочкаМаршрутаБизнесПроцесса, ФормируемыеЗадачи, СтандартнаяОбработка)
	
	Если Предмет = Неопределено Или Предмет.Пустая() Тогда
		Возврат;
	КонецЕсли;
	
КонецПроцедуры

Процедура ВыполнитьПриВыполнении(ТочкаМаршрутаБизнесПроцесса, Задача, Отказ)
	
	РезультатВыполнения = РезультатВыполненияТочкиВыполнить(Задача) + РезультатВыполнения;
	Записать();
	
КонецПроцедуры

Процедура ПроверитьПриСозданииЗадач(ТочкаМаршрутаБизнесПроцесса, ФормируемыеЗадачи, Отказ)
	
	Если Проверяющий.Пустая() Тогда
		Отказ = Истина;
		Возврат;
	КонецЕсли;
	
	// Устанавливаем реквизиты адресации и доп. реквизиты для каждой задачи.
	Для каждого Задача Из ФормируемыеЗадачи Цикл
		
		Задача.Автор = Автор;
		Если ТипЗнч(Проверяющий) = Тип("СправочникСсылка.РолиИсполнителей") Тогда
			Задача.РольИсполнителя = Проверяющий;
			Задача.ОсновнойОбъектАдресации = ОсновнойОбъектАдресации;
		Иначе	
			Задача.Исполнитель = Проверяющий;
		КонецЕсли;
		
		Задача.Наименование = НаименованиеЗадачиДляПроверки();
		//Задача.СрокИсполнения = СрокИсполненияЗадачиДляПроверки();
		Задача.Важность = Важность;
		Задача.Предмет = Предмет;
		
	КонецЦикла;
	
КонецПроцедуры

#Область СлужебныеПроцедурыИФункции

// Актуализирует значения реквизит невыполненных задач 
// согласно реквизитам бизнес-процесса Задание:
//   Важность, СрокИсполнения, Наименование и Автор.
//
Процедура ИзменитьРеквизитыНевыполненныхЗадач() Экспорт

	НачатьТранзакцию();
	Попытка
		Блокировка = Новый БлокировкаДанных;
		ЭлементБлокировки = Блокировка.Добавить("Задача.ЗадачаИсполнителя");
		ЭлементБлокировки.УстановитьЗначение("БизнесПроцесс", Ссылка);
		Блокировка.Заблокировать();
		
		Запрос = Новый Запрос( 
			"ВЫБРАТЬ
			|	Задачи.Ссылка КАК Ссылка
			|ИЗ
			|	Задача.ЗадачаИсполнителя КАК Задачи
			|ГДЕ
			|	Задачи.БизнесПроцесс = &БизнесПроцесс
			|	И Задачи.ПометкаУдаления = ЛОЖЬ
			|	И Задачи.Выполнена = ЛОЖЬ");
		Запрос.УстановитьПараметр("БизнесПроцесс", Ссылка);
		ВыборкаДетальныеЗаписи = Запрос.Выполнить().Выбрать();
		
		Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
			ЗадачаОбъект = ВыборкаДетальныеЗаписи.Ссылка.ПолучитьОбъект();
			ЗадачаОбъект.Важность = Важность;
			ЗадачаОбъект.Автор = Автор;
			// Не выполняем предварительную блокировку данных для редактирования, т.к.
			// Это изменение имеет более высокий приоритет над открытыми формами задач.
			ЗадачаОбъект.Записать();
		КонецЦикла;
		
		ЗафиксироватьТранзакцию();
	Исключение
		ОтменитьТранзакцию();
		ВызватьИсключение;
	КонецПопытки;

КонецПроцедуры 

Процедура ИзменитьПредметЗадач()

	УстановитьПривилегированныйРежим(Истина);
	НачатьТранзакцию();
	Попытка
		Блокировка = Новый БлокировкаДанных;
		ЭлементБлокировки = Блокировка.Добавить("Задача.ЗадачаИсполнителя");
		ЭлементБлокировки.УстановитьЗначение("БизнесПроцесс", Ссылка);
		Блокировка.Заблокировать();
		
		Запрос = Новый Запрос(
			"ВЫБРАТЬ
			|	Задачи.Ссылка КАК Ссылка
			|ИЗ
			|	Задача.ЗадачаИсполнителя КАК Задачи
			|ГДЕ
			|	Задачи.БизнесПроцесс = &БизнесПроцесс");

		Запрос.УстановитьПараметр("БизнесПроцесс", Ссылка);
		ВыборкаДетальныеЗаписи = Запрос.Выполнить().Выбрать();
		
		Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
			ЗадачаОбъект = ВыборкаДетальныеЗаписи.Ссылка.ПолучитьОбъект();
			ЗадачаОбъект.Предмет = Предмет;
			// Не выполняем предварительную блокировку данных для редактирования, т.к.
			// Это изменение имеет более высокий приоритет над открытыми формами задач.
			ЗадачаОбъект.Записать();
		КонецЦикла;
		ЗафиксироватьТранзакцию();
	Исключение
		ОтменитьТранзакцию();
		ВызватьИсключение;
	КонецПопытки;

КонецПроцедуры 

Функция НаименованиеЗадачиДляВыполнения(ТочкаМаршрутаБизнесПроцесса)
	
	Возврат "Согласование """ + Предмет + """" + ТочкаМаршрутаБизнесПроцесса.НаименованиеЗадачи + """" + ОсновнойОбъектАдресации + """";	
	
КонецФункции

Функция СрокИсполненияЗадачиДляВыполнения()
	
	Возврат СрокИсполнения;	
	
КонецФункции

Функция НаименованиеЗадачиДляПроверки()
	
	Возврат БизнесПроцессы.Задание.ТочкиМаршрута.Проверить.НаименованиеЗадачи + ": " + Наименование;
	
КонецФункции

Функция РезультатВыполненияТочкиВыполнить(Знач ЗадачаСсылка)
	
	СтрокаФормат = ?(Выполнено,
		"%1, %2 " + НСтр("ru = 'выполнил(а) задачу'") + ":
		           |%3
		           |",
		"%1, %2 " + НСтр("ru = 'отклонил(а) задачу'") + ":
		           |%3
		           |");
	ЗадачаДанные = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(ЗадачаСсылка, 
		"РезультатВыполнения,ДатаИсполнения,Исполнитель");
	Комментарий = СокрЛП(ЗадачаДанные.РезультатВыполнения);
	Комментарий = ?(ПустаяСтрока(Комментарий), "", Комментарий + Символы.ПС);
	Результат = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(СтрокаФормат, ЗадачаДанные.ДатаИсполнения, ЗадачаДанные.Исполнитель, Комментарий);
	Возврат Результат;
	
КонецФункции

Процедура ЗаполнитьНаборыЗначенийДоступаПоУмолчанию(Таблица)
	
	// Логика ограничения по умолчанию для
	// - чтения:    Автор ИЛИ Исполнитель (с учетом адресации) ИЛИ Проверяющий (с учетом адресации)
	// - изменения: Автор.
	
	// Если предмет не задан (т.е. бизнес-процесс без основания), тогда предмет не участвует в логике ограничения.
	
	// Чтение, Изменение: набор № 1.
	Строка = Таблица.Добавить();
	Строка.НомерНабора     = 1;
	Строка.Чтение          = Истина;
	Строка.Изменение       = Истина;
	Строка.ЗначениеДоступа = ЭтотОбъект.Автор;
	
	// Чтение: набор № 2.
	Строка = Таблица.Добавить();
	Строка.НомерНабора     = 2;
	Строка.Чтение          = Истина;
	Строка.Изменение       = Истина;
	Строка.ЗначениеДоступа = ЭтотОбъект.ГруппаИсполнителейЗадач;
	
	// Чтение: набор № 3.
	//Строка = Таблица.Добавить();
	//Строка.НомерНабора     = 3;
	//Строка.Чтение          = Истина;
	//Строка.ЗначениеДоступа = ЭтотОбъект.ГруппаИсполнителейЗадачПроверяющий;
	
КонецПроцедуры

Процедура ВыполненоСогласованиеИСПроверкаУсловия(ТочкаМаршрутаБизнесПроцесса, Результат)
	
	Результат = ЭтотОбъект.Выполнено;
		
КонецПроцедуры

Процедура ВернутьСтатусОформлениеОбработка(ТочкаМаршрутаБизнесПроцесса)
	
	CRMРаботаСЗаданиямиСервер.СформироватьЗаписиПоСтатусуСделки(Предмет, ТекущаяДата(), "Оформление");
	
КонецПроцедуры

Процедура ОбработатьСтатусСделкиОбработка(ТочкаМаршрутаБизнесПроцесса)
	
	Если НЕ ЭтотОбъект.Выполнено Тогда
		CRMРаботаСЗаданиямиСервер.СформироватьЗаписиПоСтатусуСделки(Предмет, ТекущаяДата(), "Оформление");
	Иначе	
		CRMРаботаСЗаданиямиСервер.СформироватьЗаписиПоСтатусуСделки(Предмет, ТекущаяДата(), "СогласованиеУПН");	
	КонецЕсли;	
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли