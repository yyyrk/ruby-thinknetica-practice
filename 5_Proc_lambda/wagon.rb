require_relative 'manufactures'

class Wagon
  include Manufactures

  attr_reader :number, :type, :amount, :busy, :unbusy

  def initialize(number, type, amount)
    @number    = number
    @type      = type
    @amount    = amount
    validate!
    @busy = 0
    @unbusy = amount
  end

  def fill(qtty)
    @busy = busy + qtty
    @busy = busy - qtty unless valid?
    @unbusy = amount - busy
  end

  def valid?
    validate!
  rescue
    false
  end

  protected

  attr_writer :number, :type, :speed, :route, :wagons

end