################################################################################
# System     : rummage                                                         #
# File       : searchRequest.rb                                                #
# Author     : Xanthalas                                                       #
# Description: This class encapsulates all the information required to         #
#              perform a single search.                                        #
#                                                                              #
# -----------: Change Log ---------------------------------------------------- #
# Date       : October 2009                            Author: Xanthalas       #
#            : Initial version                                                 #
################################################################################

class SearchRequest

    # Array holding the folders to search
    attr_accessor :searchFolders
    # Array of strings to search for
    attr_accessor :searchStrings
    # Array of strings used to match against filenames to include those files
    attr_accessor :includeFileStrings
    # Array of strings used to match against filenames to exclude those files
    attr_accessor :excludeFileStrings
    # Array of strings used to match against directory names to exclude those directories
    attr_accessor :excludeDirectoryStrings
    # Indicates whether the search should be case sensitive
    attr_accessor :caseSensitive
    # Indicates whether to seach hidden files and folders
    attr_accessor :searchHidden

    def initialize()
        @includeFileStrings = Array.new
        @excludeFileStrings = Array.new
        @excludeDirectoryStrings = Array.new
        @caseSensitive = false
        @searchHidden = false
    end
end
