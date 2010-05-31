

require File.join(File.dirname(__FILE__), 'spec_helper')
require File.join(File.dirname(__FILE__), '../lib/randall')

RandallMonkey.patch

class Klass
end

class Kls
  attr_reader :a, :b
  
  def initialize(a, b)
    @a = a
    @b = b
  end
end

describe 'Randall syntax sugar' do
  the 'Randall builders.' do
    Randall.integers.next.should.is_a Integer
    Randall.floats.next.should.is_a Float
    # Randall.strings.next.should.is_a String
    Randall.arrays.next.should.is_a Array
    Randall.hashes.next.should.is_a Hash
    Randall.instances_of(Klass).next.should.is_a Klass
  end
  
  the 'Sugars for string' do
    Randall.strings.should.is_a Randall
    re = REGEXPS.pick
    Randall.strings.that.match(re).next.should.match re
    Randall.strings.with.prefix('abc').next.should.match /\Aabc/
    Randall.strings.with.postfix('xyz').next.should.match /xyz\Z/
  end
  
  the 'Sugars for integer' do
    Randall.integers.lt(100).next.should.satisfy do |i| i < 100; end
    ig = Randall.integers
    ig.gt(100).should.is_a Randall
    ig.between(128..255).next.should.satisfy do |i|
      i >= 128 and i <= 255
    end
  end
  
  the 'Sugars for float' do    Randall.floats.should.is_a Randall
    Randall.floats.next.should.is_a Float
    Randall.floats.lt(100).next.should.satisfy do |i| i < 100; end
    
  end
  
  the 'Sugars for array' do
    Randall.arrays.next.should.is_a Array
    Randall.arrays.of(Klass).next.first.should.is_a Klass
    Randall.arrays.of(Integer).with_size(100).next.size.should.equal 100
  end
  
  the 'Sugars for hash' do
    Randall.hashes.from(Integer).next.keys.first.should.is_a Integer
    Randall.hashes.to(String).next.values.first.should.is_a String
    Randall.hashes.with_size(64).size.should.equal 64
  end
  
  the 'Sugars for any type' do
    
  end  
end
