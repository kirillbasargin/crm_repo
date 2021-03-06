﻿
&НаКлиенте
Процедура OK(Команда)
	
	Выгодоприобретатель = Неопределено;
	Получатель = Неопределено;
	Для каждого Строка Из ТаблицаВыбора Цикл
		Если Строка.Выгодоприобретатель И Выгодоприобретатель = Неопределено Тогда
			Выгодоприобретатель = Строка.Клиент;
		КонецЕсли;
		Если Строка.Получатель И Получатель = Неопределено Тогда
			Получатель = Строка.Клиент;
		КонецЕсли;		
	КонецЦикла;
	
	Основание = Новый Структура("Запрос, Выгодоприобретатель, Получатель", Параметры.Запрос, Выгодоприобретатель, Получатель);	
	ОткрытьФорму("Документ.ВыдачаДисконтныхКарт.ФормаОбъекта", Новый Структура("Основание", Основание), ЭтаФорма.ВладелецФормы, , , , , РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
	Закрыть();
	
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("Клиенты") Тогда
		Для каждого Клиент Из Параметры.Клиенты Цикл
			НоваяСтрока = ТаблицаВыбора.Добавить();
			НоваяСтрока.Клиент = Клиент;
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры


