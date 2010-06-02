

require File.join(File.dirname(__FILE__), 'spec_helper')
require File.join(File.dirname(__FILE__), '../lib/randall')

RandallMonkey.patch

module RandallSugarSpec
  class Klass
  end

  class Kls
    attr_reader :a, :b
  
    def initialize(a, b)
      @a = a
      @b = b
    end
  end
end

include RandallSugarSpec

describe 'Randall syntax sugar' do
  the 'Randall builders.' do
    Randall.integers.next.should.is_a Integer
    Randall.floats.next.should.is_a Float
    Randall.strings.next.should.is_a String
    Randall.arrays.next.should.is_a Array
    Randall.hashes.next.should.is_a Hash
    Randall.instances_of(RandallSugarSpec::Klass).next.should.is_a RandallSugarSpec::Klass
  end
  
  the 'Sugars for string' do
    Randall.strings.should.is_a Randall
    re = REGEXPS.pick
    Randall.strings.that.match(re).next.should.match re
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
    Randall.arrays.of(RandallSugarSpec::Klass).next.first.should.is_a RandallSugarSpec::Klass
    Randall.arrays.of(Integer).with_size(100).next.size.should.equal 100
  end
  
  the 'Sugars for hash' do
    Randall.hashes.from(Integer).next.keys.first.should.is_a Integer
    Randall.hashes.to(String).next.values.first.should.is_a String
    h = Randall.hashes.from(Randall.strings.that.match(/AA\d{5}/)).to(Integer)
    h.next.values.each do |v|; v.should.is_a Integer; end
    h.next.keys.each do |k|; k.should.match /AA\d{5}/; end
    Randall.hashes.with_size(64).next.size.should.equal 64
  end
  
  the 'Sugars for any type' do
    Randall.instances_of(RandallSugarSpec::Kls).should.is_a Randall
    Randall.instances_of(RandallSugarSpec::Kls).next.should.be.nil
    k = Randall.instances_of(RandallSugarSpec::Kls).with_arguments(1, 2)
    k.next.should.not.be.nil
    k.next.should.is_a RandallSugarSpec::Kls
    k.next.a.should.equal 1
    k.next.b.should.equal 2
  end  
end
