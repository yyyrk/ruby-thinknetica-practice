require_relative 'train'

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

    # ANSI коды
    color_reset = "\e[0m"
    color_header = "\e[34m" # Blue
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
        move_train
      when '9'
        list_wagons
      when '10'
        trains_on_station
      when '11'
        occupy_wagon
      else
        puts 'Такого пункта в меню не существует'
      end
    end
  end

  private # Делаем изолированным тк пользователю нет необходимости иметь доступ к этим функциям

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

  def list_stations
    @stations.each.with_index(1) do |station, index|
      if station.nil?
        puts "#{index}. Станция не найдена"
      else
        puts "#{index}. #{station} - #{station.name}"
      end
    end
  end

  def list_routes
    @routes.each.with_index(1) do |_route, index|
      puts "#{index}. Маршрут: #{@routes[index]} - #{@routes[index].all_stations}"
    end
  end

  def list_wagons
    @wagons.each.with_index(1) do |wagon, index|
      if wagon.is_a?(PassengerWagon)
        puts "#{index}. Пассажирский вагон #{wagon.number}: занято #{wagon.busy} / свободно #{wagon.unbusy} мест"
      elsif wagon.is_a?(CargoWagon)
        puts "#{index}. Грузовой вагон #{wagon.number}: занято #{wagon.busy} / свободно #{wagon.unbusy} объема"
      end
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
    else
      @routes << Route.new(choose_first_station, choose_last_station)
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
    puts '1. Создать пассажирский вагон'
    puts '2. Создать грузовой вагон'

    option = gets.strip

    case option
    when '1'
      puts 'Введите номер вагона:'
      number = gets.strip.to_i
      puts 'Введите количество мест:'
      places = gets.strip.to_i
      wagon = PassengerWagon.new(number, places)
      @wagons << wagon
      puts "Пассажирский вагон #{wagon.number} создан с #{places} местами"
    when '2'
      puts 'Введите номер грузового вагона:'
      number = gets.strip.to_i
      puts 'Введите вместимость грузового вагона (объем):'
      capacity = gets.strip.to_i
      wagon = CargoWagon.new(number, capacity)
      @wagons << wagon
      puts "Грузовой вагон #{wagon.number} создан с объемом #{capacity}."
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
    when option == '2'
      choose_train.back
    else
      puts 'неверный выбор'
    end
    puts choose_train.current_station
  end

  def trains_on_station
    print 'Введите номер станции: '
    list_stations
    station_number = gets.chomp.to_i

    # Проверяем, что введенный номер станции корректен
    if station_number < 1 || station_number > @stations.size
      puts "Неверный номер станции! Пожалуйста, выберите существующую станцию."
      return
    end

    # Получаем выбранную станцию
    station = @stations[station_number - 1]

    # Выводим список поездов на станции
    puts "На станции #{station.name} находятся поезда:"
    station.trains.each.with_index(1) do |train, index|
      puts "#{index}. Поезд №#{train.number}, тип: #{train.type}, скорость: #{train.current_speed}"
    end
  end

  def occupy_wagon
    print 'Введите номер вагона: '
    list_wagons
    wagon_number = gets.chomp.to_i

    wagon = @wagons[wagon_number - 1]

    if wagon.is_a?(PassengerWagon)
      wagon.take_place
      puts "Место в вагоне #{wagon.number} занято."
    elsif wagon.is_a?(CargoWagon)
      print 'Введите объем для загрузки: '
      volume = gets.chomp.to_i
      wagon.load_cargo(volume)
      puts "Объем в вагоне #{wagon.number} занят."
    else
      puts 'Неверный вагон'
    end
  end

  def list_trains
    puts 'Поезда на станции:'
    @trains.each(&:display_all_wagons)
  end

  def display_wagons
    puts 'Вагоны поезда:'
    @wagons.each do |wagon|
      puts "- #{wagon.number} - #{wagon.type} - занято: #{wagon.busy} / свободно: #{wagon.unbusy}"
    end
  end
end
