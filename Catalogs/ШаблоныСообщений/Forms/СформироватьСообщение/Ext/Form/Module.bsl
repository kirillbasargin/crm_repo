﻿#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Предмет      = Параметры.Предмет;
	ВидСообщения = Параметры.ВидСообщения;
	РежимВыбора  = Параметры.РежимВыбора;
	//EXTCODE Шумилин Сергей 03.11.2017 {{ --->
	ПредметСтрокой = Параметры.ПредметСтрокой;
	//EXTCODE Шумилин Сергей 03.11.2017 <--- }} 
	
	Если ЗначениеЗаполнено(Предмет) Тогда
		ПолноеИмяТипаОснования = Предмет.Метаданные().ПолноеИмя();
	КонецЕсли;
	
	Если ВидСообщения = "СообщениеSMS" Тогда
		ПредназначенДляSMS = Истина;
		ПредназначенДляЭлектронныхПисем = Ложь;
		Заголовок = НСтр("ru = 'Шаблоны сообщений SMS'");
	Иначе
		ПредназначенДляSMS = Ложь;
		ПредназначенДляЭлектронныхПисем = Истина;
	КонецЕсли;
	
	Если НЕ ПравоДоступа("Изменение", Метаданные.Справочники.ШаблоныСообщений) Тогда
		ЕстьПравоИзменения = Ложь;
		Элементы.ФормаИзменить.Видимость = Ложь;
		Элементы.ФормаСоздать.Видимость = Ложь;
	Иначе
		ЕстьПравоИзменения = Истина;
	КонецЕсли;
	
	Если РежимВыбора Тогда
		Элементы.ФормаСформироватьИОтправить.Видимость = Ложь;
	КонецЕсли;
	
	ЗаполнитьСписокДоступныхШаблонов();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	Если ПустойСписокШаблонов Тогда
		ПараметрыОтправки = КонструкторПараметровОтправки();
		ПараметрыОтправки.ДополнительныеПараметры.ПреобразовыватьHTMLДляФорматированногоДокумента = Ложь;
		СформироватьСообщениеДляОтправки(ПараметрыОтправки);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	Если ИмяСобытия = "Запись_ШаблоныСообщений" Тогда
		СсылкаНаВыбранныйЭлемент = Неопределено;
		Если Элементы.Шаблоны.ТекущиеДанные <> Неопределено Тогда
			СсылкаНаВыбранныйЭлемент = Элементы.Шаблоны.ТекущиеДанные.Ссылка;
		КонецЕсли;
		ЗаполнитьСписокДоступныхШаблонов();
		НайденныеСтроки = Шаблоны.НайтиСтроки(Новый Структура("Ссылка", СсылкаНаВыбранныйЭлемент));
		Если НайденныеСтроки.Количество() > 0 Тогда
			Элементы.Шаблоны.ТекущаяСтрока = НайденныеСтроки[0].ПолучитьИдентификатор();
			////<875164>, Басаргин (08.10.2018) {
			//ИдентификаторСтроки = Неопределено;
			//ОбщегоНазначенияКлиентСервер.ПолучитьИдентификаторСтрокиДереваПоЗначениюПоля("Ссылка", ИдентификаторСтроки, Шаблоны_Дерево.ПолучитьЭлементы(), НайденныеСтроки[0].Ссылка);
			//Если НЕ ИдентификаторСтроки = Неопределено Тогда
			//	Элементы.Шаблоны_Дерево.ТекущаяСтрока = ИдентификаторСтроки;	
			//КонецЕсли;
			////<875164> }
		КонецЕсли;		
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыШаблоны

&НаКлиенте
Процедура ШаблоныПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа, Параметр)
	Отказ = Истина;
	СоздатьНовыйШаблон();
КонецПроцедуры

&НаКлиенте
Процедура ШаблоныПриАктивизацииСтроки(Элемент)
	Если Элемент.ТекущиеДанные <> Неопределено Тогда
		Элементы.ФормаСформироватьИОтправить.Доступность = (Элемент.ТекущиеДанные.Имя <> "<БезШаблона>");
		Если Элемент.ТекущиеДанные.ТипТекстаПисьма = ПредопределенноеЗначение("Перечисление.СпособыРедактированияЭлектронныхПисем.HTML") Тогда
			Элементы.СтраницыПредпросмотра.ТекущаяСтраница = Элементы.СтраницаФорматированныйДокумент;
			ПодключитьОбработчикОжидания("ОбновитьДанныеПредпросмотра", 0.2, Истина);
		Иначе
			Элементы.СтраницыПредпросмотра.ТекущаяСтраница = Элементы.СтраницаОбычныйТекст;
			ПредпросмотрОбычныйТекст.УстановитьТекст(Элемент.ТекущиеДанные.ТекстШаблона);
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ШаблоныПередНачаломИзменения(Элемент, Отказ)
	Отказ = Истина;
	Если Элемент.ТекущиеДанные <> Неопределено Тогда
		ПараметрыФормы = Новый Структура("Ключ", Элемент.ТекущиеДанные.Ссылка);
		ОткрытьФорму("Справочник.ШаблоныСообщений.ФормаОбъекта", ПараметрыФормы);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ШаблоныВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	СформироватьСообщениеПоВыбранномШаблону();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Сформировать(Команда)
	
	СформироватьСообщениеПоВыбранномШаблону();
	
КонецПроцедуры

&НаКлиенте
Процедура СформироватьИОтправить(Команда)
	
	Если Элементы.Шаблоны.ТекущаяСтрока = Неопределено Тогда
		Возврат;
	КонецЕсли;
		
	ТекущиеДанные = Шаблоны.НайтиПоИдентификатору(Элементы.Шаблоны.ТекущаяСтрока);
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ПараметрыОтправки = КонструкторПараметровОтправки(ТекущиеДанные.Ссылка);
	ПараметрыОтправки.ДополнительныеПараметры.ОтправитьСразу = Истина;
	Если ТекущиеДанные.ЕстьПроизвольныеПараметры Тогда
		ВводПараметров(ТекущиеДанные.Ссылка, ПараметрыОтправки, Истина);
	Иначе
		ОтравитьСообщение(ПараметрыОтправки);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура Создать(Команда)
	СоздатьНовыйШаблон();
КонецПроцедуры

&НаКлиенте
Процедура ВводПараметров(Шаблон, ПараметрыОтправки, ОтправлятьСразу)
	
	ПараметрыДляЗаполнения = Новый Структура("Шаблон, Предмет", Шаблон, Предмет);
	
	Оповещение = Новый ОписаниеОповещения("ПослеВводаПараметров", ЭтотОбъект, ПараметрыОтправки);
	ОткрытьФорму("Справочник.ШаблоныСообщений.Форма.ЗаполнитьПроизвольныеПараметры", ПараметрыДляЗаполнения,,,,, Оповещение);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура СформироватьСообщениеПоВыбранномШаблону()
	
	Если Элементы.Шаблоны.ТекущаяСтрока = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ТекущиеДанные = Шаблоны.НайтиПоИдентификатору(Элементы.Шаблоны.ТекущаяСтрока);
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ПараметрыОтправки = КонструкторПараметровОтправки(ТекущиеДанные.Ссылка);
	ПараметрыОтправки.ДополнительныеПараметры.ПреобразовыватьHTMLДляФорматированногоДокумента = Истина;
	
	Если ТекущиеДанные.ЕстьПроизвольныеПараметры Тогда
		ВводПараметров(ТекущиеДанные.Ссылка, ПараметрыОтправки, Ложь);
	Иначе
		СформироватьСообщениеДляОтправки(ПараметрыОтправки);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СформироватьСообщениеДляОтправки(ПараметрыОтправки)
	
	АдресВременногоХранилища = Неопределено;
	АдресВременногоХранилища = ПоместитьВоВременноеХранилище(Неопределено, УникальныйИдентификатор);
	
	АдресРезультата = СформироватьСообщениеНаСервере(АдресВременногоХранилища, ПараметрыОтправки, ВидСообщения);
	
	Результат = ПолучитьИзВременногоХранилища(АдресРезультата);
	Если ПараметрыОтправки.ДополнительныеПараметры.ОтправитьСразу Тогда
		ПослеФормированияИОтправкиСообщения(Результат, ПараметрыОтправки);
	Иначе
		Если РежимВыбора Тогда
			Закрыть(Результат);
		Иначе
			Закрыть();
			ПоказатьФормуСообщения(Результат);
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция СформироватьСообщениеНаСервере(АдресВременногоХранилища, ПараметрыОтправки, ВидСообщения)
	
	ПараметрыВызоваСервера = Новый Структура();
	ПараметрыВызоваСервера.Вставить("ПараметрыОтправки", ПараметрыОтправки);
	ПараметрыВызоваСервера.Вставить("ВидСообщения",      ВидСообщения);
	
	ШаблоныСообщенийСлужебный.СформироватьСообщениеВФоне(ПараметрыВызоваСервера, АдресВременногоХранилища);
	
	Возврат АдресВременногоХранилища;
	
КонецФункции

&НаКлиенте
Процедура ПослеВводаПараметров(Результат, ПараметрыОтправки) Экспорт
	
	Если Результат <> Неопределено И Результат <> КодВозвратаДиалога.Отмена Тогда
		ПараметрыОтправки.ДополнительныеПараметры.ПроизвольныеПараметры = Результат;
		СформироватьСообщениеДляОтправки(ПараметрыОтправки);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОтравитьСообщение(Знач ПараметрыОтправкиСообщения)
	
	Если ВидСообщения = "Письмо" Тогда
		Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.РаботаСПочтовымиСообщениями") Тогда
			ОписаниеОповещения = Новый ОписаниеОповещения("ОтравитьСообщениеПроверкаУчетнойЗаписиВыполнена", ЭтотОбъект, ПараметрыОтправкиСообщения);
			МодульРаботаСПочтовымиСообщениямиКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("РаботаСПочтовымиСообщениямиКлиент");
			МодульРаботаСПочтовымиСообщениямиКлиент.ПроверитьНаличиеУчетнойЗаписиДляОтправкиПочты(ОписаниеОповещения);
		КонецЕсли;
	Иначе
		СформироватьСообщениеДляОтправки(ПараметрыОтправкиСообщения);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОтравитьСообщениеПроверкаУчетнойЗаписиВыполнена(УчетнаяЗаписьНастроена, ПараметрыОтправки) Экспорт
	
	Если УчетнаяЗаписьНастроена Тогда
		СформироватьСообщениеДляОтправки(ПараметрыОтправки);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеФормированияИОтправкиСообщения(Результат, ПараметрыОтправки)
	
	Если Результат.Отправлено Тогда;
		Закрыть();
	Иначе
		Оповещение = Новый ОписаниеОповещения("ПослеВопросаОбОткрытиеФормыСообщения", ЭтотОбъект, ПараметрыОтправки);
		ОписаниеОшибки = Результат.ОписаниеОшибки + Символы.ПС + НСтр("ru = 'Открыть форму отправки сообщения?'");
		ПоказатьВопрос(Оповещение, ОписаниеОшибки, РежимДиалогаВопрос.ДаНет);
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ПоказатьФормуСообщения(Сообщение)
	
	Если ВидСообщения = "СообщениеSMS" Тогда
		Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.ОтправкаSMS") Тогда 
			МодульОтправкаSMSКлиент= ОбщегоНазначенияКлиент.ОбщийМодуль("ОтправкаSMSКлиент");
			ДополнительныеПараметры = Новый Структура("ИсточникКонтактнойИнформации, ПеревестиВТранслит");
			
			Если Сообщение.ДополнительныеПараметры <> Неопределено Тогда
				ЗаполнитьЗначенияСвойств(ДополнительныеПараметры, Сообщение.ДополнительныеПараметры);
			КонецЕсли;
			
			ДополнительныеПараметры.ИсточникКонтактнойИнформации = Предмет;
			Текст      = ?(Сообщение.Свойство("Текст"), Сообщение.Текст, "");
			Получатель = ?(Сообщение.Свойство("Получатель"), Сообщение.Получатель.ВыгрузитьЗначения(), Новый СписокЗначений);
			МодульОтправкаSMSКлиент.ОтправитьSMS(Получатель, Текст, ДополнительныеПараметры);
		КонецЕсли;
	Иначе
		Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.РаботаСПочтовымиСообщениями") Тогда
			МодульРаботаСПочтовымиСообщениямиКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("РаботаСПочтовымиСообщениямиКлиент");
			МодульРаботаСПочтовымиСообщениямиКлиент.СоздатьНовоеПисьмо(Сообщение);
		КонецЕсли;
	КонецЕсли;
	
	Если Сообщение.Свойство("СообщенияПользователю")
		И Сообщение.СообщенияПользователю <> Неопределено
		И Сообщение.СообщенияПользователю.Количество() > 0 Тогда
			Для каждого СообщенияПользователю Из Сообщение.СообщенияПользователю Цикл
				ОбщегоНазначенияКлиентСервер.СообщитьПользователю(СообщенияПользователю.Текст,
					СообщенияПользователю.КлючДанных, СообщенияПользователю.Поле, СообщенияПользователю.ПутьКДанным);
			КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Функция КонструкторПараметровОтправки(Шаблон = Неопределено)
	
	ПараметрыОтправки = Новый Структура();
	ПараметрыОтправки.Вставить("Шаблон", Шаблон);
	ПараметрыОтправки.Вставить("Предмет", Предмет);
	ПараметрыОтправки.Вставить("УникальныйИдентификатор", УникальныйИдентификатор);
	ПараметрыОтправки.Вставить("ДополнительныеПараметры", Новый Структура);
	ПараметрыОтправки.ДополнительныеПараметры.Вставить("ПреобразовыватьHTMLДляФорматированногоДокумента", Ложь);
	ПараметрыОтправки.ДополнительныеПараметры.Вставить("ВидСообщения", ВидСообщения);
	ПараметрыОтправки.ДополнительныеПараметры.Вставить("ПроизвольныеПараметры", Новый Соответствие);
	ПараметрыОтправки.ДополнительныеПараметры.Вставить("ОтправитьСразу", Ложь);
	
	//EXTCODE Шумилин Сергей 03.11.2017 {{ --->
	ПараметрыОтправки.ДополнительныеПараметры.ПроизвольныеПараметры.Вставить("ПредметСтрокой", ПредметСтрокой);
	//EXTCODE Шумилин Сергей 03.11.2017 <--- }} 
	
	Возврат ПараметрыОтправки;
	
КонецФункции

&НаКлиенте
Процедура ПослеВопросаОбОткрытиеФормыСообщения(Результат, ПараметрыОтправки) Экспорт
	Если Результат = КодВозвратаДиалога.Да Тогда
		ПараметрыОтправки.ДополнительныеПараметры.ОтправитьСразу                                  = Ложь;
		ПараметрыОтправки.ДополнительныеПараметры.ПреобразовыватьHTMLДляФорматированногоДокумента = Истина;
		СформироватьСообщениеДляОтправки(ПараметрыОтправки);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура СоздатьНовыйШаблон()
	
	ПараметрыФормы = Новый Структура("ВидСообщения, ПолноеИмяТипаОснования, ТолькоДляАвтора", ВидСообщения, ПолноеИмяТипаОснования, Истина);
	Оповещение = Новый ОписаниеОповещения("ОбновитьОкно", ЭтотОбъект);
	ОткрытьФорму("Справочник.ШаблоныСообщений.ФормаОбъекта", ПараметрыФормы, ЭтотОбъект,,,, )
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьОкно(Результат, ДополнительныеПараметры) Экспорт
	ЗаполнитьСписокДоступныхШаблонов();
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьСписокДоступныхШаблонов()
	
	//<875164>, Басаргин (08.10.2018) {		
	Шаблоны.Очистить();
	
	тДерево = РеквизитФормыВЗначение("Шаблоны_Дерево");
	тДерево.Строки.Очистить(); 
	ЗначениеВРеквизитФормы(тДерево, "Шаблоны_Дерево");
	
	ТипШаблона = ?(ПредназначенДляSMS, "SMS", "Письмо");
	
	Запрос = ПодготовитьЗапросДляПолученияСпискаШаблонов(ТипШаблона, Предмет);
	
	РезультатЗапросаИтоги = Запрос.Выполнить().Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
	
	ДеревоЗначений = ДанныеФормыВЗначение(Шаблоны_Дерево, Тип("ДеревоЗначений"));
	
	Пока РезультатЗапросаИтоги.Следующий() Цикл
		
		РезультатЗапроса = РезультатЗапросаИтоги.Выбрать();
		
		НоваяСтрока = ДеревоЗначений.Строки.Добавить();
		НоваяСтрока.РодительПредставление = РезультатЗапросаИтоги.РодительПредставление;
		
		Пока РезультатЗапроса.Следующий() Цикл
			СтрокаДерева = НоваяСтрока.Строки.Добавить();
			ЗаполнитьЗначенияСвойств(СтрокаДерева, РезультатЗапроса);
			СтрокаДерева.РодительПредставление = "";
			
			Если РезультатЗапроса.ШаблонПоВнешнейОбработке
				И ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ДополнительныеОтчетыИОбработки") Тогда
				МодульДополнительныеОтчетыИОбработки = ОбщегоНазначения.ОбщийМодуль("ДополнительныеОтчетыИОбработки");
				ВнешнийОбъект = МодульДополнительныеОтчетыИОбработки.ОбъектВнешнейОбработки(РезультатЗапроса.ВнешняяОбработка);
				ПараметрыШаблона = ВнешнийОбъект.ПараметрыШаблона();
				
				Если ПараметрыШаблона.Количество() > 1 Тогда
					ЕстьПроизвольныеПараметры = Истина;
				Иначе
					ЕстьПроизвольныеПараметры = Ложь;
				КонецЕсли;
			Иначе
				ПроизвольныеПараметры = РезультатЗапроса.ЕстьПроизвольныеПараметры.Выгрузить();
				ЕстьПроизвольныеПараметры = ПроизвольныеПараметры.Количество() > 0;
			КонецЕсли;
			
			СтрокаДерева.ЕстьПроизвольныеПараметры = ЕстьПроизвольныеПараметры;
			
			Строка = Шаблоны.Добавить();		
			ЗаполнитьЗначенияСвойств(Строка, СтрокаДерева);				
		КонецЦикла;
	КонецЦикла;
	
	Если ДеревоЗначений.Строки.Количество() = 0 Тогда
		ПустойСписокШаблонов = Истина;
		Возврат;
	КонецЕсли;
	
	Если НЕ РежимВыбора Тогда
		ПерваяСтрока = ДеревоЗначений.Строки.Вставить(0);
		ПерваяСтрока.Имя = "<БезШаблона>";
		ПерваяСтрока.Представление = НСтр("ru = '<Без шаблона>'");
		
		ПерваяСтрока = Шаблоны.Вставить(0);
		ПерваяСтрока.Имя = "<БезШаблона>";
		ПерваяСтрока.Представление = НСтр("ru = '<Без шаблона>'");		
	КонецЕсли;
	
	Если ДеревоЗначений.Строки.Количество() = 0 Тогда
		Элементы.ФормаСоздать.ТолькоВоВсехДействиях = Ложь;
	КонецЕсли;
	
	ЗначениеВДанныеФормы(ДеревоЗначений, Шаблоны_Дерево);
	//<875164> }	
	
	//Шаблоны.Очистить();
	//ТипШаблона = ?(ПредназначенДляSMS, "SMS", "Письмо");
	//Запрос = ШаблоныСообщенийСлужебный.ПодготовитьЗапросДляПолученияСпискаШаблонов(ТипШаблона, Предмет);
	//
	//РезультатЗапроса = Запрос.Выполнить().Выбрать();
	//	
	//Пока РезультатЗапроса.Следующий() Цикл
	//	НоваяСтрока = Шаблоны.Добавить();
	//	ЗаполнитьЗначенияСвойств(НоваяСтрока, РезультатЗапроса);
	//	
	//	Если РезультатЗапроса.ШаблонПоВнешнейОбработке
	//		И ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ДополнительныеОтчетыИОбработки") Тогда
	//			МодульДополнительныеОтчетыИОбработки = ОбщегоНазначения.ОбщийМодуль("ДополнительныеОтчетыИОбработки");
	//			ВнешнийОбъект = МодульДополнительныеОтчетыИОбработки.ОбъектВнешнейОбработки(РезультатЗапроса.ВнешняяОбработка);
	//			ПараметрыШаблона = ВнешнийОбъект.ПараметрыШаблона();
	//			
	//			Если ПараметрыШаблона.Количество() > 1 Тогда
	//				ЕстьПроизвольныеПараметры = Истина;
	//			Иначе
	//				ЕстьПроизвольныеПараметры = Ложь;
	//			КонецЕсли;
	//	Иначе
	//		ПроизвольныеПараметры = РезультатЗапроса.ЕстьПроизвольныеПараметры.Выгрузить();
	//		ЕстьПроизвольныеПараметры = ПроизвольныеПараметры.Количество() > 0;
	//	КонецЕсли;
	//	
	//	НоваяСтрока.ЕстьПроизвольныеПараметры = ЕстьПроизвольныеПараметры;
	//КонецЦикла;
	//
	//Если Шаблоны.Количество() = 0 Тогда
	//	ПустойСписокШаблонов = Истина;
	//	Возврат;
	//КонецЕсли;
	//
	//Шаблоны.Сортировать("Представление");
	//
	//Если НЕ РежимВыбора Тогда
	//	ПерваяСтрока = Шаблоны.Вставить(0);
	//	ПерваяСтрока.Имя = "<БезШаблона>";
	//	ПерваяСтрока.Представление = НСтр("ru = '<Без шаблона>'");
	//КонецЕсли;
	//
	//Если Шаблоны.Количество() = 0 Тогда
	//	Элементы.ФормаСоздать.ТолькоВоВсехДействиях = Ложь;
	//КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ОбновитьДанныеПредпросмотра()
	ТекущиеДанные = Элементы.Шаблоны.ТекущиеДанные;
	Если ТекущиеДанные <> Неопределено Тогда
		УстановитьHTMLВФорматированныйДокумент(ТекущиеДанные.ТекстШаблона, ТекущиеДанные.Ссылка);
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура УстановитьHTMLВФорматированныйДокумент(ТекстШаблонаПисьмаHTML, СсылкаНаТекущийОбъект);
	
	ПараметрШаблона = Новый Структура("Шаблон, УникальныйИдентификатор");
	ПараметрШаблона.Шаблон = СсылкаНаТекущийОбъект;
	ПараметрШаблона.УникальныйИдентификатор = УникальныйИдентификатор;
	Сообщение = ШаблоныСообщенийСлужебный.КонструкторСообщения();
	Сообщение.Текст = ТекстШаблонаПисьмаHTML;
	ШаблоныСообщенийСлужебный.ОбработатьHTMLДляФорматированногоДокумента(ПараметрШаблона, Сообщение, Истина);
	СтруктураВложений = Новый Структура();
	Для каждого ВложениеВHTML Из Сообщение.Вложения Цикл
		Изображение = Новый Картинка(ПолучитьИзВременногоХранилища(ВложениеВHTML.АдресВоВременномХранилище));
		СтруктураВложений.Вставить(ВложениеВHTML.Представление, Изображение);
	КонецЦикла;
	ПредпросмотрФорматированныйДокумент.УстановитьHTML(Сообщение.Текст, СтруктураВложений);
	
КонецПроцедуры

//<875164>, Басаргин (08.10.2018) {
Функция ПодготовитьЗапросДляПолученияСпискаШаблонов(ТипШаблона, Предмет = Неопределено) Экспорт
	
	Если ТипШаблона = "SMS" Тогда
		ПредназначенДляSMS = Истина;
		ПредназначенДляЭлектронныхПисем = Ложь;
	Иначе
		ПредназначенДляSMS = Ложь;
		ПредназначенДляЭлектронныхПисем = Истина;
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ РАЗРЕШЕННЫЕ
	               |	ШаблоныСообщений.Родитель.Представление КАК РодительПредставление,
	               |	ШаблоныСообщений.Ссылка КАК Ссылка,
	               |	ШаблоныСообщений.Представление КАК Представление,
	               |	ШаблоныСообщений.Наименование КАК Имя,
	               |	ШаблоныСообщений.ВнешняяОбработка КАК ВнешняяОбработка,
	               |	ШаблоныСообщений.ШаблонПоВнешнейОбработке КАК ШаблонПоВнешнейОбработке,
	               |	ВЫБОР
	               |		КОГДА ШаблоныСообщений.ПредназначенДляЭлектронныхПисем
	               |			ТОГДА ВЫБОР
	               |					КОГДА ШаблоныСообщений.ТипТекстаПисьма = ЗНАЧЕНИЕ(Перечисление.СпособыРедактированияЭлектронныхПисем.HTML)
	               |						ТОГДА ШаблоныСообщений.ТекстШаблонаПисьмаHTML
	               |					ИНАЧЕ ШаблоныСообщений.ТекстШаблонаПисьма
	               |				КОНЕЦ
	               |		ИНАЧЕ ШаблоныСообщений.ТекстШаблонаSMS
	               |	КОНЕЦ КАК ТекстШаблона,
	               |	ШаблоныСообщений.ТипТекстаПисьма КАК ТипТекстаПисьма,
	               |	ШаблоныСообщений.ТемаПисьма КАК ТемаПисьма,
	               |	ШаблоныСообщений.Параметры.(
	               |		ВЫБОР
	               |			КОГДА КОЛИЧЕСТВО(ШаблоныСообщений.Параметры.ИмяПараметра) > 0
	               |				ТОГДА ИСТИНА
	               |			ИНАЧЕ ЛОЖЬ
	               |		КОНЕЦ КАК Поле1
	               |	) КАК ЕстьПроизвольныеПараметры
	               |ИЗ
	               |	Справочник.ШаблоныСообщений КАК ШаблоныСообщений
	               |ГДЕ
	               |	(ШаблоныСообщений.ТолькоДляАвтора = ЛОЖЬ
	               |			ИЛИ ШаблоныСообщений.Автор = &Пользователь)
	               |	И ШаблоныСообщений.ПредназначенДляSMS = &ПредназначенДляSMS
	               |	И ШаблоныСообщений.ПредназначенДляЭлектронныхПисем = &ПредназначенДляЭлектронныхПисем
	               |	И ШаблоныСообщений.Назначение <> ""Служебный""
	               |	И ШаблоныСообщений.ПометкаУдаления = ЛОЖЬ";
	
	Запрос.УстановитьПараметр("ПредназначенДляSMS", ПредназначенДляSMS);
	Запрос.УстановитьПараметр("ПредназначенДляЭлектронныхПисем", ПредназначенДляЭлектронныхПисем);
	Запрос.УстановитьПараметр("Пользователь", Пользователи.АвторизованныйПользователь());
	
	Если ЗначениеЗаполнено(Предмет) Тогда
		Запрос.Текст = Запрос.Текст + " И (ШаблоныСообщений.ПредназначенДляВводаНаОсновании = ЛОЖЬ ИЛИ ШаблоныСообщений.ПолноеИмяТипаПараметраВводаНаОсновании = &ПолноеИмяТипаПредмета)";
		Запрос.УстановитьПараметр("ПолноеИмяТипаПредмета", 
			?(ТипЗнч(Предмет) = Тип("Строка"), Предмет, Предмет.Метаданные().ПолноеИмя()));
	Иначе 
		Запрос.Текст = Запрос.Текст + " И ШаблоныСообщений.ПредназначенДляВводаНаОсновании = ЛОЖЬ";
	КонецЕсли;
	
	Запрос.Текст = Запрос.Текст + Символы.ПС +  "УПОРЯДОЧИТЬ ПО РодительПредставление, Представление ИТОГИ ПО РодительПредставление";
	
	Возврат Запрос;
	
КонецФункции

&НаКлиенте
Процедура Шаблоны_ДеревоПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа, Параметр)

	Отказ = Истина;
	СоздатьНовыйШаблон();
	
КонецПроцедуры

&НаКлиенте
Процедура Шаблоны_ДеревоПередНачаломИзменения(Элемент, Отказ)
	
	Отказ = Истина;
	
	ТекущиеДанные = Элемент.ТекущиеДанные;
	НайденныеСтроки = Шаблоны.НайтиСтроки(Новый Структура("Ссылка", ТекущиеДанные.Ссылка));
	Если НайденныеСтроки.Количество() Тогда
		Элементы.Шаблоны.ТекущаяСтрока = НайденныеСтроки[0].ПолучитьИдентификатор();
	Иначе
		Элементы.Шаблоны.ТекущаяСтрока = Неопределено;
		Возврат;
	КонецЕсли;	
	
	Если Элемент.ТекущиеДанные <> Неопределено Тогда
		ПараметрыФормы = Новый Структура("Ключ", Элемент.ТекущиеДанные.Ссылка);
		ОткрытьФорму("Справочник.ШаблоныСообщений.ФормаОбъекта", ПараметрыФормы);
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура Шаблоны_ДеревоВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	Если Элемент.ТекущиеДанные.ПолучитьРодителя() = Неопределено Тогда
		Возврат;
	КонецЕсли;
		
	ТекущиеДанные = Элемент.ТекущиеДанные;
	НайденныеСтроки = Шаблоны.НайтиСтроки(Новый Структура("Ссылка", ТекущиеДанные.Ссылка));
	Если НайденныеСтроки.Количество() Тогда
		Элементы.Шаблоны.ТекущаяСтрока = НайденныеСтроки[0].ПолучитьИдентификатор();
	Иначе
		Элементы.Шаблоны.ТекущаяСтрока = Неопределено;
		Возврат;
	КонецЕсли;
	
	СформироватьСообщениеПоВыбранномШаблону();	
	
КонецПроцедуры

&НаКлиенте
Процедура Шаблоны_ДеревоПриАктивизацииСтроки(Элемент)
	
	Если Элемент.ТекущиеДанные.ПолучитьРодителя() = Неопределено Тогда
		Элементы.Шаблоны.ТекущаяСтрока = 0;
		ПредпросмотрОбычныйТекст.УстановитьТекст("");
		ПредпросмотрФорматированныйДокумент.УстановитьФорматированнуюСтроку(Новый ФорматированнаяСтрока("",,,,));
		Возврат;
	КонецЕсли;
	
	ТекущиеДанные = Элемент.ТекущиеДанные;
	НайденныеСтроки = Шаблоны.НайтиСтроки(Новый Структура("Ссылка", ТекущиеДанные.Ссылка));
	Если НайденныеСтроки.Количество() Тогда
		Элементы.Шаблоны.ТекущаяСтрока = НайденныеСтроки[0].ПолучитьИдентификатор();
	Иначе
		Элементы.Шаблоны.ТекущаяСтрока = Неопределено;
		Возврат;
	КонецЕсли;
			
	Если Элемент.ТекущиеДанные <> Неопределено Тогда
		Элементы.ФормаСформироватьИОтправить.Доступность = (Элемент.ТекущиеДанные.Имя <> "<БезШаблона>");
		Если Элемент.ТекущиеДанные.ТипТекстаПисьма = ПредопределенноеЗначение("Перечисление.СпособыРедактированияЭлектронныхПисем.HTML") Тогда
			Элементы.СтраницыПредпросмотра.ТекущаяСтраница = Элементы.СтраницаФорматированныйДокумент;
			ПодключитьОбработчикОжидания("ОбновитьДанныеПредпросмотра", 0.2, Истина);
		Иначе
			Элементы.СтраницыПредпросмотра.ТекущаяСтраница = Элементы.СтраницаОбычныйТекст;
			ПредпросмотрОбычныйТекст.УстановитьТекст(Элемент.ТекущиеДанные.ТекстШаблона);
		КонецЕсли;
	КонецЕсли;
		
КонецПроцедуры
//<875164> }

#КонецОбласти