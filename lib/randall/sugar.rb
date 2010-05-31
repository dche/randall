

module RandallClassSugar
  def strings
    self.new(String)
  end
  
  def integers
    self.new(Integer)
  end
  
  def floats
    self.new(Float)
  end
  
  def arrays
    self.new(Array)
  end
  
  def hashes
    self.new(Hash)
  end
  
  def instances_of(cls)
    self.new(cls)
  end
end

module RandallInstanceSugar
  def that
    self
  end
  
  def match(re)
    unless @type == String then
      raise ArgumentError, 'Applied to Generator for String only.'
    end
    
    self.restrict :like => re
    self
  end
  
  def less_than(number)
    self
  end
  alias :lt :less_than
  
  def greater_than(number)
    self
  end
  alias :gt :greater_than
  
  def and
    self
  end
  
  def close_to(f)
    self
  end
  
  def of(type)
    unless @type == Array then
      raise ArgumentError, 'Applied to Generator for Array only.'
    end
    
    case type
    when Randall
    when Class
    else
    end
  end
  
  def with_size(number)
    self
  end
  
  def from(type)
    self
  end
  
  def to(type)
    self
  end
  
  def with_arguments(args)
    self
  end
end
