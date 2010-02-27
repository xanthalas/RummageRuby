#!/usr/bin/ruby
=begin rdoc
* System     : rummage
* Author     : Xanthalas
* Description: Simple front-end to the Rummage search system.

 -----------: Change Log ----------------------------------------------------
 Date       : November 2009                           Author: Xanthalas
            : Initial version

=end

require File.expand_path("../search", __FILE__)
require File.expand_path("../searchRequest", __FILE__)
require File.expand_path("../match", __FILE__)

searchStrings = Array.new
searchFolders = Array.new
excludeFileStrings = Array.new
includeFileStrings = Array.new
caseSensitiveValue = false
searchHidden = false

charsBeforeAndAfter = 20

if ARGV.length == 0 || ARGV[0] == "help"
	puts "rummage v 0.1"
	puts "Usage: rummage s=string_to_search "
	puts ""
	puts "       The following optional parameters are also available:"
	puts ""
	puts "               f=folder_to_search          - Defaults to current folder" 
	puts "               x=regex                     - Don't search files whose name matches this regex"
	puts "               i=regex                     - Only search files whose name matches this regex"
	puts "               c=on/off                    - Case-sensitive search on or off (defaults to off)"
  puts "               h=on/off                    - Hidden search on or off (defaults to off)"
	puts ""
	puts "        The s, f, x and i parameters can be repeated as many times as required to"
	puts "        pass multiple values to the search"
	exit
end

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
        excludeFileStrings << contents
    end
    if cmd == "i" 
        includeFileStrings << contents
    end
    if cmd == "c" 
        caseSensitiveValue = contents
    end
    if cmd == "h" 
        searchHidden = contents
    end

}

#Make the folder parameter optional by defaulting to the current folder if none is given
if searchFolders.length == 0
	searchFolders << "."
end

#puts "searchStrings = #{searchStrings}  #{searchStrings.length}"
sc = Search.new
sr = SearchRequest.new
sr.searchStrings = searchStrings
sr.searchFolders = searchFolders
sr.excludeFileStrings = excludeFileStrings
sr.includeFileStrings = includeFileStrings
sr.setCaseSensitive(caseSensitiveValue)
sr.setHiddenSearch(searchHidden)
sc.searchRequest = sr
sc.search
sc.matches.each {|match| puts "#{match.matchFile}:#{match.matchLineNumber}:#{match.matchLine}" }

puts ""
puts "Found #{sc.matches.length} matches"
