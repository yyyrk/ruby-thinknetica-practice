def primary
  # Станции
  s11 = Station.new('NewYork')
  s12 = Station.new('Orlando')
  s13 = Station.new('Portlend')
  s14 = Station.new('Washington')
  s15 = Station.new('San Diego')
  s21 = Station.new('Chicago')
  s22 = Station.new('Detroit')

  # Добавляем станции в массив
  @stations = [s11, s12, s13, s14, s15, s21, s22]

  # Маршруты
  r1 = Route.new(s11, s15)
  r1.add_station(s12)
  r1.add_station(s13)

  r2 = Route.new(s21, s22)
  r2.add_station(s14)
  r2.add_station(s15)

  # Добавляем маршруты в массив
  @routes = [r1, r2]

  # Поезда
  pt1 = PassengerTrain.new('P10-00')
  pt2 = PassengerTrain.new('P20-00')

  ct1 = CargoTrain.new('C1000')
  ct2 = CargoTrain.new('C2000')

  # Добавляем поезда в массив
  @trains = [pt1, pt2, ct1, ct2]

  # Вагоны
  pw1 = PassengerWagon.new('PW0001', 50)
  pw2 = PassengerWagon.new('PW0002', 45)

  cw1 = CargoWagon.new('CW0001', 1000)
  cw2 = CargoWagon.new('CW0002', 1100)

  # Добавляем вагоны в массив
  @wagons = [pw1, pw2, cw1, cw2]

  # Привязываем вагоны к поездам
  pt1.add_wagon(pw1)
  pt1.add_wagon(pw2)

  ct1.add_wagon(cw1)
  ct1.add_wagon(cw2)

  # # Тестирование добавленных данных
  # puts "Станции:"
  # @stations.each { |station| puts station.name }
  #
  # puts "\nМаршруты:"
  # @routes.each { |route| puts route.inspect }
  #
  # puts "\nПоезда:"
  # @trains.each { |train| puts train.inspect }
  #
  # puts "\nВагоны:"
  # @wagons.each { |wagon| puts wagon.inspect }
end