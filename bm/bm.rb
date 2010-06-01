
require File.join(File.dirname(__FILE__), '../spec/spec_helper')
require File.join(File.dirname(__FILE__), '../lib/randall')

RandallMonkey.patch

require 'benchmark'
include Benchmark

puts "Comparing parsing and generating string."
bm(24) do |b|
  r = nil
    
  [/cat/, /[[:punct:]aeiou]/, /((\d\d):(\d\d))(..)/].each do |re|
    b.report("P - #{re.inspect}") { 1_000.times { r = Randall.strings.that.match(re) } }
    b.report("G - #{re.inspect}") { 1_000.times { r.next } }
  end
end

puts
puts "Generating different regexps, 10_000 each."
bm(24) do |b|
  r = nil
  
  REGEXPS.each do |re|
    r = Randall.strings.that.match(re)
    b.report(re.inspect) { 10_000.times { r.next } }
  end
end
