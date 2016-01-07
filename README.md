# MiniReadline

This gem is used to get console style input from the user, with support for
inline editing and command history.

The mini readline gem is an experiment in replacing the standard readline gem
that is part of Ruby. The reasons for doing this are somewhat shaky, but here
is a list of what is hoped to be accomplished here.

* The standard readline gem works poorly under Windows.
<br>- The keypad arrow keys do not work.
<br>- If the program attempts to send data to a subprocess, it breaks.
* The code is so convoluted that it is difficult to fix or re-factor.
* The code is just plain UGLY! With all we've learned about object oriented
design, there just HAD to be a better way!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mini_readline'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mini_readline

## Usage

The typical way of utilizing this gem is to place the following:

```ruby
require 'mini_readline'
```

<br>By default, the constant Readline is set to the MiniReadline module. If this
is not desired use the following:

```ruby
$no_alias_read_line_module = true
require 'mini_readline'
```

### Compatible Mode

In this mode, mini_readline is somewhat compatible with the classic readline.
Simply use:

```ruby
Readline.readline('>', true)
```
or to avoid tracking command history, use:

```ruby
Readline.readline('>', false)
```
Where the string argument is the prompt seen by the user and the flag controls
the history buffer.

### Native Mode

In native mode, instances of the Readline class are used to get user input.

```ruby
edit = MiniReadline::Readline.new()
```

The constructor takes a single optional argument which is either:
* An array of strings; A history buffer pre-loaded with commands
* An empty array; A history buffer with no pre-load.
* The value **false**, to disable the history buffer.

<br>Once an instance is created it may be used as follows:

```ruby
edit.readline(prompt, options)
```
Where prompt is a prompt string and options is a hash of options settings.
More on options below. In addition, it is possible to get a hold of the
history buffer of the edit object with:
```ruby
hist = edit.history
```
This is an array os strings. Entries added to this array are avaialable to
the edit instance:
```ruby
hist << "launch --weapons:nuclear --all"
```
Although one would hope that less apocalyptic commands would be involved.

### Options
In mini_readline, options exist at two levels:
* The MiniReadline module. These options are shared by all instances
* The options argument of the Readline classes readline method.

<br>The available options are described below:
```ruby
BASE_OPTIONS = {
  :window_width  => 79,       #The width of the edit area.
  :scroll_step   => 12,       #The amount scrolled.
  :alt_prompt    => "<< ",    #The prompt when scrolled.
                              #Set to nil for no alt prompt.

  :no_blanks     => true,     #No empty lines in history.
  :no_dups       => true,     #No duplicate lines in history.

  :term          => nil,      #Filled in by raw_term.rb

  :debug         => false}    #Used during development.
```

<br>The options in effect on any given call of the readline method are the
module base options plus any options passed in as an argument. The passed in
options override the base options for the duration of that method call.

#### Notes
* Since the compatibility mode does not accept an options hash, the only way to
affect options in this case is to modify the MiniReadline::BASE_OPTIONS hash.
* The :term option is the low level console io object used to get data
from the user and control what is displayed. This gem automatically adapts to
the environment and plugs in the needed object. This can be overridden where
special io needs exist.

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/PeterCamilleri/mini_readline.


## License

The gem is available as open source under the terms of the
[MIT License](http://opensource.org/licenses/MIT).

