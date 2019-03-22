require 'byebug'

cell = {
  x: 0,
  y: 0,
  description: 'You are standing in a swamp, the cold burns your skin',
  enemy: 'nil',
  item: ['Potion']
 }


@world = [
  [ [0, 0, cell],[0,1],[0,2],[0,3] ],
  [ [3,0],[1,1],[1,2],[1,3] ],
  [ [2,0],[2,1],[2,2],[2,3] ],
  [ [3,0],[3,1],[3,2],[3,3] ],
]

# def build_world(size)
#   size -= 1
#   @world = []
#   row = []
#   blueprint = [*0..size].product([*0..size])
#   blueprint.each do |element|
#     row << element
#     if element[1] == size
#       @world << row
#       row = []
#     end
#   end
# end
def wld
world = []
  4.times do |y|
    row = []
   4.times do |x|
     row << [y,x]
   end
   world << row
  end
  return world
end

def build_world(size)
  board =  [*0..size].product([*0..size]).each_slice(size + 1) {|x| @world <<  x}
end

def board(size)
  board = Array.new(size) {|y| Array.new(size) {|x| [y,x]} }
end
# puts "Enter the world size"
# size = gets.chomp().to_i
# build_world(size)

@player = {
  x: 2,
  y: 1,
  health: 10,
  inventory: ['rusty key']
 }

def show_world(world)
  system "clear"
  puts @player[:inventory]
  @world.each do |y|
    print "\n"
    y.each do |x|
      if x == [@player[:y], @player[:x]]
        print "@@"
      else
        print "--"
      end
    end
  end
  puts 'please enter a direction'
  direction = gets.chomp
  move(direction, world)
  if @player[:x] == 0 && @player[:y] == 0
    puts @world[0][0][2][:description]
    item = @world[0][0][2][:item].pop
    @player[:inventory] << item
  end
end

def move(direction, world)
  if direction == 'n' && @player[:y] != 0
    @player[:y] -= 1
  end
  if direction == 's' && @player[:y] != (@world.length) -1
    @player[:y] += 1
  end
  if direction == 'w' && @player[:x] != 0
    @player[:x] -= 1
  end
  if direction == 'e' && @player[:x] != (@world[0].length) -1
    @player[:x] += 1
  end
end

while 1 < 10
  show_world(@world)
end

# until (player_death)
#   show_world
# end
def print_map(h, w)

map = Array.new(h){|y| Array.new(w){|x| [y,x]}}

  map.each do |y|
    print "\n"
    y.each do |x|
      if y[0][0] == 0 || y[0][0] == h - 1
        print [177].pack("U*")
      elsif x[1] == 0 || x[1] ==  w - 1
        print [177].pack("U*")
      else
        print "~"
      end
    end
  end
  print "\n"
end

print_map(15, 30)




# start with 4x4 map, print out the world without newline.
# add newline to show each loop
# explain coords and add player into it -
# arr = ['first element', 'second element', 'third el'] they stat at zero because number line,
# also looping arrays like two hands, with each hand being an outer array, and finders being the contents of that array,
# and , separation is like saying 'and' i.e [1,2,3,4] [1 and 2 and 3 and 4]
# clear screen
# add movement
# add conditionals to the movement - cant walk off map
# add a world builder method
# introduce byebug at some point
# explain array like money, 10 dollar note is an array of 1 dollars
