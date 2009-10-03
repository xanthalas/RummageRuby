#! /usr/bin/ruby
################################################################################
# System     : rummage                                                         #
# File       : searchTest.rb                                                   #
# Author     : Xanthalas                                                       #
# Description: Unit test class for testing the Search class.                   #
#                                                                              #
# -----------: Change Log ---------------------------------------------------- #
# Date       : September 2009                          Author: Xanthalas       #
#            : Initial version                                                 #
################################################################################
require 'search'
require 'test/unit'

class TestSearch < Test::Unit::TestCase

    def testSearchWithErrors
        sc = Search.new

        # Test that there are no matches yet
        assert_equal(0, sc.matches.count)

        # No folders or search string specified
        assert_raise(RuntimeError)  { sc.search }

        sc.searchFolders = ['./testdata']
        # No search string specified
        assert_raise(RuntimeError)  { sc.search }

        sc.searchStrings= ['ruby', 'xanthalas' ]
        # Folders and string specified - no error
        assert_nothing_thrown() { sc.search }
        
    end

    # Test that case sensitive matching works
    def testSearchCaseSensitive
        s = Search.new
        s.searchFolders =  ['./testdata']
        s.searchStrings = ['hew', 'brown']
        s.caseSensitive = true
        s.search
        assert_equal(3, s.matches.count)
    end

    # Test that case insensitive matching works
    def testSearchCaseInsensitive
        s = Search.new
        s.searchFolders =  ['./testdata']
        s.searchStrings = ['hew', 'brown']
        s.caseSensitive = false
        s.search
        assert_equal(4, s.matches.count)
    end

    # Test that searching defaults to case insensitive
    def testSearchCaseInsensitiveDefault
        s = Search.new
        s.searchFolders =  ['./testdata']
        s.searchStrings = ['blue', 'ORAnge', 'GREEN']
        s.caseSensitive = false
        s.search
        assert_equal(3, s.matches.count)
    end

    # Test that the results from the search - line number and file are what we expect
    def testSearchResults
        s = Search.new
        s.searchFolders =  ['./testdata']
        s.searchStrings = ['red', 'purple', 'brown',  'dung']
        s.caseSensitive = false
        s.search
        assert_equal(6, s.matches.count)
s.matches.each {|match| puts match.matchFile}
        assert_equal("What's brown and sounds like a bell?\n", s.matches[0].matchLine)
        assert_equal(1, s.matches[0].matchLineNumber)
        assert_equal("Dung\n", s.matches[1].matchLine)
        assert_equal(2, s.matches[1].matchLineNumber)
        assert_equal("Red is the first colour\n", s.matches[2].matchLine)
        assert_equal(1, s.matches[2].matchLineNumber)
        assert_equal("Fifth is brown which is in lower case\n", s.matches[3].matchLine)
        assert_equal(5, s.matches[3].matchLineNumber)
        assert_equal("And sixth is PURPLE which is in upper case\n", s.matches[4].matchLine)
        assert_equal(6, s.matches[4].matchLineNumber)
        assert_equal("Brown a second time coming in ninth\n", s.matches[5].matchLine)
        assert_equal(9, s.matches[5].matchLineNumber)
    end

    # Test that no matches is handled correctly
    def testSearchNoMatches
        s = Search.new
        s.searchFolders =  ['./testdata']
        s.searchStrings = ['apples']
        s.caseSensitive = false
        s.search
        assert_equal(0, s.matches.count)
    end
end
