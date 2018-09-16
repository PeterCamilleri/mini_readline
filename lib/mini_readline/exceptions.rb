# coding: utf-8

# The exception raised when an enabled EOI is detected in a readline operation.
class MiniReadlineEOI < StandardError; end

# The exception raised when the keyboard mapping is invalid.
class MiniReadlineKME < RuntimeError; end

# The exception raised when the prompt is too long to fit.
class MiniReadlinePLE < RuntimeError; end

# The exception raised when the secret entry mask is invalid.
class MiniReadlineSME < RuntimeError; end
