# Класс ClothesItem, который все знает про одну шмотку. Хранит всю информацию
# о ней, знает, для какой температуры она подходит, для какой нет.
class ClothesItem
  # Напишем геттеры для удобства использования класса, чтобы мы могли достать
  # любую переменную экземпляра просто вызвав clothes_item.title
  attr_reader :title, :type, :min_temp, :max_temp

  # В конструктор передаем имя файла, в котором лежит описание вещи в формате
  #
  # <Название шмотки>
  # <Тип шмотки>
  # <Диапазон температур>
  def initialize(hash)
    @title = hash[:title]
    @type = hash[:type]
    @min_temp = hash[:min_temp]
    @max_temp = hash[:max_temp]
  end

  # Метод suits_for_temperature? отвечает на вопрос, подходит эта вещь для
  # той температуры, которую мы передадим ему в качестве паарметра
  def suits_for?(temperature)
    temperature.between?(@min_temp, @max_temp)
  end

  # Метод to_s просто выводит все параметры элемента одежды одной строкой
  def to_s
    "#{@title}, #{@type} от #{@min_temp} до #{@max_temp}"
  end
end
