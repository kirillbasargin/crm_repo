﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	//ОбновитьФормуНаСервере();	
	//Заявки.Параметры.УстановитьЗначениеПараметра("НачалоДня", НачалоДня(ТекущаяДата()));
	//Заявки.Параметры.УстановитьЗначениеПараметра("КонецДня", КонецДня(ТекущаяДата()));
	
	Заявки.Параметры.УстановитьЗначениеПараметра("Ответственный", Пользователи.АвторизованныйПользователь());
	ОбщееКоличествоЗаявок = ПолучитьЗаявкиМенеджера();
	Элементы.ЗаявкиОбновитьФорму.Заголовок = "Обновить форму (" + ОбщееКоличествоЗаявок + ")";	
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	Для Каждого Строка Из МенеджерыСегодня.ПолучитьЭлементы() Цикл   
		Элементы.МенеджерыСегодня.Развернуть(Строка.ПолучитьИдентификатор(), Истина);
	КонецЦикла; 

	Для Каждого Строка Из ПриоритетыЗаявок.ПолучитьЭлементы() Цикл 
		Элементы.ПриоритетыЗаявок.Развернуть(Строка.ПолучитьИдентификатор(), Истина);
	КонецЦикла; 
	
	ЭтаФорма.ПодключитьОбработчикОжидания("ОбновитьФормуНаКлиенте", 60);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы



#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицФормы

&НаКлиенте
Процедура ПриоритетыЗаявокПриАктивизацииСтроки(Элемент)
	ПодключитьОбработчикОжидания("АктивизацияСтрокиКлиентыЗавершение", 0.1, Истина);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОтчетМенеджера(Команда)
	
	ПараметрыОткрываемойФормы = Новый Структура("Отбор,СформироватьПриОткрытии", 
													Новый Структура("Стадия", ПредопределенноеЗначение("Перечисление.СтадииЗапроса.Звонок")),
													Истина);
	ОткрытьФорму("Отчет.ОтчетМенеджера.ФормаОбъекта", ПараметрыОткрываемойФормы, ЭтотОбъект);	
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьФорму(Команда)
	
	//ОбновитьФормуНаСервере();
	//
	//Для Каждого Строка Из МенеджерыСегодня.ПолучитьЭлементы() Цикл   
	//	Элементы.МенеджерыСегодня.Развернуть(Строка.ПолучитьИдентификатор(), Истина);
	//КонецЦикла; 

	//Для Каждого Строка Из ПриоритетыЗаявок.ПолучитьЭлементы() Цикл 
	//	Элементы.ПриоритетыЗаявок.Развернуть(Строка.ПолучитьИдентификатор(), Истина);
	//КонецЦикла; 
	
	Элементы.Заявки.Обновить();
	Элементы.ЗаявкиОбновитьФорму.ЦветФона = Новый Цвет(255, 225, 0);
	
КонецПроцедуры

&НаКлиенте
Процедура СоздатьЗаявку(Команда)
	
	ПараметрыФормы = Новый Структура("ЗначенияЗаполнения", УправлениеЗаявкамиНаЗвонок.СоздатьЗначенияЗаполнения());	
	ОткрытьФорму("Документ.ЗаявкаНаЗвонок.Форма.ФормаДокумента", ПараметрыФормы, ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьУправлениеЗаявками(Команда)
	ОткрытьФорму("Обработка.УправлениеРаспределениемЗаявок.Форма.Форма");
КонецПроцедуры

&НаКлиенте
Процедура ОтчетПоВзаимодействиям(Команда)
	
	ПараметрыОткрываемойФормы = Новый Структура("СформироватьПриОткрытии", Ложь);
	ОткрытьФорму("Отчет.ОтчетПоВзаимодействиям.ФормаОбъекта", ПараметрыОткрываемойФормы, ЭтотОбъект);	

КонецПроцедуры

&НаКлиенте
Процедура ОтчетПоЭффективностиМенеджетраГПТ(Команда)
	
	ПараметрыОткрываемойФормы = Новый Структура("СформироватьПриОткрытии", Ложь);
	ОткрытьФорму("Отчет.ЭффективностьМенеджера_ГПТ.ФормаОбъекта", ПараметрыОткрываемойФормы, ЭтотОбъект);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура АктивизацияСтрокиКлиентыЗавершение()

	//Заявки.Параметры.УстановитьЗначениеПараметра("Приоритет", Неопределено);
	//Заявки.Параметры.УстановитьЗначениеПараметра("Этап", Неопределено);
	
	ТекущиеДанные = Элементы.ПриоритетыЗаявок.ТекущиеДанные;	
	Если ТекущиеДанные = Неопределено Тогда		
		Возврат;
	КонецЕсли;
	
	Если ЗначениеЗаполнено(ТекущиеДанные.Приоритет) Тогда  
		Заявки.Параметры.УстановитьЗначениеПараметра("Приоритет", ТекущиеДанные.Приоритет);
	Иначе
		Заявки.Параметры.УстановитьЗначениеПараметра("Приоритет", Неопределено);	
	КонецЕсли;
	
	//Если ЗначениеЗаполнено(ТекущиеДанные.Этап) Тогда  
	//	Заявки.Параметры.УстановитьЗначениеПараметра("Этап", ТекущиеДанные.Этап);
	//КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьФормуНаСервере(Регламентно = Ложь)

	Заявки.Параметры.УстановитьЗначениеПараметра("Ответственный", Пользователи.АвторизованныйПользователь());
	Заявки.Параметры.УстановитьЗначениеПараметра("Приоритет", Неопределено);
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ РАЗЛИЧНЫЕ
	|	ГруппыДоступа.Ссылка КАК ГруппаДоступа,
	|	ГруппыДоступа.Профиль КАК Профиль,
	|	ГруппыДоступаПользователи.Пользователь КАК Пользователь,
	|	ВЫБОР
	|		КОГДА ТИПЗНАЧЕНИЯ(ГруппыДоступаПользователи.Пользователь) <> ТИП(Справочник.Пользователи)
	|				И ТИПЗНАЧЕНИЯ(ГруппыДоступаПользователи.Пользователь) <> ТИП(Справочник.ВнешниеПользователи)
	|			ТОГДА ИСТИНА
	|		ИНАЧЕ ЛОЖЬ
	|	КОНЕЦ КАК ГрупповоеУчастие
	|ПОМЕСТИТЬ ГруппыДоступаПользователя
	|ИЗ
	|	Справочник.ГруппыДоступа КАК ГруппыДоступа
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ГруппыДоступа.Пользователи КАК ГруппыДоступаПользователи
	|		ПО ГруппыДоступа.Ссылка = ГруппыДоступаПользователи.Ссылка
	|			И (НЕ ГруппыДоступа.ПометкаУдаления)
	|			И (НЕ ГруппыДоступа.Профиль.ПометкаУдаления)
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ГруппыДоступаПользователя.Профиль КАК Профиль,
	|	ГруппыДоступаПользователя.ГруппаДоступа КАК ГруппаДоступа,
	|	ЕСТЬNULL(ГруппыДоступаВидыДоступа.ВидДоступа, НЕОПРЕДЕЛЕНО) КАК ВидДоступа,
	|	ЕСТЬNULL(ГруппыДоступаВидыДоступа.ВсеРазрешены, ЛОЖЬ) КАК ВсеРазрешены,
	|	ЕСТЬNULL(ГруппыДоступаЗначенияДоступа.ЗначениеДоступа, НЕОПРЕДЕЛЕНО) КАК ЗначениеДоступа
	|ПОМЕСТИТЬ ВидыИЗначенияДоступа
	|ИЗ
	|	ГруппыДоступаПользователя КАК ГруппыДоступаПользователя
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.ГруппыДоступа.ВидыДоступа КАК ГруппыДоступаВидыДоступа
	|		ПО (ГруппыДоступаВидыДоступа.Ссылка = ГруппыДоступаПользователя.ГруппаДоступа)
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.ГруппыДоступа.ЗначенияДоступа КАК ГруппыДоступаЗначенияДоступа
	|		ПО (ГруппыДоступаЗначенияДоступа.Ссылка = ГруппыДоступаВидыДоступа.Ссылка)
	|			И (ГруппыДоступаЗначенияДоступа.ВидДоступа = ГруппыДоступаВидыДоступа.ВидДоступа)
	|
	|ОБЪЕДИНИТЬ
	|
	|ВЫБРАТЬ
	|	ГруппыДоступаПользователя.Профиль,
	|	ГруппыДоступаПользователя.ГруппаДоступа,
	|	ПрофилиГруппДоступаВидыДоступа.ВидДоступа,
	|	ПрофилиГруппДоступаВидыДоступа.ВсеРазрешены,
	|	ЕСТЬNULL(ПрофилиГруппДоступаЗначенияДоступа.ЗначениеДоступа, НЕОПРЕДЕЛЕНО)
	|ИЗ
	|	ГруппыДоступаПользователя КАК ГруппыДоступаПользователя
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ПрофилиГруппДоступа.ВидыДоступа КАК ПрофилиГруппДоступаВидыДоступа
	|		ПО (ПрофилиГруппДоступаВидыДоступа.Ссылка = ГруппыДоступаПользователя.Профиль)
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.ПрофилиГруппДоступа.ЗначенияДоступа КАК ПрофилиГруппДоступаЗначенияДоступа
	|		ПО (ПрофилиГруппДоступаЗначенияДоступа.Ссылка = ПрофилиГруппДоступаВидыДоступа.Ссылка)
	|			И (ПрофилиГруппДоступаЗначенияДоступа.ВидДоступа = ПрофилиГруппДоступаВидыДоступа.ВидДоступа)
	|ГДЕ
	|	ПрофилиГруппДоступаВидыДоступа.Предустановленный
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ВидыИЗначенияДоступа.ЗначениеДоступа КАК ЗначениеДоступа,
	|	ГруппыДоступаПользователи.Пользователь КАК Пользователь
	|ИЗ
	|	ВидыИЗначенияДоступа КАК ВидыИЗначенияДоступа
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ГруппыДоступа.Пользователи КАК ГруппыДоступаПользователи
	|		ПО ВидыИЗначенияДоступа.ГруппаДоступа = ГруппыДоступаПользователи.Ссылка
	|ГДЕ
	|	ГруппыДоступаПользователи.Пользователь ССЫЛКА Справочник.Пользователи
	|
	|УПОРЯДОЧИТЬ ПО
	|	ЗначениеДоступа УБЫВ
	|ИТОГИ ПО
	|	ЗначениеДоступа";	
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ДеревоМенеджеры = РеквизитФормыВЗначение("МенеджерыСегодня");
	ДеревоМенеджеры.Строки.Очистить();
	
	ВыборкаЗначениеДоступа = РезультатЗапроса.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
	Пока ВыборкаЗначениеДоступа.Следующий() Цикл
		СтрокаДерева = ДеревоМенеджеры.Строки.Добавить();
		СтрокаДерева.Проект = ВыборкаЗначениеДоступа.ЗначениеДоступа;
		ВыборкаДетальныеЗаписи = ВыборкаЗначениеДоступа.Выбрать();
		СтрокаДерева.Количество = ВыборкаДетальныеЗаписи.Количество();
		Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
			ПодСтрока = СтрокаДерева.Строки.Добавить();
			Если Активные Тогда
				СоединенияИнформационнойБазы = ПолучитьСеансыИнформационнойБазы();                 
				Для Каждого Соединение Из СоединенияИнформационнойБазы Цикл
					Если //Найти(Соединение.Пользователь.Имя, "ABSGROUP\") И 
						НЕ Найти(Соединение.ИмяПриложения, "Designer") И НЕ Найти(Соединение.ИмяПриложения, "BackgroundJob") Тогда
						НайденныйПользователь = Справочники.Пользователи.НайтиПоРеквизиту("ИдентификаторПользователяИБ", Соединение.Пользователь.УникальныйИдентификатор);  //Справочники.Пользователи.НайтиПоКоду(Соединение.Пользователь.Имя);
						Если ЗначениеЗаполнено(НайденныйПользователь) И НайденныйПользователь = ВыборкаДетальныеЗаписи.Пользователь Тогда
							ПодСтрока.Менеджер = ВыборкаДетальныеЗаписи.Пользователь;
						КонецЕсли; 
					КонецЕсли;
				КонецЦикла;				
			Иначе
				ПодСтрока.Менеджер = ВыборкаДетальныеЗаписи.Пользователь;
			КонецЕсли;
		КонецЦикла;
	КонецЦикла;
	
	ЗначениеВРеквизитФормы(ДеревоМенеджеры, "МенеджерыСегодня");
		
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	ЗаявкаНаЗвонок.Приоритет КАК Приоритет,
	|	КОЛИЧЕСТВО(ЗаявкаНаЗвонок.Ссылка) КАК Количество
	|ИЗ
	|	Документ.ЗаявкаНаЗвонок КАК ЗаявкаНаЗвонок
	|ГДЕ
	|	НЕ ЗаявкаНаЗвонок.ПометкаУдаления
	|	И ЗаявкаНаЗвонок.Ответственный = &Ответственный
	|	И ЗаявкаНаЗвонок.ДатаРаспределения МЕЖДУ &ДатаНачала И &ДатаОкончания
	|
	|СГРУППИРОВАТЬ ПО
	|	ЗаявкаНаЗвонок.Приоритет
	|
	|УПОРЯДОЧИТЬ ПО
	|	Приоритет";
	
	Запрос.УстановитьПараметр("ДатаНачала", НачалоДня(ТекущаяДата()));
	Запрос.УстановитьПараметр("ДатаОкончания", КонецДня(ТекущаяДата()));
	Запрос.УстановитьПараметр("Ответственный", Пользователи.АвторизованныйПользователь());
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ДеревоПриоритетыЗаявок = РеквизитФормыВЗначение("ПриоритетыЗаявок");
	ДеревоПриоритетыЗаявок.Строки.Очистить();
	
	//ВыборкаЭтапРаботы = РезультатЗапроса.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);	
	//Пока ВыборкаЭтапРаботы.Следующий() Цикл
	//	СтрокаДерева = ДеревоПриоритетыЗаявок.Строки.Добавить();
	//	//СтрокаДерева.Этап = ВыборкаЭтапРаботы.ЭтапРаботы;		
	//	ВыборкаПриоритет = ВыборкаЭтапРаботы.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
	//	//СтрокаДерева.Количество = ВыборкаПриоритет.Количество();
	//	Пока ВыборкаПриоритет.Следующий() Цикл
	//		ПодСтрока = СтрокаДерева.Строки.Добавить();
	//		ПодСтрока.Приоритет = ВыборкаПриоритет.Приоритет;
	//		ВыборкаДетальныеЗаписи = ВыборкаПриоритет.Выбрать();
	//		ПодСтрока.Количество = ВыборкаДетальныеЗаписи.Количество();
	//		СтрокаДерева.Количество = СтрокаДерева.Количество + ПодСтрока.Количество;
	//	КонецЦикла;
	//КонецЦикла;
	
	ВыборкаПриоритет = РезультатЗапроса.Выбрать();
	Пока ВыборкаПриоритет.Следующий() Цикл
		СтрокаДерева = ДеревоПриоритетыЗаявок.Строки.Добавить();
		СтрокаДерева.Приоритет = ВыборкаПриоритет.Приоритет;
		СтрокаДерева.Количество = ВыборкаПриоритет.Количество;
	КонецЦикла;
	
	ОбщееКоличествоЗаявок = ДеревоПриоритетыЗаявок.Строки.Итог("Количество", Истина);
	
	ЗначениеВРеквизитФормы(ДеревоПриоритетыЗаявок, "ПриоритетыЗаявок");
	
	Элементы.ЗаявкиОбновитьФорму.Заголовок = "Обновить форму (" + ОбщееКоличествоЗаявок + ")";	
	 	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ПолучитьЗаявкиМенеджера()
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	КОЛИЧЕСТВО(ЗаявкаНаЗвонок.Ссылка) КАК Количество
	|ИЗ
	|	Документ.ЗаявкаНаЗвонок КАК ЗаявкаНаЗвонок
	|ГДЕ
	|	НЕ ЗаявкаНаЗвонок.ПометкаУдаления
	|	И ЗаявкаНаЗвонок.Ответственный = &Ответственный
	|	И ЗаявкаНаЗвонок.ДатаРаспределения МЕЖДУ &ДатаНачала И &ДатаОкончания";
	
	Запрос.УстановитьПараметр("ДатаНачала", НачалоДня(ТекущаяДата()));
	Запрос.УстановитьПараметр("ДатаОкончания", КонецДня(ТекущаяДата()) + 1);
	Запрос.УстановитьПараметр("Ответственный", Пользователи.АвторизованныйПользователь());
	
	РезультатЗапроса = Запрос.Выполнить();

	Выборка = РезультатЗапроса.Выбрать();
	Если Выборка.Следующий() Тогда
		Возврат Выборка.Количество;	
	КонецЕсли;
	
	Возврат 0;
	
КонецФункции

&НаКлиенте
Процедура ОбновитьФормуНаКлиенте() Экспорт
	
	//ОбновитьФормуНаСервере(Истина);
	
	_ОбщееКоличествоЗаявок = ПолучитьЗаявкиМенеджера();
	Если НЕ (ОбщееКоличествоЗаявок = 0 ИЛИ ОбщееКоличествоЗаявок = _ОбщееКоличествоЗаявок) Тогда
	//	Элементы.ЗаявкиОбновитьФорму.ЦветФона = Новый Цвет(255, 225, 0);	
	//Иначе
		Элементы.ЗаявкиОбновитьФорму.ЦветФона = Новый Цвет(0, 255, 255);		
	КонецЕсли;		
	ОбщееКоличествоЗаявок = _ОбщееКоличествоЗаявок;
	Элементы.ЗаявкиОбновитьФорму.Заголовок = "Обновить форму (" + ОбщееКоличествоЗаявок + ")";
	Элементы.Заявки.Обновить();
	
КонецПроцедуры

#КонецОбласти

