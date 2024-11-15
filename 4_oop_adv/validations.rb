# frozen_string_literal: true

module Validations
  NUMBER_TRAIN_FORMAT = /^[а-яА-Яa-zA-Z0-9]{3}-?[а-яА-Яa-zA-Z0-9]{2}$/i.freeze

  protected

  def validate!
    begin
      case self
      when Station
        raise 'Название станции не может быть пустым!!!' if name.nil? || name.empty?
        raise 'Пробел после первого символа не допускается' if name =~ /^[wd]s/
      when Train
        raise 'Неверный формат номера поезда!!!' if number !~ NUMBER_TRAIN_FORMAT
      when Route
        raise "Станции #{station} не создана!!!" unless station.is_a?(Station)
      when Wagon
        raise ArgumentError, "Значение должно быть 1 или 2!!!, получено: #{option}" unless option =~ /A[12]z/
        raise 'Введите корректное значение вагона!!! Это поле не может быть пустым' if name.nil? || name.empty?
      end
    rescue StandardError => e
      puts "Произошла ошибка класса #{e.class.name}: #{e.message}"
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end
  end
end