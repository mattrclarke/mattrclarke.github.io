---
layout: post
title: Ruby String Methods
---

#### .include?
```ruby
"hello".include? "lo"   #=> true
"hello".include? "ol"   #=> false
"hello".include? ?h
```

#### .starts_with
```ruby
"hello"..starts_with? "lo"   #=> true

```
#### .ends_with
```ruby
"hello"..ends_with? "lo"   #=> true

```
#### .index
```ruby
"hello".index? "lo"   #=> true

```
#### .concat
```ruby
"hello".concat "lo"   #=> true

```
#### .reverse
```ruby
"hello".reverse? "lo"   #=> "olleh"

```
#### .split
```ruby
"Returns an array or strings".split?
#=> ['Returns', 'an', 'array', 'of', 'strings']
```

#### .swapcase               
```ruby
"ThIs WiLl Be SwApPeD".swapcase
 #=> "tHiS wIlL bE sWaPpEd".split?
```
#### .sub                    
```ruby
"Returns an array or strings".split?
# "I should look into your problem when I get time".sub('I','We')
```
#### .gsub                   
```ruby
"Returns an array or strings".split?
# "I wasn't able to understand".gsub(/[aeiou]/, '1') - // = regex
```
#### .match

#### .squeeze                
```ruby
"Returns an array or strings".split?
# bring spaces down to 1 in length
```

#### .squish                 
```ruby
"Returns an array or strings".split?
# bring spaces down to 0
```

#### .tr                     
```ruby
"Returns an array or strings".split?
# replaces all characters that match
```

#### .tr_s                   
```ruby
"Returns an array or strings".split?
# replace and squash, basically gsub
```


#### Mutation