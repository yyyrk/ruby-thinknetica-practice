require_relative 'manufactures'
require_relative 'instance_counter'

class Train
  include InstanceCounter
  include Manufactures

  attr_reader :number, :current_speed, :all_wagons

  NUMBER_FORMAT = /^([da-zа-яё]){3}-?g<-1>{2}$/i.freeze # и кирилица и латиница

  @@trains = {}

  def self.find(number)
    @@trains[number]
  end

  def initialize(number)
    @number = number
    @all_wagons = []
    @current_speed = 0
    @station_number = 0
    @@trains[number] = self
    register_instance
  end

  def valid?
    validate!
  rescue
    false
  end

  def speedup(number)
    @current_speed = number
    puts "Ускорение поезда #{@current_speed}"
  end

  def current_speed
    puts "Текущая скорость поезда: #{@current_speed}"
  end

  def stop
    @current_speed = 0
    puts "Стоп! Скорость поезда: #{@current_speed}"
  end

  def connect_wagon(wagon)
    return unless @current_speed.zero? && (wagon.type == :cargo || wagon.type == :passenger)

    @all_wagons << wagon unless @all_wagons.include?(wagon)
  end

  def delete_wagon(wagon)
    if @current_speed.zero? && @all_wagons.positive?
      @all_wagons.delete(wagon)
    else
      puts 'Невозможно удалить вагон от поезда'
    end
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

  def validate!
    raise "Номер не должен быть пустым!" if number.nil?
    raise "Номер не должен быть пустым!" if number.to_s.empty?
    raise 'Номер должен быть в 5 символов' if number.strip.length.positive? && number.strip.length < 4
    raise "Номер имеет неверный формат! \n Верный номер должен быть в формате: XXX-X or XXXX \n   (где 'X' : 0-9 , a-z , A-Z ) " if number !~ NUMBER_FORMAT
    raise 'Значение не может быть пустым' if type.nil?
    raise 'Не менее 4 символов' if type.length < 4
  end
end
