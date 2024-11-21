class Wagon
  attr_reader :number, :type, :amount, :busy, :unbusy

  def initialize(number, type, amount)
    @number    = number
    @type      = type
    @amount    = amount
    @busy      = 0
    @unbusy    = amount
    validate!
  end

  # Добавил метод fiil для уменьшения дублирования кода для подклассов
  def fill(amount)
    new_busy  = @busy + amount
    if valid_fill?(new_busy)
      @busy   = new_busy
      @unbusy = @amount - @busy
    else
      raise "Недостаточно места"
    end
  end

  def valid_fill?(new_busy)
    new_busy >= 0 && new_busy <= @amount
  end

  protected

  # Добавил универсальную валидацию для всех типов вагонов
  def validate!
    raise ArgumentError, "Номер вагона не может быть пустым" if @number.nil? || @number.empty?
    raise ArgumentError, "Тип вагона не может быть пустым" if @type.nil? || @type.empty?
    raise ArgumentError, "Количество мест должно быть больше нуля" if @amount <= 0
  end
end