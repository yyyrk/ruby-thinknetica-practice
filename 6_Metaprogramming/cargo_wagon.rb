require_relative 'wagon'
require_relative 'accessors'

class CargoWagon < Wagon
  def initialize(number, volume)
    super(number, :cargo, volume)
  end

  def load_cargo(volume)
    fill(volume)
  end

  def volume_free
    unbusy
  end

  def unload_cargo(volume)
    fill(-volume)
  end
end
