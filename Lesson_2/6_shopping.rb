# Пользователь вводит поочередно название товара, цену за единицу и кол-во купленного товара (может быть нецелым числом).
# Пользователь может ввести произвольное кол-во товаров до тех пор, пока не введет "стоп" в качестве названия товара. 
# На основе введенных данных требуетеся:
#
# Заполнить и вывести на экран хеш, ключами которого являются названия товаров, а значением - вложенный хеш, 
# содержащий цену за единицу товара и кол-во купленного товара.
# Также вывести итоговую сумму за каждый товар.
# Вычислить и вывести на экран итоговую сумму всех покупок в корзине.

def print_separator(length = 85)
  puts '=' * length
end

def shopping_cart
  cart = {}

  loop do
    print "Название товара (или 'стоп' для завершения списка): "
    product_name = gets.chomp

    break if product_name.downcase == 'стоп'

    print "Цена: "
    unit_price = gets.chomp.to_f

    print "Количество: "
    quantity = gets.chomp.to_f

    cart[product_name] = { price: unit_price, quantity: quantity }
  end

  display_cart(cart)
end

def display_cart(cart)
  total_sum = 0.0

  print_separator

  cart.each do |name, details|
    item_total = details[:price] * details[:quantity]
    total_sum += item_total

    puts '-' * 85
    puts format(
      "Товар: #{name} | Цена за единицу: #{details[:price]} | " \
      "Количество: #{details[:quantity]} | Итоговая сумма: #{item_total}"
    )
    puts '-' * 85
  end

  print_separator

  puts "\nИтоговая сумма всех покупок: #{total_sum}"
end

shopping_cart
