class CargoTrain < Train
  def hitch_wagon(wagon)
    super if wagon.is_a?(CargoWagon)
  end
end