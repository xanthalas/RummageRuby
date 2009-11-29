#!/usr/bin/ruby
################################################################################
# System     : rummage                                                         #
# File       : rummage.rb                                                      #
# Author     : Xanthalas                                                       #
# Description: Simple front-end to the Rummage search system.                  #
#                                                                              #
# -----------: Change Log ---------------------------------------------------- #
# Date       : November 2009                           Author: Xanthalas       #
#            : Initial version                                                 #
################################################################################

require 'search'
require 'searchRequest'
require 'match'
searchStrings = Array.new
searchFolders = Array.new
excludeStrings = Array.new

charsBeforeAndAfter = 20

ARGV.each {|arg|
    separator=arg.index('=')
    cmd=arg.slice(0, separator)
    separator += 1
    contents=arg.slice(separator, arg.length)
#puts "arg:#{arg} cmd:#{cmd} contents:#{contents}"
    if cmd == "s" 
        searchStrings << contents
    end
    if cmd == "f" 
        searchFolders << contents
    end
    if cmd == "x" 
        excludeStrings << contents
    end

}
#puts "searchStrings = #{searchStrings}  #{searchStrings.length}"
sc = Search.new
sr = SearchRequest.new
sr.searchStrings = searchStrings
sr.searchFolders = searchFolders
sc.searchRequest = sr
sc.search
sc.matches.each {|match| puts "#{match.matchFile}:#{match.matchLineNumber}:#{match.matchLine}" }

