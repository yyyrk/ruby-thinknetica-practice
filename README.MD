# Моё хранилище решенных ruby задачек

Здесь я регулярно буду выкладывать решения задач от школы программирования Thinktetica. Важная заметка - несколько уроков я сохранял в 4 урок и не создавал новые папки, поэтому в 5 идут сразу блоки.


## Важные ссылки для любого Ruby разработчика

0. **Основа основ - грамотный стиль кода.** Это репозиторий с описанием правил и рекомендаций о том как писать красивый, удобный и эффективный код для себя и других разработчиков [ruby-style-guide-RU](https://github.com/arbox/ruby-style-guide/blob/master/README-ruRU.md)

1. **Официальная документация Ruby**: Это основной источник информации о языке Ruby, его синтаксисе и стандартной библиотеке. Вы можете найти её по адресу [ruby-doc.org](https://www.ruby-doc.org).

2. **Ruby on Rails**: Если вы работаете с фреймворком Ruby on Rails, официальная документация по Rails будет незаменима. Она доступна на [rubyonrails.org](https://rubyonrails.org).

3. **RubyGems**: Это система управления пакетами для Ruby. На сайте [rubygems.org](https://rubygems.org) вы можете найти и установить различные библиотеки и гемы.

4. **RDoc**: Это инструмент для документирования Ruby-кода. Он позволяет создавать документацию для ваших проектов и доступен на [rdoc.github.io](https://rdoc.github.io).

5. **Сообщество и форумы**: Участие в сообществах, таких как Stack Overflow или Reddit, может помочь вам получить ответы на вопросы и обменяться опытом с другими разработчиками.

6. **RubyFlow**: Это ресурс, где публикуются статьи и новости о Ruby. Он может быть полезен для получения актуальной информации и обучения новым техникам. Сайт доступен по адресу [rubyflow.com](http://rubyflow.com).

## Ссылки с мини-курсами для моей само подготовки. Для повторения основ.

1. по командной строке https://linuxsurvival.com/linux-tutorial-introduction/
2. по git https://learngitbranching.js.org/
3. по git на русском http://githowto.com/ru

## Полезные материалы:

- Cheat Sheet по консоли, Ruby и Rails [pragtob.info](http://www.pragtob.info/rails-beginner-cheatsheet/index.html)
- Мини-книга по командной строке https://launchschool.com/books/command_line
- Мини-книга по Git и Github https://launchschool.com/books/git




## Пример простого Ruby кода

```ruby
# передача блока как именованного аргумента:

def caps(str, &block)
  str.capitalize!
  block.call(str)
end

caps('abc') { |x| puts x }
```

## Ссылки которые оказались для меня полезными

-  Просто PDF с оновами [по рубикам](https://launchschool.com/books/githttps://www.rubyguides.com/wp-content/uploads/2019/11/ruby-reference-2019-optin.pdf)
- Классная статься [про блоки](https://online.pragmaticstudio.com/tour/courses/ruby-blocks/steps/4)
- Этот сайт мне просто понравился про рубин от [rubyguides](rubyguides.com)
