﻿#Область ПрограммныйИнтерфейс

#Область УстаревшиеПроцедурыИФункции

// Устарела. Будет удалена в следующей редакции библиотеки.
// Возвращает массив методов, которые могут быть выполнены расширением безопасного
// режима.
//
// Возвращаемое значение:
//   Массив - массив строк, в которых хранятся разрешенные методы.
//
Функция ПолучитьРазрешенныеМетоды() Экспорт
	
	Результат = Новый Массив();
	
	Возврат Новый ФиксированныйМассив(Результат);
	
КонецФункции

// Устарела. Будет удалена в следующей редакции библиотеки.
// Возвращает словарь синонимов видов разрешений дополнительных отчетов и обработок
// и их параметров (для отображения в пользовательском интерфейсе).
//
// Возвращаемое значение:
//  ФиксированноеСоответствие - ключи:
//    * Ключ - ТипXDTO - соответствующий виду разрешения,
//    * Значение - Структура - ключи:
//        * Представление - Строка - краткое представление вида разрешения,
//        * Описание - Строка - подробное описание вида разрешения,
//        * Параметры - ТаблицаЗначений - колонки:
//            * Имя - Строка - имя свойства, определенного для ТипаXDTO,
//            * Описание - Строка - описание последствий параметра разрешения для указанного значения параметра,
//        * ОписаниеЛюбогоЗначения - Строка - описание последствий параметра разрешения для неуказанного значения параметра.
//
Функция Словарь() Экспорт
	
	Результат = Новый Соответствие();
	
	// {http://www.1c.ru/1cFresh/ApplicationExtensions/Permissions/a.b.c.d}GetFileFromInternet
	
	Представление = НСтр("ru = 'Получение данных из сети Интернет'");
	Описание = НСтр("ru = 'Дополнительному отчету или обработке будет разрешено получать данные из сети Интернет'");
	
	Параметры = ТаблицаПараметров();
	ДобавитьПараметр(Параметры, "Host", НСтр("ru = 'с сервера %1'"), НСтр("ru = 'с любого сервера'"));
	ДобавитьПараметр(Параметры, "Protocol", НСтр("ru = 'по протоколу %1'"), НСтр("ru = 'по любому протоколу'"));
	ДобавитьПараметр(Параметры, "Port", НСтр("ru = 'через порт %1'"), НСтр("ru = 'через любой порт'"));
	
	Значение = Новый Структура;
	Значение.Вставить("Представление", Представление);
	Значение.Вставить("Описание", Описание);
	Значение.Вставить("Параметры", Параметры);
	
	Результат.Вставить(
		ДополнительныеОтчетыИОбработкиВБезопасномРежимеИнтерфейс.ТипПолучениеДанныхИзИнтернет(),
		Значение);
	
	// Конец {http://www.1c.ru/1cFresh/ApplicationExtensions/Permissions/a.b.c.d}GetFileFromInternet
	
	// {http://www.1c.ru/1cFresh/ApplicationExtensions/Permissions/a.b.c.d}SendFileToInternet
	
	Представление = НСтр("ru = 'Передача данных в сеть Интернет'");
	Описание = НСтр("ru = 'Дополнительному отчету или обработке будет разрешено отправлять данные в сеть Интернет'");
	Последствия = НСтр("ru = 'Внимание! Отправка данных потенциально может использоваться дополнительным
                        |отчетом или обработкой для совершения действий, не предполагаемых администратором
                        |информационной базы.
                        |
                        |Используйте данный дополнительный отчет или обработку только в том случае, если доверяете
                        |ее разработчику и контролируйте ограничения (сервер, протокол и порт), накладываемые на
                        |выданные разрешения.'");
	
	Параметры = ТаблицаПараметров();
	ДобавитьПараметр(Параметры, "Host", НСтр("ru = 'на сервер %1'"), НСтр("ru = 'на любой сервера'"));
	ДобавитьПараметр(Параметры, "Protocol", НСтр("ru = 'по протоколу %1'"), НСтр("ru = 'по любому протоколу'"));
	ДобавитьПараметр(Параметры, "Port", НСтр("ru = 'через порт %1'"), НСтр("ru = 'через любой порт'"));
	
	Значение = Новый Структура;
	Значение.Вставить("Представление", Представление);
	Значение.Вставить("Описание", Описание);
	Значение.Вставить("Последствия", Последствия);
	Значение.Вставить("Параметры", Параметры);
	
	Результат.Вставить(
		ДополнительныеОтчетыИОбработкиВБезопасномРежимеИнтерфейс.ТипПередачаДанныхВИнтернет(),
		Значение);
	
	// Конец {http://www.1c.ru/1cFresh/ApplicationExtensions/Permissions/a.b.c.d}SendFileToInternet
	
	// {http://www.1c.ru/1cFresh/ApplicationExtensions/Permissions/a.b.c.d}SoapConnect
	
	Представление = НСтр("ru = 'Обращение к веб-сервисам в сети Интернет'");
	Описание = НСтр("ru = 'Дополнительному отчету или обработке будет разрешено обращаться к веб-сервисам, расположенным в сети Интернет (при этом возможно как получение дополнительным отчетом или обработкой информации из сети Интернет, так и передача.'");
	Последствия = НСтр("ru = 'Внимание! Обращение к веб-сервисам потенциально может использоваться дополнительным
                        |отчетом или обработкой для совершения действий, не предполагаемых администратором
                        |информационной базы.
                        |
                        |Используйте данный дополнительный отчет или обработку только в том случае, если доверяете
                        |ее разработчику и контролируйте ограничения (адрес подключения), накладываемые на
                        |выданные разрешения.'");
	
	Параметры = ТаблицаПараметров();
	ДобавитьПараметр(Параметры, "WsdlDestination", НСтр("ru = 'по адресу %1'"), НСтр("ru = 'по любому адресу'"));
	
	Значение = Новый Структура;
	Значение.Вставить("Представление", Представление);
	Значение.Вставить("Описание", Описание);
	Значение.Вставить("Последствия", Последствия);
	Значение.Вставить("Параметры", Параметры);
	
	Результат.Вставить(
		ДополнительныеОтчетыИОбработкиВБезопасномРежимеИнтерфейс.ТипWSСоединение(),
		Значение);
	
	// Конец {http://www.1c.ru/1cFresh/ApplicationExtensions/Permissions/a.b.c.d}SoapConnect
	
	// {http://www.1c.ru/1cFresh/ApplicationExtensions/Permissions/a.b.c.d}CreateComObject
	
	Представление = НСтр("ru = 'Создание COM-объекта'");
	Описание = НСтр("ru = 'Дополнительному отчету или обработке будет разрешено использовать механизмы внешнего программного обеспечения с помощью COM-соединения'");
	Последствия = НСтр("ru = 'Внимание! Использование средств стороннего программного обеспечения может использоваться
                        |дополнительным отчетом или обработкой для совершения действий, не предполагаемых администратором
                        |информационной базы, а также для несанкционированного обхода ограничений, накладываемых на дополнительную обработку
                        |в безопасном режиме.
                        |
                        |Используйте данный дополнительный отчет или обработку только в том случае, если доверяете
                        |ее разработчику и контролируйте ограничения (программный идентификатор), накладываемые на
                        |выданные разрешения.'");
	
	Параметры = ТаблицаПараметров();
	ДобавитьПараметр(Параметры, "ProgId", НСтр("ru = 'с программным идентификатором %1'"), НСтр("ru = 'с любым программным идентификатором'"));
	
	Значение = Новый Структура;
	Значение.Вставить("Представление", Представление);
	Значение.Вставить("Описание", Описание);
	Значение.Вставить("Последствия", Последствия);
	Значение.Вставить("Параметры", Параметры);
	
	Результат.Вставить(
		ДополнительныеОтчетыИОбработкиВБезопасномРежимеИнтерфейс.ТипСозданиеCOMОбъекта(),
		Значение);
	
	// Конец {http://www.1c.ru/1cFresh/ApplicationExtensions/Permissions/a.b.c.d}CreateComObject
	
	// {http://www.1c.ru/1cFresh/ApplicationExtensions/Permissions/a.b.c.d}AttachAddin
	
	Представление = НСтр("ru = 'Создание объекта внешней компоненту'");
	Описание = НСтр("ru = 'Дополнительному отчету или обработке будет разрешено использовать механизмы внешнего программного обеспечения с помощью создания объекта внешней компоненты, поставляемой в макете конфигурации'");
	Последствия = НСтр("ru = 'Внимание! Использование средств стороннего программного обеспечения может использоваться
                        |дополнительным отчетом или обработкой для совершения действий, не предполагаемых администратором
                        |информационной базы, а также для несанкционированного обхода ограничений, накладываемых на дополнительную обработку
                        |в безопасном режиме.
                        |
                        |Используйте данный дополнительный отчет или обработку только в том случае, если доверяете
                        |ее разработчику и контролируйте ограничения (имя макета, из которого выполняется подключение внешней
                        |компоненты), накладываемые на выданные разрешения.'");
	
	Параметры = ТаблицаПараметров();
	ДобавитьПараметр(Параметры, "TemplateName", НСтр("ru = 'из макета %1'"), НСтр("ru = 'из любого макета'"));
	
	Значение = Новый Структура;
	Значение.Вставить("Представление", Представление);
	Значение.Вставить("Описание", Описание);
	Значение.Вставить("Последствия", Последствия);
	Значение.Вставить("Параметры", Параметры);
	
	Результат.Вставить(
		ДополнительныеОтчетыИОбработкиВБезопасномРежимеИнтерфейс.ТипПодключениеВнешнейКомпоненты(),
		Значение);
	
	// Конец {http://www.1c.ru/1cFresh/ApplicationExtensions/Permissions/a.b.c.d}AttachAddin
	
	// {http://www.1c.ru/1cFresh/ApplicationExtensions/Permissions/a.b.c.d}GetFileFromExternalSoftware
	
	Представление = НСтр("ru = 'Получение файлов из внешнего объекта'");
	Описание = НСтр("ru = 'Дополнительному отчету или обработке будет разрешено получать файлы из внешнего программного обеспечения (например, с помощью COM-соединения или внешней компоненты)'");
	
	Значение = Новый Структура;
	Значение.Вставить("Представление", Представление);
	Значение.Вставить("Описание", Описание);
	
	Результат.Вставить(
		ДополнительныеОтчетыИОбработкиВБезопасномРежимеИнтерфейс.ТипПолучениеФайлаИзВнешнегоОбъекта(),
		Значение);
	
	// Конец {http://www.1c.ru/1cFresh/ApplicationExtensions/Permissions/a.b.c.d}GetFileFromExternalSoftware
	
	// {http://www.1c.ru/1cFresh/ApplicationExtensions/Permissions/a.b.c.d}SendFileToExternalSoftware
	
	Представление = НСтр("ru = 'Передача файлов во внешний объект'");
	Описание = НСтр("ru = 'Дополнительному отчету или обработке будет разрешено передавать файлы во внешнее программное обеспечение (например, с помощью COM-соединения или внешней компоненты)'");
	
	Значение = Новый Структура;
	Значение.Вставить("Представление", Представление);
	Значение.Вставить("Описание", Описание);
	
	Результат.Вставить(
		ДополнительныеОтчетыИОбработкиВБезопасномРежимеИнтерфейс.ТипПередачаФайлаВоВнешнийОбъект(),
		Значение);
	
	// Конец {http://www.1c.ru/1cFresh/ApplicationExtensions/Permissions/a.b.c.d}SendFileToExternalSoftware
	
	// {http://www.1c.ru/1cFresh/ApplicationExtensions/Permissions/a.b.c.d}SendFileToInternet
	
	Представление = НСтр("ru = 'Проведение документов'");
	Описание = НСтр("ru = 'Дополнительному отчету или обработке будет разрешено изменять состояние проведенности документов'");
	
	Параметры = ТаблицаПараметров();
	ДобавитьПараметр(Параметры, "DocumentType", НСтр("ru = 'документы с типом %1'"), НСтр("ru = 'любые документы'"));
	ДобавитьПараметр(Параметры, "Action", НСтр("ru = 'разрешенное действие: %1'"), НСтр("ru = 'любое изменение состояния проведения'"));
	
	Значение = Новый Структура;
	Значение.Вставить("Представление", Представление);
	Значение.Вставить("Описание", Описание);
	Значение.Вставить("Параметры", Параметры);
	Значение.Вставить("ОтображатьПользователю", Неопределено);
	
	Результат.Вставить(
		ДополнительныеОтчетыИОбработкиВБезопасномРежимеИнтерфейс.ТипПроведениеДокументов(),
		Значение);
	
	// Конец {http://www.1c.ru/1cFresh/ApplicationExtensions/Permissions/a.b.c.d}SendFileToInternet
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ДобавитьПараметр(Знач ТаблицаПараметров, Знач Имя, Знач Описание, Знач ОписаниеЛюбогоЗначения)
	
	Параметр = ТаблицаПараметров.Добавить();
	Параметр.Имя = Имя;
	Параметр.Описание = Описание;
	Параметр.ОписаниеЛюбогоЗначения = ОписаниеЛюбогоЗначения;
	
КонецПроцедуры

Функция ТаблицаПараметров()
	
	Результат = Новый ТаблицаЗначений();
	Результат.Колонки.Добавить("Имя", Новый ОписаниеТипов("Строка"));
	Результат.Колонки.Добавить("Описание", Новый ОписаниеТипов("Строка"));
	Результат.Колонки.Добавить("ОписаниеЛюбогоЗначения", Новый ОписаниеТипов("Строка"));
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти
