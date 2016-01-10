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
* Finally, since this code will borrow a lot from the original, it is hoped
that I will see the same bugs and fix them. Then perhaps it can be seen how
the original code can also be fixed. In the long run, this is perhaps the
most important goal.

<br>The mini_readline gem is designed for use with MRI version 1.9.3 or later.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mini_readline'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mini_readline

## Key Mappings
The mini_readline gem supports a simple set of editing commands. These vary
somewhat based on the system platform. The keyboard mappings (and alias
mappings) are listed below:

Editor Action    | Windows Key               | Other Key
-----------------|---------------------------|------------
Enter            | Enter                     | Enter
Left             | Left Arrow, Keypad Left   | Left Arrow
Right            | Right Arrow, Keypad Right | Right Arrow
Go to start      | Home, Keypad Home         | Home, Ctrl-A
Go to end        | End, Keypad End           | End, Ctrl-E
Previous History | Up Arrow, Keypad Up       | Up Arrow, Ctrl-R
Next History     | Down Arrow, Keypad Down   | Down Arrow
Erase Left       | Backspace                 | Backspace, Ctrl-H
Erase Right      | Delete, Ctrl-Backspace    | Delete, Ctrl-Backspace
Erase All        | Escape                    | Ctrl-B

### Notes
* The label "Other" is an umbrella that bundles together the Linux, Mac,
and Cygwin platforms.
* References to Keypad keys under Windows assume that Num Lock is not engaged.

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
the history buffer. This assumes that the $no_alias_read_line_module setting
mentioned above was *not* used. If it was, then these somewhat less compatible
forms are required:
```ruby
MiniReadline.readline('>', true)
```
and
```ruby
MiniReadline.readline('>', false)
```


### Native Mode

In native mode, instances of the Readline class are used to get user input.

```ruby
edit = MiniReadline::Readline.new()
```

The constructor takes a single optional argument which is either:
* An array of strings; A history buffer pre-loaded with commands.
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
This method answers an array of strings. Entries added to this array are
available to the edit instance. For example, the following makes a rather
menacing part of the history buffer.
```ruby
hist << "launch --weapons:nuclear --all"
```

### Options
In mini_readline, options exist at two levels:
* The MiniReadline module hash BASE_OPTIONS. These options are shared by
all instances of the Readline class.
* The options hash argument of the Readline class's readline instance method.

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

## Demo
A simple demo of mini_readline in action is available. To access this demo use
the following from the mini_readline root folder:

    $ ruby sire.rb

This will launch SIRE, a Simple Interactive Ruby Environment, a sort of
simple minded irb knock-off. This starts off by requiring the mini
readline gem from either the system gem library or the local lib folder or
if all fails, it will load the "classic" Readline gem. Here is a typical run:

    C:\Sites\mini_readline>ruby sire.rb


    Loaded mini_readline from the local code folder.

    Welcome to a Simple Interactive Ruby Environment
    Use the command 'q' to quit.

    SIRE>
Of note, the run method can be used to test for the shell process bug. For
example:

    SIRE>(run 'ls').split("\n")
    ["Gemfile",
     "LICENSE.txt",
     "README.md",
     "Rakefile",
     "bin",
     "lib",
     "mini_readline.gemspec",
     "rdoc",
     "reek.txt",
     "sire.rb",
     "tests"]
    SIRE>
After this command is run, the program should continue to operate correctly
and not go bannanas. To test the behavior of the standard readline library, use:

    $ ruby sire.rb old

To test the local copy of mini_readline in the lib folder instead of the
system gem, use this instead:

    $ ruby sire.rb local

## Testing
To date this code has been tested under:
* Windows 7 with MRI ruby 2.1.6p336 (2015-04-13 revision 50298) [i386-mingw32]
* Windows 7 + Cygwin with ruby 2.2.3p173 (2015-08-18 revision 51636) [i386-cygwin]

<br>More testing is clearly called for.

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/PeterCamilleri/mini_readline.


## License

The gem is available as open source under the terms of the
[MIT License](http://opensource.org/licenses/MIT).

