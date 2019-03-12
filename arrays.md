---
layout: post
title: Ruby Array Methods
---

#### .concat
Join two strings
```ruby
"hello".concat "there"   #=> hellothere
```

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

.assoc
```ruby

```

.bsearch
```ruby

```
### .each
```ruby

```
### .each_slice
```ruby
 source.each{|x| destination << x if x < 4}
```
### .each_with_index
```ruby
[1,2,3,4,5,6,7,8,9,10].each_slice(5){|x| puts x}
```
### group_by
```ruby
[1,2,2,3,4,5].group_by(&:itself) || [1,2,2,3,4,5].group_by(&:itself).transform_values(&:size)
 #=> {1=>[1], 2=>[2, 2], 3=>[3], 4=>[4], 5=>[5]}
```

.reverse_each
```ruby

```
### map
```ruby

```
### product
```ruby
 [1..5].product([*1..5])
```
.select
```ruby
 [1..100].select {|number| number % 2 == 0 }
```

.delete
```ruby

```
### delete_if
```ruby
[1,2,3,4,5,6,7].delete_if{|i| i < 4 }
```
### .all
```ruby

```
### any?
check if array contains a value
```ruby
arr = [1, 2, 3]  arr.any? {|x| x == 2}
```

.flatten
```ruby

```
### flat_map
```ruby

```
###  maps then flattens
.inject
```ruby

```
### chunk
```ruby

```
### collect
```ruby

```
### partition
splits an array into 2 based on a condition
```ruby
(1..6).partition {|v| v.even? }  #returns  [[2, 4, 6], [1, 3, 5]]
```

.reduce
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
