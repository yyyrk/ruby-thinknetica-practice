class Route
  attr_reader :first_station, :last_station, :all_stations

  def initialize(first_station, last_station)
    @all_stations = [first_station, last_station]
    @first_station = first_station
    @last_station = last_station
    validate!
  end

  def valid?
    validate!
  rescue
    false
  end

  def add_station(station)
    @all_stations.insert(-2, station) unless @all_stations.include?(station)
    puts " Все станции:#{@all_stations}"
  end

  def delete_station(station)
    @all_stations.delete(station) if (@all_stations[0] != station) && (@all_stations[-1] != station)
  end

  protected

  def validate!
    validate(first_station)
    validate(last_station)
    raise "На маршруте должны быть разные станции! (В данном случае первая: #{first_station.name}, а последняя: #{last_station.name}) " if first_station.name == last_station.name
    true
  end

  def validate(station)
    raise "Название станции не может быть пустым!" if station.nil?
    raise "Этот объект: #{station} - не является экземпляром класса Station!!!" unless station.class == Station
    raise "Название станции не может быть пустым!" if station.name.strip.empty?
  end

end