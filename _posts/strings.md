### String Methods


## Searching

.include?

```ruby
"hello".include? "lo"   #=> true
"hello".include? "ol"   #=> false
"hello".include? ?h
```

.starts_with
```ruby
"hello"..starts_with? "lo"   #=> true

```
.ends_with
```ruby
"hello"..ends_with? "lo"   #=> true

```
.index
```ruby
"hello".index? "lo"   #=> true

```
.concat
```ruby
"hello".concat "lo"   #=> true

```
.reverse
```ruby
"hello".reverse? "lo"   #=> "olleh"

```
# ['returns', 'an', 'array', 'of', 'strings']
.split
```ruby
"Returns an array or strings".split?   #=> ['returns', 'an', 'array', 'of', 'strings']

```            
# "ThIs WiLl Be SwApPeD"
.swapcase               
# "I should look into your problem when I get time".sub('I','We')
.sub                    
# "I wasn't able to understand".gsub(/[aeiou]/, '1') - // = regex
.gsub                   
.match
# bring spaces down to 1 in length
.squeeze                
# bring spaces down to 0
.squish                 
# replaces all characters that match
.tr                     
# replace and squash, basically gsub
.tr_s                   


### Mutation