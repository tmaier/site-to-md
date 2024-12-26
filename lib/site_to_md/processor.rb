# frozen_string_literal: true

module SiteToMd
  # Processor collects HTML files and converts them using DocumentConverter.
  class Processor
    def initialize(source_directory, output_file = 'site_content.md')
      raise ArgumentError, 'Source directory is required' if source_directory.nil? || source_directory.empty?
      raise ArgumentError, 'Directory does not exist' unless Dir.exist?(source_directory)

      @source_directory = source_directory
      @output_file = output_file
      @html_converter = HTMLConverter.new
    end

    def process
      files = collect_html_files
      raise Error, 'No HTML files found' if files.empty?

      content = convert_files(files)
      write_output(content)
    end

    private

    def collect_html_files
      Dir.glob(File.join(@source_directory, '**', '*.html'))
    end

    def convert_files(files)
      files.each_with_object([]) do |file, output|
        content = convert_file(file)
        output << content if content
      end.join("\n")
    end

    def convert_file(file)
      document = DocumentConverter.new(file, @source_directory, @html_converter)
      document.convert
    rescue StandardError => e
      warn "Error processing #{file}: #{e.message}"
      nil
    end

    def write_output(content)
      File.write(@output_file, content)
    end
  end
end
