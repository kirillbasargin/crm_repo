﻿
&НаСервереБезКонтекста
Функция ВыполнитьНаСервере(МасКлиенты, НомерКлиента)
	
	//Ищем все ссылки на клиента
	ТабСсылок = НайтиПоСсылкам(МасКлиенты);
	ТабСсылок.Сортировать("Данные Убыв");
	
	Результат = Ложь;
	
	НачатьТранзакцию();
	ОбщегоНазначенияКлиентСервер.СообщитьПользователю("Начало транзации по объекту " + МасКлиенты[0]);
	
	ОписаниеТиповДокументов 	= Документы.ТипВсеСсылки();
	ОписаниеТиповСправочников 	= Справочники.ТипВсеСсылки();
	ОписаниеТиповЗадачи			= Задачи.ТипВсеСсылки();
	
	Счетчик = 0;
	
	УстановитьПривилегированныйРежим(Истина);	
	
	Для Каждого СтрокаСсылок из ТабСсылок Цикл
		
		//Удаление документов
		Если ОписаниеТиповДокументов.СодержитТип(ТипЗнч(СтрокаСсылок.Данные)) Тогда
			Попытка
				ДокОбъект = СтрокаСсылок.Данные.ПолучитьОбъект();
				Если НЕ ДокОбъект.ПометкаУдаления Тогда
					ДокОбъект.УстановитьПометкуУдаления(Истина);
				КонецЕсли;			
			Исключение
				Сообщить(ОписаниеОшибки(), СтатусСообщения.Внимание);
				ОтменитьТранзакцию();
				Прервать;
			КонецПопытки;	
		КонецЕсли;		
		
	КонецЦикла;
	
	Если ТранзакцияАктивна() Тогда
		
		Для Каждого СтрокаСсылок из ТабСсылок Цикл
			
			Представление = Строка(СтрокаСсылок.Данные);
			
			//Удаление документов
			Если ОписаниеТиповДокументов.СодержитТип(ТипЗнч(СтрокаСсылок.Данные)) Тогда
				Попытка
					ДокОбъект = СтрокаСсылок.Данные.ПолучитьОбъект();
					ДокОбъект.Удалить();
					Счетчик = Счетчик + 1;
					ОбщегоНазначенияКлиентСервер.СообщитьПользователю("Удалено: " + Представление);
				Исключение
					Сообщить(ОписаниеОшибки(), СтатусСообщения.Внимание);
					ОтменитьТранзакцию();
					Прервать;
				КонецПопытки;	
			КонецЕсли;		
			
		КонецЦикла;
		
		Для Каждого СтрокаСсылок из ТабСсылок Цикл
			
			Представление = Строка(СтрокаСсылок.Данные);
			
			//Удаление задач
			Если ОписаниеТиповЗадачи.СодержитТип(ТипЗнч(СтрокаСсылок.Данные)) Тогда
				Попытка
					СпрОбъект = СтрокаСсылок.Данные.ПолучитьОбъект();
					СпрОбъект.Удалить();
					Счетчик = Счетчик + 1;
					ОбщегоНазначенияКлиентСервер.СообщитьПользователю("Удалено: " + Представление);					
				Исключение
					Сообщить(ОписаниеОшибки(), СтатусСообщения.Внимание);
					ОтменитьТранзакцию();
				КонецПопытки;	
			КонецЕсли;					
			
			//Удаление элементов справочников
			Если ОписаниеТиповСправочников.СодержитТип(ТипЗнч(СтрокаСсылок.Данные)) Тогда
				Попытка
					СпрОбъект = СтрокаСсылок.Данные.ПолучитьОбъект();
					СпрОбъект.Удалить();
					Счетчик = Счетчик + 1;
					ОбщегоНазначенияКлиентСервер.СообщитьПользователю("Удалено: " + Представление);					
				Исключение
					Сообщить(ОписаниеОшибки(), СтатусСообщения.Внимание);
					ОтменитьТранзакцию();
				КонецПопытки;	
				
			КонецЕсли;
			
			//Удаление записей в регистрах сведений
			Если Метаданные.РегистрыСведений.Содержит(СтрокаСсылок.Метаданные) Тогда
				
				СтруктураИзмерений = Новый Структура;
				
				НаборЗаписей = РегистрыСведений[СтрокаСсылок.Метаданные.Имя].СоздатьНаборЗаписей();
				
				Для Каждого Измерение ИЗ СтрокаСсылок.Метаданные.Измерения Цикл
					НаборЗаписей.Отбор[Измерение.Имя].Установить(СтрокаСсылок.Данные[Измерение.Имя]);  //
					СтруктураИзмерений.Вставить(Измерение.Имя);
				КонецЦикла;
				//Если СтрокаТаблицы.Метаданные.ПериодичностьРегистраСведений <> Метаданные.СвойстваОбъектов.ПериодичностьРегистраСведений.Непериодический Тогда
				//	НаборЗаписей.Отбор["Период"].Установить(СтрокаТаблицы.Данные.Период);
				//КонецЕсли;
				НаборЗаписей.Прочитать();			
				НаборЗаписей.Очистить();
				НаборЗаписей.Записать();
				
				Счетчик = Счетчик + 1;
				ОбщегоНазначенияКлиентСервер.СообщитьПользователю("Удалено: " + Представление);				
				
			КонецЕсли;
			
		КонецЦикла;
		
	КонецЕсли;
	
	//Транзакцию фиксируем только если успешно удалось все элементы удалить
	Если Счетчик = ТабСсылок.Количество() Тогда
		Если ТранзакцияАктивна() Тогда
			//Удаляем самого клиента
			Попытка
				ОбъектКлиент = МасКлиенты[0].ПолучитьОбъект();	
				Если НЕ ОбъектКлиент = Неопределено Тогда
					ОбъектКлиент.Удалить();					
				КонецЕсли; 				
			Исключение
				Сообщить(ОписаниеОшибки(), СтатусСообщения.Внимание);
				ОтменитьТранзакцию();
				ОбщегоНазначенияКлиентСервер.СообщитьПользователю("В транзакции произошли ошибки, произведена отмена транзакции");
				УстановитьПривилегированныйРежим(Ложь);
				Возврат Ложь;				
			КонецПопытки;	
			ЗафиксироватьТранзакцию();
			Результат = Истина;
		КонецЕсли;
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю("Транзакция по объекту " + МасКлиенты[0] +  " успешно зафиксирована");
	Иначе
		Если ТранзакцияАктивна() Тогда
			ОтменитьТранзакцию();
			Результат = Ложь;
		КонецЕсли;		
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю("В транзакции произошли ошибки, произведена отмена транзакции");
	КонецЕсли;
	
	УстановитьПривилегированныйРежим(Ложь);
	
	Возврат Результат;
	
КонецФункции

&НаКлиенте
Процедура УдалитьСтрокиНаУдалениеВДереве(КоллекцияСтрокДереваОдногоУровня, ИмяЭлемента, МассивНаУдаление) 
	
	Для Каждого Строка Из КоллекцияСтрокДереваОдногоУровня Цикл
		Если НЕ МассивНаУдаление.Найти(Строка[ИмяЭлемента]) = Неопределено Тогда
			//Индекс = Строка.ПолучитьИдентификатор();
			КоллекцияСтрокДереваОдногоУровня.Удалить(Строка);			
		Иначе
			УдалитьСтрокиНаУдалениеВДереве(Строка.ПолучитьЭлементы(), ИмяЭлемента, МассивНаУдаление);
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьКоманду(Команда)
	
	ОчиститьСообщения();
	
	МассивКлиенты = ПодготовитьКлиентовНаУдаление();
	МассивНаУдаление = Новый Массив;
	
	МассивОбработки = Новый Массив;
	Для Каждого Стр Из МассивКлиенты Цикл
		МассивОбработки.Очистить();
		МассивОбработки.Добавить(Стр);
		Результат = ВыполнитьНаСервере(МассивОбработки, МассивКлиенты.Найти(Стр)+1);			
		Если НЕ Результат Тогда
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю("Что то пошло не так. " + Стр);
			Продолжить;
		КонецЕсли;
		
		УдалитьСтрокиНаУдалениеВДереве(ДеревоКлиентов.ПолучитьЭлементы(), "Клиент", МассивОбработки);
		
	КонецЦикла;
	
	ЭлементыДерева = ДеревоКлиентов.ПолучитьЭлементы();
	Для каждого СтрокаРодитель Из ЭлементыДерева Цикл  
		Если НЕ СтрокаРодитель.ПолучитьЭлементы().Количество() Тогда
			ЭлементыДерева.Удалить(СтрокаРодитель); //.ПолучитьИдентификатор()	
		КонецЕсли;
	КонецЦикла;
	
	МассивЗапросы = ПодготовитьЗапросыНаУдаление();
	МассивНаУдаление = Новый Массив;
	
	МассивОбработки = Новый Массив;
	Для Каждого Стр Из МассивЗапросы Цикл
		МассивОбработки.Очистить();
		МассивОбработки.Добавить(Стр);
		Результат = ВыполнитьНаСервере(МассивОбработки, МассивЗапросы.Найти(Стр)+1);			
		Если НЕ Результат Тогда
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю("Что то пошло не так. " + Стр);
			Продолжить;
		КонецЕсли;
		
		УдалитьСтрокиНаУдалениеВДереве(ДеревоКлиентов.ПолучитьЭлементы(), "Запрос", МассивОбработки);
		
	КонецЦикла;
	
	ЭлементыДерева = ДеревоКлиентов.ПолучитьЭлементы();
	Для каждого СтрокаРодитель Из ЭлементыДерева Цикл  
		Если НЕ СтрокаРодитель.ПолучитьЭлементы().Количество() Тогда
			ЭлементыДерева.Удалить(СтрокаРодитель);	
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Функция ПодготовитьКлиентовНаУдаление()	
	
	МассивКлиенты = Новый Массив;	
	Для каждого ГруппировкаКлиенту Из ДеревоКлиентов.ПолучитьЭлементы() Цикл				
		Если ГруппировкаКлиенту.УдалитьКлиента Тогда
			Если МассивКлиенты.Найти(ГруппировкаКлиенту.Клиент) = Неопределено Тогда
				МассивКлиенты.Добавить(ГруппировкаКлиенту.Клиент);
			КонецЕсли;
		КонецЕсли;				
	КонецЦикла;	
	
	Возврат МассивКлиенты;
	
КонецФункции

&НаКлиенте
Функция ПодготовитьЗапросыНаУдаление()	
	
	МассивЗапросы = Новый Массив;
	Для каждого ГруппировкаКлиенту Из ДеревоКлиентов.ПолучитьЭлементы() Цикл		
		Для каждого Стр Из ГруппировкаКлиенту.ПолучитьЭлементы() Цикл			
			Если НЕ ЗначениеЗаполнено(Стр.Запрос) Тогда		
				Продолжить;
			КонецЕсли;
			Если Стр.УдалитьЗапрос И НЕ Стр.УдалитьКлиента Тогда
				Если МассивЗапросы.Найти(Стр.Запрос) = Неопределено Тогда
					МассивЗапросы.Добавить(Стр.Запрос);
				КонецЕсли;
			КонецЕсли;
		КонецЦикла;
	КонецЦикла;	
	
	Возврат МассивЗапросы;
	
КонецФункции

&НаКлиенте
Процедура Подбор(Команда)	
	ОткрытьФорму("Справочник.Клиенты.Форма.ФормаВыбора", Новый Структура("ЗакрыватьПриВыборе, МножественныйВыбор", Ложь, Истина), Элементы.ДеревоКлиентов);	
КонецПроцедуры

&НаКлиенте
Процедура СписокЭлементовДляУдаленияОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	Если ТипЗнч(ВыбранноеЗначение) = Тип("Массив") Тогда
		Для каждого Значение Из ВыбранноеЗначение Цикл
			Если ЭтоДубль(Значение) Тогда
				Продолжить;
			КонецЕсли;			
			ЗаполнитьСвязанныеЭлементыПоКлиенту(Значение);
		КонецЦикла;
	Иначе	
		Если ЭтоДубль(ВыбранноеЗначение) Тогда
			Возврат;
		КонецЕсли;
		ЗаполнитьСвязанныеЭлементыПоКлиенту(Значение);		
	КонецЕсли;
	
	ПреобразоватьРезультатВДерево();
	
КонецПроцедуры    

&НаСервере
Процедура ПреобразоватьРезультатВДерево()
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	СписокЭлементовДляУдаления.Клиент КАК Клиент,
	|	СписокЭлементовДляУдаления.УдалитьКлиента КАК УдалитьКлиента,
	|	СписокЭлементовДляУдаления.Запрос КАК Запрос,
	|	СписокЭлементовДляУдаления.Проект КАК Проект,
	|	СписокЭлементовДляУдаления.Сделка КАК Сделка,
	|	СписокЭлементовДляУдаления.УдалитьЗапрос КАК УдалитьЗапрос
	|ПОМЕСТИТЬ ВТ_СписокЭлементовДляУдаления
	|ИЗ
	|	&ВТ КАК СписокЭлементовДляУдаления
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВТ_СписокЭлементовДляУдаления.Клиент КАК Клиент,
	|	ВТ_СписокЭлементовДляУдаления.УдалитьКлиента КАК УдалитьКлиента,
	|	ВТ_СписокЭлементовДляУдаления.Запрос КАК Запрос,
	|	ВТ_СписокЭлементовДляУдаления.Проект КАК Проект,
	|	ВТ_СписокЭлементовДляУдаления.Сделка КАК Сделка,
	|	ВТ_СписокЭлементовДляУдаления.УдалитьЗапрос КАК УдалитьЗапрос,
	|	0 КАК Уровень
	|ИЗ
	|	ВТ_СписокЭлементовДляУдаления КАК ВТ_СписокЭлементовДляУдаления
	|
	|УПОРЯДОЧИТЬ ПО
	|	Клиент
	|ИТОГИ
	|	МАКСИМУМ(1) КАК Уровень
	|ПО
	|	Клиент";
	
	Запрос.УстановитьПараметр("ВТ", Объект.СписокЭлементовДляУдаления.Выгрузить());
	
	РезультатЗапроса = Запрос.Выполнить();
	Если НЕ РезультатЗапроса.Пустой() Тогда
		дзДеревоКлиентов = РезультатЗапроса.Выгрузить(ОбходРезультатаЗапроса.ПоГруппировкам);
	Иначе
		ДеревоКлиентов.ПолучитьЭлементы().Очистить();
		Возврат;	
	КонецЕсли;		
	
	Для каждого ГруппировкаКлиенту Из дзДеревоКлиентов.Строки Цикл		
		УдалитьЗапрос = Истина;
		Для каждого Строка Из ГруппировкаКлиенту.Строки Цикл
			Если НЕ Строка.УдалитьЗапрос Тогда
				УдалитьЗапрос = Ложь;
				Прервать;
			КонецЕсли;
		КонецЦикла;
		ГруппировкаКлиенту.УдалитьЗапрос = УдалитьЗапрос;
		ГруппировкаКлиенту.УдалитьКлиента = УдалитьЗапрос;
	КонецЦикла;	
	
	ЗначениеВРеквизитФормы(дзДеревоКлиентов, "ДеревоКлиентов");
	
КонецПроцедуры

&НаКлиенте
Функция ЭтоДубль(Стр)
	
	Отбор = Новый Структура("Клиент", Стр);
	Если Объект.СписокЭлементовДляУдаления.НайтиСтроки(Отбор).Количество() > 0 Тогда
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю("" + Стр + " уже присутствует в списке клиентов!");
		Возврат Истина;
	КонецЕсли;
	
	Возврат Ложь;
	
КонецФункции

&НаСервере
Процедура ЗаполнитьСвязанныеЭлементыПоКлиенту(Клиент)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ЗапросУчастники.Ссылка КАК Ссылка,
	|	ЗапросУчастники.Ссылка.Проект КАК Проект
	|ПОМЕСТИТЬ ВТ_Запросы
	|ИЗ
	|	Документ.Запрос.Участники КАК ЗапросУчастники
	|ГДЕ
	|	НЕ ЗапросУчастники.Ссылка.ПометкаУдаления
	|	И ЗапросУчастники.Клиент = &Клиент
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	Ссылка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ЗаявкаНаСделку.Ссылка КАК Ссылка,
	|	ЗаявкаНаСделку.ДокументОснование КАК ДокументОснование
	|ПОМЕСТИТЬ ВТ_ЗаявкиНаСделку
	|ИЗ
	|	Документ.ЗаявкаНаСделку КАК ЗаявкаНаСделку
	|ГДЕ
	|	НЕ ЗаявкаНаСделку.ПометкаУдаления
	|	И ЗаявкаНаСделку.ДокументОснование В
	|			(ВЫБРАТЬ
	|				ВТ_Запросы.Ссылка КАК Ссылка
	|			ИЗ
	|				ВТ_Запросы КАК ВТ_Запросы)
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	ДокументОснование,
	|	Ссылка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	&Клиент КАК Клиент,
	|	ВТ_Запросы.Ссылка КАК Запрос,
	|	ВТ_Запросы.Проект КАК Проект,
	|	ЕСТЬNULL(Сделки.Ссылка, ЗНАЧЕНИЕ(Справочник.Сделки.ПустаяСсылка)) КАК Сделка
	|ИЗ
	|	ВТ_Запросы КАК ВТ_Запросы
	|		ЛЕВОЕ СОЕДИНЕНИЕ ВТ_ЗаявкиНаСделку КАК ВТ_ЗаявкиНаСделку
	|			ЛЕВОЕ СОЕДИНЕНИЕ Справочник.Сделки КАК Сделки
	|			ПО ВТ_ЗаявкиНаСделку.Ссылка = Сделки.ЗаявкаНаСделку
	|				И (НЕ Сделки.СтатусСделки = ЗНАЧЕНИЕ(Перечисление.СтатусыСделокСправочник.Расторгнута))
	|		ПО ВТ_Запросы.Ссылка = ВТ_ЗаявкиНаСделку.ДокументОснование";
	
	Запрос.УстановитьПараметр("Клиент", Клиент);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Если НЕ РезультатЗапроса.Пустой() Тогда		
		ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
		Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
			НовОбъект = Объект.СписокЭлементовДляУдаления.Добавить();
			ЗаполнитьЗначенияСвойств(НовОбъект, ВыборкаДетальныеЗаписи);
			НовОбъект.УдалитьЗапрос = НЕ ЗначениеЗаполнено(НовОбъект.Сделка);
		КонецЦикла;
		
		Если Объект.СписокЭлементовДляУдаления.Количество() Тогда
			Для каждого Строка Из Объект.СписокЭлементовДляУдаления Цикл
				НайденныеСтроки = Объект.СписокЭлементовДляУдаления.НайтиСтроки(Новый Структура("Клиент", Строка.Клиент));
				УдалитьКлиента = Истина;
				Для каждого НайденнаяСтрока Из НайденныеСтроки Цикл
					Если НЕ НайденнаяСтрока.УдалитьЗапрос Тогда	
						УдалитьКлиента = Ложь;
						Прервать;
					КонецЕсли;
				КонецЦикла;
				Строка.УдалитьКлиента = УдалитьКлиента;				
			КонецЦикла;
		КонецЕсли;
	Иначе
		НовОбъект = Объект.СписокЭлементовДляУдаления.Добавить();
	    НовОбъект.Клиент = Клиент;
	КонецЕсли;	
	
КонецПроцедуры

&НаКлиенте
Процедура СписокЭлементовДляУдаленияПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа, Параметр)
	Отказ = Истина;
КонецПроцедуры

&НаКлиенте
Процедура СписокЭлементовДляУдаленияУдалитьКлиентаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.СписокЭлементовДляУдаления.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;	
	КонецЕсли;
	
	УдалитьКлиента = ТекущиеДанные.УдалитьКлиента;
	Клиент = ТекущиеДанные.Клиент;
	
	Если УдалитьКлиента Тогда	
		Если Объект.СписокЭлементовДляУдаления.Количество() Тогда
			
			НайденныеСтроки = Объект.СписокЭлементовДляУдаления.НайтиСтроки(Новый Структура("Клиент", Клиент));			
			Для каждого НайденнаяСтрока Из НайденныеСтроки Цикл
				Если НЕ НайденнаяСтрока.УдалитьЗапрос Тогда	
					УдалитьКлиента = Ложь;
					Прервать;
				КонецЕсли;
			КонецЦикла;
			Для каждого НайденнаяСтрока Из НайденныеСтроки Цикл
				НайденнаяСтрока.УдалитьКлиента = УдалитьКлиента;	
			КонецЦикла;
			
		КонецЕсли;
	Иначе
		НайденныеСтроки = Объект.СписокЭлементовДляУдаления.НайтиСтроки(Новый Структура("Клиент", Клиент));			
		Для каждого НайденнаяСтрока Из НайденныеСтроки Цикл
			НайденнаяСтрока.УдалитьКлиента = УдалитьКлиента;
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СписокЭлементовДляУдаленияУдалитьЗапросПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.СписокЭлементовДляУдаления.ТекущиеДанные;
	Если НЕ ТекущиеДанные = Неопределено Тогда
		Если ЗначениеЗаполнено(ТекущиеДанные.Сделка) Тогда	
			ТекущиеДанные.УдалитьЗапрос = Ложь;		
		КонецЕсли;
	КонецЕсли;	
	
КонецПроцедуры

&НаКлиенте
Процедура ДеревоКлиентовУдалитьКлиентаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.ДеревоКлиентов.ТекущиеДанные;
	Если ТекущиеДанные <> Неопределено
		И ТекущиеДанные.Уровень = 1 Тогда
		
		СтрокиВГруппировке = ТекущиеДанные.ПолучитьЭлементы(); 
		
		Результат = Истина;
		
		УдалитьКлиента = ТекущиеДанные.УдалитьКлиента;
		Для каждого СтрокаДерева Из СтрокиВГруппировке Цикл
			Если УдалитьКлиента Тогда
				СтрокаДерева.УдалитьКлиента = СтрокаДерева.УдалитьЗапрос;	
			Иначе
				СтрокаДерева.УдалитьКлиента	= Ложь;
			КонецЕсли;
			Если НЕ СтрокаДерева.УдалитьКлиента И Результат Тогда
				Результат = Ложь;	
			КонецЕсли;
		КонецЦикла;
		
		Если НЕ Результат Тогда
			ТекущиеДанные.УдалитьКлиента = Ложь;
		КонецЕсли;		
		
	ИначеЕсли ТекущиеДанные <> Неопределено
		И ТекущиеДанные.Уровень = 0 Тогда
		
		Если НЕ ТекущиеДанные.УдалитьЗапрос Тогда
			ТекущиеДанные.УдалитьКлиента = Ложь;
		КонецЕсли;
		
		СтрокаРодитель = ТекущиеДанные.ПолучитьРодителя();
		Если НЕ СтрокаРодитель.УдалитьКлиента = ТекущиеДанные.УдалитьКлиента Тогда			
			СтрокиВГруппировке = СтрокаРодитель.ПолучитьЭлементы(); 					
			ЕстьРазличия = Ложь;
			Для каждого СтрокаДерева Из СтрокиВГруппировке Цикл
				Если НЕ СтрокаДерева.УдалитьКлиента = ТекущиеДанные.УдалитьКлиента Тогда
					ЕстьРазличия = Истина;
					Прервать;
				КонецЕсли;
			КонецЦикла;
			Если НЕ ЕстьРазличия Тогда
				СтрокаРодитель.УдалитьКлиента = ТекущиеДанные.УдалитьКлиента;
			Иначе
				СтрокаРодитель.УдалитьЗапрос = Ложь;				
			КонецЕсли;
		КонецЕсли;
		
	КонецЕсли;		
	
КонецПроцедуры

&НаКлиенте
Процедура ДеревоКлиентовУдалитьЗапросПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.ДеревоКлиентов.ТекущиеДанные;
	Если ТекущиеДанные <> Неопределено
		И ТекущиеДанные.Уровень = 1 Тогда
		
		СтрокиВГруппировке = ТекущиеДанные.ПолучитьЭлементы();
		
		Результат = Истина;
		
		УдалитьЗапрос = ТекущиеДанные.УдалитьЗапрос;
		Для каждого СтрокаДерева Из СтрокиВГруппировке Цикл
			Если УдалитьЗапрос Тогда
				СтрокаДерева.УдалитьЗапрос = НЕ ЗначениеЗаполнено(СтрокаДерева.Сделка);	
			Иначе
				СтрокаДерева.УдалитьЗапрос	= Ложь;
			КонецЕсли;
			Если НЕ СтрокаДерева.УдалитьЗапрос И Результат Тогда
				Результат = Ложь;	
			КонецЕсли;
		КонецЦикла;
		
		Если НЕ Результат Тогда
			ТекущиеДанные.УдалитьЗапрос	= Ложь;
		КонецЕсли;
		
	ИначеЕсли ТекущиеДанные <> Неопределено
		И ТекущиеДанные.Уровень = 0 Тогда
		Если ЗначениеЗаполнено(ТекущиеДанные.Сделка) Тогда
			ТекущиеДанные.УдалитьЗапрос = Ложь;
		КонецЕсли;
		
		СтрокаРодитель = ТекущиеДанные.ПолучитьРодителя();
		Если НЕ СтрокаРодитель.УдалитьЗапрос = ТекущиеДанные.УдалитьЗапрос Тогда			
			СтрокиВГруппировке = СтрокаРодитель.ПолучитьЭлементы(); 					
			ЕстьРазличия = Ложь;
			Для каждого СтрокаДерева Из СтрокиВГруппировке Цикл
				Если НЕ СтрокаДерева.УдалитьЗапрос = ТекущиеДанные.УдалитьЗапрос Тогда
					ЕстьРазличия = Истина;
					Прервать;
				КонецЕсли;
			КонецЦикла;
			Если НЕ ЕстьРазличия Тогда
				СтрокаРодитель.УдалитьЗапрос = ТекущиеДанные.УдалитьЗапрос;
			Иначе
				СтрокаРодитель.УдалитьЗапрос = Ложь;
			КонецЕсли;
		КонецЕсли;		
		
	КонецЕсли;	
	
КонецПроцедуры

&НаКлиенте
Процедура ДеревоКлиентовПослеУдаления(Элемент)
	
КонецПроцедуры

&НаКлиенте
Процедура ДеревоКлиентовПередУдалением(Элемент, Отказ)
	
	ТекущиеДанные = Элементы.ДеревоКлиентов.ТекущиеДанные;
	Если ТекущиеДанные <> Неопределено Тогда
		Отбор = Новый Структура("Клиент", ТекущиеДанные.Клиент);
		НайденныеСтроки = Объект.СписокЭлементовДляУдаления.НайтиСтроки(Отбор);
		
		МассивНаУдаление = Новый Массив;		
		Если НайденныеСтроки.Количество() Тогда
			Для каждого Строка Из НайденныеСтроки Цикл
				Если МассивНаУдаление.Найти(Строка) = Неопределено Тогда
					МассивНаУдаление.Добавить(Строка);
				КонецЕсли;
			КонецЦикла;
		КонецЕсли;
		
		Для Каждого Стр Из МассивНаУдаление Цикл
			Объект.СписокЭлементовДляУдаления.Удалить(Стр);
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ДеревоКлиентовПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа, Параметр)
	Отказ = Истина;
КонецПроцедуры

&НаКлиенте
Процедура ДеревоКлиентовОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	Если ТипЗнч(ВыбранноеЗначение) = Тип("Массив") Тогда
		Для каждого Значение Из ВыбранноеЗначение Цикл
			Если ЭтоДубль(Значение) Тогда
				Продолжить;
			КонецЕсли;			
			ЗаполнитьСвязанныеЭлементыПоКлиенту(Значение);
		КонецЦикла;
	Иначе	
		Если ЭтоДубль(ВыбранноеЗначение) Тогда
			Возврат;
		КонецЕсли;
		ЗаполнитьСвязанныеЭлементыПоКлиенту(Значение);		
	КонецЕсли;
	
	ПреобразоватьРезультатВДерево();

КонецПроцедуры
