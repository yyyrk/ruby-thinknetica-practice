# Заполнить массив числами фибоначчи до 100

fibonacci_numbers = []
a = 0
b = 1
# a, b = 0, 1

while a <= 100
  fibonacci_numbers << a
  a, b = b, a + b
end

puts fibonacci_numbers.inspect
