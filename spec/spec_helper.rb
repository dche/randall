
require 'rubygems'
require 'bacon'

module Bacon
  # :nodoc:
  class Context
    alias :the :it
    alias :its :it
    
  end
end

# Regexp examples borrowed from pickaxe, third edition.
REGEXPS = [
    /cat/,
    /123/,
    /t a b/,
    /mm\/dd/,
    /\|/,
    /\(no\)/,
    /e\?/,
    /^the/,
    /is$/,
    /^she$/,
    /\Athis/,
    /[aeiou]/,
    /[\s]/,
    /[$.]/,
    /[A-F]/,
    /[A-Fa-f]/,
    /[0-9]/,
    /[0-9][0-9]/,
    /[^A-Z]/,
    /[^\w]/,
    /[a-z][^a-z]/,
    /[[:digit:]]/,
    /[[:space:]]/,
    /[[:^alpha:]]/,
    /[[:punct:]aeiou]/,
    # /[]]/,
    /[0-9\]]/,
    /[\d\-]/,
    /\s/,
    /\d/,
    /[a-z&&[^aeiou]]/,
    /c.s/,
    /\w+/,
    /\s.*\s/,
    /\s.*?\s/,
    /[aeiou]{2,99}/,
    /mo?o/,
    /mo??o/,
    /m*/,
    /Z*/,
    /d|e/,
    /al|lu/,
    /red ball|angry sky/,
    /an+/,
    /(an)+/,
    /(blue|red) \w+/,
    /red|blue \w+/,
    /(\d\d):(\d\d)(..)/,
    /((\d\d):(\d\d))(..)/,
    
    # -- Not support below --
    # /\p{Alnum}/,
    # /\P{Alnum}/,
    # /(\w)\1/,
    # /(?<char>\w)\k<char>/,
    # /(?<seq>\w+)\k<seq>/,
    # /(?<hour>\d\d):(?<min>\d\d)(..)/,
    # /(?<first>\w+):(?<last>\w+)/,
    # /(?<c1>.)(?<c2>.)/,
    # /(\d+)(?:/|:)(\d+)(?:/|:)(\d+)/,
    # /[a-z]+(?=,)/,
    # /(?<=hot)dog/,
    # /(X+)(?!O)/,
    # /((?>X+))(?!O)/,
    # # TODO: support numbered back reference?
    # /(\d\d):\d\d-\1:\d\d/,
    # /(?<hour>\d\d):\d\d-\k<hour>:\d\d/,
    # /(.)(.)\k<-1>\k<-2>/,
    # /(?<color>red|green|blue) \w+ \g<color> \w+/,
    # /\A(?<a>|.|(?:(?<b>.)\g<a>\k<b+0>))\z/,
    
    # TODO: add more regexp 
  ]
