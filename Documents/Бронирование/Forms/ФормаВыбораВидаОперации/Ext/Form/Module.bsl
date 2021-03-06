﻿#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Параметры.Свойство("ЗначениеКопирования", 	ЗначениеКопирования);
	Параметры.Свойство("ЗначенияЗаполнения", 	ЗначенияЗаполнения);
	Параметры.Свойство("Основание", 			Основание);
	Параметры.Свойство("Ключ", 					Ключ);
	
	Для каждого ЗначениеПеречисления Из Перечисления.ВидыОперацииБронирования Цикл
		СписокВидовОпераций.Добавить(ЗначениеПеречисления);
	КонецЦикла;
	
	Если Параметры.Свойство("ВидОперации") Тогда
	    ЭлементСписка = СписокВидовОпераций.НайтиПоЗначению(Параметры.ВидОперации);
		Если ЭлементСписка <> Неопределено Тогда
			Элементы.СписокВидовОпераций.ТекущаяСтрока = ЭлементСписка.ПолучитьИдентификатор();
		КонецЕсли;
	КонецЕсли;
	
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

#КонецОбласти

#Область ОбработчикиСобытийЭлементовФормы

&НаКлиенте
Процедура СписокВидовОперацийВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	Выбрать("");	
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Выбрать(Команда)
	
	ТекущиеДанные = Элементы.СписокВидовОпераций.ТекущиеДанные;
	ВидОперации = ТекущиеДанные.Значение;
	
	ПараметрыФормы = Новый Структура;
	
	Если ЗначениеЗаполнено(Ключ) Тогда
		ПараметрыФормы.Вставить("Ключ", Ключ);
	КонецЕсли;
	
	Если ЗначениеЗаполнено(ЗначенияЗаполнения) Тогда
		ПараметрыФормы.Вставить("ЗначенияЗаполнения", ЗначенияЗаполнения);
	КонецЕсли;
		
	Если ЗначениеЗаполнено(ЗначениеКопирования) Тогда
		ПараметрыФормы.Вставить("ЗначениеКопирования", ЗначениеКопирования);
	КонецЕсли;
	
	Закрыть();
	
	ОткрытьФорму("Документ.Бронирование.Форма." + ПолучитьИмяФормыПоВидуОперации(ВидОперации), ПараметрыФормы, ВладелецФормы);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервереБезКонтекста
Функция ПолучитьИмяФормыПоВидуОперации(ВидОперации)

	Соотвествие = Документы.Бронирование.ПолучитьСоотвествиеФормИВидовОпераций();
	Возврат Соотвествие[ВидОперации];	

КонецФункции // ПолучитьИмяФормыПоВидуОперации()

#КонецОбласти

















