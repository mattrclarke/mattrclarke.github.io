---
layout: post
title: You're up and running!
---
## This is a header

1. This is the first item
2. this is the second item

grid:
  [*1..size].product([*1..size]).each_slice(size).to_a

  def unlock(item)
   unless item[:requires].include?(false)
     item[:locked] = false
     end
   end



   group_by can return an enum if the condition are more than true or false, like enumerator %3 rather than enumerator.odd?.
   could bei useful in checking a state, like all enemies not in a certian distance get a state of 0,
   then some action can be performed on them

   .grep
   Class.methods.grep(/methods/)

   operators
    # + * - \ && || ! == < > === <=> =~ !!


   def return_binding
     foo = 100
     binding
   end
   puts return_binding.class
   puts return_binding.eval('foo')

   l = lambda {|x| puts x}
   la  = -> (x) {puts x}
   l.()
   l.[]()
   l.call(x)
   l.===

   Enumerator #  to_enum, enum_for, each, or lazy
   lazy = Enumerator::Lazy.new([1,2,3]) do |yielder, value|
       yielder << value
     end
   lazy.next
   lazy.force
   .rewind
   .peek
   .feed
   .detect                     #[1,3,5,7,8,9].detect(&:even?) returns 8

   p = Proc.new {|x| puts x}
   a = [1,2,3,4,5]
   a.each(&p)
   def blocks(&block)
   end

   b = proc {|x, y, z, *w| (x||0) + (y||0) + (z||0) + w.inject(0, &:+) }
   p b.curry(5)[1][2][3][4][5]  #=> 15


   & is block, which ruby calls to_proc on
   :upcase.to_proc # => proc { |e| e.upcase }
   therefore
   ['foo', 'bar', 'blah'].map(&:upcase) => ['FOO', 'BAR', 'BLAH']




   build a hash from an array, keyed by array object, where each value is the number of same objects in the array - essentially return a count of those objects
   [1, 3, 2, 3, 1, 3].each_with_object(Hash.new(0)) {|i, a| a[i] += 1}
   or
   h = Hash.new(0)
   a = [1,3,2,4,3,3,4,5,6,4,5,4,2,3]
   a.each {|x| h[x] += 1 }
    collecting the amount of instances all the odd numbers only show up
   a.partition{|x| x.odd?}[0].each{|x| h[x] += 1}
   or
   words = %w(cat cat dog cat lion)
   words.group_by(&:itself).transform_values(&:size)


   Lonely Operator &.  # wont error if a method is called on nil

   arr = [1,2,nil,4]

   arr.each do |x|
     puts x&.*(4)
   end





   def yielding(x)
    yield 1
    yield 2
   end

   times {|x| p x * 10}

   1.+(2) # + is a method

   Ternary operator
     10 > 3 ? 'yes' : 'no'


   class Foo
     def method_name
       p "method_name called for #{object_id}"
     end
   end

   [Foo.new, Foo.new].map do |el|
    el.method_name
   end

   same as
   [Foo.new. Foo.new].map(&:method_name)
   because
   :upcase.to_proc.call("string")
   ruby calls to_proc on every method call


### String Methods

   .include?
   .starts_with
   .ends_with
   .index
   .concat
   .reverse
   # ['returns', 'an', 'array', 'of', 'strings']
   .split                  
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

### Array Methods


    # .& .* .+ .-                  # & will return unique elements from both array

   .assoc

   .bsearch

   .each                   source.each{|x| destination << x if x < 4}

   .each_slice             # [1,2,3,4,5,6,7,8,9,10].each_slice(5){|x| puts x}

   .each_with_index

   .group_by              # [1,2,2,3,4,5].group_by(&:itself) || [1,2,2,3,4,5].group_by(&:itself).transform_values(&:size)

   .reverse_each

   .map

   .product                #[*1..5].product([*1..5])

   .select                 #[*1..100].select {|number| number % 2 == 0 }

   .delete

   .delete_if              #[1,2,3,4,5,6,7].delete_if{|i| i < 4 }

   .all

   .any?                  # check if array contains a value arr = [1, 2, 3]  arr.any? {|x| x == 2}

   .flatten

   .flat_map              # maps then flattens

   .inject

   .chunk

   .collect

   .partition             # splits an array into 2 based on a condition -> (1..6).partition {|v| v.even? }  #returns  [[2, 4, 6], [1, 3, 5]]

   .reduce                # does something to each element ie .reduce(:+) adds all els, .reduce(:*) multiplies them all?
   .values_at             # get the elements at values_at(1,4,5) etc

   (1..100).partition{|x| x.even?}[0]
   a = [1, 2, 3, 4, 5, 6, 7, 8, 9]
   b = a[3..-3] = "four to seven"
   b = [1, 2, 3, "four to seven", 8, 9]

### Hash Methods
   .keys                  # list all keys
   .each_with_object
   .values                # list all values
   .each_key              # calls block once for each key, h.each_key {|key| puts key }
   .each_value
   .invert                # swap keys and values
   .merge                 # add a kv pair
   .rassoc                # search and return first match  h = {name: 'tim', age 20} h.rassoc(20)
   .values_at
   .dig
   .transform_values

   Kernal
   .itself

### Fibre Methods

### Loops

   loop do
     monk.meditate
     break if monk.nirvana?
   end

   5.times do
       # do the stuff that needs to be done
     end

   array = [1, 2, 3, 4, 5]
   for i in array
     puts i
   end

   array.each{|i| puts i}

   array.each do |i|
     puts i
   end

   def array_copy(source)
     destination = []
     source.each do |x|
         if x < 4
         destination << x
         puts destination
         end
         return destination
       end
     end

   Methods
   arr = [1,2,3]
   arr.method('map').class
   arr.length
   arr::length


   Truth



   a = [[1,2],[3,4]]

   a.each do |(first, last)|
     puts first
     puts last
   end




![_config.yml]({{ site.baseurl }}/images/config.png)

The easiest way to make your first post is to edit this one. Go into /_posts/ and update the Hello World markdown file. For more instructions head over to the [Jekyll Now repository](https://github.com/barryclark/jekyll-now) on GitHub.
