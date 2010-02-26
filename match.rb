=begin rdoc
* System     : rummage
* Author     : Xanthalas
* Description: Holds the result of a single match.

 -----------: Change Log ----------------------------------------------------
 Date       : October 2009                             Author: Xanthalas
            : Initial version

=end
class Match

    # String which matched
    attr_reader :matchString
    # Line on which the match was found
    attr_reader :matchLine
    # Number of the line on which the match was found
    attr_reader :matchLineNumber
    # File in which the match was found
    attr_reader :matchFile

    def initialize(match, line, lineNumber, file)
        @matchString = match
        @matchLine = line
        @matchLineNumber = lineNumber
        @matchFile = file
    end
end
