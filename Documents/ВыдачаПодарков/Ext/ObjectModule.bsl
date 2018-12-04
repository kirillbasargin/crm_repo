﻿
Процедура ОбработкаЗаполнения(ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка)
	Если ТипЗнч(ДанныеЗаполнения) = Тип("Структура")
			И ДанныеЗаполнения.Свойство("ДокументОснование")  
			И ТипЗнч(ДанныеЗаполнения.ДокументОснование) = Тип("ДокументСсылка.Запрос") Тогда
		ДокументОснование 	= ДанныеЗаполнения.ДокументОснование;
		Проект 				= ДанныеЗаполнения.ДокументОснование.Проект;
		Клиент				= ДанныеЗаполнения.ДокументОснование.Клиент;
	КонецЕсли;		
КонецПроцедуры

Процедура ПриКопировании(ОбъектКопирования)
	
	Ответственный    = Пользователи.ТекущийПользователь();
	Автор            = Пользователи.ТекущийПользователь();

КонецПроцедуры

Процедура ОбработкаПроведения(Отказ, РежимПроведения)	
	
	Движения.ВыдачаПодарков.Записывать = Истина;
	Движения.ВыдачаПодарков.Очистить();
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ВыдачаПодарковПодарки.Подарок,
		|	СУММА(ВыдачаПодарковПодарки.Количество) КАК Количество,
		|	ВыдачаПодарковПодарки.Причина,
		|	ВЫРАЗИТЬ(ВыдачаПодарковПодарки.Комментарий КАК СТРОКА(500)) КАК Комментарий,
		|	ЗНАЧЕНИЕ(Справочник.Номенклатура.ПустаяСсылка) КАК Комплект,
		|	ВыдачаПодарковПодарки.Сделка,
		|	ВыдачаПодарковПодарки.ТипДокумента,
		|	ВыдачаПодарковПодарки.НомерСертификата
		|ПОМЕСТИТЬ вт_СписокПодарковБезКомплекта
		|ИЗ
		|	Документ.ВыдачаПодарков.Подарки КАК ВыдачаПодарковПодарки
		|ГДЕ
		|	ВыдачаПодарковПодарки.Ссылка = &Ссылка
		|	И НЕ ВыдачаПодарковПодарки.Подарок.Комплект
		|
		|СГРУППИРОВАТЬ ПО
		|	ВЫРАЗИТЬ(ВыдачаПодарковПодарки.Комментарий КАК СТРОКА(500)),
		|	ВыдачаПодарковПодарки.Причина,
		|	ВыдачаПодарковПодарки.Подарок,
		|	ВыдачаПодарковПодарки.Сделка,
		|	ВыдачаПодарковПодарки.ТипДокумента,
		|	ВыдачаПодарковПодарки.НомерСертификата
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	НоменклатураКомплектующие.Номенклатура,
		|	ВыдачаПодарковПодарки.Причина,
		|	ВыдачаПодарковПодарки.Количество * НоменклатураКомплектующие.Количество КАК Количество,
		|	ВЫРАЗИТЬ(ВыдачаПодарковПодарки.Комментарий КАК СТРОКА(500)) КАК Комментарий,
		|	ВыдачаПодарковПодарки.Подарок КАК Комплект,
		|	ВыдачаПодарковПодарки.Сделка,
		|	ВыдачаПодарковПодарки.ТипДокумента,
		|	ВыдачаПодарковПодарки.НомерСертификата
		|ПОМЕСТИТЬ вт_СписокПодарковИзКомплекта
		|ИЗ
		|	Документ.ВыдачаПодарков.Подарки КАК ВыдачаПодарковПодарки
		|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.Номенклатура.Комплектующие КАК НоменклатураКомплектующие
		|		ПО ВыдачаПодарковПодарки.Подарок = НоменклатураКомплектующие.Ссылка
		|ГДЕ
		|	ВыдачаПодарковПодарки.Ссылка = &Ссылка
		|	И (ВыдачаПодарковПодарки.Подарок.Комплект
		|			ИЛИ ВыдачаПодарковПодарки.Подарок = ЗНАЧЕНИЕ(Справочник.Номенклатура.ПустаяСсылка))
		|	И ВыдачаПодарковПодарки.Количество * НоменклатураКомплектующие.Количество <> 0
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	вт_СписокПодарковБезКомплекта.Подарок,
		|	вт_СписокПодарковБезКомплекта.Количество,
		|	вт_СписокПодарковБезКомплекта.Причина,
		|	вт_СписокПодарковБезКомплекта.Комментарий,
		|	вт_СписокПодарковБезКомплекта.Комплект,
		|	вт_СписокПодарковБезКомплекта.Сделка,
		|	вт_СписокПодарковБезКомплекта.ТипДокумента,
		|	вт_СписокПодарковБезКомплекта.НомерСертификата
		|ПОМЕСТИТЬ вт_НеСгруппированныйРезультат
		|ИЗ
		|	вт_СписокПодарковБезКомплекта КАК вт_СписокПодарковБезКомплекта
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	вт_СписокПодарковИзКомплекта.Номенклатура,
		|	вт_СписокПодарковИзКомплекта.Количество,
		|	вт_СписокПодарковИзКомплекта.Причина,
		|	вт_СписокПодарковИзКомплекта.Комментарий,
		|	вт_СписокПодарковИзКомплекта.Комплект,
		|	вт_СписокПодарковИзКомплекта.Сделка,
		|	вт_СписокПодарковИзКомплекта.ТипДокумента,
		|	вт_СписокПодарковИзКомплекта.НомерСертификата
		|ИЗ
		|	вт_СписокПодарковИзКомплекта КАК вт_СписокПодарковИзКомплекта
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	вт_НеСгруппированныйРезультат.Подарок,
		|	СУММА(вт_НеСгруппированныйРезультат.Количество) КАК Количество,
		|	вт_НеСгруппированныйРезультат.Причина,
		|	вт_НеСгруппированныйРезультат.Комментарий,
		|	вт_НеСгруппированныйРезультат.Комплект,
		|	вт_НеСгруппированныйРезультат.Сделка,
		|	вт_НеСгруппированныйРезультат.ТипДокумента,
		|	вт_НеСгруппированныйРезультат.НомерСертификата
		|ИЗ
		|	вт_НеСгруппированныйРезультат КАК вт_НеСгруппированныйРезультат
		|
		|СГРУППИРОВАТЬ ПО
		|	вт_НеСгруппированныйРезультат.Подарок,
		|	вт_НеСгруппированныйРезультат.Причина,
		|	вт_НеСгруппированныйРезультат.Комментарий,
		|	вт_НеСгруппированныйРезультат.Комплект,
		|	вт_НеСгруппированныйРезультат.Сделка,
		|	вт_НеСгруппированныйРезультат.ТипДокумента,
		|	вт_НеСгруппированныйРезультат.НомерСертификата";
	
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Если НЕ РезультатЗапроса.Пустой() Тогда
		
		Выборка = РезультатЗапроса.Выбрать();
		
		Пока Выборка.Следующий() Цикл
			
			ДвижениеПодарок = Движения.ВыдачаПодарков.Добавить();
			
			ДвижениеПодарок.Ответственный = Ответственный;
			ДвижениеПодарок.Период 		  = Дата;
			ДвижениеПодарок.Клиент 		  = Клиент;
			ДвижениеПодарок.Проект 		  = Проект;
			ДвижениеПодарок.Склад 		  = Склад;	
			
			ЗаполнитьЗначенияСвойств(ДвижениеПодарок, Выборка);
			
			// очищаем номер от маски 
			// NN NN №NNNN (3,6,7)
			ВыборкаНомерСертификата = Выборка.НомерСертификата;
			НомерСертификата = "";
			Для i = 1 По СтрДлина(ВыборкаНомерСертификата) Цикл
				Если i = 3 ИЛИ i = 6 ИЛИ i = 7 Тогда
					Продолжить;
				КонецЕсли;
				НомерСертификата = НомерСертификата + Сред(ВыборкаНомерСертификата,i,1);
			КонецЦикла;
			
			ДвижениеПодарок.НомерСертификата = НомерСертификата;
		КонецЦикла;  
	КонецЕсли; 
	
КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	// Обходим строки и проверяем заполнение реквизита
	Для Индекс = 0 по Подарки.Количество()-1 Цикл
		СтрокаПодарки = Подарки.Получить(Индекс);
		ЕстьСделка = ЗначениеЗаполнено(СтрокаПодарки.Причина) И СтрокаПодарки.Причина.Сделка;
		Если ЕстьСделка И Не ЗначениеЗаполнено(СтрокаПодарки.ТипДокумента) Тогда
			
			Сообщение = Новый СообщениеПользователю();
			Сообщение.Текст = "В строке " + Строка(Индекс + 1) + " не указан тип документа!";
			Сообщение.Поле = "Подарки[" + Строка(Индекс + 1) + "].ТипДокумента";
			Сообщение.УстановитьДанные(ЭтотОбъект);
			Сообщение.Сообщить();
			Отказ = Истина;
			
		КонецЕсли;
		
		Если ЕстьСделка	И Не ЗначениеЗаполнено(СтрокаПодарки.Сделка) Тогда
			
			Сообщение = Новый СообщениеПользователю();
			Сообщение.Текст = "В строке " + Строка(Индекс + 1) + " не указана сделка!";
			Сообщение.Поле = "Подарки[" + Строка(Индекс + 1) + "].Сделка";
			Сообщение.УстановитьДанные(ЭтотОбъект);
			Сообщение.Сообщить();
			Отказ = Истина;
			
		КонецЕсли;

	КонецЦикла;
	
КонецПроцедуры

Процедура ПроверкаПериодаДокумента(Отказ, РежимЗаписи = Неопределено)
	
	//СоответствиеГраницЗапрета = Константы.ДатаЗапретаРедактированияДокументовВыдачиПодарков.Получить();
	//
	//Если НЕ ЗначениеЗаполнено(СоответствиеГраницЗапрета) Тогда
	//	Возврат;
	//КонецЕсли;
	//
	//ПараметрыПроверкиДокумента = ПолучитьПараметрыПроверкиДокумента(ЭтотОбъект);
	//
	//Если Не ЭтоНовый() Тогда
	//	СтараяВерсияДокумента = ПолучитьВерсиюДокументаПередИзменением(ЭтотОбъект, ПараметрыПроверкиДокумента);
	//	ПроверитьВерсиюДокумента(СтараяВерсияДокумента, ПараметрыПроверкиДокумента, СоответствиеГраницЗапрета, Отказ);
	//КонецЕсли;
	//		
	//Если Не Отказ Тогда
	//	ПроверитьВерсиюДокумента(ЭтотОбъект, ПараметрыПроверкиДокумента, СоответствиеГраницЗапрета, Отказ, РежимЗаписи);
	//КонецЕсли;
	
КонецПроцедуры 

Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	//ПроверкаПериодаДокумента(Отказ, РежимЗаписи);
	ГруппировкаСтрок(Отказ);
КонецПроцедуры

// Функция возвращает структуру с параметрами проверки документа по умолчанию
//
Функция ПолучитьПараметрыПроверкиДокумента(ДокументОбъект)
	
	ПараметрыПроверкиДокумента = Новый Структура;
	МетаданныеДокумента = ДокументОбъект.Метаданные();
	
	ПараметрыПроверкиДокумента.Вставить("МетаданныеДокумента", МетаданныеДокумента);
	// Если для документа проведение запрещено, проверка на дату запрета редактирования
	//проверяется без учета проведенности
	ПараметрыПроверкиДокумента.Вставить("ПроверятьПроведениеДокумента", (МетаданныеДокумента.Проведение = Метаданные.СвойстваОбъектов.Проведение.Разрешить));
		
	Возврат ПараметрыПроверкиДокумента;
	
КонецФункции 

// Функция возвращает из БД версию документа до его изменения
//
Функция ПолучитьВерсиюДокументаПередИзменением(ДокументОбъект, ПараметрыПроверкиДокумента)
	
	Запрос = Новый Запрос;
	Запрос.Текст = "
	|ВЫБРАТЬ 
	|Дата" 
	+ ?(ПараметрыПроверкиДокумента.ПроверятьПроведениеДокумента, "," + Символы.ПС + "Проведен КАК Проведен", "") + "	
	|ИЗ Документ." + ПараметрыПроверкиДокумента.МетаданныеДокумента.Имя + "
	|ГДЕ Ссылка = &Ссылка";
	Запрос.УстановитьПараметр("Ссылка", ДокументОбъект.Ссылка);
	Выборка = Запрос.Выполнить().Выбрать();
	Выборка.Следующий();
	Возврат Выборка;
	
КонецФункции   

// Процедура проверки версии документа на нарушение даты запрета
//
Процедура ПроверитьВерсиюДокумента(ДокументОбъект, ПараметрыПроверкиДокумента, СоответствиеГраницЗапрета, Отказ, РежимЗаписи = Неопределено)
		
	Если ПараметрыПроверкиДокумента.ПроверятьПроведениеДокумента Тогда		
		ДокументПроведен = ДокументОбъект.Проведен ИЛИ ?(РежимЗаписи = Неопределено, ЛОЖЬ, РежимЗаписи = РежимЗаписиДокумента.Проведение);
		Если  ДокументПроведен И ЗначениеЗаполнено(СоответствиеГраницЗапрета) И СоответствиеГраницЗапрета>= НачалоДня(ДокументОбъект.Дата) Тогда        
			Отказ = Истина;	
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю("Дата запрета редактирования (" + Формат(СоответствиеГраницЗапрета,"ДФ=dd.MM.yyyy") + ") распространяется на этот документ!");
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

Процедура ГруппировкаСтрок(Отказ)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ВыдачаПодарковПодарки.Подарок,
		|	ВыдачаПодарковПодарки.Причина,
		|	ВыдачаПодарковПодарки.Сделка,
		|	ВыдачаПодарковПодарки.ТипДокумента,
		|	ВЫРАЗИТЬ(ВыдачаПодарковПодарки.Комментарий КАК СТРОКА(300)) КАК Комментарий,
		|	ВыдачаПодарковПодарки.НомерСтроки,
		|	ВыдачаПодарковПодарки.Количество,
		|	ВыдачаПодарковПодарки.НомерСертификата
		|ПОМЕСТИТЬ вр1
		|ИЗ
		|	&ТЗ КАК ВыдачаПодарковПодарки
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	вр1.Подарок,
		|	СУММА(вр1.Количество) КАК Количество,
		|	КОЛИЧЕСТВО(РАЗЛИЧНЫЕ вр1.НомерСтроки) КАК НомерСтроки
		|ИЗ
		|	вр1 КАК вр1
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ вр1 КАК вр11
		|		ПО вр1.Подарок = вр11.Подарок
		|			И вр1.Причина = вр11.Причина
		|			И вр1.Сделка = вр11.Сделка
		|			И вр1.ТипДокумента = вр11.ТипДокумента
		|			И вр1.Комментарий = вр11.Комментарий
		|			И вр1.НомерСертификата = вр11.НомерСертификата
		|
		|СГРУППИРОВАТЬ ПО
		|	вр1.Подарок,
		|	вр1.Комментарий,
		|	вр1.Причина,
		|	вр1.Сделка,
		|	вр1.ТипДокумента,
		|	вр1.НомерСертификата
		|
		|ИМЕЮЩИЕ
		|	КОЛИЧЕСТВО(РАЗЛИЧНЫЕ вр1.НомерСтроки) > 1
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ВыдачаПодарковПодарки.Подарок,
		|	ВыдачаПодарковПодарки.Причина,
		|	ВыдачаПодарковПодарки.Сделка,
		|	ВыдачаПодарковПодарки.ТипДокумента,
		|	ВыдачаПодарковПодарки.НомерСтроки,
		|	ВыдачаПодарковПодарки.Количество
		|ПОМЕСТИТЬ вр2
		|ИЗ
		|	&ТЗ КАК ВыдачаПодарковПодарки
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	вр2.Подарок,
		|	СУММА(вр2.Количество) КАК Количество,
		|	КОЛИЧЕСТВО(РАЗЛИЧНЫЕ вр2.НомерСтроки) КАК НомерСтроки
		|ИЗ
		|	вр2 КАК вр2
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ вр2 КАК вр12
		|		ПО вр2.Подарок = вр12.Подарок
		|			И вр2.Причина = вр12.Причина
		|			И вр2.Сделка = вр12.Сделка
		|			И вр2.ТипДокумента = вр12.ТипДокумента
		|
		|СГРУППИРОВАТЬ ПО
		|	вр2.Подарок,
		|	вр2.Причина,
		|	вр2.Сделка,
		|	вр2.ТипДокумента
		|
		|ИМЕЮЩИЕ
		|	КОЛИЧЕСТВО(РАЗЛИЧНЫЕ вр2.НомерСтроки) > 1";

	Запрос.УстановитьПараметр("ТЗ", ЭтотОбъект.Подарки.Выгрузить());

	Результат = Запрос.ВыполнитьПакет();
	РезультатПолноеЗадвоение = Результат[1];
	РезультатКритическоеЗадвоение = Результат[3];
	ВыборкаПолное = РезультатПолноеЗадвоение.Выбрать();
	ВыборкаКритическое = РезультатКритическоеЗадвоение.Выбрать();
	
	Пока ВыборкаКритическое.Следующий() Цикл
		Отбор = Новый Структура("Подарок, НомерСтроки", ВыборкаКритическое.Подарок, ВыборкаКритическое.НомерСтроки);
		Если ВыборкаПолное.НайтиСледующий(Отбор) Тогда
			Продолжить;
			ВыборкаПолное.Сбросить();
		КонецЕсли;
		ВыборкаПолное.Сбросить();
		Сообщить("По подарку """ + ВыборкаКритическое.Подарок + """ обнаружены дубли, которые не могут быть сгруппированы (по комментарию или номеру сертификата).");
		Отказ = Истина;
	КонецЦикла;

	Если Отказ=Истина Тогда
		Возврат;
	КонецЕсли;

	
	Пока ВыборкаПолное.Следующий() Цикл
		Сообщить("Обнаружены дубли (" + ВыборкаПолное.НомерСтроки + " шт.) по подарку """ + ВыборкаПолное.Подарок  + """" 
		+ Символы.ПС + "Строки будут сгруппированы.");
	КонецЦикла;

	Подарки.Свернуть("Подарок, Причина, Комментарий, Сделка, ТипДокумента, НомерСертификата","Количество");

КонецПроцедуры