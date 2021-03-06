﻿
&НаКлиенте
Перем КонтекстВыбора Экспорт;

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	УстановитьОтборыДляРабочихСтолов(Параметры);
	
КонецПроцедуры

&НаКлиенте
Процедура СрокиБронированияОбъектовНедвижимостиВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ТекущиеДанные = Элементы.СрокиБронированияОбъектовНедвижимости.ТекущиеДанные;
	Если ТекущиеДанные <> Неопределено Тогда
		ОткрытьФорму("Документ.Бронирование.ФормаОбъекта", Новый Структура("Ключ", ТекущиеДанные.Регистратор), ЭтотОбъект);	
	КонецЕсли;	
	
КонецПроцедуры

&НаКлиенте
Процедура ПриПовторномОткрытии()
	
	Если ТипЗнч(КонтекстВыбора) = Тип("Структура") Тогда
		УстановитьОтборыДляРабочихСтолов(КонтекстВыбора);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьОтборыДляРабочихСтолов(Знач ПараметрыОтбора)
	
	ПараметрТекущийПользователь = ПользователиКлиентСервер.ТекущийПользователь();
	ПараметрПроекты = Новый СписокЗначений;
	ПараметрОграничиватьПроекты = Неопределено;
	
	Если ПараметрыОтбора.Свойство("ОтборДляСтаршегоМенеджера") Или ПараметрыОтбора.Свойство("ОтборДляМенеджераФилиала") Тогда
		СрокиБронированияОбъектовНедвижимости.Параметры.УстановитьЗначениеПараметра("ТекущийПользователь", ПараметрыОтбора.Ответственный);
		//ПараметрТекущийПользователь = ПараметрыОтбора.Ответственный;
		СрокиБронированияОбъектовНедвижимости.Параметры.УстановитьЗначениеПараметра("НачалоДня", ПараметрыОтбора.НачалоДня);
		//СрокиБронированияОбъектовНедвижимости.Параметры.УстановитьЗначениеПараметра("Проекты", ПараметрыОтбора.Проект);
		ПараметрПроекты.ЗагрузитьЗначения(ПараметрыОтбора.Проект);
		//СрокиБронированияОбъектовНедвижимости.Параметры.УстановитьЗначениеПараметра("ОграничиватьПроекты", Истина);
		ПараметрОграничиватьПроекты = Истина;
	Иначе
		//СрокиБронированияОбъектовНедвижимости.Параметры.УстановитьЗначениеПараметра("ОграничиватьПроекты", Неопределено);
		//СрокиБронированияОбъектовНедвижимости.Параметры.УстановитьЗначениеПараметра("Проекты", Новый Массив);
		СрокиБронированияОбъектовНедвижимости.Параметры.УстановитьЗначениеПараметра("ТекущийПользователь", ПользователиКлиентСервер.ТекущийПользователь());
		СрокиБронированияОбъектовНедвижимости.Параметры.УстановитьЗначениеПараметра("НачалоДня", НачалоДня(ТекущаяДата()));
	КонецЕсли;
	
	//СрокиБронированияОбъектовНедвижимости.Параметры.УстановитьЗначениеПараметра("ТекущийПользователь", ПараметрТекущийПользователь);
	СрокиБронированияОбъектовНедвижимости.Параметры.УстановитьЗначениеПараметра("Проекты", ПараметрПроекты.ВыгрузитьЗначения());
	СрокиБронированияОбъектовНедвижимости.Параметры.УстановитьЗначениеПараметра("ОграничиватьПроекты", ПараметрОграничиватьПроекты);
	
	СрокиБронированияОбъектовНедвижимости.Параметры.УстановитьЗначениеПараметра("НеОграничиватьПользователей", Ложь);
	
КонецПроцедуры

&НаКлиенте
Процедура ПараметрТекущийПользовательПриИзменении(Элемент)	
	ПараметрТекущийПользовательПриИзмененииНаСервере(ПараметрТекущийПользователь);	
КонецПроцедуры

&НаКлиенте
Процедура ПараметрПроектыПриИзменении(Элемент)		
	СрокиБронированияОбъектовНедвижимости.Параметры.УстановитьЗначениеПараметра("Проекты", ПараметрПроекты.ВыгрузитьЗначения());
КонецПроцедуры

&НаСервере
Процедура ПараметрТекущийПользовательПриИзмененииНаСервере(Ответственный = Неопределено)
	
	СрокиБронированияОбъектовНедвижимости.Параметры.УстановитьЗначениеПараметра("НеОграничиватьПользователей", Ответственный = Справочники.Пользователи.ПустаяСсылка());
	
	Ответственный = ?(Ответственный = Неопределено, ПользователиКлиентСервер.ТекущийПользователь(), Ответственный);
	
	МенеджерСтарший = Пользователи.РолиДоступны("РедактированиеСрокаБронирования", Ответственный);
	
	Если МенеджерСтарший Тогда
		ТекущийПользователь = ПолучитьОтбор(Ответственный);
	Иначе
		ТекущийПользователь = Ответственный;
	КонецЕсли;
	
	СрокиБронированияОбъектовНедвижимости.Параметры.УстановитьЗначениеПараметра("ТекущийПользователь", ?(ТипЗнч(ТекущийПользователь) = Тип("СписокЗначений"), ТекущийПользователь.ВыгрузитьЗначения(), ТекущийПользователь));
	
КонецПроцедуры

Функция ПолучитьОтбор(Ответственный, ВМассив = Ложь, Группа = Ложь)
	
	Если ВМассив Тогда
		СписокОтбора = Новый Массив;
	Иначе
		СписокОтбора = Новый СписокЗначений;
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ РАЗЛИЧНЫЕ
		|	Состав.Ссылка КАК Группа
		|ПОМЕСТИТЬ ВТ_СписокГрупп
		|ИЗ
		|	Справочник.ГруппыПользователей.Состав КАК Состав
		|ГДЕ
		|	Состав.Пользователь = &Пользователь
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ РАЗЛИЧНЫЕ
		|	ГруппыПользователейСостав.Пользователь КАК Ссылка
		|ИЗ
		|	Справочник.ГруппыПользователей.Состав КАК ГруппыПользователейСостав
		|ГДЕ
		|	ГруппыПользователейСостав.Ссылка В ИЕРАРХИИ
		|			(ВЫБРАТЬ
		|				ВТ.Группа
		|			ИЗ
		|				ВТ_СписокГрупп КАК ВТ)
		|
		|СГРУППИРОВАТЬ ПО
		|	ГруппыПользователейСостав.Пользователь";
	
	Запрос.УстановитьПараметр("Пользователь", Ответственный);
	
	Если Группа Тогда
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "ГруппыПользователейСостав.Пользователь", "ГруппыПользователейСостав.Ссылка");
	КонецЕсли;
	
	Результат = Запрос.Выполнить();	
	Если Результат.Пустой() Тогда
		СписокОтбора.Добавить(Ответственный);
	Иначе
		Выборка = Результат.Выбрать();
		Пока Выборка.Следующий() Цикл
			СписокОтбора.Добавить(Выборка.Ссылка);
		КонецЦикла;
	КонецЕсли;
	
	Возврат СписокОтбора;
	
КонецФункции

&НаКлиенте
Процедура ПараметрПроектыНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	ПараметрПроекты.ТипЗначения = Новый ОписаниеТипов("СправочникСсылка.Проекты");
КонецПроцедуры
