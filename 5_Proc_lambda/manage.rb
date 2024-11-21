require_relative 'train'

class Manage
  attr_reader :wagons, :trains, :stations, :routes

  def initialize
    @wagons   = []
    @trains   = []
    @stations = []
    @routes   = []
  end

  def menu
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
    color_option = "\e[32m"   # Green
    color_exit   = "\e[31m"     # Red

    puts model_of_train
    puts line
    puts "#{border}               #{color_header}<<---- GLOBAL MENU ---->>#{color_reset}                   #{border}"
    puts line
    puts "#{border}  #{color_option}1. Создать станцию                                       #{color_reset}#{border}"
    puts "#{border}  #{color_option}2. Создать поезд                                         #{color_reset}#{border}"
    puts "#{border}  #{color_option}3. Создать вагон                                         #{color_reset}#{border}"
    puts "#{border}  #{color_option}4. Создать маршрут                                       #{color_reset}#{border}"
    puts "#{border}  #{color_option}5. Добавить/удалить станцию из маршрута                  #{color_reset}#{border}"
    puts "#{border}  #{color_option}6. Назначить поезду маршрут                              #{color_reset}#{border}"
    puts "#{border}  #{color_option}7. Добавить/отцепить вагон                               #{color_reset}#{border}"
    puts "#{border}  #{color_option}8. Отправить поезд по маршруту                           #{color_reset}#{border}"
    puts "#{border}  #{color_option}9. Вывести список вагонов у поезда                       #{color_reset}#{border}"
    puts "#{border}  #{color_option}10. Выводить список поездов на станции                   #{color_reset}#{border}"
    puts "#{border}  #{color_option}11. Занять место или объем в вагоне                      #{color_reset}#{border}"
    puts "#{border}  #{color_exit}0. Выйти из программы                                    #{color_reset}#{border}"
    puts line
    print "#{border} Выберите номер из меню: "
  end

  def choose
    loop do
      menu
      option = gets.strip
      case option
      when '0'
        break
      when '1'  then create_station
      when '2'  then create_train
      when '3'  then create_wagon
      when '4'  then create_route
      when '5'  then edit_route
      when '6'  then train_get_route
      when '7'  then manage_wagons
      when '8'  then move_train
      when '9'  then list_wagons
      when '10' then trains_on_station
      when '11' then occupy_wagon
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
    station = Station.new(name)
    @stations << station
    puts "Станция #{name} создана."
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

    case option
    when '1'
      train = PassengerTrain.new(number)
    when '2'
      train = CargoTrain.new(number)
    else
      puts 'Неверный тип поезда.'
      return
    end

    @trains << train
    puts "Поезд #{number} (#{train.type}) создан."
  end

  # 3. Создать вагон
  def create_wagon
    puts '1. Создать пассажирский вагон'
    puts '2. Создать грузовой вагон'

    option = gets.strip

    case option
    when '1'
      print 'Введите номер вагона: '
      number = gets.strip
      print 'Введите количество мест: '
      places = gets.strip.to_i
      wagon = PassengerWagon.new(number, places)
      @wagons << wagon
      puts "Пассажирский вагон #{wagon.number} с #{places} местами создан."
    when '2'
      print 'Введите номер грузового вагона: '
      number = gets.strip
      print 'Введите вместимость (объем): '
      capacity = gets.strip.to_i
      wagon = CargoWagon.new(number, capacity)
      @wagons << wagon
      puts "Грузовой вагон #{wagon.number} с вместимостью #{capacity} создан."
    else
      puts 'Неверный выбор.'
    end
  end

  # 4. Создать маршрут
  def create_route
    print 'Введите номер начальной станции в маршруте: '
    list_stations
    first_station = gets.strip.to_i - 1

    print 'Введите номер конечной станции в маршруте: '
    list_stations
    last_station = gets.strip.to_i - 1

    if first_station == last_station
      puts 'Начальная и конечная станции не могут быть одинаковыми.'
    else
      @routes << Route.new(@stations[first_station], @stations[last_station])
      puts "Маршрут создан: #{@stations[first_station].name} - #{@stations[last_station].name}"
    end
  end

  # 5. Добавить/удалить станцию из маршрута
  def edit_route
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
      puts 'Неверный выбор.'
    end
  end

  # 6. Назначить поезду маршрут
  def train_get_route
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
  end

  # 7. Добавить/отцепить вагон
  def manage_wagons
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
      puts 'Неверный выбор.'
    end
  end

  # 8. Отправить поезд по маршруту
  def move_train
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
      puts 'Неверный выбор.'
    end
  end

  # 9. Вывести список вагонов у поезда
  def list_wagons
    puts 'Вагоны:'
    @wagons.each.with_index(1) do |wagon, index|
      if wagon.is_a?(PassengerWagon)
        puts "#{index}. Пассажирский вагон #{wagon.number}: занято #{wagon.busy_places} / свободно #{wagon.unbusy_places} мест"
      elsif wagon.is_a?(CargoWagon)
        puts "#{index}. Грузовой вагон #{wagon.number}: занято #{wagon.busy} / свободно #{wagon.volume_free} объема"
      end
    end
  end

  # 10. Выводить список поездов на станции
  def trains_on_station
    print 'Введите номер станции: '
    list_stations
    station_number = gets.chomp.to_i - 1

    if station_number < 0 || station_number >= @stations.size
      puts 'Неверный номер станции.'
      return
    end

    station = @stations[station_number]

    puts "На станции #{station.name} находятся следующие поезда:"
    station.trains.each.with_index(1) do |train, index|
      puts "#{index}. Поезд №#{train.number}, тип: #{train.type}, скорость: #{train.current_speed} км/ч"
    end
  end

  # 11. Занять место или объем в вагоне
  def occupy_wagon
    print 'Введите номер вагона: '
    list_wagons
    wagon_number = gets.chomp.to_i - 1

    wagon = @wagons[wagon_number]

    if wagon.is_a?(PassengerWagon)
      wagon.take_seat  # Теперь вызываем take_seat для пассажирского вагона
      puts "Место в пассажирском вагоне #{wagon.number} занято."
    elsif wagon.is_a?(CargoWagon)
      print 'Введите объем для загрузки (в куб. метрах): '
      volume = gets.chomp.to_i
      wagon.load_cargo(volume)  # Используем метод load_cargo для грузового вагона
      puts "Объем в грузовом вагоне #{wagon.number} занят."
    else
      puts 'Неизвестный тип вагона.'
    end
  end


  # Добавио утилиты для вывода информации
  def list_stations
    @stations.each.with_index(1) do |station, index|
      puts "#{index}. #{station.name}"
    end
  end

  def list_routes
    @routes.each.with_index(1) do |route, index|
      puts "#{index}. Маршрут: #{route.first_station.name} - #{route.last_station.name}"
    end
  end

  def list_trains
    @trains.each.with_index(1) do |train, index|
      puts "#{index}. Поезд №#{train.number}, тип: #{train.type}, скорость: #{train.current_speed} км/ч"
    end
  end
end