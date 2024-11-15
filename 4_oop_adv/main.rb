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