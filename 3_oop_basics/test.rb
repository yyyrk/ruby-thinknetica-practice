require_relative 'trains'

# Создание станций
station1 = Station.new("Станция 1")
station2 = Station.new("Станция 2")
station3 = Station.new("Станция 3")

# Создание маршрута
route = Route.new(station1, station3)
route.add_station(station2)

# Создание поезда
train = Train.new("Поезд 1", "пассажирский", 5)

# Присоединение маршрута к поезду
train.select_route(route)

# Проверка текущей станции
puts "Текущая станция: #{train.current_station}"

# Перемещение поезда на следующую станцию
train.go_next_station
puts "Текущая станция после перемещения: #{train.current_station}"

# Перемещение поезда на предыдущую станцию
train.go_previous_station
puts "Текущая станция после возврата: #{train.current_station}"

# Присоединение и отцепление вагонов
train.hitch_wagon
puts "Количество вагонов после прицепки: #{train.wagons}"

train.unhitch_wagon
puts "Количество вагонов после отцепки: #{train.wagons}"

# Проверка всех поездов на станции
station1.accept_train(train)
puts "Поезда на #{station1.instance_variable_get(:@name)}: #{station1.trains.map(&:number)}"