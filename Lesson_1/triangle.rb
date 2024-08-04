puts "Введите через 'Enter' значения 3-х сторон треугольника"
a = gets.chomp.to_f
b = gets.chomp.to_f
c = gets.chomp.to_f

if a + b > c && a + c > b && b + c > a
  if a == b && b == c
    puts "Ваш треугольник равносторонний"
  elsif a == b || b == c || a == c
    puts "Ваш треугольник равнобедренный"
  elsif a**2 + b**2 == c**2 || b**2 + c**2 == a**2 || a**2 + c**2 == b**2
    puts "Ваш треугольник прямоугольный"
  else
    puts "Ваш треугольник произвольный"
  end
else
  puts "Такого треугольника не существует"
end