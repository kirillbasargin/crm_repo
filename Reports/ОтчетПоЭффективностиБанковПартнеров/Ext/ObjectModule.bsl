﻿
Процедура ПриКомпоновкеРезультата(ДокументРезультат, ДанныеРасшифровки, СтандартнаяОбработка)
	
	ЗначениеПараметраЗаголовок = КомпоновщикНастроек.Настройки.ПараметрыДанных.НайтиЗначениеПараметра(Новый ПараметрКомпоновкиДанных("ДатаФормированияОтчета"));
	Если НЕ ЗначениеПараметраЗаголовок = Неопределено Тогда
		ЗначениеПараметраЗаголовок.Значение = ТекущаяДата();
		ЗначениеПараметраЗаголовок.Использование = Истина;
	КонецЕсли;
	
КонецПроцедуры
