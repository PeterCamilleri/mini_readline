# coding: utf-8

require_relative '../lib/mini_readline'
gem              'minitest'
require          'minitest/autorun'
require          'minitest_visible'

#Test the monkey patches applied to the Object class.
class MiniReadlineTester < Minitest::Test

  #Track mini-test progress.
  include MinitestVisible

  def test_that_it_has_a_version_number
    refute_nil ::MiniReadline::VERSION
    assert(::MiniReadline::VERSION.is_a?(String))
    assert(/\A\d+\.\d+\.\d+/ =~ ::MiniReadline::VERSION)
  end

  def test_that_module_entities_exists
    assert_equal(Module, MiniReadline.class)
    assert_equal(String, MiniReadline::VERSION.class)
    assert_equal(Class,  MiniReadline::Readline.class)
  end

  def test_that_it_has_terminfo
    info = MiniReadline.term_info

    assert(info.is_a?(Array))
  #  assert_equal(2, info.length)
    assert(info[0].is_a?(Integer))
    assert(info[1].is_a?(Integer))
    assert_equal([80,32], info)
  end

end
