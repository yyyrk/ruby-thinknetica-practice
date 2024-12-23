require_relative 'manufactures'
require_relative 'instance_counter'
require_relative 'validations'

class Train
  include InstanceCounter
  include Manufactures
  include Validations

  attr_reader :number, :current_speed, :all_wagons


  @@trains = {}

  def self.find(number)
    @@trains[number]
  end

  def initialize(number)
    @number = number
    @all_wagons = []
    @current_speed = 0
    @station_number = 0

    validate! # Выполняю валидацию

    @@trains[number] = self # Теперь регистрируем объект только если он валиден
    register_instance
  end

  def speedup(number)
    @current_speed = number
    # puts "Ускорение поезда #{@current_speed}"
  end

  def current_speed
    p current_speed
  end

  def stop
    @current_speed = 0
    # puts "Стоп! Скорость поезда: #{@current_speed}"
  end

  def connect_wagon(wagon)
    return unless @current_speed.zero? && (wagon.type == :cargo || wagon.type == :passenger)

    @all_wagons << wagon unless @all_wagons.include?(wagon)
  end

  #добавил псевдоним для метода
  alias add_wagon connect_wagon

  def delete_wagon(wagon)
    @current_speed.zero? && @all_wagons.positive?
    @all_wagons.delete(wagon)
  end

  def get_route(route)
    @route = route
    @station_number = 0 unless @route.nil?
    current_station.get_train(self)
  end

  def forward
    return if next_station.nil?

    current_station.train_out(self)
    next_station.get_train(self)
    @station_number += 1
  end

  def back
    return if prev_station.nil?

    current_station.train_out(self)
    prev_station.get_train(self)
    @station_number -= 1
  end

  def current_station
    @route.all_stations[@station_number]
  end

  private

  def join_wagon?(wagon)
    type == wagon.type
  end

  def next_station
    @route.all_stations[@station_number + 1]
  end

  def prev_station
    @route.all_stations[@station_number - 1] if @station_number != 0
  end

  # def valid?
  #   validate!(number)
  #   true
  # rescue RuntimeError
  #   false
  # end
  #
  # protected
  #
  # def validate!(number)
  #   raise 'Неверный формат номера поезда!' if number !~ NUMBER_FORMAT
  # end
end