# coding: utf-8

#* regex.rb - The regex source for auto-complete.
module MiniReadline

  #* regex.rb - The regex source for auto-complete.
  class FileFolderSource

    #For all rules, the following apply:
    #<a> is a file name character without spaces.
    #<b> is a file name character with spaces.
    #<c> is a file system 'root' specification.
    #<x> is a file spec with no embedded spaces.
    #<y> is a quoted file spec that may have embedded spaces.

    strict  = %r{(?<a> [^\/\\\:\*\?\<\>\"\s]){0}
                 (?<b> [^\/\\\:\*\?\<\>\"]){0}
                 (?<c> ([a-zA-z]\:)?\\){0}
                 (?<x> \g<c>?(\g<a>*\\?)*){0}
                 (?<y> \"\g<c>?(\g<a>(\g<b>*\g<a>)?\\?)*\"){0}
                 (\g<x>|\g<y>)$
                }x

    flex    = %r{(?<a> [^\/\\\:\*\?\<\>\"\s]){0}
                 (?<b> [^\/\\\:\*\?\<\>\"]){0}
                 (?<c> ([a-zA-z]\:)?\/){0}
                 (?<x> \g<c>?(\g<a>*\/?)*){0}
                 (?<y> \"\g<c>?(\g<a>(\g<b>*\g<a>)?\/?)*\"){0}
                 (\g<x>|\g<y>)$
                }x

    classic = %r{(?<a> [^\/\\\:\*\?\<\>\"\s]){0}
                 (?<b> [^\/\\\:\*\?\<\>\"]){0}
                 (?<c> \/){0}
                 (?<x> \g<c>?(\g<a>*\/?)*){0}
                 (?<y> \"\g<c>?(\g<a>(\g<b>*\g<a>)?\/?)*\"){0}
                 (\g<x>|\g<y>)$
                }x

    windows = {flex: flex,    strict: strict}
    other   = {flex: classic, strict: classic}

    REGEX_LIB = {windows: windows, other: other}

    def regex
      REGEX_LIB[MiniReadline::PLATFORM][@options[:files_parse]]
    end
  end
end
