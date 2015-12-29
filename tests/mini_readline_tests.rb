# coding: utf-8

require_relative '../lib/mini_readline'
gem              'minitest'
require          'minitest/autorun'
require          'minitest_visible'

#Test the monkey patches applied to the Object class.
class MiniReadlineTester < Minitest::Test

  #Track mini-test progress.
  MinitestVisible.track self, __FILE__

  def test_that_module_entities_exists
    assert_equal(Module, MiniReadline.class)
    assert_equal(String, MiniReadline::VERSION.class)
    assert_equal(Class,  MiniReadline::Readline.class)
  end

  def test_platform_detection
    if (RUBY_PLATFORM =~ /\bcygwin\b/i) || (RUBY_PLATFORM !~ /mswin|mingw/)
      assert_equal(:other, MiniReadline::PLATFORM)
    else
      assert_equal(:windows, MiniReadline::PLATFORM)
    end
  end

  def test_reading_a_line
    puts
    puts "Enter the word: test"
    assert_equal("test", MiniReadline::readline(">"))
  end

end
