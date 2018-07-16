require 'json'
require 'net/http'
require 'telegram/bot'

# Этот гем имеет смысл подключать, только если вы будете дебажить ваш код
require 'byebug'

# Подключаем файлы классов ClothesItem и Wardrobe
require_relative 'lib/clothes_item'
require_relative 'lib/wardrobe'
require_relative 'lib/open_weather_map'

# Настройки нашего бота, никогда не храните эти данные в репозитории
TOKEN = '653010945:AAFv1PDBZxg-lZsL1bcNRX3Rvhy5rNGfylk'
CITY = 'Москва'

# Создаем новый экземпляр класса Wardrobe, передавая методу класса (статическому
# методу) from_dir путь к папке со шмотками.
wardrobe = Wardrobe.from_dir(File.dirname(__FILE__) + '/data')

Telegram::Bot::Client.run(TOKEN) do |bot|
  bot.listen do |message|
    case message.text
    when '/start', '/start start'
      bot.api.send_message(
        chat_id: message.chat.id,
        text: "Здравствуй, #{message.from.first_name}"
      )
    else
      # Получаем погоду с openweathermap.org используя наш модуль
      hash = OpenWeatherMap.current_weather(CITY)
      temperature = hash[:main][:temp]

      bot.api.send_message(
        chat_id: message.chat.id,
        text: "По данным openweathermap.org в городе #{CITY} сейчас: #{temperature}°С"
      )

      # С помощью метода suitable_items экземпляра класса Wardrobe находим нужный нам
      # набор — по 1 шмотке каждого типа, подходящей по температуре.
      clothes_items = wardrobe.suitable_items(temperature)

      # Выводим все шмотки на экран просто передавая их методу puts по одной. Метод
      # puts сам вызовет у объекта, который ему передали, метод to_s.
      response_text = "Предлагаем сегодня надеть:\n"
      clothes_items.each { |item| response_text << "#{item}\n" }

      bot.api.send_message(
        chat_id: message.chat.id,
        text: response_text
      )
    end
  end
end
