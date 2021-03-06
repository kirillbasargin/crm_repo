﻿
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если ЗначениеЗаполнено(Параметры.ОсновнойТелефон) Тогда
		ЭтаФорма.Заголовок = "Клиент по номеру: " + Параметры.ОсновнойТелефон;
		ПолеПоиска = Параметры.ОсновнойТелефон;
		Клиенты.Параметры.УстановитьЗначениеПараметра("Телефоны", "%" + УправлениеТелефониейКлиентСервер.ФорматироватьТелефон(СокрЛП(ПолеПоиска)) + "%");
	Иначе
		ЭтаФорма.АвтоЗаголовок = Истина;
	КонецЕсли;

	Если Параметры.Свойство("СозданиеКлиентаИзЗапроса") Тогда
		СозданиеКлиентаИзЗапроса = Параметры.СозданиеКлиентаИзЗапроса;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СоздатьКлиента(Команда)
	
	Если ЗначениеЗаполнено(Параметры.ОсновнойТелефон) Тогда
		Номера = Новый Массив;		
		Если НЕ РежимПоиска Тогда
			Номера.Добавить(ПолеПоиска);
		КонецЕсли;
		Номера.Добавить(Параметры.ОсновнойТелефон);
		ОткрытьФорму("Справочник.Клиенты.Форма.ФормаЭлемента", Новый Структура("ОсновнойТелефон, СозданиеКлиентаИзЗапроса", Номера, СозданиеКлиентаИзЗапроса), ?(СозданиеКлиентаИзЗапроса, ЭтаФорма.ВладелецФормы, ЭтаФорма));
	Иначе
		Если НЕ РежимПоиска Тогда
			Номера = Новый Массив;
			Номера.Добавить(ПолеПоиска);		
			ОткрытьФорму("Справочник.Клиенты.Форма.ФормаЭлемента", Новый Структура("ОсновнойТелефон, СозданиеКлиентаИзЗапроса", Номера, СозданиеКлиентаИзЗапроса), ?(СозданиеКлиентаИзЗапроса, ЭтаФорма.ВладелецФормы, ЭтаФорма));
		Иначе
			ОткрытьФорму("Справочник.Клиенты.Форма.ФормаЭлемента", Новый Структура("СозданиеКлиентаИзЗапроса"), ?(СозданиеКлиентаИзЗапроса, ЭтаФорма.ВладелецФормы, ЭтаФорма));
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьПоиск(Команда)
	                                                              
	Если НЕ ПустаяСтрока(ПолеПоиска) Тогда
		Если НЕ РежимПоиска Тогда
			НомерТелефона = УправлениеТелефониейКлиентСервер.ФорматироватьТелефон(СокрЛП(ПолеПоиска));
			Если СтрДлина(НомерТелефона) = 11 И (Сред(НомерТелефона, 1, 1) = "7" ИЛИ Сред(НомерТелефона, 1, 1) = "8") Тогда
				НомерТелефона = Прав(НомерТелефона, 10);
			КонецЕсли;			
			Клиенты.Параметры.УстановитьЗначениеПараметра("Телефоны", "%" + НомерТелефона + "%"); //УправлениеТелефониейКлиентСервер.ФорматироватьТелефон(СокрЛП(ПолеПоиска))
			Для каждого Элемент Из Клиенты.Параметры.Элементы Цикл 
				Если Элемент.Параметр = Новый ПараметрКомпоновкиДанных("ФИО") Тогда
					Элемент.Использование = Ложь;
				КонецЕсли;
			КонецЦикла;			
		Иначе
			Клиенты.Параметры.УстановитьЗначениеПараметра("ФИО", "%" + СокрЛП(ПолеПоиска) + "%");
			Для каждого Элемент Из Клиенты.Параметры.Элементы Цикл 
				Если Элемент.Параметр = Новый ПараметрКомпоновкиДанных("Телефоны") Тогда
					Элемент.Использование = Ложь;
				КонецЕсли;
			КонецЦикла;
		КонецЕсли;
	Иначе		
		//Для каждого Элемент Из Клиенты.Параметры.Элементы Цикл 
		//	Если Элемент.Параметр = Новый ПараметрКомпоновкиДанных("Телефоны") Тогда
		//		Элемент.Использование = Ложь;
		//		Прервать;
		//	КонецЕсли;
		//КонецЦикла;	
		Для каждого Элемент Из Клиенты.Параметры.Элементы Цикл 
			Если Элемент.Параметр = Новый ПараметрКомпоновкиДанных("ФИО")
				ИЛИ Элемент.Параметр = Новый ПараметрКомпоновкиДанных("Телефоны") Тогда
				Элемент.Использование = Ложь;
			КонецЕсли;
		КонецЦикла;				
	КонецЕсли;	
	Элементы.Клиенты.Обновить();	
	
КонецПроцедуры

&НаКлиенте
Процедура СброситьПоиск(Команда)
	
	ПолеПоиска = "";
	ВыполнитьПоиск(Неопределено);
	
КонецПроцедуры

&НаКлиенте
Процедура РежимПоискаПриИзменении(Элемент)
	
	ПолеПоиска = "";
	ВыполнитьПоиск(Неопределено);	
	
КонецПроцедуры

&НаКлиенте
Процедура ПолеПоискаОкончаниеВводаТекста(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, СтандартнаяОбработка)	
	
	//ПолеПоиска = Текст;	
	//ВыполнитьПоиск(Неопределено);	
	
КонецПроцедуры

&НаКлиенте
Процедура ПолеПоискаИзменениеТекстаРедактирования(Элемент, Текст, СтандартнаяОбработка)
	
	//ПолеПоиска = Текст;	
	//ВыполнитьПоиск(Неопределено);	

КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	//Если Источник = "Клиенты" И ИмяСобытия = "СозданиеКлиентаИзТелефонии" Тогда
	Если Источник = "Клиенты" И ИмяСобытия = "ЗакрытьФормуВыбораКлиента" Тогда
		Закрыть();
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ПолеПоискаПриИзменении(Элемент)
	ВыполнитьПоиск(Неопределено);	
КонецПроцедуры
