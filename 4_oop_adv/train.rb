class Train
  attr_reader :number, :current_speed, :all_wagons

  def initialize(number)
    @number = number
    @all_wagons = []
    @current_speed = 0
    @station_number = 0
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
    if @current_speed == 0 && (wagon.type == :cargo || wagon.type == :passenger)
      @all_wagons << wagon unless @all_wagons.include?(wagon)
    end
  end

  def delete_wagon(wagon)
    if @current_speed == 0 && @all_wagons > 0
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

  def next_station
    @route.all_stations[@station_number + 1]
  end

  def prev_station
    @route.all_stations[@station_number - 1] if @station_number != 0
  end
end