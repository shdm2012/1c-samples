//Создаем справочник фото и туда добавляем реквизит Файл с Типом ХранилищеЗначения
//У формы другого справочника добавляем реквизит Фото тип строка, на форме Поле картинки
//Переходим в модуль и пишем следующее


&НаКлиенте
Процедура ДобавитьФото(Команда)
	
	ИмяФайла = "";
	ПутьФайла = "";
	Если ПоместитьФайл(ПутьФайла, , ИмяФайла, Истина) = Истина Тогда
		Фото = ПутьФайла;
		УстановитьКартинку();
	КонецЕсли; 
	
КонецПроцедуры

&НаСервере
Процедура УстановитьКартинку()
	
	НовыйФайлКартинки = Справочники.ФотоСотрудников.СоздатьЭлемент();
	НовыйФайлКартинки.Файл = Новый ХранилищеЗначения(ПолучитьИзВременногоХранилища(Фото));
	Фото = ПоместитьВоВременноеХранилище(НовыйФайлКартинки.Файл.Получить());
	НовыйФайлКартинки.Записать();
	
	Объект.Фото = НовыйФайлКартинки.Ссылка;
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Фото = ПолучитьНавигационнуюСсылку(Объект.Фото, "Файл");
	Элементы.Фото.РазмерКартинки = РазмерКартинки.АвтоРазмер;
	
КонецПроцедуры
