print "Введите свой рост: "
user_height = Integer(gets.chomp)
print "Введите свое имя: "
user_name = gets.chomp
ideal_weight = (user_height - 110) * 1.15
if ideal_weight < 0
  puts "Ваш вес уже оптимальный"
elsif
  puts "#{user_name}, ваш идеальный вес: #{ideal_weight.to_i}"
end
