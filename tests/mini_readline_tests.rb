# coding: utf-8

require_relative '../lib/mini_readline'
gem              'minitest'
require          'minitest/autorun'

#Test the monkey patches applied to the Object class.
class MiniReadlineTester < Minitest::Test

  def test_that_it_has_a_version_number
    refute_nil ::MiniReadline::VERSION
    assert(::MiniReadline::VERSION.frozen?)
    assert(::MiniReadline::VERSION.is_a?(String))
    assert(/\A\d+\.\d+\.\d+/ =~ ::MiniReadline::VERSION)
  end

  def test_that_it_has_a_description
    refute_nil ::MiniReadline::DESCRIPTION
    assert(::MiniReadline::DESCRIPTION.frozen?)
    assert(::MiniReadline::DESCRIPTION.is_a?(String))
  end

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


  def test_reading_a_line
    puts
    puts "To finish this test, enter the word: quit"

    edit = MiniReadline::Readline.new

    result = ''

    loop do
      result = edit.readline(prompt: ">", chomp: true, history: true)
      puts result.inspect
      break unless result != "quit"
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
      break unless result != "quit\n"
    end

    assert_equal("quit\n", result)
  end

  def test_reading_with_a_default
    puts
    puts "To finish this test, enter the word: quit"

    result = ''

    loop do
      result = MiniReadline.readline(">", false, initial: "qui").chomp
      puts result.inspect
      break unless result != "quit"
    end

    assert_equal("quit", result)
  end

  def test_reading_a_password
    puts
    puts "To finish this test, enter the word: password"

    result = ''

    loop do
      result = MiniReadline.readline(">", false, secret_mask: "*").chomp
      puts result.inspect
      break unless result != "password"
    end

    assert_equal("password", result)
  end

  def test_reading_blanked
    puts
    puts "To finish this test, enter the word: password"

    edit = MiniReadline::Readline.new

    result = ''

    loop do
      result = edit.readline(prompt: ">", secret_mask: " ").chomp
      puts result.inspect
      break unless result != "password"
    end

    assert_equal("password", result)
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
    assert(fruit.include?(result.chomp))
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
    assert(fruit.include?(result.chomp))
  end

  def test_file_auto
    puts "\nPlease select an unquoted file."

    edit = MiniReadline::Readline.new(auto_complete: true,
                                      auto_source: MiniReadline::FileFolderSource)

    result = edit.readline(prompt: "File: ")
    assert(result.is_a?(String))
  end

  def test_file_quoted
    puts "\nPlease select an quoted file."

    edit = MiniReadline::Readline.new(auto_complete: true,
                                      auto_source: MiniReadline::QuotedFileFolderSource)

    result = edit.readline(prompt: "File: ")
    assert(result.is_a?(String))
  end

  def test_file_shell
    puts "\nPlease select an auto file."

    edit = MiniReadline::Readline.new(auto_complete: true,
                                      auto_source: MiniReadline::AutoFileSource)

    result = edit.readline(prompt: "File: ")
    assert(result.is_a?(String))
  end

  def test_end_of_input_detection
    edit = MiniReadline::Readline.new()
    puts "Exit by signaling end of input"
    assert_raises(MiniReadlineEOI) {edit.readline(prompt: ">", eoi_detect: true)}
  end

  def test_prompt_verification
    opts = {prompt: ">"*70}
    edit = MiniReadline::Readline.new()
    assert_raises(MiniReadlinePLE) {edit.readline(opts)}
  end

  def test_mask_verification
    opts = {prompt: ">", secret_mask: ""}
    edit = MiniReadline::Readline.new()
    assert_raises(MiniReadlineSME) {edit.readline(opts)}

    opts = {prompt: ">", secret_mask: "xx"}
    edit = MiniReadline::Readline.new()
    assert_raises(MiniReadlineSME) {edit.readline(opts)}
  end

end
