module Validations
  NUMBER_TRAIN_FORMAT = /^[а-яА-Яa-zA-Z0-9]{3}-?[а-яА-Яa-zA-Z0-9]{2}$/i.freeze



  def validate!
    begin
      case self
      when Station
        raise 'Название станции не может быть пустым!!!' if name.nil? || name.empty?
        raise 'Пробел после первого символа не допускается' if name =~ /^[wd]s/
      when Train
        raise 'Неверный формат номера поезда!!!' if number !~ NUMBER_TRAIN_FORMAT
      when Route
        validate(first_station)
        validate(last_station)
        raise "Станции #{station} не создана!!!" unless station.is_a?(Station)
        if first_station.name == last_station.name
          raise "На маршруте должны быть разные станции! (В этом случае первая: #{first_station.name}, а последняя: #{last_station.name})"
        end
      when Wagon
        raise ArgumentError, "Значение должно быть 1 или 2!!!, получено: #{option}" unless option =~ /A[12]z/
        raise 'Введите корректное значение вагона!!! Это поле не может быть пустым' if name.nil? || name.empty?
        raise 'Количество не может быть равно нулю!' if amount.nil?

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