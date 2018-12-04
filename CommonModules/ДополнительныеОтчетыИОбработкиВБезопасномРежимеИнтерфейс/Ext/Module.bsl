﻿#Область ПрограммныйИнтерфейс

#Область УстаревшиеПроцедурыИФункции

// Устарела. Будет удалена в следующей редакции библиотеки.
// Возвращает пространство имен текущей (используемой вызывающим кодом) версии интерфейса сообщений.
//
// Возвращаемое значение:
//   Строка - пространство имен текущей.
//
Функция Пакет() Экспорт
	
	Возврат "http://www.1c.ru/1cFresh/ApplicationExtensions/Permissions/" + Версия();
	
КонецФункции

// Устарела. Будет удалена в следующей редакции библиотеки.
// Возвращает текущую (используемую вызывающим кодом) версию интерфейса сообщений.
//
// Возвращаемое значение:
//   Строка - версия.
//
Функция Версия() Экспорт
	
	Возврат "1.0.0.1";
	
КонецФункции

// Устарела. Будет удалена в следующей редакции библиотеки.
// Возвращает название программного интерфейса сообщений.
//
// Возвращаемое значение:
//   Строка - идентификатор программного интерфейса.
//
Функция ПрограммныйИнтерфейс() Экспорт
	
	Возврат "ApplicationExtensionsPermissions";
	
КонецФункции

// Устарела. Будет удалена в следующей редакции библиотеки.
// Выполняет регистрацию поддерживаемых версий интерфейса сообщений.
//
// Параметры:
//  СтруктураПоддерживаемыхВерсий - Структура - в качестве ключа передается название программного интерфейса,
//    а в качестве значения массив поддерживаемых версий.
//
Процедура ЗарегистрироватьИнтерфейс(Знач СтруктураПоддерживаемыхВерсий) Экспорт
	
	МассивВерсий = Новый Массив;
	МассивВерсий.Добавить("1.0.0.1");
	СтруктураПоддерживаемыхВерсий.Вставить(ПрограммныйИнтерфейс(), МассивВерсий);
	
КонецПроцедуры

// Устарела. Будет удалена в следующей редакции библиотеки.
// Выполняет регистрацию обработчиков сообщений в качестве обработчиков каналов обмена сообщениями.
//
// Параметры:
//  МассивОбработчиков - Массив - массив обработчиков.
//
Процедура ОбработчикиКаналовСообщений(Знач МассивОбработчиков) Экспорт
	
КонецПроцедуры

// Устарела. Будет удалена в следующей редакции библиотеки.
// Возвращает идентификатор вида действия, соответствующего вызову метода конфигурации.
//
// Возвращаемое значение:
//   Строка - идентификатор вида действия.
//
Функция ВидДействияВызовМетодаКонфигурации() Экспорт
	
	Возврат "МетодКонфигурации"; // Не локализуется
	
КонецФункции

// Устарела. Будет удалена в следующей редакции библиотеки.
// Возвращает идентификатор вида действия, соответствующего вызову метода обработки.
//
// Возвращаемое значение:
//   Строка - идентификатор вида действия.
//
Функция ВидДействияВызовМетодаОбработки() Экспорт
	
	Возврат "МетодОбработки"; // Не локализуется
	
КонецФункции

// Устарела. Будет удалена в следующей редакции библиотеки.
// Возвращает идентификатор вида параметра, соответствующему ключу запуска.
//
// Возвращаемое значение:
//   Строка - вида параметра.
//
Функция ВидПараметраКлючСессии() Экспорт
	
	Возврат "КлючСессии"; // Не локализуется
	
КонецФункции

// Устарела. Будет удалена в следующей редакции библиотеки.
// Возвращает идентификатор вида параметра, соответствующему фиксированному значению.
//
// Возвращаемое значение:
//   Строка - идентификатор вида параметра.
//
Функция ВидПараметраЗначение() Экспорт
	
	Возврат "ФиксированноеЗначение"; // Не локализуется
	
КонецФункции

// Устарела. Будет удалена в следующей редакции библиотеки.
// Возвращает идентификатор вида параметра, соответствующему сохраняемому значению.
//
// Возвращаемое значение:
//   Строка - идентификатор вида действия.
//
Функция ВидПараметраСохраняемоеЗначение() Экспорт
	
	Возврат "СохраняемоеЗначение"; // Не локализуется
	
КонецФункции

// Устарела. Будет удалена в следующей редакции библиотеки.
// Возвращает идентификатор вида параметра, соответствующему коллекции сохраняемых значений.
//
// Возвращаемое значение:
//   Строка - идентификатор вида действия.
//
Функция ВидПараметраКоллекцияСохраняемыхЗначений() Экспорт
	
	Возврат "КоллекцияСохраняемыхЗначений"; // Не локализуется
	
КонецФункции

// Устарела. Будет удалена в следующей редакции библиотеки.
// Возвращает идентификатор вида параметра, соответствующему параметру выполнения команды.
//
// Возвращаемое значение:
//   Строка - идентификатор вида действия.
//
Функция ВидПараметраПараметрВыполненияКоманды() Экспорт
	
	Возврат "ПараметрВыполненияКоманды"; // Не локализуется
	
КонецФункции

// Устарела. Будет удалена в следующей редакции библиотеки.
// Возвращает идентификатор вида параметра, соответствующему коллекции объектов назначения.
//
// Возвращаемое значение:
//   Строка - идентификатор вида действия.
//
Функция ВидПараметраОбъектыНазначения() Экспорт
	
	Возврат "ОбъектыНазначения"; // Не локализуется
	
КонецФункции

// Устарела. Будет удалена в следующей редакции библиотеки.
// Конструктор пустой таблицы значений, которая используется в качестве описания сценария,
// выполняемого в безопасном режиме.
//
// Возвращаемое значение:
//   ТаблицаЗначений - таблица с колонками:
//     * ВидДействия - Строка - идентификатор вида действия,
//     * ИмяМетода - Строка - идентификатор имени метода,
//     * Параметры - ТаблицаЗначений - таблица параметров,
//     * СохранениеРезультата - Строка - сохранение результата.
//
Функция НовыйСценарий() Экспорт
	
	Результат = Новый ТаблицаЗначений();
	Результат.Колонки.Добавить("ВидДействия", Новый ОписаниеТипов("Строка"));
	Результат.Колонки.Добавить("ИмяМетода", Новый ОписаниеТипов("Строка"));
	Результат.Колонки.Добавить("Параметры", Новый ОписаниеТипов("ТаблицаЗначений"));
	Результат.Колонки.Добавить("СохранениеРезультата", Новый ОписаниеТипов("Строка"));
	
	Возврат Результат;
	
КонецФункции

// Устарела. Будет удалена в следующей редакции библиотеки.
// Добавляет в сценарий выполнения обработки в безопасном режиме этап сценария, содержащий
// выполнение метода конфигурации.
//
// Параметры:
//  Сценарий - ТаблицаЗначений - см. НовыйСценарий,
//  ИмяМетода - Строка - имя метода конфигурации, вызов которого предполагается на этапе выполнения
//    этапа сценария,
//  СохранениеРезультата - Строка - имя сохраняемого значения сценария, в котором будет сохранен
//    результат выполнения метода, переданного в качестве значения параметра ИмяМетода.
//
// Возвращаемое значение:
//   СтрокаТаблицыЗначений - см. НовыйСценарий.
//
Функция ДобавитьМетодКонфигурации(Сценарий, Знач ИмяМетода, Знач СохранениеРезультата = "") Экспорт
	
	Возврат ДобавитьЭтап(Сценарий, ВидДействияВызовМетодаКонфигурации(), ИмяМетода, СохранениеРезультата);
	
КонецФункции

// Устарела. Будет удалена в следующей редакции библиотеки.
// Добавляет в сценарий выполнения обработки в безопасном режиме этап сценария, содержащий
// выполнение метода обработки.
//
// Параметры:
//  Сценарий - ТаблицаЗначений - см. НовыйСценарий,
//  ИмяМетода - Строка - имя метода конфигурации, вызов которого предполагается на этапе выполнения
//    этапа сценария,
//  СохранениеРезультата - Строка - имя сохраняемого значения сценария, в котором будет сохранен
//    результат выполнения метода, переданного в качестве значения параметра ИмяМетода.
//
// Возвращаемое значение:
//   СтрокаТаблицыЗначений - см. НовыйСценарий.
//
Функция ДобавитьМетодОбработки(Сценарий, Знач ИмяМетода, Знач СохранениеРезультата = "") Экспорт
	
	Возврат ДобавитьЭтап(Сценарий, ВидДействияВызовМетодаОбработки(), ИмяМетода, СохранениеРезультата);
	
КонецФункции

// Устарела. Будет удалена в следующей редакции библиотеки.
// Конструктор пустой таблицы значений, которая используется в качестве описания
// параметров элементов сценария, выполняемого в безопасном режиме.
//
// Возвращаемое значение:
//   ТаблицаЗначений - таблица с колонками:
//     * Вид - Строка - вид параметра,
//     * Значение - Произвольный - значение параметра.
//
Функция НоваяТаблицаПараметров() Экспорт
	
	Результат = Новый ТаблицаЗначений();
	Результат.Колонки.Добавить("Вид", Новый ОписаниеТипов("Строка"));
	Результат.Колонки.Добавить("Значение");
	
	Возврат Результат;
	
КонецФункции

// Устарела. Будет удалена в следующей редакции библиотеки.
// Добавляет в таблицу параметров ключ запуска текущей обработки.
//
// Параметры:
//  Этап - СтрокаТаблицыЗначений - см. ДобавитьМетодКонфигурации или см.ДобавитьМетодОбработки.
//
Процедура ДобавитьКлючСессии(Этап) Экспорт
	
	ДобавитьПараметр(Этап, ВидПараметраКлючСессии());
	
КонецПроцедуры

// Устарела. Будет удалена в следующей редакции библиотеки.
// Добавляет в таблицу параметров фиксированное значение.
//
// Параметры:
//  Этап - СтрокаТаблицыЗначений - см. ДобавитьМетодКонфигурации или см. ДобавитьМетодОбработки,
//  Значение - Произвольный - фиксированное значение.
//
Процедура ДобавитьЗначение(Этап, Знач Значение) Экспорт
	
	ДобавитьПараметр(Этап, ВидПараметраЗначение(), Значение);
	
КонецПроцедуры

// Устарела. Будет удалена в следующей редакции библиотеки.
// Добавляет в таблицу параметров фиксированное значение.
//
// Параметры:
//  Этап - СтрокаТаблицыЗначений - см. ДобавитьМетодКонфигурации или см. ДобавитьМетодОбработки,
//  СохраняемоеЗначение - Строка - имя переменной сохраняемого значения внутри сценария.
//
Процедура ДобавитьСохраняемоеЗначение(Этап, Знач СохраняемоеЗначение) Экспорт
	
	ДобавитьПараметр(Этап, ВидПараметраСохраняемоеЗначение(), СохраняемоеЗначение);
	
КонецПроцедуры

// Устарела. Будет удалена в следующей редакции библиотеки.
// Добавляет в таблицу параметров коллекцию сохраняемых значений.
//
// Параметры:
//  Этап - СтрокаТаблицыЗначений - см. ДобавитьМетодКонфигурации или см. ДобавитьМетодОбработки.
//
Процедура ДобавитьКоллекциюСохраняемыхЗначений(Этап) Экспорт
	
	ДобавитьПараметр(Этап, ВидПараметраКоллекцияСохраняемыхЗначений());
	
КонецПроцедуры

// Устарела. Будет удалена в следующей редакции библиотеки.
// Добавляет в таблицу параметров параметр выполнения команды.
//
// Параметры:
//  Этап - СтрокаТаблицыЗначений - см. ДобавитьМетодКонфигурации или см. ДобавитьМетодОбработки,
//  ИмяПараметра - Строка - имя параметра выполнения команды.
//
Процедура ДобавитьПараметрВыполненияКоманды(Этап, Знач ИмяПараметра) Экспорт
	
	ДобавитьПараметр(Этап, ВидПараметраПараметрВыполненияКоманды(), ИмяПараметра);
	
КонецПроцедуры

// Устарела. Будет удалена в следующей редакции библиотеки.
// Добавляет в таблицу параметров коллекцию объектов назначения.
//
// Параметры:
//  Этап - СтрокаТаблицыЗначений- см. ДобавитьМетодКонфигурации или см. ДобавитьМетодОбработки.
//
Процедура ДобавитьОбъектыНазначения(Этап) Экспорт
	
	ДобавитьПараметр(Этап, ВидПараметраОбъектыНазначения());
	
КонецПроцедуры

// Устарела. Будет удалена в следующей редакции библиотеки.
// Возвращает тип {http://www.1c.ru/1cFresh/ApplicationExtensions/Core/a.b.c.d}CreateComObject
//
// Параметры:
//  ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой
//    получается тип сообщения.
//
// Возвращаемое значение:
//  ТипXDTO - тип сообщения.
//
Функция ТипСозданиеCOMОбъекта(Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Возврат СоздатьТипСообщения(ИспользуемыйПакет, "CreateComObject");
	
КонецФункции

// Устарела. Будет удалена в следующей редакции библиотеки.
// Возвращает объект {http://www.1c.ru/1cFresh/ApplicationExtensions/Core/a.b.c.d}CreateComObject
//
// Параметры:
//  ProgId - Строка - ProgID класса COM, с которым он зарегистрирован в системе.
//    Например, "Excel.Application".
//  ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой
//    получается тип сообщения.
//
// Возвращаемое значение:
//  ОбъектXDTO - разрешение.
//
Функция РазрешениеСозданиеCOMОбъекта(Знач ProgId, Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Тип = ТипСозданиеCOMОбъекта(ИспользуемыйПакет);
	Разрешение = ФабрикаXDTO.Создать(Тип);
	Разрешение.ProgId = ProgId;
	
	Возврат Разрешение;
	
КонецФункции

// Устарела. Будет удалена в следующей редакции библиотеки.
// Возвращает тип {http://www.1c.ru/1cFresh/ApplicationExtensions/Core/a.b.c.d}AttachAddin
//
// Параметры:
//  ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой
//    получается тип сообщения.
//
// Возвращаемое значение:
//  ТипXDTO - тип сообщения.
//
Функция ТипПодключениеВнешнейКомпоненты(Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Возврат СоздатьТипСообщения(ИспользуемыйПакет, "AttachAddin");
	
КонецФункции

// Устарела. Будет удалена в следующей редакции библиотеки.
// Возвращает объект {http://www.1c.ru/1cFresh/ApplicationExtensions/Core/a.b.c.d}AttachAddin
//
// Параметры:
//  ИмяОбщегоМакета - Строка - имя общего макета,
//  ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой
//    получается тип сообщения.
//
// Возвращаемое значение:
//  ОбъектXDTO - разрешение.
//
Функция РазрешениеПодключениеВнешнейКомпонентыИзОбщегоМакетаКонфигурации(Знач ИмяОбщегоМакета, Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Тип = ТипПодключениеВнешнейКомпоненты(ИспользуемыйПакет);
	Разрешение = ФабрикаXDTO.Создать(Тип);
	Разрешение.TemplateName = "ОбщийМакет." + ИмяОбщегоМакета;
	
	Возврат Разрешение;
	
КонецФункции

// Устарела. Будет удалена в следующей редакции библиотеки.
// Возвращает объект {http://www.1c.ru/1cFresh/ApplicationExtensions/Core/a.b.c.d}AttachAddin
//
// Параметры:
//  ОбъектМетаданных - ОбъектМетаданных - объект метаданных,
//  ИмяМакета - Строка - имя макета,
//  ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой
//    получается тип сообщения.
//
// Возвращаемое значение:
//  ОбъектXDTO - разрешение.
//
Функция РазрешениеПодключениеВнешнейКомпонентыИзМакетаКонфигурации(Знач ОбъектМетаданных, Знач ИмяМакета, Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Тип = ТипПодключениеВнешнейКомпоненты(ИспользуемыйПакет);
	Разрешение = ФабрикаXDTO.Создать(Тип);
	Разрешение.TemplateName = ОбъектМетаданных.ПолноеИмя() + ".Макет" + ИмяМакета;
	
	Возврат Разрешение;
	
КонецФункции

// Устарела. Будет удалена в следующей редакции библиотеки.
// Возвращает тип {http://www.1c.ru/1cFresh/ApplicationExtensions/Core/a.b.c.d}GetFileFromExternalSoftware
//
// Параметры:
//  ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой
//    получается тип сообщения.
//
// Возвращаемое значение:
//  ТипXDTO - тип сообщения.
//
Функция ТипПолучениеФайлаИзВнешнегоОбъекта(Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Возврат СоздатьТипСообщения(ИспользуемыйПакет, "GetFileFromExternalSoftware");
	
КонецФункции

// Устарела. Будет удалена в следующей редакции библиотеки.
// Возвращает объект {http://www.1c.ru/1cFresh/ApplicationExtensions/Core/a.b.c.d}GetFileFromExternalSoftware
//
// Параметры:
//  ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой
//    получается тип сообщения.
//
// Возвращаемое значение:
//  ОбъектXDTO - разрешение.
//
Функция РазрешениеПолучениеФайлаИзВнешнегоОбъекта(Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Тип = ТипПолучениеФайлаИзВнешнегоОбъекта(ИспользуемыйПакет);
	Разрешение = ФабрикаXDTO.Создать(Тип);
	
	Возврат Разрешение;
	
КонецФункции

// Устарела. Будет удалена в следующей редакции библиотеки.
// Возвращает тип {http://www.1c.ru/1cFresh/ApplicationExtensions/Core/a.b.c.d}SendFileToExternalSoftware
//
// Параметры:
//  ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой
//    получается тип сообщения.
//
// Возвращаемое значение:
//  ТипXDTO - тип сообщения.
//
Функция ТипПередачаФайлаВоВнешнийОбъект(Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Возврат СоздатьТипСообщения(ИспользуемыйПакет, "SendFileToExternalSoftware");
	
КонецФункции

// Устарела. Будет удалена в следующей редакции библиотеки.
// Возвращает объект {http://www.1c.ru/1cFresh/ApplicationExtensions/Core/a.b.c.d}SendFileToExternalSoftware
//
// Параметры:
//  ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой
//    получается тип сообщения.
//
// Возвращаемое значение:
//  ОбъектXDTO - разрешение.
//
Функция РазрешениеПередачаФайлаВоВнешнийОбъект(Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Тип = ТипПередачаФайлаВоВнешнийОбъект(ИспользуемыйПакет);
	Разрешение = ФабрикаXDTO.Создать(Тип);
	
	Возврат Разрешение;
	
КонецФункции

// Устарела. Будет удалена в следующей редакции библиотеки.
// Возвращает тип {http://www.1c.ru/1cFresh/ApplicationExtensions/Core/a.b.c.d}GetFileFromInternet
//
// Параметры:
//  ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой
//    получается тип сообщения.
//
// Возвращаемое значение:
//  ТипXDTO- тип сообщения.
//
Функция ТипПолучениеДанныхИзИнтернет(Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Возврат СоздатьТипСообщения(ИспользуемыйПакет, "GetFileFromInternet");
	
КонецФункции

// Устарела. Будет удалена в следующей редакции библиотеки.
// Возвращает объект {http://www.1c.ru/1cFresh/ApplicationExtensions/Core/a.b.c.d}GetFileFromInternet
//
// Параметры:
//  Протокол - Строка - протокол,
//  Сервер - Строка - сервер,
//  Порт - Строка - порт,
//  ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой
//    получается тип сообщения.
//
// Возвращаемое значение:
//  ОбъектXDTO - разрешение.
//
Функция РазрешениеПолучениеДанныхИзИнтернет(Знач Протокол, Знач Сервер, Знач Порт, Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Тип = ТипПолучениеДанныхИзИнтернет(ИспользуемыйПакет);
	Разрешение = ФабрикаXDTO.Создать(Тип);
	Разрешение.Protocol = ВРег(Протокол);
	Разрешение.Host = Сервер;
	Разрешение.Port = Порт;
	
	Возврат Разрешение;
	
КонецФункции

// Устарела. Будет удалена в следующей редакции библиотеки.
// Возвращает тип {http://www.1c.ru/1cFresh/ApplicationExtensions/Core/a.b.c.d}SendFileToInternet
//
// Параметры:
//  ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой
//    получается тип сообщения.
//
// Возвращаемое значение:
//  ТипXDTO - тип сообщения.
//
Функция ТипПередачаДанныхВИнтернет(Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Возврат СоздатьТипСообщения(ИспользуемыйПакет, "SendFileToInternet");
	
КонецФункции

// Устарела. Будет удалена в следующей редакции библиотеки.
// Возвращает объект {http://www.1c.ru/1cFresh/ApplicationExtensions/Core/a.b.c.d}SendFileToInternet
//
// Параметры:
//  Протокол - Строка- используемый протокол передачи данных,
//  Сервер - Строка - сервер,
//  Порт - Строка - порт,
//  ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой
//    получается тип сообщения.
//
// Возвращаемое значение:
//  ОбъектXDTO - разрешение.
//
Функция РазрешениеПередачаДанныхВИнтернет(Знач Протокол, Знач Сервер, Знач Порт, Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Тип = ТипПередачаДанныхВИнтернет(ИспользуемыйПакет);
	Разрешение = ФабрикаXDTO.Создать(Тип);
	Разрешение.Protocol = ВРег(Протокол);
	Разрешение.Host = Сервер;
	Разрешение.Port = Порт;
	
	Возврат Разрешение;
	
КонецФункции

// Устарела. Будет удалена в следующей редакции библиотеки.
// Возвращает тип {http://www.1c.ru/1cFresh/ApplicationExtensions/Core/a.b.c.d}SoapConnect
//
// Параметры:
//  ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой
//    получается тип сообщения.
//
// Возвращаемое значение:
//  ТипXDTO - тип сообщения.
//
Функция ТипWSСоединение(Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Возврат СоздатьТипСообщения(ИспользуемыйПакет, "SoapConnect");
	
КонецФункции

// Устарела. Будет удалена в следующей редакции библиотеки.
// Возвращает объект {http://www.1c.ru/1cFresh/ApplicationExtensions/Core/a.b.c.d}SoapConnect
//
// Параметры:
//  АдресWSDL - Строка  - адрес публикации WSDL,
//  ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой
//    получается тип сообщения.
//
// Возвращаемое значение:
//  ОбъектXDTO - разрешение.
//
Функция РазрешениеWSСоединение(Знач АдресWSDL, Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Тип = ТипWSСоединение(ИспользуемыйПакет);
	Разрешение = ФабрикаXDTO.Создать(Тип);
	Разрешение.WsdlDestination = АдресWSDL;
	
	Возврат Разрешение;
	
КонецФункции

// Устарела. Будет удалена в следующей редакции библиотеки.
// Возвращает тип {http://www.1c.ru/1cFresh/ApplicationExtensions/Core/a.b.c.d}DocumentPosting
//
// Параметры:
//  ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой
//    получается тип сообщения.
//
// Возвращаемое значение:
//  ТипXDTO - тип сообщения.
//
Функция ТипПроведениеДокументов(Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Возврат СоздатьТипСообщения(ИспользуемыйПакет, "DocumentPosting");
	
КонецФункции

// Устарела. Будет удалена в следующей редакции библиотеки.
// Возвращает объект {http://www.1c.ru/1cFresh/ApplicationExtensions/Core/a.b.c.d}DocumentPosting
//
// Параметры:
//  ОбъектМетаданных - ОбъектМетаданных - объект метаданных,
//  РежимЗаписи - РежимЗаписиДокумента - режим записи документа,
//  ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой
//    получается тип сообщения.
//
// Возвращаемое значение:
//  ОбъектXDTO - разрешение.
//
Функция РазрешениеПроведениеДокументов(Знач ОбъектМетаданных, Знач РежимЗаписи, Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Тип = ТипПроведениеДокументов(ИспользуемыйПакет);
	Разрешение = ФабрикаXDTO.Создать(Тип);
	Разрешение.DocumentType = ОбъектМетаданных.ПолноеИмя();
	Если РежимЗаписи = РежимЗаписиДокумента.Проведение Тогда
		Разрешение.Action = "Posting";
	Иначе
		Разрешение.Action = "UndoPosting";
	КонецЕсли;
	
	Возврат Разрешение;
	
КонецФункции

// Устарела. Будет удалена в следующей редакции библиотеки.
// Возвращает тип {http://www.1c.ru/1cFresh/ApplicationExtensions/Core/a.b.c.d}InternalFileHandler
//
// Параметры:
//  ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой
//    получается тип сообщения.
//
// Возвращаемое значение:
//  ТипXDTO - тип сообщения.
//
Функция ПараметрПередаваемыйФайл(Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Возврат СоздатьТипСообщения(ИспользуемыйПакет, "InternalFileHandler");
	
КонецФункции

// Устарела. Будет удалена в следующей редакции библиотеки.
// Возвращает значение, соответствующее любому значению ограничителя (*) при
// регистрации разрешений, запрашиваемых дополнительной обработкой.
//
// Возвращаемое значение:
//  Неопределено - любое значение.
//
Функция ЛюбоеЗначение() Экспорт
	
	Возврат Неопределено;
	
КонецФункции

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция СоздатьТипСообщения(Знач ИспользуемыйПакет, Знач Тип)
		
	Если ИспользуемыйПакет = Неопределено Тогда
		ИспользуемыйПакет = Пакет();
	КонецЕсли;
	
	Возврат ФабрикаXDTO.Тип(ИспользуемыйПакет, Тип);
	
КонецФункции

Функция ДобавитьЭтап(Сценарий, Знач ВидЭтапа, Знач ИмяМетода, Знач СохранениеРезультата = "")
	
	Этап = Сценарий.Добавить();
	Этап.ВидДействия = ВидЭтапа;
	Этап.ИмяМетода = ИмяМетода;
	Этап.Параметры = НоваяТаблицаПараметров();
	Если Не ПустаяСтрока(СохранениеРезультата) Тогда
		Этап.СохранениеРезультата = СохранениеРезультата;
	КонецЕсли;
	
	Возврат Этап;
	
КонецФункции

Процедура ДобавитьПараметр(Этап, Знач ВидПараметра, Знач Значение = Неопределено)
	
	Параметр = Этап.Параметры.Добавить();
	Параметр.Вид = ВидПараметра;
	Если Значение <> Неопределено Тогда
		Параметр.Значение = Значение;
	КонецЕсли;
	
КонецПроцедуры

// Преобразовывает разрешения из формата 2.1.3 в формат 2.2.2.
//
Функция ПреобразоватьРазрешенияВерсии_2_1_3_ВРазрешенияВерсии_2_2_2(Знач ДополнительныйОтчетИлиОбработка, Знач Разрешения) Экспорт
	
	Результат = Новый Массив();
	
	// Если у обработки есть команды, которые являются сценарием - добавляем права на работу с каталогом временных
	// файлов.
	
	МодульРаботаВБезопасномРежиме = ОбщегоНазначения.ОбщийМодуль("РаботаВБезопасномРежиме");
	
	ОтборСценариев = Новый Структура("ВариантЗапуска", Перечисления.СпособыВызоваДополнительныхОбработок.СценарийВБезопасномРежиме);
	ЕстьСценарии = ДополнительныйОтчетИлиОбработка.Команды.НайтиСтроки(ОтборСценариев).Количество() > 0;
	Если ЕстьСценарии Тогда
		Результат.Добавить(МодульРаботаВБезопасномРежиме.РазрешениеНаИспользованиеКаталогаВременныхФайлов(Истина, Истина));
	КонецЕсли;
	
	// Преобразуем разрешения в нотации "расширения" безопасного режима.
	Для Каждого Разрешение Из Разрешения Цикл
		
		Если Разрешение.Тип() = ТипПолучениеДанныхИзИнтернет(Пакет()) Тогда
			
			Результат.Добавить(
				МодульРаботаВБезопасномРежиме.РазрешениеНаИспользованиеИнтернетРесурса(
					Разрешение.Protocol,
					Разрешение.Host,
					Разрешение.Port));
			
		ИначеЕсли Разрешение.Тип() = ТипПередачаДанныхВИнтернет(Пакет()) Тогда
			
			Результат.Добавить(
				МодульРаботаВБезопасномРежиме.РазрешениеНаИспользованиеИнтернетРесурса(
					Разрешение.Protocol,
					Разрешение.Host,
					Разрешение.Port));
			
		ИначеЕсли Разрешение.Тип() = ТипWSСоединение(Пакет()) Тогда
			
			СтруктураURI = ОбщегоНазначенияКлиентСервер.СтруктураURI(Разрешение.WsdlDestination);
			
			Результат.Добавить(
				МодульРаботаВБезопасномРежиме.РазрешениеНаИспользованиеИнтернетРесурса(
					СтруктураURI.Схема,
					СтруктураURI.ИмяСервера,
					СтруктураURI.Порт));
			
		ИначеЕсли Разрешение.Тип() = ТипСозданиеCOMОбъекта(Пакет()) Тогда
			
			Результат.Добавить(
				МодульРаботаВБезопасномРежиме.РазрешениеНаСозданиеCOMКласса(
					Разрешение.ProgId,
					ИдентификаторCOMКлассаВРежимеОбратнойСовместимости(Разрешение.ProgId)));
			
		ИначеЕсли Разрешение.Тип() = ТипПодключениеВнешнейКомпоненты(Пакет()) Тогда
			
			Результат.Добавить(
				МодульРаботаВБезопасномРежиме.РазрешениеНаИспользованиеВнешнейКомпоненты(
					Разрешение.TemplateName));
			
		ИначеЕсли Разрешение.Тип() = ТипПолучениеФайлаИзВнешнегоОбъекта(Пакет()) Тогда
			
			Результат.Добавить(
				МодульРаботаВБезопасномРежиме.РазрешениеНаИспользованиеКаталогаВременныхФайлов(Истина, Истина));
			
		ИначеЕсли Разрешение.Тип() = ТипПередачаФайлаВоВнешнийОбъект(Пакет()) Тогда
			
			Результат.Добавить(
				МодульРаботаВБезопасномРежиме.РазрешениеНаИспользованиеКаталогаВременныхФайлов(Истина, Истина));
			
		ИначеЕсли Разрешение.Тип() = ТипПроведениеДокументов(Пакет()) Тогда
			
			Результат.Добавить(МодульРаботаВБезопасномРежиме.РазрешениеНаИспользованиеПривилегированногоРежима());
			
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

Функция ИдентификаторCOMКлассаВРежимеОбратнойСовместимости(Знач ProgId)
	
	ПоддерживаемыеИдентификаторы = ИдентификаторыCOMКлассовВРежимеОбратнойСовместимости();
	CLSID = ПоддерживаемыеИдентификаторы.Получить(ProgId);
	
	Если CLSID = Неопределено Тогда
		
		ВызватьИсключение СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = 'Разрешение на использование COM-класса ""%1"" не может быть предоставлено дополнительной обработке,
				|работающей в режиме обратной совместимости с механизмом разрешений, реализованным в версии БСП 2.1.3.
				|Для использования COM-класса требуется переработать дополнительную обработку для работы без режима обратной совместимости.'"),
			ProgId);
		
	Иначе
		
		Возврат CLSID;
		
	КонецЕсли;
	
КонецФункции

Функция ИдентификаторыCOMКлассовВРежимеОбратнойСовместимости()
	
	Результат = Новый Соответствие();
	
	// V83.ComConnector
	Результат.Вставить(ОбщегоНазначенияКлиентСервер.ИмяCOMСоединителя(), ОбщегоНазначения.ИдентификаторCOMСоединителя(ОбщегоНазначенияКлиентСервер.ИмяCOMСоединителя()));
	// Word.Application
	Результат.Вставить("Word.Application", "000209FF-0000-0000-C000-000000000046");
	// Excel.Application
	Результат.Вставить("Excel.Application", "00024500-0000-0000-C000-000000000046");
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти
