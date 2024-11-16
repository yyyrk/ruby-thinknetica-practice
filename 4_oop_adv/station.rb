require_relative 'manufactures'
require_relative 'instance_counter'
require_relative 'validations'

class Station

  include Manufactures
  include InstanceCounter
  include Validations

  attr_reader :name, :trains_on_station
  @@all_stations = []

  def self.all
    @@all_stations
  end

  def initialize(name)

    @name = name
    @trains_on_station = []

    validate!

    @@all_stations << self
    # puts "Создана станция #{station_name}"
    register_instance
  end

  def get_train(train)
    @trains_on_station << train
    # puts "Поезд #{train} прибыл на станцию #{@name}"
  end

  def all_train
    # puts "Поезда на станции #{@name}: #{@trains_on_station}"
  end

  def type_train(type)
    @trains.select { |train| train.type == type }.count
  end

  def train_out(train)
    # puts "Поезд #{@trains_on_station.delete(train)} покидает станцию #{@name}"
    @trains_on_station.delete(train)
  end

  # def valid?
  #   validate!(name)
  #   true
  # rescue RuntimeError
  #   false
  # end

  # private

  # def validate!(name)
  #   raise 'Название станции не может быть пустым!!!' if name.nil? || name.empty?
  # end
end