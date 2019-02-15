class HashSet
  attr_reader :count, :store, :num_buckets  #make reader for store and num_buckets yourself

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
    @num_buckets = num_buckets
  end

  def insert(key) #this will put the element inside the bucket we found
    if !self[key].include?(key)  #shovel into array! not = 
      if count < store.length  
        self[key] << key 
        @count += 1
      else
        # debugger
        resize!   #the method shoudl be called by itself; not on the "self" as it is a private method!
        self[key] << key 
        @count += 1
      end
    end
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
      if self[key].include?(key)
      self[key].delete(key)
      @count -= 1
    end
  end

  private

  def [](num) #DO THIS STEP FIRST
    # optional but useful; return the bucket corresponding to `num`
    return @store[num.hash % @store.length]
    #this is finding the bucket we wnat to put our values inside
    #errors that broke the code:
      #method solutions same as p01 but uses key instead of num
      #here we're using self.length rather than @store.length - private methods don't call on the self.
  end

  def num_buckets
    @store.length
  end

  def resize!
    resized = HashSet.new(num_buckets * 2)  #error: change the name of the class you're initializing a new instance of!
    store.each do |bucket|
      bucket.each do |el|
        resized.insert(el)
      end
    end
    @store = resized.store  #store has only a reader, not an accessor
              #so you can access @store as the instance variable, not calling the method on the self.
  end
end
