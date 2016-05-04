# MiniReadline

This gem is used to get console style input from the user, with support for
inline editing and command history.

The mini readline gem is an experiment in replacing the standard readline gem
that is part of Ruby. The mini readline will focus on the needs of Ruby programs
as opposed to a UN*X shell program. It will also try to correct a number of
irritating issues encountered when running under a Windows platform.

The mini_readline gem is designed for use with MRI version 1.9.3 or later.
The original readline tried to support older versions of Ruby.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mini_readline'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mini_readline

The mini_readline gem itself is found at: ( https://rubygems.org/gems/mini_readline )

## Key Mappings
The mini_readline gem supports a simple set of editing commands. These vary
somewhat based on the system platform. The keyboard mappings (and alias
mappings) are listed below:

Editor Action    | Windows Key                      | Other Key
-----------------|----------------------------------|------------
Enter            | Enter                            | Enter
Left             | Left Arrow, Pad Left             | Left Arrow, Ctrl-B
Word Left        | Ctrl Left Arrow, Ctrl Pad Left   | Ctrl Left Arrow, Alt-b
Right            | Right Arrow, Pad Right           | Right Arrow, Ctrl-F
Word Right       | Ctrl Right Arrow, Ctrl Pad Right | Ctrl Right Arrow, Alt-f
Go to start      | Home, Pad Home                   | Home, Ctrl-A
Go to end        | End, Pad End                     | End, Ctrl-E
Previous History | Up Arrow, Pad Up                 | Up Arrow, Ctrl-R
Next History     | Down Arrow, Pad Down             | Down Arrow
Erase Left       | Backspace, Ctrl-H                | Backspace, Ctrl-H
Erase All Left   |                                  | Ctrl-U
Erase Right      | Delete, Ctrl-Backspace           | Delete, Ctrl-Backspace
Erase All Right  |                                  | Ctrl-K
Erase All        | Escape                           | Ctrl-L
Auto-complete    | Tab, Ctrl-I                      | Tab, Ctrl-I
End of Input     | Ctrl-Z                           | Alt-z

### Notes
* The label "Other" is an umbrella that bundles together the Linux, Mac,
and Cygwin platforms. On systems lacking an Alt key, these sequences may be
replaced by Escape followed by the appropriate letter.
* References to Pad keys under Windows assume that Num Lock is not engaged.
* Support for End of Input is controlled by the eoi_detect option. See options
below.

## Usage

The typical way of utilizing this gem is to place the following:

```ruby
require 'mini_readline'
```

### Demos

There are a number of demo/test programs available for the mini_readline gem.
These are:

    $ irbm
    Starting an IRB console with mini_readline.
    irb(main):001:0>

This runs against the most recently installed gem. Also available in the gem
root folder is the irbt test utility.

    $ ruby irbt.rb

which again, uses the most recent gem installed in the system.

    $ ruby irbt.rb local

which uses the local copy of mini_readline, ignoring the system gems. This can
also be accomplished with the command:

    $ rake console

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

##### Module Aliasing

For enhanced compatibility, the mini_readline gem has the ability to alias
itself as the readline gem. This ability is subject to the following list
of conditions.

1) If the global variable $no_alias_read_line_module is set to true before the
mini_readline gem is required, *no* aliasing will take place.
```ruby
$no_alias_read_line_module = true
require 'mini_readline'
```
2) Else, if the global variable $force_alias_read_line_module is set to true
before the mini_readline gem is required, aliasing *will* take place.
```ruby
$force_alias_read_line_module = true
require 'mini_readline'
```
3) Else, if the readline gem is already loaded, *no* aliasing will take place.
```ruby
require 'readline'
require 'mini_readline'
```
4) Finally, if none of the above conditions are met, aliasing *will* take place.
```ruby
require 'mini_readline'
```
Note that if the readline gem is subsequently required after the mini_readline
gem, it will redefine the Readline constant, generating a warning message on
$stderr. If that is an issue, the following should ensure that the
mini_readline gem stays in charge.
```ruby
require 'readline'
$force_alias_read_line_module = true
require 'mini_readline'
```

### Native Mode

In native mode, instances of the Readline class are used to get user input.

```ruby
edit = MiniReadline::Readline.new()
```

The constructor takes an optional argument. A hash of options that are used
as instance level options.

<br>Once an instance is created it may be used as follows:

```ruby
user_entry = edit.readline(options)
```
Where an optional hash of options settings. For example, to specify a
non-default prompt with history enabled, use the following:

```ruby
user_entry = edit.readline(prompt: '? ', history: true)
```


In addition, it is possible to get a hold
of the history buffer of the edit object with:
```ruby
hist = edit.history
```
This method answers an array of strings. Entries added to this array are
available to the edit instance. For example, the following adds a rather
menacing entry to the history buffer.
```ruby
edit.history << "launch --weapons:nuclear --all"
```
Maybe I should cut back on the Fallout/4?

### Options
In mini_readline, options exist at three levels:
* The MiniReadline module hash BASE_OPTIONS. These options are shared by
all instances of the Readline class. These options can be modified by
changing entries in the MiniReadline::BASE_OPTIONS hash.
* The instance options associated with each instance of the Readline class.
These options may be specified when a Readline instance is created (with new)
or by getting the instance options with the instance_options property and
adding/changing entries to/in it.
* The options hash argument of the Readline class's readline instance method.

<br>The options in effect during a read line operation are expressed as:

```ruby
MiniReadline::BASE_OPTIONS.merge(instance_options).merge(options)
```
<br>This means that instance_options entries override those in BASE_OPTION and
readline parameter option entries override both instance_options and BASE_OPTION
entries.

<br>The available options are described below:
```ruby
BASE_OPTIONS = {
  :window_width  => 79,       #The width of the edit area.
  :scroll_step   => 12,       #The amount scrolled.

  :prompt        => ">",      #The default prompt.
  :alt_prompt    => "<< ",    #The prompt when scrolled.
                              #Set to nil for no alt prompt.

  :auto_complete => false,    #Is auto complete enabled?
  :auto_source   => nil,      #Filled in by auto_complete.rb
                              #MiniReadline::QuotedFileFolderSource

  :eoi_detect    => false,    #Is end of input detection enabled?

  :history       => false,    #Is the history buffer enabled?
  :log           => [],       #Default is no previous history
  :no_blanks     => true,     #No empty lines in history.
  :no_dups       => true,     #No duplicate lines in history.

  :term          => nil,      #Filled in by raw_term.rb
                              #MiniReadline::RawTerm

  :debug         => false}    #Used during development only.
```

<br>While most of these options are self explanatory, a few could stand some
further description:
* :prompt is the standard prompt used when text is not scrolled.
* :alt_prompt is the prompt used when the text must be scrolled to fit on the
screen. If this is set to nil, then the main prompt is always used.
<br>Both the prompt and alt_prompt may contain ANSI terminal control sequences.
These are restricted, however, to those commands that do not alter the position
of the cursor. So basically colors, highlighting, etc.
* :auto_complete is disabled by default. Of course there are a number of ways
to enable it, or to make auto-complete enabled the default use:
```ruby
require 'mini_readline'
MiniReadline::BASE_OPTION[:auto_complete] = true
```
* :auto_source is the class of the source for auto-complete data. By default
this is MiniReadline::QuotedFileFolderSource. This option can be changed up to
get auto-complete data other than files and folders. See Auto-Compete below for
more details.
* :eoi_detect is used to control the end of input detection logic. If disabled,
eoi inputs are treated as unmapped. If enabled, they raise a MiniReadlineEOI
exception.
* :term is the interactive source of data, the console by default. The raw
terminal console driver automatically adapts to the system environment
(Windows or Other) so that correct operation is normally achieved with no
further actions on the part of the user. The terminal support class can be
changed, to a user supplied class, to get data from another source, such as
a serial attached terminal.

#### Notes
* Since the compatibility mode does not accept an options hash, the only way to
affect options in this case is to modify the MiniReadline::BASE_OPTIONS hash.
* The :term option is the low level console io object used to get data
from the user and control what is displayed. This gem automatically adapts to
the environment and plugs in the needed object. This can be overridden where
special io needs exist.

### Auto-Complete
The mini readline gem comes with three auto-complete engines. These are:
* MiniReadline::ArraySource - Make a selection from an array of choices. That
array is found in the option :array_src. This can either be an array of
strings or a proc (or lambda) that returns an array of strings.
* MiniReadline::FileFolderSource - A simple, in-line auto-complete for files
and folders that do **not** contain embedded spaces.
* MiniReadline::QuotedFileFolderSource - A simple, in-line auto-complete for
files and folders embedded in quotes. For example "foo bar.rb". Note that the
file names may contain spaces. This is the default auto-complete data source.

### Adding Custom Auto-Completers
It is possible, and fairly straightforward to add application specific
auto-completers to mini readline. To show how this might be done, the
File and Folder data source is shown. Essential components of this class are
the initialize, rebuild, and next methods.

```ruby
  class FileFolderSource

    #Create a new file/folder auto-data source. NOP
    def initialize(options)
      # Save or ignore the options hash.
    end

    #Construct a new data list for auto-complete given the current contents
    #of the mini_readline edit buffer. Return true-ish for success and
    #false-ish for failure.
    def rebuild(str)
      extract_root_pivot(str)

      list = Dir.glob(@pivot + '*')

      @cycler = list.empty? ? nil : list.cycle
    end

    #Parse the string into the two basic components. This is not part of the
    #protocol but is included to give an example of splitting the invariant
    #(root) part of the buffer from the variable (pivot) part.
    def extract_root_pivot(str)
      @root, @pivot = /\S+$/ =~ str ? [$PREMATCH, $MATCH] : [str, ""]
    end

    #Get the next string for auto-complete. Note that this is the entire
    #string, not just the pivot bit at the end.
    def next
      @root + @cycler.next
    end

  end
```
To enable the use of a custom auto-completer, three things must be done:
* The option[:auto_complete] must be set to true
* The option[:auto_source] must be set to the class name of the new completer.
* Any optional, additional options required by the completer must be set.

<br> See the section Options above for more details on setting/controlling
options.

<br>Note: Elsewhere in the code above there exists a require 'English'
statement to permit the use of clearer, easier to read access to regular
expression results.

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
system gem, use this:

    $ ruby sire.rb local

## Testing
To date this code has been tested under:
* Windows 7 with ruby 1.9.3p484 (2013-11-22) [i386-mingw32]
* Windows 7 with ruby 2.1.6p336 (2015-04-13 revision 50298) [i386-mingw32]
* Windows 7+Cygwin with ruby 2.2.3p173 (2015-08-18 revision 51636) [i386-cygwin]

<br>**More testing is clearly called for and suggestions/bug reports are most
welcomed!!!**

## Contributing

Comments, suggestions, criticisms, bug reports, and pull requests are welcome
on GitHub at:

https://github.com/PeterCamilleri/mini_readline.


## License

The gem is available as open source under the terms of the MIT License. Please
see LICENSE.txt for further details.

