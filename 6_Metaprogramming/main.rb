require_relative 'accessors'
require_relative 'validations'
require_relative 'manufactures'
require_relative 'instance_counter'

require_relative 'wagon'
require_relative 'station'
require_relative 'route'
require_relative 'train'

require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'

require_relative 'manage'


# Добавил метод, который инициализирует объекты
# primary

# Управляющий интерфейс
start = Manager.new
start.choose_option
