# frozen_string_literal: true

module SiteToMd
  # Base error class for all SiteToMd errors
  class Error < StandardError; end

  # Error raised when no converter is available for a given file type
  class UnsupportedFileTypeError < Error
    def initialize(file)
      super("No converter available for #{file}")
    end
  end

  # Error raised when no files are found in the source directory
  class NoFilesFoundError < Error
    def initialize
      super('No files found in the source directory')
    end
  end

  # Error raised when the source directory is invalid
  class InvalidSourceDirectoryError < ArgumentError
    def initialize
      super('Source directory is required and must exist')
    end
  end
end
