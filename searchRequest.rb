=begin rdoc
* System     : rummage
* Author     : Xanthalas
* Description: Encapsulates all the information required to perform a search.

 -----------: Change Log ----------------------------------------------------
 Date       : October 2009                           Author: Xanthalas
            : Initial version

=end
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
    attr_reader :caseSensitive
    # Indicates whether to seach hidden files and folders
    attr_accessor :searchHidden

    def initialize()
        @includeFileStrings = Array.new
        @excludeFileStrings = Array.new
        @excludeDirectoryStrings = Array.new
        @caseSensitive = false
        @searchHidden = false
    end
    
    #Sets the case-sensitive option based on the value passed in.
    def setCaseSensitive(value)
        if value != false && value != true
            case value.downcase
            when 'on', 'true', 'yes', 'y', '1'
                @caseSensitive = true
            when 'off', 'false', 'no', 'n', 0
                @caseSensitive = false
            end
        else
            @caseSensitive = value
        end
    end
    
    #Sets the search-hidden option based on the value passed in.
    def setHiddenSearch(value)
        if value != false && value != true
            case value.downcase
            when 'on', 'true', 'yes', 'y', '1'
                @searchHidden = true
            when 'off', 'false', 'no', 'n', '0'
                @searchHidden = false
            end
        else
            @searchHidden = value
        end
    end
end
