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

class Search

    # Array holding the folders to search
    attr_accessor :searchFolders
    # Array of strings to search for
    attr_accessor :searchStrings
    # Array of strings used to match against filenames to exclude those files
    attr_accessor :excludeFileStrings
    # Array of strings used to match against directory names to exclude those directories
    attr_accessor :excludeDirectoryStrings
    # Array of Match objects holding the results of the search
    attr_reader :matches

    def initialize()
        @matches = Array.new

        # Initialise the four instance variables which hold the current search
        # search context
        @currentSearchTerm = ""
        @currentLine = ""
        @currentLineNumber = 0
        @currentFile = ""
    end

    # Perform the search using the parameters set up.
    def search()
        # Do some checks to ensure that we know where to search and what to look for
        if @searchFolders.nil?
            fail "There are no search folders specified"
        end

        if @searchStrings.nil?
            fail "There are no search strings specified"
        end

        # Exclude strings are optional so no checking will be done here
        
        # Now perform the search
        @searchFolders.each {|folder| searchFolder(folder) }

    end

    # Searches each line passed in for a match
    def searchLine(line)
        searchStrings.each do |search|
            if line.include? search
                newMatch = Match.new(search, line, @currentLineNumber, @currentFile)
                @matches << newMatch
            end
        end
    end

    # Searches a single folder for the string(s) in the :searchStrings array
    def searchFolder(folder)
        
        Find.find(folder) do |path| 
            if FileTest.directory?(path)        #If it's a directory then don't try and search it
                next
            end
            @currentFile = path     #Store the file currently being searched
            @currentLineNumber = 0

            file = File.open(path, "r") do |contents|
                while line = contents.gets:
                    @currentLineNumber = @currentLineNumber + 1
                    searchLine(line)
                end
            end
        end
    end

end
