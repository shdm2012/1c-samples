&НаСервере
Функция ПолучитьДанныеНаСервере()
	
	HTTPСоединение = Новый HTTPСоединение("www.metaweather.com",443,,,,,Новый ЗащищенноеСоединениеOpenSSL, Ложь);
	HTTPЗапрос= Новый HTTPЗапрос("/api/location/638242/2019/11/16/");
	Попытка
		Результат =  HTTPСоединение.Получить(HTTPЗапрос); // Отправка запроса методом GET
		Тело = Результат.ПолучитьТелоКакСтроку(); // Здесь и будет JSON ответа
	Исключение
		// исключение здесь говорит о том, что запрос не дошел до HTTP-Сервера
		Сообщить("Произошла сетевая ошибка!");
		ВызватьИсключение;
	КонецПопытки;
	
	ЧтениеJSON = Новый ЧтениеJSON;
	//Или из строки
	ЧтениеJSON.УстановитьСтроку(Тело);
	//Или из файла	
	//ЧтениеJSON.ОткрытьФайл("C:\test.txt");	
	Данные = ПрочитатьJSON(ЧтениеJSON);	
	ЧтениеJSON.Закрыть();
	
	Возврат Данные.Получить(0);
	//ЧтениеJSON.Закрыть();
	
КонецФункции

Функция ПолучитьИконку(АббрПогоды)
	
	ФайлОтвет = ПолучитьИмяВременногоФайла();
	HTTPСоединение = Новый HTTPСоединение("www.metaweather.com",443,,,,,Новый ЗащищенноеСоединениеOpenSSL, Ложь);
	HTTPЗапрос= Новый HTTPЗапрос("/static/img/weather/png/64/"+АббрПогоды+".png");
	Попытка
		Результат =  HTTPСоединение.Получить(HTTPЗапрос,ФайлОтвет); // Здесь и будет JSON ответа
	Исключение
		// исключение здесь говорит о том, что запрос не дошел до HTTP-Сервера
		Сообщить("Произошла сетевая ошибка!");
		ВызватьИсключение;
	КонецПопытки;
	
	Возврат Новый ДвоичныеДанные(ФайлОтвет);
	
КонецФункции

&НаСервере
Процедура ЗагрузитьИконкуНаСервере()
	
	  БинДанные = ПолучитьИконку(Тз.Получить(0).АббревиатураПогоды);
	СпрОбъект = Справочники.Иконки.СоздатьЭлемент();
	СпрОбъект.Иконка = Новый ХранилищеЗначения(БинДанные);
	СпрОбъект.Записать();
	
	Иконка = ПолучитьНавигационнуюСсылку(СпрОбъект, "Иконка");
	
КонецПроцедуры
	