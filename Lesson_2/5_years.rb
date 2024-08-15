# Заданы три числа, которые обозначают число, месяц, год (запрашиваем у пользователя).
# Найти порядковый номер даты, начиная отсчет с начала года.
# Учесть, что год может быть високосным.
# (Запрещено использовать встроенные в ruby методы для этого вроде Date#yday или Date#leap?)
# Алгоритм опредления високосного года: docs.microsoft.com

# Функция, которая проверяет является ли год високосным
def leap_year?(year)
  (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)
end

# Функция, которая определяет количество дней в месяце
def days_in_month(month, year)
  case month
  when 1, 3, 5, 7, 8, 10, 12
    31
  when 4, 6, 9, 11
    30
  when 2
    leap_year?(year) ? 29 : 28 #тернарный оператор, который имеет формат: условие ? значение_если_истина : значение_если_ложь
  else
    0
  end
end

# Функция для вычисления порядкового номера даты
def ordinal_date(day, month, year)
  total_days = day

# Суммируем дни всех предыдущих месяцев
  (1...month).each do |m|
    total_days += days_in_month(m, year) # Добавляем дни каждого месяца до текущего
  end

  total_days # Возвращаем общую сумму дней
end

puts "Введите день:"
day = gets.to_i

puts "Введите месяц:"
month = gets.to_i

puts "Введите год:"
year = gets.to_i

# Проверка "на дурака"
if month < 1 || month > 12 || day < 1 || day > days_in_month(month, year)
  puts "Некорректная дата."
else
  ordinal_number = ordinal_date(day, month, year)
  puts "Порядковый номер даты: #{ordinal_number}"
end