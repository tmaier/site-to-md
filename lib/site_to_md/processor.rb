# frozen_string_literal: true

module SiteToMd
  # Processor collects HTML files and converts them using FileConverter.
  class Processor
    def initialize(source_directory, output_file = 'site_content.md')
      raise InvalidSourceDirectoryError if source_directory.nil? || source_directory.empty?
      raise InvalidSourceDirectoryError unless Dir.exist?(source_directory)

      @source_directory = source_directory
      @output_file = output_file
      @converters = { '.html' => HTMLConverter.new }
    end

    def process
      files = collect_files
      raise NoFilesFoundError if files.empty?

      content = convert_files(files)
      write_output(content)
    end

    private

    def collect_files
      extensions_pattern = @converters.keys.map { |ext| ext.delete_prefix('.') }.join(',')
      Dir.glob(File.join(@source_directory, '**', "*.{#{extensions_pattern}}"))
    end

    def convert_files(files)
      files.each_with_object([]) do |file, output|
        content = convert_file(file)
        output << content if content
      end.join("\n")
    end

    def convert_file(file)
      extension = File.extname(file)
      converter = @converters.fetch(extension) { raise SiteToMd::UnsupportedFileTypeError, file }
      document = FileConverter.new(file, @source_directory, converter)
      document.convert
    rescue SiteToMd::UnsupportedFileTypeError
      raise
    rescue StandardError => e
      warn "Error processing #{file}: #{e.message}"
      nil
    end

    def write_output(content)
      File.write(@output_file, content)
    end
  end
end
