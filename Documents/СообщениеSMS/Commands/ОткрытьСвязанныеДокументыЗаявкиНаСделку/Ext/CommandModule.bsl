﻿
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	//Вставить содержимое обработчика.
	Если Не ПараметрКоманды.Пустая() Тогда
	
		Предмет = ПолучитьПредметНаСервере(ПараметрКоманды);
		
		Если ЗначениеЗаполнено(Предмет)
				И ТипЗнч(Предмет) = Тип("ДокументСсылка.Запрос") Тогда
				
			ПараметрыФормы = Новый Структура("Отбор", Новый Структура("ДокументОснование", Предмет));
			ОткрытьФорму("Документ.ЗаявкаНаСделку.ФормаСписка", ПараметрыФормы, ПараметрыВыполненияКоманды.Источник, ПараметрыВыполненияКоманды.Уникальность, ПараметрыВыполненияКоманды.Окно, ПараметрыВыполненияКоманды.НавигационнаяСсылка);
				
		КонецЕсли;
	
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция ПолучитьПредметНаСервере(ДокументВзаимодействие)
	
	Возврат Взаимодействия.ПолучитьЗначениеПредмета(ДокументВзаимодействие);
	
КонецФункции

