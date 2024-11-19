class Manage
  attr_reader :wagons, :trains, :stations, :routes

  def initialize
    @wagons = []
    @trains = []
    @stations = []
    @routes = []
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
    puts model_of_train
    puts line
    puts "#{border}               <<---- GLOBAL MENU ---->>                  #{border}"
    puts line
    puts "#{border}  1. Создать станцию                                      #{border}"
    puts "#{border}  2. Создать поезд                                        #{border}"
    puts "#{border}  3. Создать вагон                                        #{border}"
    puts "#{border}  4. Создать маршрут                                      #{border}"
    puts "#{border}  5. Добавить/удалить станцию из маршрута                 #{border}"
    puts "#{border}  6. Назначить поезду маршрут                             #{border}"
    puts "#{border}  7. Добавить/отцепить вагон                              #{border}"
    puts "#{border}  8. Отправить поезд по маршруту                          #{border}"

    puts "#{border}  9. Вывести список вагонов у поезда                      #{border}"
    puts "#{border} 10. Выводить список поездов на станции                   #{border}"
    puts "#{border} 11. Занять место или объем в вагоне                      #{border}"

    puts "#{border}  0. Выйти из программы                                   #{border}"
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
      when '1'
        create_station
      when '2'
        create_train
      when '3'
        create_wagon
      when '4'
        create_route
      when '5'
        train_get_route
      when '6'
        manage_wagons
      when '7'
        move_train
      when '8'
        trains_on_station

      # when '9'
      #   trains_on_station
      # when '10'
      #   trains_on_station
      # when '11'
      #   trains_on_station

      else
        puts 'Такого пункта в меню не существует'
      end
    end
  end

  private

  def create_station
    print 'Введите название вашей станции: '
    name = gets.chomp.capitalize

    station = Station.new(name)
    @stations << station
    puts "Станция '#{name}' создана."
  end

  def create_train
    print 'Введите номер поезда в формате ХХХ-Х или ХХХХХ (примеры: ABC12, 123-AB, A1B-34, XYZ99): '
    number = gets.chomp

    print 'Введите тип создаваемого поезда:
1. Пассажирский
2. Грузовой

Номер типа поезда: '

    option = gets.strip

    case option
    when '1'
      train = PassengerTrain.new(number)
      @trains << train
      puts "Пассажирский поезд '#{number}' создан."
    when '2'
      train = CargoTrain.new(number)
      @trains << train
      puts "Грузовой поезд '#{number}' создан."
    else
      puts 'Выбран неправильный вариант.'
    end
  end

  def list_stations
    if @stations.empty?
      puts "Станции не найдены."
    else
      @stations.each.with_index(1) do |station, index|
        puts "#{index}. Станция: #{station.name}"
      end
    end
  end

  def list_trains
    if @trains.empty?
      puts "Поезда не найдены."
    else
      @trains.each.with_index(1) do |train, index|
        puts "#{index}. Поезд: #{train.number} - тип: #{train.type}"
      end
    end
  end

  def list_routes
    if @routes.empty?
      puts "Маршруты не найдены."
    else
      @routes.each.with_index(1) do |route, index|
        puts "#{index}. Маршрут: #{route.name} - Станции: #{route.all_stations.join(', ')}"
      end
    end
  end

  def list_wagons
    if @wagons.empty?
      puts "Вагоны не найдены."
    else
      @wagons.each.with_index(1) do |wagon, index|
        puts "#{index}. Вагон: #{wagon.type}"
      end
    end
  end

  def create_route
    print 'Введите порядковый номер начальной станции в маршруте: '
    list_stations

    first_station_index = gets.chomp.to_i - 1

    if first_station_index < 0 || first_station_index >= @stations.size
      puts "Некорректный номер станции."
      return
    end

    first_station = @stations[first_station_index]

    print 'Введите порядковый номер конечной станции в маршруте: '
    list_stations

    last_station_index = gets.chomp.to_i - 1

    if last_station_index < 0 || last_station_index >= @stations.size || last_station_index == first_station_index
      puts "Некорректный номер конечной станции."
      return
    end

    last_station = @stations[last_station_index]

    route = Route.new(first_station, last_station)
    @routes << route

    puts "Маршрут создан от '#{first_station.name}' до '#{last_station.name}'."
  end

  # Здесь добавьте реализацию метода add_cargo_or_occupy_space, если это необходимо.
end
