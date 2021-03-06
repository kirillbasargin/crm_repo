﻿
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Элементы.Страницы.Видимость = НЕ Объект.ТолькоОтправкаПисем;
	Элементы.ГруппаПолучатели.Видимость = Объект.ТолькоОтправкаПисем;

	//<897513>, Басаргин (23.11.2018) {
	Если НЕ Параметры.Ключ.Пустая() Тогда
		ЗаполнитьЗначенияСвойств(ЭтаФорма, УправлениеИпотечнымиЗаявкамиДомКлик.ПолучитьСекреты(Параметры.Ключ));
		ЗаполнитьЗначенияСвойств(ЭтаФорма, УправлениеИпотечнымиЗаявкамиДомКлик.ПолучитьКлючиДоступаDaData(Параметры.Ключ));
	КонецЕсли;	
	Элементы.ГруппаКлючиDaData.Видимость = Объект.НормализацияАдресаDaData;
	//<897513> }
	
КонецПроцедуры

&НаКлиенте
Процедура НастройкиПравДоступаПользователейОбъектДоступаНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	// Вставить содержимое обработчика.
КонецПроцедуры

&НаКлиенте
Процедура НастройкиПравДоступаПользователейОбъектДоступаОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	// Вставить содержимое обработчика.
КонецПроцедуры

&НаКлиенте
Процедура ТолькоОтправкаПисемПриИзменении(Элемент)
	
	Элементы.Страницы.Видимость = НЕ Объект.ТолькоОтправкаПисем;
	Элементы.ГруппаПолучатели.Видимость = Объект.ТолькоОтправкаПисем;
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	
	//<897513>, Басаргин (23.11.2018) {		
	УправлениеИпотечнымиЗаявкамиДомКлик.ЗаписатьСекреты(Объект.Ссылка, client_id, client_secret);
	Если НЕ ЗначениеЗаполнено(client_id) ИЛИ НЕ ЗначениеЗаполнено(client_secret) Тогда
		ЗаполнитьЗначенияСвойств(ЭтаФорма, УправлениеИпотечнымиЗаявкамиДомКлик.ПолучитьСекреты(Параметры.Ключ));
	КонецЕсли;
	УправлениеИпотечнымиЗаявкамиДомКлик.ЗаписатьКлючиДоступаDaData(Объект.Ссылка, DaData_APIКлюч, DaData_СекретныйКлюч);
	Если НЕ ЗначениеЗаполнено(DaData_APIКлюч) ИЛИ НЕ ЗначениеЗаполнено(DaData_СекретныйКлюч) Тогда
		ЗаполнитьЗначенияСвойств(ЭтаФорма, УправлениеИпотечнымиЗаявкамиДомКлик.ПолучитьКлючиДоступаDaData(Параметры.Ключ));	
	КонецЕсли;	
	//<897513> }
	
	//УстановитьПривилегированныйРежим(Истина);
	//ОбщегоНазначения.ЗаписатьДанныеВБезопасноеХранилище(ТекущийОбъект.Ссылка, Password);
	//УстановитьПривилегированныйРежим(Ложь);
		
КонецПроцедуры


Функция ПолучитьКлючиДоступаDaData(ПараметрыAPI) Экспорт
	
	DaData_APIКлюч = "";	
	DaData_СекретныйКлюч = "";
	
	УстановитьПривилегированныйРежим(Истина);
    Данные = ОбщегоНазначения.ПрочитатьДанныеИзБезопасногоХранилища(ПараметрыAPI, "DaData");
	Если ТипЗнч(Данные) = Тип("Структура") И Данные.Свойство("DaData_APIКлюч") И Данные.Свойство("DaData_СекретныйКлюч") Тогда
		DaData_APIКлюч = Данные.DaData_APIКлюч;
		DaData_СекретныйКлюч = Данные.DaData_СекретныйКлюч;
	КонецЕсли;
	УстановитьПривилегированныйРежим(Ложь);
		
	Возврат Новый Структура("DaData_APIКлюч, DaData_СекретныйКлюч", DaData_APIКлюч, DaData_СекретныйКлюч);
		
КонецФункции

Процедура ЗаписатьКлючиДоступаDaData(ПараметрыAPI, client_id, client_secret) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	Данные = Новый Структура("DaData_APIКлюч, DaData_СекретныйКлюч", client_id, client_secret);
    ОбщегоНазначения.ЗаписатьДанныеВБезопасноеХранилище(ПараметрыAPI, Данные, "DaData");
    УстановитьПривилегированныйРежим(Ложь);
	
КонецПроцедуры

&НаКлиенте
Процедура НормализацияАдресаDaDataПриИзменении(Элемент)	
	Элементы.ГруппаКлючиDaData.Видимость = Объект.НормализацияАдресаDaData;	
КонецПроцедуры
