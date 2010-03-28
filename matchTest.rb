require 'match'
require 'test/unit'

=begin rdoc
* System     : rummage
* Author     : Xanthalas
* Description: Unit test class for testing the Match class.

 -----------: Change Log ----------------------------------------------------
 Date       : October 2009                             Author: Xanthalas
            : Initial version

=end
class TestMatch < Test::Unit::TestCase

    def testMatch
        m = Match.new("findme", "you found findme in this line", 1, "testfile", nil)

        assert_equal("findme", m.matchString)
        assert_equal("you found findme in this line", m.matchLine)
        assert_equal(1, m.matchLineNumber)
        assert_equal("testfile", m.matchFile)
    end
end

