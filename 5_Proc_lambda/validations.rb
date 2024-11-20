module Validations
  # Регулярное выражение для проверки формата номера поезда
  NUMBER_TRAIN_FORMAT = /^[а-яА-Яa-zA-Z0-9]{3}-?[а-яА-Яa-zA-Z0-9]{2}$/i.freeze

  def validate!
    case self
    when Station
      validate_station
    when Train
      validate_train
    when Route
      validate_route
    when Wagon
      validate_wagon
    else
      raise "Неизвестный тип для валидации: #{self.class}"
    end
  end

  def validate_station
    begin
      raise 'Название станции не может быть пустым!' if name.nil? || name.empty?
      # Здесь можно добавить другие валидации для Station, если нужно
    rescue StandardError => e
      puts "Ошибка валидации для станции: #{e.message} (#{self.class})"
    end
  end

  def validate_train
    begin
      raise 'Неверный формат номера поезда!' if number !~ NUMBER_TRAIN_FORMAT
      # Здесь можно добавить другие валидации для Train, если нужно
    rescue StandardError => e
      puts "Ошибка валидации для поезда: #{e.message} (#{self.class})"
    end
  end

  def validate_route
    begin
      raise 'Начальная станция не может быть пустой!' if @first_station.nil?
      raise 'Конечная станция не может быть пустой!' if @last_station.nil?
      raise 'Начальная и конечная станция не могут быть одинаковыми!' if @first_station == @last_station
    rescue StandardError => e
      puts "Ошибка валидации для маршрута: #{e.message} (#{self.class})"
    end
  end

  def validate_wagon
    begin
      raise ArgumentError, "Значение должно быть 1 или 2!!!, получено: #{option}" unless option =~ /A[12]z/
      raise 'Введите корректное значение вагона! Это поле не может быть пустым' if name.nil? || name.empty?
      raise 'Количество не может быть равно нулю!' if amount.nil? || amount == 0
    rescue StandardError => e
      puts "Ошибка валидации для вагона: #{e.message} (#{self.class})"
    end
  end

  def valid?
    validate!
    true
  rescue StandardError => e
    # Выводим сообщение об ошибке, если возникла ошибка валидации на уровне класса
    puts "Общая ошибка валидации: #{e.message} (#{self.class})"
    false
  end
end