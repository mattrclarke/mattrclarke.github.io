---
layout: post
title: Ruby Array Methods
---


### .& .* .+ .-
add,
```ruby
[1,2,3] * 2
 => [1, 2, 3, 1, 2, 3]

 [1,2,3] - [2]
 => [1, 3]

[1,2,3] + [2]
 => [1, 2, 3, 2]

 [1,2,3] & [1, 3]
  => [1, 3]
  ```

### .assoc
Searches through an array whose elements are also arrays comparing obj with the first element of each contained array using obj.==.
 Returns the first contained array that matches (that is, the first associated array), or nil if no match is found
```ruby
s1 = [ "colors", "red", "blue", "green" ]
s2 = [ "letters", "a", "b", "c" ]
s3 = "foo"
a  = [ s1, s2, s3 ]
a.assoc("letters")  #=> [ "letters", "a", "b", "c" ]
a.assoc("foo")      #=> nil
```

### .rassoc
Searches through the array whose elements are also arrays.
Compares obj with the second element of each contained array
Returns the first contained array that matches.
```ruby
a = [ [ 1, "one"], [2, "two"], [3, "three"], ["ii", "two"] ]
a.rassoc("two")    #=> [2, "two"]
a.rassoc("four")   #=> nil
```

### .bsearch
```ruby
ary = [0, 4, 7, 10, 12]
ary.bsearch {|x| x >=   4 } #=> 4
ary.bsearch {|x| x >=   6 } #=> 7
ary.bsearch {|x| x >=  -1 } #=> 0
ary.bsearch {|x| x >= 100 } #=> nil

statuses = ["Cancelled", "Completed", "Open", "Options", "Shipped"]
statuses.bsearch { |status| "Completed" <=> status }
=> "Completed"

```
### .each
```ruby
 source.each{|x| destination << x if x < 4}
```
### .each_slice
```ruby
 [1,2,3,4,5,6,7,8,9,10].each_slice(5){|x| puts x}
```
### .each_with_index
```ruby

```
### group_by
```ruby
[1,2,2,3,4,5].group_by(&:itself) || [1,2,2,3,4,5].group_by(&:itself).transform_values(&:size)
 #=> {1=>[1], 2=>[2, 2], 3=>[3], 4=>[4], 5=>[5]}
```

### .reverse_each
```ruby

```

### .product
```ruby
 [*1..5].product([*1..5])
```
### .select
```ruby
 [1..100].select {|number| number % 2 == 0 }
```

### .delete
```ruby

```
### .delete_if
```ruby
[1,2,3,4,5,6,7].delete_if{|i| i < 4 }
```
### .all
```ruby

```
### .any?
check if array contains a value
```ruby
[1, 2, 3].any? {|x| x == 2}
# => true
```

### .map
```ruby

```

### .flatten
```ruby
[ [1,2,3], [4,5,6] ].flatten
 => [1, 2, 3, 4, 5, 6]
```

### .flat_map
Maps then flattens
```ruby
[ [1,2,3], [4,5,6] ].flat_map{ |array| array[0] }
# => [1, 4]

array = [[ { key: "value_1" } ], [ { key: "value_2" } ]]

array.flat_map{ |arr| arr[0][:key] }
 # => ["value_1", "value_2"]
```

### .sum
Add the contents
```ruby
[1,2,3,4,5].sum
#=> 15
```

### .inject
```ruby

```
### .chunk
```ruby

```
### collect
```ruby

```
### .partition
Split an array into 2 based on a condition
```ruby
(1..6).partition {|v| v.even? }
#=>  [[2, 4, 6], [1, 3, 5]]

(1..6).partition {|v| v < 4 }
#=>  [[1, 2, 3], [4, 5, 6]]
```

### .reduce
```ruby

```
###  does something to each element ie .reduce(:+) adds all els, .reduce(:*) multiplies them all?
.values_at
```ruby

```
###  get the elements at values_at(1,4,5) etc



- assoc
- bsearch
- each                   # source.each{|x| destination << x if x < 4}
- each_slice             # [1,2,3,4,5,6,7,8,9,10].each_slice(5){|x| puts x}
- each_with_index
- group_by              # [1,2,2,3,4,5].group_by(&:itself) || [1,2,2,3,4,5].group_by(&:itself).transform_values(&:size)
- reverse_each
- map
- product                #[*1..5].product([*1..5])
- select                 #[*1..100].select {|number| number % 2 == 0 }
- delete
- delete_if              #[1,2,3,4,5,6,7].delete_if{|i| i < 4 }
- all
- any?                  # check if array contains a value arr = [1, 2, 3]  arr.any? {|x| x == 2}
- flatten
- flat_map              # maps then flattens
- inject
- chunk
- collect
- partition             # splits an array into 2 based on a condition -> (1..6).partition {|v| v.even? }  #returns  [[2, 4, 6], [1, 3, 5]]
- reduce                # does something to each element ie .reduce(:+) adds all els, .reduce(:*) multiplies them all?
- values_at


Build an n*n board
Array.new(n){|y| Array.new(n) {|x| [y,x] } }
[*0..n].product([*0..n])
