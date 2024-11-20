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

    # ANSI escape codes for colors
    color_reset = "\e[0m"
    color_header = "\e[34m"  # Blue
    color_option = "\e[32m"   # Green
    color_exit = "\e[31m"     # Red

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
    puts "#{border}  #{color_option}10. Выводить список поездов на станции                    #{color_reset}#{border}"
    puts "#{border}  #{color_option}11. Занять место или объем в вагоне                       #{color_reset}#{border}"
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
      when '9'
        trains_on_station
      when '10'
        look_trains_by_stations(" - - - - list stations for select - - - - #{message_return} ", @stations)
      when '11'
        trains_on_station
      else
        puts 'Такого пункта в меню не существует'
      end
    end
  end

  private #Делаем изолированным тк пользователю нет необходимости иметь доступ к этим функциям

  def create_station
    print 'Введите название вашей станции: '
    name = gets.chomp.capitalize

    station = Station.new(name)
    @stations << station
    puts @stations
  end

  def create_train
    print 'Введите номер поезда в формате ХХХ-Х или ХХХХХ  (примеры:ABC12, 123-AB, A1B-34, XYZ99): '
    number = gets.chomp

    print 'Введите тип создаваемого поезда
  1. Пассажирский
  2. Грузовой

  Номер типа поезда: '

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

  # def list_stations
  #   @stations.each.with_index(1) do |station, index|
  #     puts "#{index}. #{@stations[index]} - #{@stations[index].name}"
  #   end
  # end ---- Ошибочный код, внизу корректный, позже удалю этот коммент

  def list_stations
    @stations.each.with_index(1) do |station, index|
      if station.nil?
        puts "#{index}. Станция не найдена"
      else
        puts "#{index}. #{station} - #{station.name}"
      end
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
    print 'Введите порядковый номер начальной станции в маршруте: '
    list_stations
    first_station = gets.chomp.to_i
    choose_first_station = @stations[first_station - 1]

    print 'Введите порядковый номер конечной станции в маршруте: '
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

    print 'Введите порядковый номер маршрута: '
    list_routes
    route_number = gets.chomp.to_i

    choose_route = @routes[route_number - 1]

    print 'Введите порядковый номер станции: '
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
    print 'Введите порядковый номер маршрута: '
    list_routes
    route_number = gets.chomp

    print 'Введите порядковый номер поезда: '
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
    print 'Выберите поезд из списка выше: '
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
    print 'Введите номер станции: '
    list_stations
    station = gets.chomp.to_i

    station = @stations[station - 1]

    puts "На станции #{station} находятся поезда:"

    station.trains.each { |i| print i }
  end
end