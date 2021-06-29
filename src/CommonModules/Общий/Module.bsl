//МодельЗапроса = Общий.МодельЗапроса(ТекстЗапроса);
//МодельЗапроса = Общий.МодельЗапроса(СхемаКомпоновкиДанных, НастройкиКомпоновкиДанных);
//МодельЗапроса = Общий.МодельЗапроса(ДинамическийСписок);
Функция МодельЗапроса(ТекстЗапроса = "", НастройкиКомпоновки = "") Экспорт
	МодельЗапроса = Обработки.МодельЗапроса.Создать();
	ТипЗначенияТекстаЗапроса = ТипЗнч(ТекстЗапроса);
	
	Если ТипЗначенияТекстаЗапроса = Тип("СхемаКомпоновкиДанных") Тогда
		Возврат МодельЗапроса.УстановитьСхемуКомпоновкиДанных(ТекстЗапроса, НастройкиКомпоновки);
	КонецЕсли;

	Если ТипЗначенияТекстаЗапроса = Тип("ТаблицаФормы") Тогда
		Возврат МодельЗапроса.УстановитьСхемуТаблицыСписка(ТекстЗапроса);
	КонецЕсли;
	
	Если ТипЗначенияТекстаЗапроса = Тип("ДинамическийСписок") Тогда
		Возврат МодельЗапроса.УстановитьСхемуДинамическогоСписка(ТекстЗапроса);
	КонецЕсли;
	
	Если ПустаяСтрока(ТекстЗапроса) Тогда
		Возврат МодельЗапроса;
	КонецЕсли;
	
	МодельЗапроса.УстановитьТекстЗапроса(ТекстЗапроса);
	Возврат МодельЗапроса;
КонецФункции
