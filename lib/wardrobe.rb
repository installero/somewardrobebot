class Wardrobe
  # Напишем аксессор переменной экземпляра @clothes_items, чтобы можно было
  # считывать и менять это поле прямо по ссылке wardrobe.clothes_item.
  attr_accessor :clothes_items

  # Конструктор создает пустой массив шмоток. Изначально гардероб пуст.
  def initialize
    @clothes_items = []
  end

  # Метод класса from_dir создает новый экземпляр класса (это альтернативный
  # конструктор), заполняет его шмотками из файла и возвращает ссылку на новый
  # экземпляр класса Wardrobe
  def self.from_dir(dir)
    wardrobe = self.new

    Dir["#{dir}/*.json"].each do |file|
      wardrobe.clothes_items << ClothesItem.new(file)
    end

    wardrobe
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
