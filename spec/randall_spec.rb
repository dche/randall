#
# randall_spec.rb -- Core functions.
# 
# This file is covered by the MIT license. See LICENSE for more details.
#
# copyright (c) 2010, Diego Che
#

require File.join(File.dirname(__FILE__), 'spec_helper')
require File.join(File.dirname(__FILE__), '../lib/randall')

class Kls
  def initialize(a, b, c); end
end

class Klass
  def initialize(o); end
end

vg = Randall.new

describe Randall do
  it "should generate value with expected types" do
    [Integer, Float, String, Array, Hash].each do |c|
      vg.r(c).should.be.is_a c
    end
  end
    
  it "value property should equal to the generated value" do
    [Integer, Float, String, Array, Hash].each do |c|
      vg.r(c).should.equal vg.v
    end
  end
  
  it "should generate different values each time (in most time)" do
    10.times do 
      vg.r(Integer).should.not.equal vg.r(Integer)
    end
  end
  
  it "should generate value that satisfy predication." do
    10.times do
      vg.r(Integer, :less_than => -10 ** 24).should.satisfy do |i|
        i < -10 ** 24
      end
      vg.r(Float, :greater_than => 10 ** 24).should.satisfy do |i|
        i > 10 ** 24
      end
      vg.r(Float, :close_to => 0).abs.should.satisfy do |f| f < 0.001; end
      vg.r(Float, :close_to => 1, :epsilon => 1e-6).should.satisfy do |f|
        (f - 1).abs < 1e-6
      end
      vg.r(Float, :range => 1..100).should.satisfy do |f|
        f > 1 and f < 100
      end
    end
  end
  
  it "should generate compound object" do
    vg.r(Array, :type => Integer, :size => 3, :greater_than => -1, :less_than => 12345)
    vg.v.should.is_a Array
    vg.v.length.should.equal 3
    vg.v.each do |i|
      i.should.is_a Integer
      i.should.satisfy do |i|; i > -1 and i < 12345; end
    end
    
    vg.r(Hash, :key_type => Float, :value_type => String, :size => 100)
    vg.v.should.is_a Hash
    vg.v.length.should.equal 100
    vg.v.keys.each do |s|
      s.should.is_a Float
    end
    
    vg.v.values.each do |i|
      i.should.is_a String
    end
  end
  
  it "should accept another Randall object for elements" do
    items = Randall.new(Integer)
    vg.r(Array, :item => items).each do |i|
      i.should.is_a Integer
    end
    
    vg.r(Hash, :key => Randall.new(String), :value => Randall.new(Float))
    vg.v.keys.each do |s|
      s.should.is_a String
    end
    
    vg.v.values.each do |f|
      f.should.is_a Float
    end
  end
  
  it "should generate expected strings" do
    vg.r(String, :like => /AB[0-9]+/).should.satisfy do |s|
      s =~ /AB[0-9]+/
    end
  end
  
  it "should generate instance of any class" do
    vg.r(Kls, :args => ['Args', :in, Randall.new(String)])
    vg.v.should.be.instance_of Kls
    
    Randall.new(Klass, :args => [vg]).next.should.be.instance_of Klass
  end
end
