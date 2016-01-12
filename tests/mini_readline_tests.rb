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
    assert_equal(Class,  MiniReadline::History.class)
    assert_equal(Class,  MiniReadline::NoHistory.class)
    assert_equal(Class,  MiniReadline::Edit.class)
    assert_equal(Class,  MiniReadline::EditWindow.class)
    assert_equal(Class,  MiniReadline::Mapper.class)
  end

  def test_for_storage_of_options
    assert_equal(Hash, MiniReadline::BASE_OPTIONS.class)
    edit = MiniReadline::Readline.new()
    assert_equal(Hash, edit.instance_options.class)
    refute_equal(MiniReadline::BASE_OPTIONS, edit.instance_options)
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
    puts "To finish this test, enter the word: quit"

    edit = MiniReadline::Readline.new

    result = ''

    loop do
      result = edit.readline(">", history: true)
      puts result.inspect
      break unless result != 'quit'
    end

    assert_equal("quit", result)
  end

  def test_prompt_verification
    opts = {:window_width  => 39}
    edit = MiniReadline::Readline.new()
    assert_raises(RuntimeError) {edit.readline(">"*20, opts)}
  end



end
