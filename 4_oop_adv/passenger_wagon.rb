require_relative 'wagon'

class PassengerWagon < Wagon
  def initialize
    super(:passenger)
    validate!
  end
end