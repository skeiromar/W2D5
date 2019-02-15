require 'byebug'

class MaxIntSet
  attr_reader :max, :store  #create attr_readers for what you initialize

  def initialize(max)
    @store = Array.new(max) {false} #this doesn't default to the same pointer addres sin memory bc we have a block. 
                                    #block executes for every value in the range of max.
    @max = max #extra var check if the size of the array is less than this variable; then add more elements
  end

  def insert(num)
    raise "Out of bounds" if (num > max) || (num < 0) #range is min to max. then create an attr_reader for max
    store[num] = true #because the default is false, then inserting an element will change its value to true
    return num
  end

  def remove(num)
    store[num] = false #this removes the element (setting)
  end

  def include?(num) #index is th ele itself
    return true if store[num] == true  
    return false if store[num] == false  #need two equals bc this is comparison -- = is setting var name to value
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  attr_reader :store, :num_buckets
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @num_buckets = num_buckets
  end


  def insert(num)
    
    # pushing to sub array because store[idx] buckets is a array

    # debugger
    self[num] << num #self[num] is @store[num % num_buckets] to get the index. NOT self[idx]

  end

  def remove(num) 
    # debugger
    #self[num] -= [num]
    #self[num]
    self[num].delete(num)

    #array minus the [element] that deletes it

    # self[num].delete_at(self[num].index(num)) 
    #.index(num) is where the num is found in the bucket.
    #self[num] is the bucket
    #.delete_at(this location)
    #self[num].delete is the array that takes the delete method
  end

  def include?(num)
    self[num].include?(num)

  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :store, :count, :num_buckets

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
    @num_buckets = num_buckets
  end

  def insert(num)
    if !self[num].include?(num)  #shovel into array! not = 
      # if count < store.length  
      #   self[num] << num 
      #   @count += 1
      # else
      #   # debugger
      #   resize!   #the method shoudl be called by itself; not on the "self" as it is a private method!
      #   self[num] << num 
      #   @count += 1
      # end
      resize! unless count < store.length 
      self[num] << num 
      @count += 1
    end
  end

  def remove(num)
    if self[num].include?(num)
      self[num].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
     @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    # debugger
    # p store
    resized = ResizingIntSet.new(num_buckets * 2)
    store.each do |bucket|
      bucket.each do |el|
        resized.insert(el)
      end
    end
    @store = resized.store  #store has only a reader, not an accessor
  end           #so you can access @store as the instance variable, not calling the method on the self.

end
