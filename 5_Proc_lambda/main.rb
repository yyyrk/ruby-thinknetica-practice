require_relative 'train'
require_relative 'station'
require_relative 'route'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'
require_relative 'manage'
require_relative 'wagon'
require_relative 'validations'
require_relative 'manufactures'

# puts "Управляющий интерфейс"
start = Manage.new
start.choose

#       e@@@@@@@@@@@@@@@
#     @@@""""""""""
#    @" ___ ___________
#   II__[w] | [i] [z] |
#  {======|_|~~~~~~~~~|
# /oO--000'"`-OO---OO-'

# для отладки , чтобы не с нуля заполнять данные
def primary
  s11 = Station.new('NewYork')
  s12 = Station.new('Orlando')
  s13 = Station.new('Portlend')
  s14 = Station.new('Washington')
  s15 = Station.new('San Diego')
  s21 = Station.new('Chicago')
  s22 = Station.new('Detroit')
  s23 = Station.new('Pittsburg')
  s24 = Station.new('Atlanta')
  s25 = Station.new('Dallas')
  @stations = [s11, s15, s21, s25, s14, s13, s22, s24, s12, s23]
  # ------------- Routes
  r1 = Route.new(s11, s25)
  r1.add_station(s15)
  r1.add_station(s21)

  r2 = Route.new(s14, s22)
  r2.add_station(s13)
  r2.add_station(s24)

  r3 = Route.new(s23, s24)
  r3.add_station(s12)
  r3.add_station(s13)
  r3.add_station(s11)

  r4 = Route.new(s13, s24)
  r4.add_station(s22)
  r4.add_station(s23)
  r4.add_station(s25)
  r4.add_station(s14)

  @routes = [r1, r3, r2, r4]
  # ---------------- здесь  p - Passenger, c - Cargo, t - Train
  pt1 = PassengerTrain.new('P10-00')
  pt2 = PassengerTrain.new('P20-00')
  pt3 = PassengerTrain.new('P30-00')
  pt4 = PassengerTrain.new('P40-00')
  pt5 = PassengerTrain.new('P50-00')

  ct1 = CargoTrain.new('C1000')
  ct2 = CargoTrain.new('C2000')
  ct3 = CargoTrain.new('C3000')
  ct4 = CargoTrain.new('C4000')
  ct5 = CargoTrain.new('C5000')
  @trains = [pt1, pt2, pt3, pt4, pt5, ct1, ct2, ct3, ct4, ct5]

  # ----------------

  cw1 = CargoWagon.new('CW0001', 1000)
  cw2 = CargoWagon.new('CW0002', 1100)
  cw3 = CargoWagon.new('CW0003', 1200)
  cw4 = CargoWagon.new('CW0004', 1200)
  cw5 = CargoWagon.new('CW0005', 900)
  cw6 = CargoWagon.new('CW0006', 500)
  cw7 = CargoWagon.new('CW0007', 600)
  cw8 = CargoWagon.new('CW0008', 700)
  cw9 = CargoWagon.new('CW0009', 1300)
  cw10 = CargoWagon.new('CW0010', 1110)
  cw11 = CargoWagon.new('CW0011', 1210)
  cw12 = CargoWagon.new('CW0012', 1310)
  cw13 = CargoWagon.new('CW0013', 1420)
  cw14 = CargoWagon.new('CW0014', 950)
  cw15 = CargoWagon.new('CW0015', 1000)
  cw16 = CargoWagon.new('CW0016', 850)
  cw17 = CargoWagon.new('CW0017', 987)
  cw18 = CargoWagon.new('CW0018', 1250)
  cw19 = CargoWagon.new('CW0019', 1500)
  cw20 = CargoWagon.new('CW0020', 2000)

  pw1 = PassengerWagon.new('PW0001', 50)
  pw2 = PassengerWagon.new('PW0002', 45)
  pw3 = PassengerWagon.new('PW0003', 70)
  pw4 = PassengerWagon.new('PW0004', 70)
  pw5 = PassengerWagon.new('PW0005', 50)
  pw6 = PassengerWagon.new('PW0006', 60)
  pw7 = PassengerWagon.new('PW0007', 50)
  pw8 = PassengerWagon.new('PW0008', 30)
  pw9 = PassengerWagon.new('PW0009', 70)
  pw10 = PassengerWagon.new('PW0010', 70)
  pw11 = PassengerWagon.new('PW0011', 48)
  pw12 = PassengerWagon.new('PW0012', 50)
  pw13 = PassengerWagon.new('PW0013', 60)
  pw14 = PassengerWagon.new('PW0014', 50)
  pw15 = PassengerWagon.new('PW0015', 60)
  pw16 = PassengerWagon.new('PW0016', 50)
  pw17 = PassengerWagon.new('PW0017', 40)

  @wagons = [cw1, cw2, cw3, cw4, cw5, cw6, cw7, cw8, cw9, cw10, cw10, cw11, cw12, cw13, cw14, cw15, cw16, cw17, cw18,
             cw19, cw20, pw1, pw2, pw3, pw4, pw5, pw6, pw7, pw8, pw9, pw10, pw11, pw12, pw13, pw14, pw15, pw16, pw17]

  ct1.add_wagon(cw1)
  ct1.add_wagon(cw3)
  ct1.add_wagon(cw5)
  ct1.add_wagon(cw7)
  ct1.add_wagon(cw9)

  ct2.add_wagon(cw2)
  ct2.add_wagon(cw4)
  ct2.add_wagon(cw6)
  ct2.add_wagon(cw8)
  ct2.add_wagon(cw10)

  ct3.add_wagon(cw11)
  ct3.add_wagon(cw12)
  ct3.add_wagon(cw13)

  pt1.add_wagon(pw1)
  pt1.add_wagon(pw3)
  pt1.add_wagon(pw5)

  pt2.add_wagon(pw7)
  pt2.add_wagon(pw9)

  pt3.add_wagon(pw2)
  pt3.add_wagon(pw4)
  pt3.add_wagon(pw6)

  pt4.add_wagon(pw8)
  pt4.add_wagon(pw10)
end