
require 'rubygems'
require 'bacon'

module Bacon
  # :nodoc:
  class Context
    alias :the :it
    alias :its :it
    
  end
end

REGEXPS = [
    /cat/,
    /123/,
    /t a b/,
    /mm\/dd/,
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
    #/[0-9\]]/,
    #/[\d\-]/,
    /\s/,
    /\d/,
    #/[a-z&&[^aeiou]]/,
    /\p{Alnum}/,
    /\P{Alnum}/,
    /c.s/,
    /\w+/,
    /\s.*\s/,
    #/\s.*?\s/,
    /[aeiou]{2,99}/,
    /mo?o/,
    #/mo??o/,
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
    /(\w)\1/,
    # TODO: add more regexp 
  ]
