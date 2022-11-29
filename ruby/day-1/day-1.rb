# 打印字符串 "Hello, world."。
puts 'Hello, world.'

# 在字符串 "Hello, Ruby."中，找出"Ruby."所在下标。
'Hello, Ruby.'.index('Ruby.')

# 打印你的名字十遍
(1..10).each {puts 'jack'}

# 打印字符串 "This is sentence number 1. "， 其中的数字1会一直变化到10.
(1..10).each do |i|
   puts "This is sentence number #{i}"
end
    
# 从文件运行 Ruby 程序。
ruby day-1.rb

# 写一个选随机数的程序。该程序让玩家猜随机数是多少？并告诉玩家是猜大了还是猜小了。
num = rand(10)
begin
    puts '输入数字'
    guess = gets.to_i
    puts '太大'  if num < guess
    puts '太小'  if num > guess
end while  num != guess
puts '猜中了'
