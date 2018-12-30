# coding: utf-8

require_relative '../lib/mini_readline'
gem              'minitest'
require          'minitest/autorun'
require          'minitest_visible'

class MiniReadlineTester < Minitest::Test

  #Track mini-test progress.
  include MinitestVisible

  def test_some_history_options
    buffer = ["one", "two", "three"]
    options = {:no_blanks => true,
               :no_dups   => true,
               :no_move   => false}

    history = MiniReadline::History.new(buffer)
    history.initialize_parms(options)

    assert_equal(3, history.history.length)
    assert_equal(["one", "two", "three"], history.history)

    history.append_history("four")
    assert_equal(4, history.history.length)
    assert_equal(["one", "two", "three", "four"], history.history)

    history.append_history("two")
    assert_equal(4, history.history.length)
    assert_equal(["one", "three", "four", "two"], history.history)

    options[:no_move] = true
    history.append_history("three")
    assert_equal(4, history.history.length)
    assert_equal(["one", "three", "four", "two"], history.history)
  end

end
