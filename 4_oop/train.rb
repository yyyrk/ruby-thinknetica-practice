class Train
  attr_accessor :speed, :wagons
  attr_reader :current_station_index

  def initialize(number, type)
    @number = number
    @type = type
    @wagons = []
    @speed = 0
  end

  def stop
    @speed = 0
  end

  def hitch_wagon(wagon)
    # Метод защищаем, тк его нет необходимости вызывать извне. В данном случае он должен
    # использоваться только внутри класса или его наследника
    add_wagon(wagon) if speed.zero?
  end

  def unhitch_wagon
    # Метод защищаем, тк его нет необходимости вызывать извне. В данном случае он должен
    # использоваться только внутри класса или его наследника
    remove_wagon if speed.zero? && wagons.any?
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
    return nil unless @route && current_station_index < @route.stations.size - 1
    @route.stations[current_station_index + 1]
  end

  def previous_station
    return nil unless @route && current_station_index > 0
    @route.stations[current_station_index - 1]
  end

  def go_next_station
    @current_station_index += 1 if next_station
  end

  def go_previous_station
    @current_station_index -= 1 if previous_station
  end

  protected

  def add_wagon(wagon)
    wagons << wagon
  end

  def remove_wagon
    wagons.pop
  end
end