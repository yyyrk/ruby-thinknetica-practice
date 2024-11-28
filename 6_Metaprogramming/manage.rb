require_relative 'train'
require_relative 'accessors'
require_relative 'validations'
\





class Manager
  attr_reader :wagons, :trains, :stations, :routes

  def initialize
    @wagons   = []
    @trains   = []
    @stations = []
    @routes   = []
  end

  def show_menu
    model_of_train = %q(
___________   _______________________________________^__
 ___   ___ |||  ___   ___   ___    ___ ___  |   __  ,----\
|   | |   |||| |   | |   | |   |  |   |   | |  |  | |_____\
|___| |___|||| |___| |___| |___|  | O | O | |  |  |        \
           |||                    |___|___| |  |__|         |
___________|||______________________________|______________/
           |||                                        /-----
-----------'''---------------------------------------'
)
    border = '|'
    line = '=' * 60

    # ANSI коды
    color_reset  = "\e[0m"
    color_header = "\e[34m" # Blue
    color_option = "\e[32m" # Green
    color_exit   = "\e[31m" # Red

    puts model_of_train
    puts line
    puts "#{border}               #{color_header}<<---- GLOBAL MENU ---->>#{color_reset}                  #{border}"
    puts line
    puts "#{border}  #{color_option} 1. Создать станцию                                     #{color_reset}#{border}"
    puts "#{border}  #{color_option} 2. Создать поезд                                       #{color_reset}#{border}"
    puts "#{border}  #{color_option} 3. Создать вагон                                       #{color_reset}#{border}"
    puts "#{border}  #{color_option} 4. Создать маршрут                                     #{color_reset}#{border}"
    puts "#{border}  #{color_option} 5. Добавить/удалить станцию из маршрута                #{color_reset}#{border}"
    puts "#{border}  #{color_option} 6. Назначить поезду маршрут                            #{color_reset}#{border}"
    puts "#{border}  #{color_option} 7. Добавить/отцепить вагон                             #{color_reset}#{border}"
    puts "#{border}  #{color_option} 8. Отправить поезд по маршруту                         #{color_reset}#{border}"
    puts "#{border}  #{color_option} 9. Вывести список вагонов у поезда                     #{color_reset}#{border}"
    puts "#{border}  #{color_option}10. Выводить список поездов на станции                  #{color_reset}#{border}"
    puts "#{border}  #{color_option}11. Занять место или объем в вагоне                     #{color_reset}#{border}"
    puts "#{border}  #{color_exit} 0. Выйти из программы                                  #{color_reset}#{border}"
    puts line
    print "#{border} Выберите номер из меню: "
  end

  def choose_option
    loop do
      show_menu
      option = gets.strip
      case option
      when '0'   then break
      when '1'   then create_station
      when '2'   then create_train
      when '3'   then create_wagon
      when '4'   then create_route
      when '5'   then modify_route
      when '6'   then assign_route_to_train
      when '7'   then manage_wagons
      when '8'   then send_train_on_route
      when '9'   then show_wagons
      when '10'  then show_trains_at_station
      when '11'  then occupy_wagon
      else
        puts 'Такого пункта в меню не существует'
      end
    end
  end

  private

  # 1. Создать станцию
  def create_station
    print 'Введите название вашей станции: '
    name = gets.chomp.capitalize
    begin
      station = Station.new(name)

      station.validate!
      @stations << station
      puts "Станция #{name} создана."
    rescue StandardError => e
      puts "Ошибка при создании станции: #{e.message}. Станция не создана."
    end
  end


  # 2. Создать поезд
  def create_train
    print 'Введите номер поезда (например: ABC12, 123-AB): '
    number = gets.chomp

    print 'Выберите тип поезда:
  1. Пассажирский
  2. Грузовой
  Номер типа поезда: '
    option = gets.strip

    begin
      case option
      when '1'
        train = PassengerTrain.new(number)
      when '2'
        train = CargoTrain.new(number)
      else
        raise 'Неверный тип поезда.'
      end

      train.validate!
      @trains << train
      puts "Поезд #{number} (#{train.type}) создан."
    rescue StandardError => e
      puts "Ошибка при создании поезда: #{e.message}. Поезд не создан."
    end
  end


  # 3. Создать вагон
  def create_wagon
    puts '1. Создать пассажирский вагон'
    puts '2. Создать грузовой вагон'

    option = gets.strip

    begin
      case option
      when '1'
        print 'Введите номер вагона: '
        number = gets.strip
        print 'Введите количество мест: '
        places = gets.strip.to_i
        raise 'Количество мест должно быть положительным числом!' if places <= 0
        wagon = PassengerWagon.new(number, places)
        @wagons << wagon
        puts "Пассажирский вагон #{wagon.number} с #{places} местами создан."
      when '2'
        print 'Введите номер грузового вагона: '
        number = gets.strip
        print 'Введите вместимость (объем): '
        capacity = gets.strip.to_i
        raise 'Вместимость должна быть положительным числом!' if capacity <= 0
        wagon = CargoWagon.new(number, capacity)
        @wagons << wagon
        puts "Грузовой вагон #{wagon.number} с вместимостью #{capacity} создан."
      else
        raise 'Неверный выбор типа вагона.'  # Если выбран неверный тип вагона
      end
    rescue StandardError => e
      puts "Ошибка при создании вагона: #{e.message}. Вагон не создан."
    end
  end


  # 4. Создать маршрут
  def create_route
    begin
      print 'Введите номер начальной станции в маршруте: '
      list_stations
      first_station = gets.strip.to_i - 1

      print 'Введите номер конечной станции в маршруте: '
      list_stations
      last_station = gets.strip.to_i - 1

      if first_station == last_station
        raise 'Начальная и конечная станции не могут быть одинаковыми.'
      end

      route = Route.new(@stations[first_station], @stations[last_station])
      @routes << route
      puts "Маршрут создан: #{@stations[first_station].name} - #{@stations[last_station].name}"
    rescue StandardError => e
      puts "Ошибка при создании маршрута: #{e.message}. Маршрут не создан."
    end
  end

  # 5. Добавить/удалить станцию из маршрута
  def modify_route
    begin
      print 'Введите номер маршрута для редактирования: '
      list_routes
      route_number = gets.strip.to_i - 1

      route = @routes[route_number]
      puts '1. Добавить станцию'
      puts '2. Удалить станцию'
      option = gets.strip

      print 'Введите номер станции для добавления/удаления: '
      list_stations
      station_number = gets.strip.to_i - 1

      station = @stations[station_number]
      case option
      when '1'
        route.add_station(station)
        puts "Станция #{station.name} добавлена в маршрут."
      when '2'
        route.delete_station(station)
        puts "Станция #{station.name} удалена из маршрута."
      else
        raise 'Неверный выбор. Выберите 1 или 2.'
      end
    rescue StandardError => e
      puts "Ошибка при редактировании маршрута: #{e.message}. Изменения не применены."
    end
  end


  # 6. Назначить поезду маршрут
  def assign_route_to_train
    begin
      print 'Введите номер маршрута: '
      list_routes
      route_number = gets.strip.to_i - 1

      print 'Введите номер поезда: '
      list_trains
      train_number = gets.strip.to_i - 1

      route = @routes[route_number]
      train = @trains[train_number]

      train.get_route(route)
      puts "Поезду #{train.number} назначен маршрут #{route.first_station.name} - #{route.last_station.name}"
    rescue IndexError => e
      puts "Ошибка: Неверный номер маршрута или поезда. Попробуйте снова."
    rescue StandardError => e
      puts "Ошибка при назначении маршрута поезду: #{e.message}. Операция не выполнена."
    end
  end


  # 7. Добавить/отцепить вагон
  def manage_wagons
    begin
      print 'Выберите действие:
    1. Присоединить вагон
    2. Отцепить вагон'
      option = gets.strip

      print 'Выберите вагон: '
      list_wagons
      wagon_number = gets.strip.to_i - 1

      print 'Выберите поезд: '
      list_trains
      train_number = gets.strip.to_i - 1

      wagon = @wagons[wagon_number]
      train = @trains[train_number]

      case option
      when '1'
        train.connect_wagon(wagon)
        puts "Вагон #{wagon.number} присоединен к поезду #{train.number}."
      when '2'
        train.delete_wagon(wagon)
        puts "Вагон #{wagon.number} отцеплен от поезда #{train.number}."
      else
        raise 'Неверный выбор. Выберите 1 или 2.'
      end
    rescue StandardError => e
      puts "Ошибка при управлении вагонами: #{e.message}. Операция не выполнена."
    end
  end

  # 8. Отправить поезд по маршруту
  def send_train_on_route
    begin
      print '1. Переместить поезд вперед'
      print '2. Переместить поезд назад'
      option = gets.strip

      print 'Выберите поезд: '
      list_trains
      train_number = gets.strip.to_i - 1

      train = @trains[train_number]

      case option
      when '1'
        train.forward
        puts "Поезд #{train.number} перемещен вперед."
      when '2'
        train.back
        puts "Поезд #{train.number} перемещен назад."
      else
        raise 'Неверный выбор. Выберите 1 или 2.'
      end
    rescue StandardError => e
      puts "Ошибка при перемещении поезда: #{e.message}. Операция не выполнена."
    end
  end


  # 9. Вывести список вагонов у поезда
  def show_wagons
    puts 'Вагоны поезда:'
    print 'Выберите поезд: '
    list_trains
    train_number = gets.strip.to_i - 1
    train = @trains[train_number]
    train.show_wagons
  end

  # 10. Вывести список поездов на станции
  def show_trains_at_station
    print 'Выберите станцию: '
    list_stations
    station_number = gets.strip.to_i - 1
    station = @stations[station_number]
    station.show_trains
  end

  # 11. Занять место или объем в вагоне
  def occupy_wagon
    begin
      print 'Выберите вагон: '
      list_wagons
      wagon_number = gets.strip.to_i - 1
      wagon = @wagons[wagon_number]

      case wagon
      when PassengerWagon
        print 'Введите количество мест для бронирования: '
        places = gets.strip.to_i
        wagon.take_places(places)
        puts "#{places} мест забронировано в вагоне #{wagon.number}."
      when CargoWagon
        print 'Введите объем для бронирования: '
        volume = gets.strip.to_i
        wagon.take_capacity(volume)
        puts "#{volume} объема забронировано в вагоне #{wagon.number}."
      else
        raise 'Неизвестный тип вагона.'
      end
    rescue StandardError => e
      puts "Ошибка при бронировании: #{e.message}. Операция не выполнена."
    end
  end

  # Методы для вывода списков
  def list_stations
    @stations.each_with_index { |station, index| puts "#{index + 1}. #{station.name}" }
  end

  def list_routes
    @routes.each_with_index { |route, index| puts "#{index + 1}. #{route.first_station.name} - #{route.last_station.name}" }
  end

  def list_trains
    @trains.each_with_index { |train, index| puts "#{index + 1}. #{train.number}" }
  end

  def list_wagons
    @wagons.each_with_index { |wagon, index| puts "#{index + 1}. #{wagon.number}" }
  end
end
