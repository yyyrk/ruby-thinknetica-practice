class Manage
  attr_reader :wagons, :trains, :stations, :routes

  def initialize
    @wagons = []
    @trains = []
    @stations = []
    @routes = []
  end

  def menu
    puts '=' * 60
    puts '       МЕНЮ:'
    puts '-' * 60
    puts '1. Создать станцию'
    puts '2. Создать поезд'
    puts '3. Создать вагон'
    puts '4_oop_adv. Создать маршрут'
    puts '5. Добавить/удалить станцию из маршрута'
    puts '6. Назначить поезду маршрут'
    puts '7. Добавить/отцепить вагон'
    puts '8. Отправить поезд по маршруту'
    puts '9. Показать список станций и список поездов на станции'
    puts '0. Выйти из программы'
    puts '=' * 60
    print 'Выберите номер из меню:'
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
      when '4_oop_adv'
        create_route
      when '5'
        train_get_route
      when '6'
        manage_wagons
      when '7'
        move_train
      when '8'
        trains_on_station
      else
        puts 'Такого пункта в меню не существует'
      end
    end
  end

  private #Делаем изолированным тк пользователю нет необходимости иметь доступ к этим функциям

  def create_station
    puts 'Введите название станции'
    name = gets.chomp.capitalize

    station = Station.new(name)
    @stations << station
    puts @stations
  end

  def create_train
    puts 'Введите номер поезда в формате ХХХХ'
    number = gets.chomp

    puts 'Введите тип создаваемого поезда
  1. Грузовой
  2. Пассажирский'

    option = gets.strip

    case option
    when '1'
      train = PassengerTrain.new(number)
      @trains << train
      puts @trains
    when '2'
      train = CargoTrain.new(number)
      @trains << train
      puts @trains
    else
      puts 'Выбран неправильный вариант'
    end
  end

  def list_stations
    @stations.each.with_index(1) do |station, index|
      puts "#{index}. #{@stations[index]} - #{@stations[index].name}"
    end
  end

  def list_trains
    @trains.each.with_index(1) do |train, index|
      puts "#{index}. Поезд #{@trains[index].number} - тип #{@trains[index].type} "
    end
  end

  def list_routes
    @routes.each.with_index(1) do |route, index|
      puts "#{index}. Маршрут: #{@routes[index]} - #{@routes[index].all_stations}"
    end
  end

  def list_wagons
    @wagons.each.with_index(1) do |wagon, index|
      puts "#{index}. Вагон: #{wagon.type}"
    end
  end

  def create_route
    puts 'Введите порядковый номер начальной станции в маршруте'
    list_stations
    first_station = gets.chomp.to_i
    choose_first_station = @stations[first_station - 1]

    puts 'Введите порядковый номер конечной станции в маршруте'
    list_stations
    last_station = gets.chomp.to_i
    choose_last_station = @stations[last_station - 1]

    if first_station == last_station
      puts 'Начальная и конечная станция не могут иметь один и тот же порядковый номер'
    else @routes << Route.new(choose_first_station, choose_last_station)
    end

    puts "Начальная станция маршрута: #{choose_first_station}. Конечная станция маршрута: #{choose_last_station}"
  end

  def edit_route
    puts 'Редактирование маршрута:
  1. Добавить станцию
  2. Удалить станцию'

    option = gets.chomp

    puts 'Введите порядковый номер маршрута'
    list_routes
    route_number = gets.chomp.to_i

    choose_route = @routes[route_number - 1]

    puts 'Введите порядковый номер станции'
    list_stations
    station_number = gets.chomp.to_i

    choose_station = @stations[station_number - 1]

    case option
    when '1'
      choose_route.add_station(choose_station)
      p choose_route
    when '2'
      choose_route.delete_station(choose_station)
      p choose_route
    else
      p 'Неверный ввод'
    end
  end

  def train_get_route
    puts 'Введите порядковый номер маршрута'
    list_routes
    route_number = gets.chomp

    puts 'Введите порядковый номер поезда'
    list_trains
    train_number = gets.chomp

    choose_route = @routes[route_number - 1]
    choose_train = @trains[train_number - 1]

    choose_train.get_route(choose_route)
  end

  def create_wagon
    puts '1.Создать пассажирский вагон'
    puts '2.Создать грузовой вагон'

    option = gets.strip

    case option
    when '1'
      wagon = PassengerWagon.new
      @wagons << wagon
      p @wagons
    when '2'
      wagon = CargoWagon.new
      @wagons << wagon
      p @wagons
    else
      puts 'Такого варианта нет'
    end
  end

  def manage_wagons
    puts 'Выберите действие с вагоном:
  1.Присоединить вагон
  2.Отцепить вагон'
    option = gets.chomp

    print 'Выберите вагон'
    list_wagons
    wagon_number = gets.chomp

    print 'Выберите поезд'
    list_trains
    train_number = gets.chomp

    choose_wagon = @wagons[wagon_number - 1]
    choose_train = @trains[train_number - 1]

    case option
    when '1'
      choose_train.connect_wagon(choose_wagon)
      puts choose_train.all_wagons
    when option == '2'
      choose_train.delete_wagon(choose_wagon)
      puts choose_train.all_wagons
    else
      puts 'Такого варианта не существует'
    end
  end

  def move_train
    puts 'Движение поезда:
  1.Перемещение поезда вперед
  2.Перемещение поезда назад'
    option = gets.chomp

    list_trains
    puts 'Выберите поезд из списка выше'
    train_number = gets.chomp.to_i

    choose_train = @trains[train_number - 1]
    puts choose_train.current_station

    case option
    when '1'
      choose_train.forward
    when  option == '2'
      choose_train.back
    else
      puts 'неверный выбор'
    end
    puts choose_train.current_station
  end

  def trains_on_station
    puts 'Введите номер станции'
    list_stations
    station = gets.chomp.to_i

    station = @stations[station - 1]

    puts "На станции #{station} находятся поезда:"

    station.trains.each { |i| print i }
  end
end