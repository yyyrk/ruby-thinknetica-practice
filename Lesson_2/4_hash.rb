# Заполнить хеш гласными буквами,
# где значением будет являтся порядковый номер буквы в алфавите (a - 1)

vowels = %w[a e i o u]
vowel_hash = {}

vowels.each_with_index do |vowel, index|
  vowel_hash[vowel] = index + 1
end

puts vowel_hash