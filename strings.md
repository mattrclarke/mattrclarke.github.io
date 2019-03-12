---
layout: post
title: Ruby String Methods
---

#### .include?
Checks string for passed value
```ruby
"hello".include? "lo"   #=> true
"hello".include? "ol"   #=> false
"hello".include? ?h     #=> true
```

#### .starts_with
Returns bool
```ruby
"hello"..starts_with? "lo" #=> false

```
#### .ends_with
```ruby
"hello"..ends_with? "lo"   #=> true

```
#### .index
Show the index of the argument if matched
```ruby
'aaaaabaaaa'.index "b"   #=> 5

```
#### .concat
Join two strings
```ruby
"hello".concat "there"   #=> hellothere

```
#### .reverse
Reverse the string
```ruby
"hello".reverse? "lo"   #=> "olleh"

```
#### .split
Split a string in to an array of strings
```ruby
"Returns an array or strings".split?
#=> ['Returns', 'an', 'array', 'of', 'strings']
```

#### .swapcase
Invert caps and lowercase characters
```ruby
"ThIs WiLl Be SwApPeD".swapcase
 #=> "tHiS wIlL bE sWaPpEd".split?
```
#### .sub
Substitute the first matching element
```ruby
"I should look into your problem when I get time".sub('I','We')
#=> "We should look into your problem when I get time"
```
#### .gsub
Substitute all matching elements
```ruby
"Returns an array or strings".split?
# "I wasn't able to understand".gsub(/[aeiou]/, '1') - // = regex
```

#### .match
Converts pattern to a Regexp (if it isn’t already one), then invokes its match method on str. If the second parameter is present, it specifies the position in the string to begin the search.
```ruby 
'hello'.match('(.)\1')      #=> #<MatchData "ll" 1:"l">
'hello'.match('(.)\1')[0]   #=> "ll"
'hello'.match(/(.)\1/)[0]   #=> "ll"
'hello'.match('xx')         #=> nil
```

#### .squeeze                
```ruby
"Remove   some     space".squeeze?
 => "Remove some space"
```

#### .squish
Remove all whitespace on both ends of the string and
leave 1 whitespace for each whitespace group
```ruby
%{ Multi-line
   string }.squish                  
" foo   bar    \n   \t   boo".squish # => "foo bar boo"
# bring spaces down to 0
```

#### .tr
Replace matching characters
```ruby
"hello".tr('el', 'ip')      #=> "hippo"
"hello".tr('aeiou', '*')    #=> "h*ll*"
```

#### .tr_s
Replace and remove duplicate characters in that region     
```ruby
"hello".tr_s('l', 'r')     #=> "hero"
"hello".tr_s('el', '*')    #=> "h*o"
"hello".tr_s('el', 'hx')   #=> "hhxo"
```
