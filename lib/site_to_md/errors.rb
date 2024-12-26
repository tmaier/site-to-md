# frozen_string_literal: true

module SiteToMd
  # Base class for all errors in the SiteToMd module
  class Error < StandardError; end

  # Error raised when there is no converter available for a given file type
  class UnsupportedFileTypeError < Error
    def initialize(file)
      super("No converter available for #{file}")
    end
  end
end
