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
require 'searchRequest'
require 'test/unit'

class TestSearch < Test::Unit::TestCase

    def testSearchWithErrors
        sc = Search.new
        sr = SearchRequest.new

        # Test that there are no matches yet
        assert_equal(0, sc.matches.length)

        # No folders or search string specified
        assert_raise(RuntimeError)  { sc.search }

        sr.searchFolders = ['./testdata']
        # No search string specified
        assert_raise(RuntimeError)  { sc.search }

        sr.searchStrings= ['ruby', 'xanthalas' ]
        sc.searchRequest = sr
        # Folders and string specified - no error
        assert_nothing_thrown() { sc.search }
        
    end

    # Test that case sensitive matching works
    def testSearchCaseSensitive
        s = Search.new
        sr = SearchRequest.new
        sr.searchFolders =  ['./testdata']
        sr.searchStrings = ['hew', 'brown']
        sr.caseSensitive = true
        s.searchRequest = sr
        s.search
        assert_equal(3, s.matches.length)
    end

    # Test that case insensitive matching works
    def testSearchCaseInsensitive
        s = Search.new
        sr = SearchRequest.new
        sr.searchFolders =  ['./testdata']
        sr.searchStrings = ['hew', 'brown']
        sr.caseSensitive = false
        s.searchRequest = sr
        s.search
        assert_equal(4, s.matches.length)
    end

    # Test that searching defaults to case insensitive
    def testSearchCaseInsensitiveDefault
        s = Search.new
        sr = SearchRequest.new
        sr.searchFolders =  ['./testdata']
        sr.searchStrings = ['blue', 'ORAnge', 'GREEN']
        sr.caseSensitive = false
        s.searchRequest = sr
        s.search
        assert_equal(3, s.matches.length)
    end

    # Test that the results from the search - line number and file are what we expect
    def testSearchResults
        s = Search.new
        sr = SearchRequest.new
        sr.searchFolders =  ['./testdata']
        sr.searchStrings = ['red', 'purple', 'brown',  'dung']
        sr.caseSensitive = false
        s.searchRequest = sr
        s.search
        assert_equal(6, s.matches.length)
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
        sr = SearchRequest.new
        sr.searchFolders =  ['./testdata']
        sr.searchStrings = ['tigers']
        sr.caseSensitive = false
        s.searchRequest = sr
        s.search
        assert_equal(0, s.matches.length)
    end

    # Test that regular expression string matching works
    def testSearchRegularExpressions
        s = Search.new
        sr = SearchRequest.new
        sr.searchFolders =  ['./testdata']
        sr.searchStrings = ['o.*nge']
        sr.caseSensitive = false
        s.searchRequest = sr
        s.search
        assert_equal(1, s.matches.length)
        assert_equal("Now we have OranGe in mixed case in seventh\n", s.matches[0].matchLine)

        s = Search.new
        sr = SearchRequest.new
        sr.searchFolders =  ['./testdata']
        sr.searchStrings = ['^n']
        s.searchRequest = sr
        s.search
#s.matches.each {|match| puts match.matchLine}
        assert_equal(2, s.matches.length)
        assert_equal("Next we have yellow again - in eigth this time\n", s.matches[1].matchLine)

        # Now test that case-sensitive regex matching works
        s = Search.new
        sr = SearchRequest.new
        sr.searchFolders =  ['./testdata']
        sr.searchStrings = ['^n']
        sr.caseSensitive = true
        s.searchRequest = sr
        s.search
        assert_equal(0, s.matches.length)

        s = Search.new
        sr = SearchRequest.new
        sr.searchFolders =  ['./testdata']
        sr.searchStrings = ['^Wh']
        sr.caseSensitive = true
        s.searchRequest = sr
        s.search
        assert_equal(1, s.matches.length)
        assert_equal("What's brown and sounds like a bell?\n", s.matches[0].matchLine)
    end

    # Test that directory exclude strings are used correctly
    def testSearchDirectoryExclude
        s = Search.new
        sr = SearchRequest.new
        sr.searchFolders =  ['./testdata']
        sr.searchStrings = ['brown']
        sr.excludeDirectoryStrings = ['sub']
        sr.caseSensitive = false
        s.searchRequest = sr
        s.search
        assert_equal(2, s.matches.length)
    end

end
