# coding: utf-8

# Options selection, control, and access
module MiniReadline

  # The base options shared by all instances.
  BASE_OPTIONS = {
    :scroll_step   => 12,       # The amount scrolled.

    :prompt        => ">",      # The default prompt.
    :alt_prompt    => "<< ",    # The prompt when scrolled.
                                # Set to nil to use main prompt.

    :auto_complete => false,    # Is auto complete enabled?
    :auto_source   => nil,      # Filled in by auto_complete.rb
                                # MiniReadline::QuotedFileFolderSource

    :eoi_detect    => false,    # Is end of input detection enabled?

    :history       => false,    # Is the history buffer enabled?
    :log           => [],       # Default is no previous history
    :no_blanks     => true,     # No empty lines in history.
    :no_dups       => true,     # No duplicate lines in history.
    :no_move       => false,    # Don't move history entries.

    :secret_mask   => nil,      # No secret password mask. Use the
                                # string "*" to use stars or " "
                                # for invisible secrets.

    :initial       => ""        # The initial text for the entry.
                                # An empty string for none.
   }
end
