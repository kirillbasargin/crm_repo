﻿
#Область ОбработчикиСобытийФормы

#КонецОбласти 

#Область ОбработчикиСобытийЭлементовФормы

&НаКлиенте
Процедура СписокВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("ПоказатьКарточку", Истина);
	ПараметрыФормы.Вставить("Ключ", ВыбраннаяСтрока);
	ОткрытьФорму("Справочник.ВариантыДополнительныхОтчетов.ФормаОбъекта", ПараметрыФормы);
	
КонецПроцедуры

#КонецОбласти 

#Область ОбработчикиКомандФормы

#КонецОбласти 

#Область СлужебныеПроцедурыИФункции

#КонецОбласти
 
