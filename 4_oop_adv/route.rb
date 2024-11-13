class Route
  attr_reader :first_station, :last_station, :all_stations

  def initialize(first_station, last_station)
    @all_stations = [first_station, last_station]
    @first_station = first_station
    @last_station = last_station
  end

  def add_station(station)
    @all_stations.insert(-2, station) unless @all_stations.include?(station)
    # puts " Все станции:#{@all_stations}"
  end

  def delete_station(station)
    @all_stations.delete(station) if (@all_stations[0] != station) && (@all_stations[-1] != station)
  end

  def valid?
    @stations.each { |station| validate!(station) }
    true
  rescue RuntimeError
    false
  end

  private

  def validate!(station)
    raise "Станции #{station} не создана!!!" unless station.is_a? Station
  end

end