# Бот «Что надеть сегодня?»

Бот, который рекомендует, как одеться сегодня по погоде.

В папке `data` лежат файлы с одеждой:

``` json
{
  "title": "<Название шмотки>",
  "type": "<Тип шмотки>",
  "temperature_range": "<Диапазон температур>"
}
```

Например,

``` json
{
  "title": "Шапка-ушанка",
  "type": "Шапка",
  "temperature_range": "(-20, -5)"
}

{
  "title": "Черная куртка",
  "type": "Куртка",
  "temperature_range": "(-5, +10)"
}
```

В ответ на любое сообщение, бот тащит данные о текущей температуре с openweathermap.org (для того города, который прописан в настройках) и генерирует подходящий набор одежды, по одной вещи каждого типа так, чтобы каждая из вещей соответствовала температуре.

# Демо

Можно постучаться к @somewardrobebot и посмотреть, как это работает.

# Автор

Вадим Венедиктов для курса по основам программирования на руби, goodprogrammer.ru
