# frozen_string_literal: true

class Wagon
  attr_reader :number, :type, :amount, :busy, :unbusy

  def initialize(number, type, amount)
    @number    = number
    @type      = type
    @amount    = amount
    @busy      = 0
    @unbusy    = amount
    validate!
  end

  def fill(amount)
    new_busy = @busy + amount
    raise 'Недостаточно места' unless valid_fill?(new_busy)

    @busy = new_busy
    @unbusy = @amount - @busy
  end

  def valid_fill?(new_busy)
    new_busy >= 0 && new_busy <= @amount
  end

  protected

  def validate!
    raise ArgumentError, 'Номер вагона не может быть пустым' if @number.to_s.strip.empty?
    raise ArgumentError, 'Тип вагона не может быть пустым' if @type.to_s.strip.empty?
    raise ArgumentError, 'Количество мест должно быть больше нуля' if @amount <= 0
  end
end
