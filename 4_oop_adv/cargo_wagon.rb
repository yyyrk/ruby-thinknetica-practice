require_relative 'wagon'

class CargoWagon < Wagon
  def initialize
    super(:cargo)
    validate!
  end
end