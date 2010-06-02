# encoding: utf-8
#
# copyright (c) 2010, Diego Che
#

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
  alias :with :that
  alias :and :that
  
  def match(re)
    unless @type == String then
      raise ArgumentError, 'Applied to generator for String only.'
    end
    
    self.restrict :like => re
  end
  
  def less_than(number)
    unless @type == Float or @type == Integer then
      raise ArgumentError, 'Applied to generator for String only.'
    end
    
    @options[:less_than] = number
    self
  end
  alias :lt :less_than
  
  def greater_than(number)
    unless @type == Float or @type == Integer then
      raise ArgumentError, 'Applied to generator for number only.'
    end
    
    @options[:greater_than] = number
    self
  end
  alias :gt :greater_than
  
  def close_to(f)
    unless @type == Float then
      raise ArgumentError, 'Applied to generator for number only.'
    end
    
    @options[:close_to] = f
    self
  end
  
  def in_range(rg)
    unless @type == Float or @type == Integer then
      raise ArgumentError, 'Applied to generator for number only.'
    end
    
    @options[:range] = rg
    self
  end
  alias :between :in_range
  
  def of(type)
    unless @type == Array then
      raise ArgumentError, 'Applied to generator for Array only.'
    end
    
    case type
    when Randall
      @options[:item] = type
    when Class
      @options[:type] = type
    else
      @options[:type] = type.class
    end
    
    self
  end
  
  def with_size(number)
    unless @type == Hash or @type == Array then
      raise ArgumentError, 'Applied to generator for Hash and Array only.'
    end
    
    @options[:size] = number
    self
  end
  
  def from(type)
    unless @type == Hash then
      raise ArgumentError, 'Applied to generator for Hash only.'
    end
    
    case type
    when Class
      @options[:key_type] = type
    when Randall
      @options[:key] = type
    else
      @options[:key_type] = type.class
    end
    self
  end
  
  def to(type)
    unless @type == Hash then
      raise ArgumentError, 'Applied to generator for Hash only.'
    end
    
    case type
    when Class
      @options[:value_type] = type
    when Randall
      @options[:value] = type
    else
      @options[:value_type] = type.class
    end

    self
  end
  
  def with_arguments(*args)
    self.restrict :args => args
  end
  
end
