# coding: utf-8

require_relative '../lib/mini_readline'
gem              'minitest'
require          'minitest/autorun'
require          'minitest_visible'

#Test the monkey patches applied to the Object class.
class MiniReadlineTester < Minitest::Test

  #Track mini-test progress.
  MinitestVisible.track self, __FILE__

  def test_that_module_exists
    assert_equal(Module, MiniReadline.class)
    assert_equal(String, MiniReadline::VERSION.class)
  end

end