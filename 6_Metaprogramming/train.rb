# frozen_string_literal: true

require_relative 'manufactures'
require_relative 'instance_counter'
require_relative 'validations'
require_relative 'accessors'

class Train
  include InstanceCounter
  include Manufactures
  include Validation
  extend Accessors

  attr_reader :number, :current_speed, :all_wagons

  attr_accessor_with_history :number

  strong_attr_accessor :current_speed, Integer

  @@trains = {}

  class << self
    def find(number)
      @@trains[number]
    end
  end

  validate :number, :presence
  validate :number, :format, /^[а-яА-Яa-zA-Z0-9]{3}-?[а-яА-Яa-zA-Z0-9]{2}$/i

  def initialize(number)
    self.number = number
    @all_wagons = []
    self.current_speed = 0
    @station_number = 0

    validate!

    @@trains[number] = self
    register_instance
  end

  def each_wagon(&block)
    all_wagons.each(&block)
  end

  def speed_up(speed)
    self.current_speed = speed
  end

  def stop
    self.current_speed = 0
  end

  def connect_wagon(wagon)
    return unless stopped? && valid_wagon?(wagon)

    @all_wagons << wagon unless all_wagons.include?(wagon)
  end

  def remove_wagon(wagon)
    return unless stopped? && all_wagons.any?

    all_wagons.delete(wagon)
  end

  def assign_route(route)
    @route = route
    @station_number = 0
    current_station.add_train(self)
  end

  def move_forward
    return unless next_station

    current_station.remove_train(self)
    @station_number += 1
    current_station.add_train(self)
  end

  def move_backward
    return unless previous_station

    current_station.remove_train(self)
    @station_number -= 1
    current_station.add_train(self)
  end

  def current_station
    @route&.all_stations[@station_number]
  end

  def next_station
    @route&.all_stations[@station_number + 1]
  end

  def previous_station
    @station_number.positive? ? @route&.all_stations[@station_number - 1] : nil
  end

  private

  def valid_wagon?(wagon)
    wagon.type == :cargo || wagon.type == :passenger
  end

  def stopped?
    current_speed.zero?
  end
end
