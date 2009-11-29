################################################################################
# System     : rummage                                                         #
# File       : search.rb                                                       #
# Author     : Xanthalas                                                       #
# Description: This class performs the search.                                 #
#                                                                              #
# -----------: Change Log ---------------------------------------------------- #
# Date       : September 2009                          Author: Xanthalas       #
#            : Initial version                                                 #
################################################################################

require 'find'
require 'match'

class Search


    # Search Request to action.
    attr_accessor :searchRequest

    # Array of Match objects holding the results of the search
    attr_reader :matches


    def initialize()
        # Initialise the four instance variables which hold the current search
        @currentSearchTerm = ""
        @currentLine = ""
        @currentLineNumber = 0
        @currentFile = ""
        @matches = Array.new
    end

    # Perform the search using the search request.
    def search()
        # Do some checks to ensure that we know where to search and what to look for
        if searchRequest.nil?
            fail "No search information specified"
        end

        if searchRequest.searchFolders.nil?
            fail "There are no search folders specified"
        end

        if searchRequest.searchStrings.nil?
            fail "There are no search strings specified"
        end

        # Exclude strings are optional so no checking will be done here
        
        # Now perform the search
        searchRequest.searchFolders.each {|folder| searchFolder(folder) }

    end

    # Searches each line passed in for a match
    def searchLine(line)
        searchRequest.searchStrings.each do |search|
            if searchRequest.caseSensitive
                rx = Regexp.new(search)
            else
                rx = Regexp.new(search, Regexp::IGNORECASE)
            end

            if rx.match(line)
                newMatch = Match.new(search, line, @currentLineNumber, @currentFile)
                @matches << newMatch
            end
        end
    end

    # Searches a single folder for the string(s) in the :searchStrings array
    def searchFolder(folder)
        
        Find.find(folder) do |path| 
            if FileTest.directory?(path)        #If it's a directory then don't try and search it
                Find.prune() if path.slice(0,1) == "." && path != "." && searchRequest.searchHidden == false
                if searchRequest.excludeDirectoryStrings.length > 0
                    searchRequest.excludeDirectoryStrings.each do |filter|
                        rx = Regexp.new(filter, Regexp::IGNORECASE)

                        if rx.match(path)
                            Find.prune()
                        else
                            next
                        end
                    end
                else
                    next
                end
            end
            if !(FileTest.directory?(path))
                @currentFile = path     #Store the file currently being searched
                @currentLineNumber = 0
                baseFileName = File.basename(path)
                if baseFileName.slice(0,1) == "." && baseFileName.slice(0,2) != "./" && searchRequest.searchHidden == false
                    puts "Skipping hidden file #{baseFileName} in path #{path}"
                    next
                end
                begin
                    puts "Searching file #{baseFileName} in path #{path}"
                    file = File.open(path, "r") do |contents|
                        while line = contents.gets:
                            @currentLineNumber = @currentLineNumber + 1
                            searchLine(line)
                        end
                    end
                rescue
                    puts "Couldn't search #{path}"
                end   #begin...rescue...end
            end
        end
    end

end
