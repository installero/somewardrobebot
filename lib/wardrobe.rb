class Wardrobe
  # Напишем аксессор переменной экземпляра @clothes_items, чтобы можно было
  # считывать и менять это поле прямо по ссылке wardrobe.clothes_item.
  attr_accessor :clothes_items

  # Конструктор создает пустой массив шмоток и наполняет его из указанной папки.
  # def initialize(dir)
  #   @clothes_items = []

  #   Dir["#{dir}/*.json"].each do |file|
  #     @clothes_items << ClothesItem.new(file)
  #   end
  # end

  def initialize
    url = "https://spreadsheets.google.com/feeds/list/1bPT458nCSWahOXu6FcRmv3ASWC1Yl0UuyiTlTRCBUAI/1/public/values?alt=json"

    uri = URI(url)

    response = Net::HTTP.get(uri)

    data = JSON.parse(response)

    entries = data["feed"]["entry"]

    @clothes_items = []

    entries.each do |entry|
      @clothes_items << ClothesItem.new(
        title: entry["gsx$title"]["$t"],
        type: entry["gsx$type"]["$t"],
        min_temp: entry["gsx$min-temp"]["$t"].to_i,
        max_temp: entry["gsx$max-temp"]["$t"].to_i
      )
    end
  end


  # Метод types возвращает все типы шмоток, которые есть в гардеробе
  def types
    @types ||= clothes_items.map { |item| item.type }.uniq
  end

  # Метод type_items возвращает все шмотки определенного типа
  def items_by_type(type)
    @clothes_items.select { |item| item.type == type }
  end

  # Метод suitable_items возваращает по одной шмотке каждого типа, подходящей
  # по температуре к переданному параметру
  def suitable_items(temperature)
    clothes_items = []

    types.each do |type|
      items = items_by_type(type).select { |item| item.suits_for?(temperature) }
      clothes_items << items.sample if items.any?
    end

    clothes_items
  end
end
