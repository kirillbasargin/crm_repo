﻿
&НаКлиенте
Процедура ПриОткрытии(Отказ)
	СписокФайлов = ВладелецФормы.ПоследниеФайлыЗапросов;
	Для Каждого ФайлСписка Из СписокФайлов Цикл
		НоваяСтрока = ПоследниеФайлыЗапросов.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрока,ФайлСписка);
	КонецЦикла;
КонецПроцедуры

&НаКлиенте
Процедура ПоследниеФайлыЗапросовВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	Закрыть(Новый Структура("Файл,Каталог",Элементы.ПоследниеФайлыЗапросов.ТекущиеДанные.Файл,Элементы.ПоследниеФайлыЗапросов.ТекущиеДанные.Каталог));
КонецПроцедуры
