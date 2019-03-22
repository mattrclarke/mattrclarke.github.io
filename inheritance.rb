module ModuleName
  def i_can_use_this_method_when_ModuleName_gets_included
    p "Because its included in the Inherit class"
  end
end

class OtherClass

  def this_method_is_inherited
    p "The class on this side of the < Gets access to the methods of the Class on this side"
  end

end

class Inherit < OtherClass
  include ModuleName

  attr_accessor :read_and_write

  def initialize(read_and_write)
    @read_and_write = read_and_write
  end

end

new_instance_of_class = Inherit.new('attr_accessor means this can be read and written')


new_instance_of_class.i_can_use_this_method_when_ModuleName_gets_included

new_instance_of_class.this_method_is_inherited
