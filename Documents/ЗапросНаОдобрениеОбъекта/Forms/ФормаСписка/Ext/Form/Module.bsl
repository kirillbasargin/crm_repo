﻿
&НаКлиенте
Процедура ПроверкаСтатусовИпотечныхЗаявок_Регламентно(Команда)
	
	ПроверкаСтатусовИпотечныхЗаявок_РегламентноНаСервере();

КонецПроцедуры


&НаСервере
Процедура ПроверкаСтатусовИпотечныхЗаявок_РегламентноНаСервере() 
	
	МассивПараметров = Новый Массив;
	Задание = ФоновыеЗадания.Выполнить("ЗаявкиНаКредитRestAPI.ПроверкаСтатусовЗапросовНаОдобрение_Регламентно", МассивПараметров, Строка(Новый УникальныйИдентификатор), "Проверка статусов запросов на одобрение регламентно");

КонецПроцедуры