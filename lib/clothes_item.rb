# Класс ClothesItem, который все знает про одну шмотку. Хранит всю информацию
# о ней, знает, для какой температуры она подходит, для какой нет.
class ClothesItem
  # Напишем геттеры для удобства использования класса, чтобы мы могли достать
  # любую переменную экземпляра просто вызвав clothes_item.title
  attr_reader :title, :type, :temperature

  # В конструктор передаем имя файла, в котором лежит описание вещи в формате
  #
  # <Название шмотки>
  # <Тип шмотки>
  # <Диапазон температур>
  def initialize(file)
    content = File.read(file, encoding: 'UTF-8')
    hash = JSON.parse(content, symbolize_names: true)

    @title = hash[:title]
    @type = hash[:type]

    temp_min, temp_max = hash[:temperature_range].delete('() ').split(',')

    @temperature_range = (temp_min.to_i..temp_max.to_i)
  end

  # Метод suits_for_temperature? отвечает на вопрос, подходит эта вещь для
  # той температуры, которую мы передадим ему в качестве паарметра
  def suits_for?(temperature)
    @temperature_range.include?(temperature)
  end

  # Метод to_s просто выводит все параметры элемента одежды одной строкой
  def to_s
    "#{@title}, #{@type}, #{@temperature_range}"
  end
end
