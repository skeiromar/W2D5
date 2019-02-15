class Integer
  # Integer#hash already implemented for you
end

#we're only checking integers (except rspec "should handle empty arrays" is a special case)
#the only thing we're checking is whether the hashes are the same

class Array
  def hash  #use .hash which gives the number's hash value
    return 0.hash if self.length == 0 #"should handle empty arrays"

    sum = 0
    self.each_with_index do |num, idx|
      sum += (num.hash * idx)
    end

    return (sum / self.length)  #must have parentheses!
  end
end

class String
  def hash  #use .chr which gives the letter's ASCII value
    #"should hash deterministically" means there is only one way: what you receive you'll never know how to produce again
    sum = 0
    self.each_char.with_index do |letter, idx|
      sum += ((letter.ord).hash * idx)
    end

    return (sum / self.length)
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method

  def hash  #set symbol to var. convert var to to_s. use .ord of to_s
    return 0.hash if self.length == 0 #so you don't divide by 0
    
    sum = 0
    self.each do |key, value|
      sum += key.to_s.ord.hash * value.ord
    end

    return (sum / self.length)
    
  end
end
