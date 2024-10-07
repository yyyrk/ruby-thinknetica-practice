class PassengerTrain < Train
  def hitch_wagon(wagon)
    super if wagon.is_a?(PassengerWagon)
  end
end