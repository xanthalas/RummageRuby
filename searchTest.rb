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

    def testSearch
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

    def testSearchProper
        s = Search.new
        s.searchFolders =  ['./testdata']
        s.searchStrings = ['hew', 'brown']
        s.search
        assert_equal(2, s.matches.count)
    end
end
