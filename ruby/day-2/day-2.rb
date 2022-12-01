# 1. 分别找到用代码块和不用代码块读取文件的方法，用代码块有什么好处？

# 代码块读取

File.open("my/file/path", "r") do |f|
  f.each_line do |line|
    puts line
  end
end

# 不使用代码块读取

f = File.open("tmp.txt", "r")
f.each_line do |line|
puts line
end
f.close

# 代码块优势

使用代码块方式读取文件，文件使用完毕后，由方法执行关闭操作，避免了内存泄漏。


# 2. 如何将散列表转换成数组？数组能转换为散列表吗？

# 将散列表转换为数组

{:apple=>1, :banana=>2}.to_a

# 将数组转换为散列表

[[:foo, :bar], [1, 2]].to_h    # => {:foo => :bar, 1 => 2}

# 3. 循环遍历散列表

hash =  {a:100, b:200}
hash.each{|key,value| puts "#{key}" => "#{value}" }

# 4. ruby的数组能当作栈来用，它还能用作哪些常用的数据结构？

可用作队列、链表、栈、集合

# 5. 有一个数组，包含16个数字。仅用each方法打印数组中的内容，一次打印4个数字。然后，用可枚举模块的each_slice方法重做一遍。

# each 方法打印数组

digits = Array(1..16)
digits.each do |n|
print(n,' ')
puts if count % 4  == 0
count = count + 1
end

# each_slice 方法打印数组

digits.each_slice(4){|slice| p slice}

# 6. 设置一颗新树，为它写一个初始化方法，接受散列表和数组嵌套的结构。写好之后，你可以这样设置新树：{"granpa"=>{"dad"=>{"child1"=>{}, "child2"=>{}}, "uncle"=>{"child3"=>{}, "child4"=>{}}}}。

class Tree
attr_accessor :children, :node_name

def initialize(name, children=[])
    if name.respond_to?('keys') then
        root = name.first
        name = root[0]
        children = root[1]
    end

    if children.respond_to?('keys') then
        children = children.map {|child_name, grandchildren| Tree.new(child_name, grandchildren) }
    end

    @node_name = name
    @children = children
end

def visit(&block)
    block.call self
end

def visit_all(&block)
    visit(&block)
    children.each {|c| c.visit_all(&block)}
end
end

ruby_tree = Tree.new("Ruby",[Tree.new("Reia"), 
Tree.new("MacRuby") ])

puts "Visiting a node"
ruby_tree.visit {|node| puts node.node_name}
puts

puts "visiting entire tree"
ruby_tree.visit_all {|node| puts node.node_name}

ruby_tree2 = Tree.new( {'granpa' => {'dad' => {'child1' => {}, 'child2' => {} }, 'uncle' => {'child3' => {}, 'child4' => {} }} })

puts "Visiting a node"
ruby_tree2.visit {|node| puts node.node_name}
puts

puts "visiting entire tree"
ruby_tree2.visit_all {|node| puts node.node_name}

# 7. 写一个简单的 grep 程序，把文件中出现某词组的行全部打印出来。这需要使用简单的正则表达式匹配，并从文件中读取各行。最好可以加上行号。

def grep(file_path, pattern)
  re = Regexp.new(pattern)
  File.open(file_path,'r') do |file|
    file.each_line.with_index do |line, index|
      if re.match(line)
        print(index, ' ')
        puts line
      end
    end
  end
end
