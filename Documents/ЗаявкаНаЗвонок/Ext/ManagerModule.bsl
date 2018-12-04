﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// Определяет настройки объекта для подсистемы ВерсионированиеОбъектов.
//
// Параметры:
// Настройки - Структура - настройки подсистемы.
Процедура ПриОпределенииНастроекВерсионированияОбъектов(Настройки) Экспорт
	
	//Позволяет скрыть служебные реквизиты
	//Настройки.ПриПолученииСлужебныхРеквизитов = Истина;
	
КонецПроцедуры

// Ограничивает видимость реквизитов объекта в отчете по версии.
//
// Параметры:
// Реквизиты - Массив - список имен реквизитов объекта.
//Процедура ПриПолученииСлужебныхРеквизитов(Реквизиты) Экспорт
//    Реквизиты.Добавить("ИмяРеквизита"); // реквизит объекта
//    Реквизиты.Добавить("ИмяТабличнойЧасти.*"); // табличная часть объекта
//КонецПроцедуры

// СтандартныеПодсистемы.ГрупповоеИзменениеОбъектов

// Возвращает реквизиты объекта, которые разрешается редактировать
// с помощью обработки группового изменения реквизитов.
//
// Возвращаемое значение:
//  Массив - список имен реквизитов объекта.
Функция РеквизитыРедактируемыеВГрупповойОбработке() Экспорт
	
	Результат = Новый Массив;
	Результат.Добавить("Автор");
	Результат.Добавить("Ответственный");
	Результат.Добавить("Контакт");
	
	Возврат Результат;
	
КонецФункции

// Конец СтандартныеПодсистемы.ГрупповоеИзменениеОбъектов

// СтандартныеПодсистемы.Взаимодействия

// Получает абонента телефонного звонка.
//
// Параметры:
//  Ссылка  - ДокументСсылка.ЗаявкаНаЗвонок - документ, абонента которого необходимо получить.
//
// Возвращаемое значение:
//   ТаблицаЗначений   - таблица, содержащая колонки "Контакт", "Представление" и "Адрес".
//
Функция ПолучитьКонтакты(Ссылка) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ЗаявкаНаЗвонок.Контакт КАК Контакт,
	|	ЗаявкаНаЗвонок.reqContact КАК Адрес,
	|	ЗаявкаНаЗвонок.reqContact КАК Представление
	|ИЗ
	|	Документ.ЗаявкаНаЗвонок КАК ЗаявкаНаЗвонок
	|ГДЕ
	|	ЗаявкаНаЗвонок.Ссылка = &Ссылка";
	
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	Выборка = Запрос.Выполнить().Выбрать();
	
	Если Выборка.Следующий() Тогда
		Возврат Взаимодействия.ПолучитьУчастникаПоПолям(Выборка.Контакт, Выборка.Адрес, Выборка.Представление);
	Иначе
		Возврат Неопределено;
	КонецЕсли;
	
КонецФункции

// Конец СтандартныеПодсистемы.Взаимодействия

#КонецОбласти

#КонецОбласти

#КонецЕсли

#Область ОбработчикиСобытий

Процедура ОбработкаПолученияДанныхВыбора(ДанныеВыбора, Параметры, СтандартнаяОбработка)
	
КонецПроцедуры

#КонецОбласти
