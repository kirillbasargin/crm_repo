﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если НЕ Параметры.Свойство("Режим", Режим) ИЛИ НЕ Параметры.Свойство("АдресСхемы") ИЛИ НЕ Параметры.Свойство("АдресНастроек") Тогда
		Отказ = Истина;
		Возврат;
	КонецЕсли;
	Параметры.Свойство("СуществующийПоля", СуществующийПоля);
	ЗакрыватьПриВыборе = Истина;
	Компоновщик.Инициализировать(Новый ИсточникДоступныхНастроекКомпоновкиДанных(Параметры.АдресСхемы));
	Компоновщик.ЗагрузитьНастройки(ПолучитьИзВременногоХранилища(Параметры.АдресНастроек));
	
	УстановитьУсловноеОформление();
	
	Поля.ПолучитьЭлементы().Очистить();
	Если Режим="ПоляГруппировки" Тогда
		Заголовок = НСтр("ru = 'Поля группировки'");
		ДобавитьПоляГруппировок();
	ИначеЕсли Режим="ПоляОтбора" Тогда
		Заголовок = НСтр("ru = 'Поля отбора'");
		ДобавитьФильтры();
	КонецЕсли; 
	
КонецПроцедуры

#КонецОбласти 

#Область ОбработчикиСобытийЭлементовФормы

&НаКлиенте
Процедура ПоляВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	Стр = Элементы.Поля.ТекущиеДанные;
	Если Стр=Неопределено ИЛИ Стр.НеВыбирать Тогда
		Возврат;
	КонецЕсли; 
	ОповеститьОВыборе(Стр.Поле);
	
КонецПроцедуры

#КонецОбласти 

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Выбрать(Команда)
	
	Стр = Элементы.Поля.ТекущиеДанные;
	Если Стр=Неопределено ИЛИ Стр.НеВыбирать Тогда
		Возврат;
	КонецЕсли; 
	ОповеститьОВыборе(Стр.Поле);
	
КонецПроцедуры

#КонецОбласти 

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура УстановитьУсловноеОформление()
	
	УсловноеОформление.Элементы.Очистить();

	//

	Элемент = УсловноеОформление.Элементы.Добавить();

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных("Поля");

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Поля.НеВыбирать");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Истина;

	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветТекста", ЦветаСтиля.НедоступныеДанныеЦвет);

КонецПроцедуры

&НаСервере
Процедура ДобавитьПоляГруппировок()
	
	ДоступныеПоля = Компоновщик.Настройки.ДоступныеПоляГруппировок.Элементы;
	ИмяПредыдущегоПоля = ""; 
	Для каждого Поле Из ДоступныеПоля Цикл
		Если Поле.Папка ИЛИ Поле.Ресурс Тогда
			Продолжить;
		КонецЕсли; 
		ИмяПоля = Строка(Поле.Поле);
		Если ИмяПоля=ИмяПредыдущегоПоля Тогда
			Продолжить;
		КонецЕсли; 
		Если ИмяПоля="ДинамическийПериод" Тогда
			Продолжить;
		КонецЕсли; 
		СписокРеквизитов = Новый СписокЗначений;
		ИмяПредыдущегоРеквизита = "";
		Для каждого Реквизит Из Поле.Элементы Цикл
			Если Реквизит.Папка Тогда
				// Табличная часть
				Продолжить;
			КонецЕсли; 
			ИмяРеквизита = СокрЛП(Строка(Реквизит.Поле));
			Если ИмяРеквизита=ИмяПредыдущегоРеквизита Тогда
				Продолжить;
			КонецЕсли; 
			Если НЕ СуществующийПоля.НайтиПоЗначению(ИмяРеквизита)=Неопределено Тогда
				Продолжить;
			КонецЕсли;
			Если НЕ СписокРеквизитов.НайтиПоЗначению(ИмяРеквизита)=Неопределено Тогда
				Продолжить;
			КонецЕсли; 
			СписокРеквизитов.Добавить(ИмяРеквизита, Реквизит.Заголовок);
			ИмяПредыдущегоРеквизита = ИмяРеквизита;
		КонецЦикла;
		ВСуществующих = НЕ СуществующийПоля.НайтиПоЗначению(ИмяПоля)=Неопределено;
		Если ВСуществующих И СписокРеквизитов.Количество()=0 Тогда
			Продолжить;
		КонецЕсли;
		СтрПоле = Поля.ПолучитьЭлементы().Добавить();
		СтрПоле.Поле = ИмяПоля;
		СтрПоле.Представление = Поле.Заголовок;
		ИмяПредыдущегоПоля = ИмяПоля;
		Для каждого ЭлементСписка Из СписокРеквизитов Цикл
			СтрРеквизит = СтрПоле.ПолучитьЭлементы().Добавить();
			СтрРеквизит.Поле = ЭлементСписка.Значение;
			СтрРеквизит.Представление = ТекстПослеТочки(ЭлементСписка.Представление, Поле.Заголовок);
			СтрРеквизит.Картинка = 1;
		КонецЦикла; 
		Если ВСуществующих Тогда
			СтрПоле.НеВыбирать = Истина;
		КонецЕсли;
		СтрПоле.Картинка = ?(СтрПоле.НеВыбирать, 0, ?(Поле.Ресурс, 2, 1))
	КонецЦикла; 
	
КонецПроцедуры

&НаСервере
Процедура ДобавитьФильтры()
	
	Для каждого Поле Из Компоновщик.Настройки.ДоступныеПоляОтбора.Элементы Цикл
		Если Поле.Папка Тогда
			Продолжить;
		КонецЕсли;
		ИмяПоля = Строка(Поле.Поле);
		Если ИмяПоля="ДинамическийПериод" Тогда
			Продолжить;
		КонецЕсли; 
		Если ТекстПослеТочки(ИмяПоля)="Ссылка" Тогда
			Продолжить;
		КонецЕсли; 
		ВСуществующих = НЕ СуществующийПоля.НайтиПоЗначению(ИмяПоля)=Неопределено;
		СтрПоле = Поля.ПолучитьЭлементы().Добавить();
		СтрПоле.Поле = ИмяПоля;
		СтрПоле.Представление = Поле.Заголовок;
		ПропуститьВложенные = Ложь;
		Если Поле.ТипЗначения.Типы().Количество()=1 И Перечисления.ТипВсеСсылки().СодержитТип(Поле.ТипЗначения.Типы().Получить(0)) Тогда
			ПропуститьВложенные = Истина;
		КонецЕсли; 
		Если НЕ ПропуститьВложенные Тогда
			Для каждого Реквизит Из Поле.Элементы Цикл
				ИмяРеквизита = СокрЛП(Строка(Реквизит.Поле));
				Если ТекстПослеТочки(ИмяРеквизита, ИмяПоля)="Ссылка" Тогда
					Продолжить;
				КонецЕсли; 
				Если НЕ СуществующийПоля.НайтиПоЗначению(ИмяРеквизита)=Неопределено Тогда
					Продолжить;
				КонецЕсли;
				Если Реквизит.Папка И Прав(ИмяРеквизита, 5)=".Теги" Тогда
					Продолжить;
				КонецЕсли; 
				СтрРеквизит = СтрПоле.ПолучитьЭлементы().Добавить();
				СтрРеквизит.Поле = ИмяРеквизита;
				СтрРеквизит.Представление = СтрЗаменить(Реквизит.Заголовок, Поле.Заголовок+".", "");
				Если Реквизит.Папка Тогда
					СтрРеквизит.Картинка = 0;
					СтрРеквизит.НеВыбирать = Истина;
					Для каждого РеквизитТЧ Из Реквизит.Элементы Цикл
						ИмяРеквизитаТЧ = СокрЛП(Строка(РеквизитТЧ.Поле));
						Если НЕ СуществующийПоля.НайтиПоЗначению(ИмяРеквизитаТЧ)=Неопределено Тогда
							Продолжить;
						КонецЕсли; 
						Если ТекстПослеТочки(ИмяРеквизитаТЧ, ИмяРеквизита)="Ссылка" Тогда
							Продолжить;
						КонецЕсли; 
						СтрРеквизитТЧ = СтрРеквизит.ПолучитьЭлементы().Добавить();
						СтрРеквизитТЧ.Поле = ИмяРеквизитаТЧ;
						СтрРеквизитТЧ.Представление = СтрЗаменить(РеквизитТЧ.Заголовок, Реквизит.Заголовок+".", "");
						СтрРеквизитТЧ.Картинка = 1;
					КонецЦикла; 
				Иначе
					СтрРеквизит.Картинка = 1;
				КонецЕсли;  
			КонецЦикла; 
		КонецЕсли; 
		Если ВСуществующих И СтрПоле.ПолучитьЭлементы().Количество() = 0 Тогда
			Поля.ПолучитьЭлементы().Удалить(СтрПоле);
			Продолжить;
		ИначеЕсли ВСуществующих Тогда
			СтрПоле.НеВыбирать = Истина;
		КонецЕсли;
		ПолеВыбора = Компоновщик.Настройки.ДоступныеПоляВыбора.НайтиПоле(Поле.Поле);
		СтрПоле.Картинка = ?(СтрПоле.НеВыбирать, 0, ?(НЕ ПолеВыбора=Неопределено И ПолеВыбора.Ресурс, 2, 1))
	КонецЦикла; 
	
КонецПроцедуры

&НаСервере
Функция ТекстПослеТочки(Знач Текст, Знач ТекстРодитель = "")
	
	Если ПустаяСтрока(ТекстРодитель) Тогда
		Возврат Текст;
	КонецЕсли; 
	Возврат СтрЗаменить(Текст, ТекстРодитель+".", "");
	
КонецФункции

#КонецОбласти
 

 