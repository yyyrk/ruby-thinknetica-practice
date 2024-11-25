# frozen_string_literal: true

require_relative 'wagon'

class PassengerWagon < Wagon
  def initialize(number, seats)
    super(number, 'passenger', seats)
  end

  # Занимаем одно место
  def take_seat
    fill(1)
  end

  def busy_places
    busy
  end

  def unbusy_places
    unbusy
  end

  def total_places
    amount
  end
end
