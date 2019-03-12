Loops to add contents of an array

```ruby
def setup
  @a = [2, 5, 18, 27]
  @sum = 0
end

def teardown
  assert_equal 52, @sum
end

def test1
  i = 0
  while i < @a.length
    @sum += @a[i]
    i = i + 1
  end
end

def test2
  i = 0
  begin
    @sum += @a[i]
    i = i + 1
  end while i < @a.length
end

def test3
  i = 0
  until i >= @a.length
    @sum += @a[i]
    i = i + 1
  end
end

def test4
  i = 0
  begin
    @sum += @a[i]
    i = i + 1
  end until i >= @a.length
end

def test5
  i = 0
  loop do
    @sum += @a[i]
    i = i + 1
    break if i >= @a.length
  end
end

def test6
  i = 0
  @a.length.times {
    @sum += @a[i]
    i = i + 1
  }
end

def test7
  for i in 0 .. @a.length - 1
    @sum += @a[i]
  end
end

def test8
  for i in @a
    @sum += i
  end
end

def test9
  i = @a.to_enum
  loop do
    @sum += i.next
  end
end

def test10
  d = @a.dup
  loop do
    i = d.shift
    break if i.nil?
    @sum += i
  end
end

def test11
  0.upto(@a.length - 1){ |i| @sum += @a[i] }
end

def test12
  @a.each { |i| @sum += i }
end

def test13
  @a.each_index { |i| @sum += @a[i] }
end

def test14
  @sum = @a.inject :+
end

def test15
  @sum = eval @a.join '+'
end

end
```