# frozen_string_literal: true

require_relative 'validations'
require_relative 'instance_counter'

class Route
  include InstanceCounter
  include Validations

  attr_reader :first_station, :last_station, :all_stations

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @all_stations = [first_station, last_station]
    validate!  # Вызываем валидацию
    register_instance
  end

  def add_station(station)
    insert_station(station) unless @all_stations.include?(station)
  end

  def delete_station(station)
    remove_station(station) if station_middle?(station)
  end

  private

  def insert_station(station)
    @all_stations.insert(-2, station)
  end

  def remove_station(station)
    @all_stations.delete(station)
  end

  def station_middle?(station)
    @all_stations.first != station && @all_stations.last != station
  end
end
