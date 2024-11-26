require_relative 'validations'
require_relative 'accessors'

class Wagon
  include Validation
  include Accessors

  attr_reader :number, :type, :amount, :busy, :unbusy

  # attr_accessor_with_history :number, :type, :amount

  # strong_attr_accessor :amount, Integer

  validate :number, :presence
  validate :type, :presence
  validate :type, :type, Symbol
  validate :amount, :type, Integer
  validate :amount, :presence

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
end
