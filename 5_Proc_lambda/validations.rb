# frozen_string_literal: true

module Validations
  NUMBER_TRAIN_FORMAT = /^[а-яА-Яa-zA-Z0-9]{3}-?[а-яА-Яa-zA-Z0-9]{2}$/i.freeze

  def validate!
    case self
    when Station then validate_station
    when Train then validate_train
    when Route then validate_route
    when Wagon then validate_wagon
    else
      raise "Неизвестный тип для валидации: #{self.class}"
    end
  end

  def valid?
    validate!
    true
  rescue StandardError => e
    log_validation_error(e)
    false
  end

  private

  def validate_station
    raise 'Название станции не может быть пустым!' if name.to_s.strip.empty?
  end

  def validate_train
    raise 'Неверный формат номера поезда!' if number !~ NUMBER_TRAIN_FORMAT
  end

  def validate_route
    raise 'Начальная станция не может быть пустой!' if @first_station.nil?
    raise 'Конечная станция не может быть пустой!' if @last_station.nil?
    raise 'Начальная и конечная станция не могут быть одинаковыми!' if @first_station == @last_station
  end

  def validate_wagon
    raise 'Некорректный формат опции вагона!' unless option.to_s.match?(/\A[12]\z/)
    raise 'Название вагона не может быть пустым!' if name.to_s.strip.empty?
    raise 'Количество не может быть равно нулю или меньше!' if amount.to_i <= 0
  end

  def log_validation_error(error)
    puts "Ошибка валидации: #{error.message} (#{self.class})"
  end
end
