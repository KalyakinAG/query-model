# Объектная модель работы со схемой запроса

[![OpenYellow](https://img.shields.io/endpoint?url=https://openyellow.neocities.org/badges/2/340940374.json)](https://openyellow.notion.site/openyellow/24727888daa641af95514b46bee4d6f2?p=d6c0fe70d0b541b3ad83127c3d1c402f&amp;pm=s) ![Версия](https://img.shields.io/badge/Версия_1С-8.3.25-yellow)

Объектная модель построена на использовании внешнего интерфейса библиотеки ["Работа со схемой запроса"](https://infostart.ru/1c/articles/811832/). Модель позволяет скрыть переменные контекста работы с библиотекой и использовать вызов методов в стиле текучего интерфейса.

[![Модель запроса](https://infostart.ru/bitrix/templates/sandbox_empty/assets/tpl/abo/img/logo.svg)](https://infostart.ru/public/1390402/)
### Оглавление:
- [Варианты программного конструктора](#варианты-программного-конструктора)
- [Быстрый старт](#быстрый-старт)
- [Примеры работы](#примеры-работы)
	- [Описание простого запроса](#описание-простого-запроса)
	- [Дополнение существующего текста запроса](#дополнение-существующего-текста-запроса)
- [Состав и установка](#состав-и-установка)
	- [Установить как расширение](#установить-как-расширение)
	- [Объединить с конфигурацией текущего проекта](#объединить-с-конфигурацией-текущего-проекта)
	- [Объединить с конфигурацией проекта KASL](#объединить-с-конфигурацией-проекта-kasl)
- [Зависимости](#зависимости)
## Варианты программного конструктора

```bsl
МодельЗапроса = Общий.МодельЗапроса();
МодельЗапроса = Общий.МодельЗапроса(ТекстЗапроса);
МодельЗапроса = Общий.МодельЗапроса(СхемаКомпоновкиДанных, НастройкиКомпоновкиДанных);
МодельЗапроса = Общий.МодельЗапроса(ДинамическийСписок);
```
## Быстрый старт

Быстро сгенерировать код с использованием модели запроса можно в [Конструкторе модели запроса](https://infostart.ru/1c/articles/811832/#_Toc512118900). Интерактивный конструктор позволяет по тексту запроса получить код модели. Возможна и обратная операция - по коду модели получить текст запроса.
## Примеры работы

Больше примеров можно найти в статьях:
- ["Модель запроса"](https://infostart.ru/1c/articles/1390402/)
- ["Снежинка для запроса"](https://infostart.ru/1c/articles/1456173/)
- ["Работа со схемой запроса"](https://infostart.ru/1c/articles/811832/)
### Описание простого запроса
```bsl
МодельЗапроса = Общий.МодельЗапроса()
;//  ЗАПРОС ПАКЕТА. Контрагенты
МодельЗапроса.ЗапросПакета("Контрагенты")
    .Выбрать()
        .Источник("Справочник._ДемоКонтрагенты")
        .Поле("Ссылка")
        .Поле("ИНН")
        .Поле("КПП")
        .Порядок("Ссылка")
        .Автопорядок()
;
//  Обработка результата
МодельЗапроса.ВыполнитьЗапрос();
Выборка = МодельЗапроса.ВыбратьРезультат("Контрагенты");
Пока Выборка.Следующий() Цикл
    Сообщить(СтрШаблон("%1 (%2/%3)", Выборка.Ссылка, Выборка.ИНН, Выборка.КПП));
КонецЦикла;
```
### Дополнение существующего текста запроса

```bsl
ТекстЗапроса = "ВЫБРАТЬ
|    Контрагенты.Ссылка КАК Ссылка,
|    Контрагенты.Код КАК Код,
|    Контрагенты.Наименование КАК Наименование
|ИЗ
|    Справочник._ДемоКонтрагенты КАК Контрагенты";
//  Конструктор модели запроса на основе существующего текста запроса
МодельЗапроса = Общий.МодельЗапроса(ТекстЗапроса)
    .Источник("РегистрСведений.ДополнительныеСведения")
    .ЛевоеСоединение(0, "ДополнительныеСведения")
        .Связь("Ссылка = Объект")
    .Поле("ДополнительныеСведения.*")
;
```
На выходе получится измененный текст запроса:
```bsl
Сообщить(МодельЗапроса.ТекстЗапроса());
```

```bsl
ВЫБРАТЬ
    Контрагенты.Ссылка КАК Ссылка,
    Контрагенты.Код КАК Код,
    Контрагенты.Наименование КАК Наименование,
    ДополнительныеСведения.Объект КАК Объект,
    ДополнительныеСведения.Свойство КАК Свойство,
    ДополнительныеСведения.Значение КАК Значение
ИЗ
    Справочник._ДемоКонтрагенты КАК Контрагенты
        ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ДополнительныеСведения КАК ДополнительныеСведения
        ПО (Контрагенты.Ссылка = ДополнительныеСведения.Объект)
```

## Состав и установка

Состав:
- Конфигурация (этот проект):
	- модуль библиотеки *РаботаСоСхемойЗапроса*
	- обработка *МодельЗапроса*, реализующая объектный интерфейс
- Внешняя обработка "Конструктор модели запроса" (отдельный проект)
- Внешняя обработка "Конструктор схемы запроса" (поставляется как есть)

Есть несколько вариантов установки:
1. Установить как расширение
2. Объединить с конфигурацией текущего проекта
3. Объединить с конфигурацией проекта KASL

Далее подробнее.
### Установить как расширение

Скачать расширение из последнего релиза проекта и установить в базу.
Требуется также установить расширения проектов из [зависимостей](#зависимости).
### Объединить с конфигурацией текущего проекта

Объединить с файлом конфигурации из последнего релиза проекта:
- Снять признак объединения с общих свойств
- Установить режим объединения с приоритетом в файле
Требуется также установить расширения проектов из [зависимостей](#зависимости).
### Объединить с конфигурацией проекта KASL

Объединить с файлом конфигурации из Демо-базы к статье [Модель запроса](https://infostart.ru/1c/articles/1390402/) или с конфигурацией **KASL.cf** из релиза:
- Установить режим объединения с приоритетом в файле
- Отметить по подсистемам файла:
	- KASL->[ОбщегоНазначения](https://github.com/KalyakinAG/common)
	- KASL->[АТДМассив](https://github.com/KalyakinAG/adt-array)
	- KASL->Модели->[МодельЗапроса](https://github.com/KalyakinAG/query-model)
	- KASL->Конструкторы->[КонструкторМодельЗапроса](https://github.com/KalyakinAG/query-model-constructor)
## Зависимости

- БСП (работает с версией 3 и выше)
- Общие модули из подсистемы [KASL->ОбщегоНазначения](https://github.com/KalyakinAG/common)
- Подсистема [АТДМассив](https://github.com/KalyakinAG/adt-array)
