require_relative 'train'
require_relative 'route'
require_relative 'station'
require_relative 'cargo_train'
require_relative 'passenger_train'

def main_menu
  puts "=" * 60
  puts " 1 - Создать станцию"
  puts " 2 - Создать поезд"
  puts " 3 - Создать маршрут"
  puts " 4 - Добавить станцию в маршрут"
  puts " 5 - Удалить станцию из маршрута"
  puts " 6 - Назначить маршрут поезду"
  puts " 7 - Добавить вагон к поезду"
  puts " 8 - Отцепить вагон от поезда"
  puts " 9 - Переместить поезд вперед"
  puts "10 - Переместить поезд назад"
  puts "11 - Просмотреть список станций"
  puts "12 - Просмотреть список поездов на станции"
  puts " 0 - Выход"
  puts "=" * 60
end

stations = []
trains = []
routes = []

loop do
  main_menu
  choice = gets.chomp.to_i

  case choice
  when 1
    puts "Введите название станции:"
    name = gets.chomp
    stations << Station.new(name)
    puts "Станция '#{name}' создана."

  when 2
    puts "Введите номер поезда:"
    number = gets.chomp
    puts "Введите тип поезда (passenger/cargo):"
    type = gets.chomp.downcase
    if type == 'passenger'
      trains << PassengerTrain.new(number, type)
      puts "Пассажирский поезд '#{number}' создан."
    elsif type == 'cargo'
      trains << CargoTrain.new(number, type)
      puts "Грузовой поезд '#{number}' создан."
    else
      puts "Неверный тип поезда."
    end

  when 3
    puts "Введите начальную станцию:"
    start_station_name = gets.chomp
    puts "Введите конечную станцию:"
    last_station_name = gets.chomp
    start_station = Station.new(start_station_name)
    last_station = Station.new(last_station_name)
    routes << Route.new(start_station, last_station)
    puts "Маршрут создан."

  when 4
    route = routes.last # Предположим, что мы добавляем к последнему созданному маршруту
    puts "Введите название станции для добавления:"
    station_name = gets.chomp
    station = Station.new(station_name)
    route.add_station(station)
    puts "Станция '#{station_name}' добавлена в маршрут."

  when 5
    route = routes.last # Предположим, что мы удаляем из последнего созданного маршрута
    puts "Введите название станции для удаления:"
    station_name = gets.chomp
    station = route.stations.find { |s| s.name == station_name }
    if station
      route.delete_station(station)
      puts "Станция '#{station_name}' удалена из маршрута."
    else
      puts "Станция не найдена в маршруте."
    end

  when 6
    puts "Введите номер поезда:"
    train_number = gets.chomp
    train = trains.find { |t| t.number == train_number }
    route = routes.last # Предположим, что мы назначаем последний маршрут
    if train && route
      train.select_route(route)
      puts "Маршрут назначен поезду '#{train_number}'."
    else
      puts "Поезд или маршрут не найдены."
    end

  when 7
    train_number = gets.chomp
    train = trains.find { |t| t.number == train_number }
    if train && train.speed.zero?
      wagon_type = train.is_a?(PassengerTrain) ? PassengerWagon : CargoWagon
      train.hitch_wagon(wagon_type.new)
      puts "Вагон доб

авлен к поезду '#{train_number}'."
    else
      puts "Поезд не найден или он движется."
    end

  when 8
    train_number = gets.chomp
    train = trains.find { |t| t.number == train_number }
    if train && train.speed.zero?
      train.unhitch_wagon
      puts "Вагон отцеплен от поезда '#{train_number}'."
    else
      puts "Поезд не найден или он движется."
    end

  when 9
    train_number = gets.chomp
    train = trains.find { |t| t.number == train_number }
    if train && train.next_station
      train.go_next_station
      puts "Поезд '#{train_number}' перемещен на следующую станцию."
    else
      puts "Поезд не найден или нет следующей станции."
    end

  when 10
    train_number = gets.chomp
    train = trains.find { |t| t.number == train_number }
    if train && train.previous_station
      train.go_previous_station
        puts "Поезд '#{train_number}' перемещен на предыдущую станцию."
    else
      puts "Поезд не найден или нет предыдущей станции."
    end

  when 11
    puts "Список станций:"
    stations.each { |station| puts station.name }

  when 12
    puts "Введите название станции для просмотра поездов:"
    station_name = gets.chomp
    station = stations.find { |s| s.name == station_name }
    if station
      puts "Поезда на станции '#{station_name}':"
      station.trains.each { |train| puts train.number }
    else
      puts "Станция не найдена."
    end

  when 0
    break

  else
    puts "Неверный выбор, попробуйте снова."
  end
end

puts "Выход из программы."