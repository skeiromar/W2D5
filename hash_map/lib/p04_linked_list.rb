class Node  #write these methods first, to be used later in LinkedList
  
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list. 
    self.prev.next = self.next  
    self.next.prev = self.prev
    #if you have a node and redirect the references pointing to it, as the prev of the one after, and the next of the one before,
    #you will in effect remove it by removing all references to it.

  end
end

class LinkedList  #LinkedList is a wrapper on top of the Node class
  include Enumerable  #syntax for including a module named Enumerable
  attr_accessor :head, :tail  #EACH NODE IS WITHIN THE LINKEDLIST TAIL but there is only 1 head and 1 tail
  def initialize
    @head = Node.new  #head has access to ALL the variables and methods within Nodes bc it is a node
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next  #head is a dummy element (doesn't contain value): just there for us to add nodes
  end

  def last
    @tail.prev #tail is a dummy element (doesn't contain value): just there for us to add nodes
  end

  def empty?
    head.next == tail #if head's next is tail, then tail's prev is certainly head
  end

  def get(key)  #after empty, do get
    node = head #but head MUST remain constant, so this is essentially making a head copy
    until node == nil #when it's = nil, we want to exit the loop
      if node.key == key  #we're comparing the node's key to the key, not = setting
        return node.val   #if the node's key matches, then return its value
      else
        node = node.next
      end
    end
    return nil #"returns nil for absent keys"
  end

  def include?(key)
  end

  def append(key, val)  #do this after initializing, because #empty checks whether nodes have been appended #appending is adding
    new_node = Node.new(key, val)
    # head -> [1,n,p] -> [2,n,p] -> tail
    if head.next == tail  #if the LinkedList is empty, aka if there's only 1 head and 1 tail
      head.next = new_node #meaning we're adding 1 node
      tail.prev = new_node 
      new_node.next = tail 
      new_node.prev = head 
    else                    #if the LinkedList already contains 1+ new node
      # 
      tail.prev.next = new_node

      new_node.prev = tail.prev #next and prev are always pointing to objects.
      tail.prev = new_node
      new_node.next = tail 
    end
  end

  def update(key, val)
  end

  def remove(key) #after get, do remove (more simple than each)
    #we're given a key, not a node. so now we need to find out
    #what key that node belongs to.
    node = head
    until node == nil #until you hit the end
      if node.key == key  #if we find what we're looking for
        node.next.prev = node.prev
        node.prev.next = node.next
        break #break if we find it bc there is nothing else to do, pointless to keep looping
      end

    node = node.next #to chain over the nodes
    end
  end

  def each
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
