class Station

  include Manufactures
  include InstanceCounter
  attr_reader :station_name, :trains_on_station
  @@all_stations = []

  def self.all
    @@all_stations
  end

  def initialize(station_name)
    @name = station_name
    validate!
    @trains_on_station = []
    @@all_stations << self
    puts "Создана станция #{station_name}"
    register_instance
  end

  def valid?
    validate!
  rescue
    false
  end

  def get_train(train)
    @trains_on_station << train
    puts "Поезд #{train} прибыл на станцию #{@name}"
  end

  def all_train
    puts "Поезда на станции #{@name}: #{@trains_on_station}"
  end

  def type_train(type)
    @trains.select { |train| train.type == type }.count
  end

  def train_out(train)
    puts "Поезд #{@trains_on_station.delete(train)} покидает станцию #{@name}"
    @trains_on_station.delete(train)
  end

  def validate!
    raise "Название станции не может быть пустым!" if name.nil?
    raise "Название станции не может быть пустым!" if name.strip.empty?
    raise "Название станции должно содержать не менее 3 символов" if name.length < 2
    true
  end
end