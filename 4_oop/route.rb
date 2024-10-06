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