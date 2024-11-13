require_relative 'manufactures'

class Wagon
  include Manufactures

  attr_reader :type

  def initialize(type)
    @type = type
    validate!
  end

  def valid?
    validate!
  rescue
    false
  end

  def validate!
    raise "Число не может быть равно нулю" if number.nil?
    raise "Номер должен содержать не менее 4 символов" if number.length < 4
    raise "Тип не может быть равен нулю" if type.nil?
    raise "Шрифт должен содержать не менее 4 символов" if type.length < 4
    true
  end
end