﻿
Процедура ОбработкаПроведения(Отказ, Режим)
	//{{__КОНСТРУКТОР_ДВИЖЕНИЙ_РЕГИСТРОВ
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!

	Движения.УсловияКредитования.Записывать = Истина;
	Движения.УсловияКредитования.Очистить();	
	
	// регистр УсловияКредитования
	Для каждого СтрокаТЧ Из Проекты Цикл
		
		Движение = Движения.УсловияКредитования.Добавить();
		Движение.Период = Дата;
		Движение.Банк = Банк;
		Движение.Проект = СтрокаТЧ.Проект;
		Движение.СтавкаБазовая = СтавкаБазовая;
		Движение.СтавкаГосподдержка = СтавкаГосподдержка;
		Движение.ПервоначальныйВзнос = ПервоначальныйВзнос;
		Движение.СрокКредитования = СрокКредитования;
		Движение.ДополнительныеРасходы = ДополнительныеРасходы;
		Движение.ДосрочноеПогашение = ДосрочноеПогашение;
		Движение.ЛоготипБанка = Банк.ЛоготипБанка;
		
	КонецЦикла;
	//}}__КОНСТРУКТОР_ДВИЖЕНИЙ_РЕГИСТРОВ
КонецПроцедуры
