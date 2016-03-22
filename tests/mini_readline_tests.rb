# coding: utf-8

require_relative '../lib/mini_readline'
gem              'minitest'
require          'minitest/autorun'
require          'minitest_visible'

#Test the monkey patches applied to the Object class.
class MiniReadlineTester < Minitest::Test

  #Track mini-test progress.
  include MinitestVisible

  def test_that_module_entities_exists
    assert_equal(Module, MiniReadline.class)
    assert_equal(String, MiniReadline::VERSION.class)
    assert_equal(Class,  MiniReadline::Readline.class)
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
      result = edit.readline(prompt: ">", history: true)
      puts result.inspect
      break unless result != 'quit'
    end

    assert_equal("quit", result)
  end

  def test_reading_a_line_no_history
    puts
    puts "No history: To finish this test, enter the word: quit"

    edit = MiniReadline::Readline.new

    result = ''

    loop do
      result = edit.readline(prompt: ">")
      puts result.inspect
      break unless result != 'quit'
    end

    assert_equal("quit", result)
  end

  def test_array_complete
    puts "\nPlease select an approved fruit."

    fruit = ["apple", "blackberry", "blueberry", "cantaloupe", "cherry",
             "clementine fruit", "coconut", "cranberry", "date", "elderberry",
             "fig", "gooseberry", "grape", "loganberry", "lychee",
             "mango", "olive", "orange", "papaya", "passion fruit", "peach",
             "pear", "pineapple", "plum", "raspberry", "redcurrant",
             "star fruit", "strawberry", "tomato"]

    edit = MiniReadline::Readline.new(auto_complete: true,
                                      auto_source: MiniReadline::ArraySource,
                                      array_src: fruit)

    result = edit.readline(prompt: "\e[7mFruit:\e[0m ")
    assert(fruit.include?(result))
  end

  def test_block_complete
    puts "\nPlease select an approved fruit."

    fruit = ["apple", "blackberry", "blueberry", "cantaloupe", "cherry",
             "clementine fruit", "coconut", "cranberry", "date", "elderberry",
             "fig", "gooseberry", "grape", "loganberry", "lychee",
             "mango", "olive", "orange", "papaya", "passion fruit", "peach",
             "pear", "pineapple", "plum", "raspberry", "redcurrant",
             "star fruit", "strawberry", "tomato"]

    edit = MiniReadline::Readline.new(auto_complete: true,
                                      auto_source: MiniReadline::ArraySource,
                                      array_src: lambda { fruit })

    result = edit.readline(prompt: "Fruit: ")
    assert(fruit.include?(result))
  end

  def test_file_auto
    puts "\nPlease select an unquoted file."

    edit = MiniReadline::Readline.new(auto_complete: true,
                                      auto_source: MiniReadline::FileFolderSource)

    result = edit.readline(prompt: "File: ")
    assert(result.is_a?(String))
  end

  def test_file_quoated
    puts "\nPlease select an quoted file."

    edit = MiniReadline::Readline.new(auto_complete: true,
                                      auto_source: MiniReadline::QuotedFileFolderSource)

    result = edit.readline(prompt: "File: ")
    assert(result.is_a?(String))
  end

  def test_end_of_input_detection
    edit = MiniReadline::Readline.new()
    puts "Exit by signaling end of input"
    assert_raises(MiniReadlineEOI) {edit.readline(prompt: ">", eoi_detect: true)}
  end

  def test_prompt_verification
    opts = {prompt: ">"*20, window_width: 39}
    edit = MiniReadline::Readline.new()
    assert_raises(RuntimeError) {edit.readline(opts)}
  end



end
