
require File.join(File.dirname(__FILE__), 'spec_helper')
require File.join(File.dirname(__FILE__), '../lib/randall')

include RandallMonkey

RandallMonkey.patch

describe 'MonkeyPatches' do
  the 'array should be pickable.' do
    a = Randall.arrays.of(Integer)
    10_000.times do
      [1].pick.should.equal 1
    end
  end
  
  the 'regexp should generate random string that matches it.' do
    REGEXPS.each do |re|
      re.rand.should.satisfy do |s| s =~ re; end
    end
  end
end
