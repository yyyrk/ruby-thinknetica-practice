class Station
  attr_reader :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def accept_train(train)
    trains << train
  end

  def trains_by_type(type)
    trains.select {|train| train.type == type }
  end

  def send_train(train)
    trains.delete(train)
  end
end

class Route
  attr_reader :stations

  def initialize(start_station, last_station)
    @start_station = start_station
    @last_station = last_station
    @stations = [start_station, last_station]
  end

  def add_station(station)
    stations.insert(-2, station)
  end

  def delete_station(station)
    stations.delete(station)
  end
end

class Train
  attr_accessor :speed, :wagons
  attr_reader :current_station_index

  def initialize(number, type, wagons)
    @number = number
    @type = type
    @wagons = wagons
    @speed = 0
  end

  def stop
    @speed = 0
  end

  def hitch_wagon
    if speed == 0
      self.wagons += 1
    end
  end

  def unhitch_wagon
    if speed == 0 && wagons > 0
      @wagons -= 1
    end

  end

  def select_route(route)
    @route = route
    @current_station_index = 0
  end

  def current_station
    return nil unless @route
    @route.stations[current_station_index]
  end

  def next_station
    return nil unless @route && current_station_index < @route.stations.size - 1 # проверка, находится ли текущая станция в пределах массива
    @route.stations[current_station_index + 1]
  end

  def previous_station
    return nil unless @route && current_station_index > 0 # проверка, находится ли текущая станция в пределах массива
    @route.stations[current_station_index - 1]
  end

  def go_next_station
    @current_station_index += 1 if next_station
  end

  def go_previous_station
    @current_station_index -= 1 if previous_station
  end
end