require_relative 'wagon'
require_relative 'acce'

class PassengerWagon < Wagon
  def initialize
    super(:passenger)
  end
end