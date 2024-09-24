puts "Введи 3 коэффициента 'a', 'b' и 'c' своего квадратичного уравнения через 'Enter'"
a = gets.chomp.to_f
b = gets.chomp.to_f
c = gets.chomp.to_f

sleep(0.5)

puts "Ваше уравнение имеет вид: #{a}x**2 + #{b}x + #{c} = 0\nВерно? (Напиши ответ: 'y' или 'n')"
answer = gets.chomp

discriminant = b**2 - 4*a*c

if answer == 'y'
  if discriminant < 0
    puts "Корней нет!"
  elsif discriminant == 0
    x = -b / (2 * a)
    puts <<-END
Вывожу решение для вашего квадратичного уравнения:
Дискриминант = #{discriminant}
Корень = #{x}
END
  else
    quadratic_d = Math.sqrt(discriminant)
    x1 = (-b + quadratic_d) / (2 * a)
    x2 = (-b - quadratic_d) / (2 * a)
    puts <<-END
Вывожу решение для вашего квадратичного уравнения:
Дискриминант = #{discriminant}
Первый корень = #{x1}
Второй корень = #{x2}
END
  end
elsif answer == 'n'
  puts "Введи повторно 3 коэффициента 'a', 'b' и 'c' своего квадратичного уравнения через 'Enter'"
  a = gets.chomp.to_f
  b = gets.chomp.to_f
  c = gets.chomp.to_f

  discriminant = b**2 - 4*a*c

  if discriminant < 0
    puts "Корней нет!"
  elsif discriminant == 0
    x = -b / (2 * a)
    puts <<-END
Вывожу решение для вашего квадратичного уравнения:
Дискриминант = #{discriminant}
Корень = #{x}
END
  else
    quadratic_d = Math.sqrt(discriminant)
    x1 = (-b + quadratic_d) / (2 * a)
    x2 = (-b - quadratic_d) / (2 * a)
    puts <<-END
Вывожу решение для вашего квадратичного уравнения:
Дискриминант = #{discriminant}
Первый корень = #{x1}
Второй корень = #{x2}
END
  end
else
  puts "Сэр, вы ввели что-то не то..."
end
