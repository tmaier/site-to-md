# frozen_string_literal: true

require 'nokogiri'

module SiteToMd
  # FileConverter is responsible for converting individual files to a format based on the given converter.
  class FileConverter
    def initialize(file_path, base_directory, converter)
      @file_path = file_path
      @base_directory = base_directory
      @converter = converter
    end

    def convert
      return nil if content.nil? || content.strip.empty?

      format_document
    end

    private

    def relative_path
      @file_path.sub("#{@base_directory}/", '')
    end

    def document
      @document ||= Nokogiri::HTML(File.read(@file_path))
    end

    def title
      document.at_css('title')&.text || 'Untitled'
    end

    def content_element
      @content_element ||= document.at_css('main') || document.at_css('body')
    end

    def html_content
      content_element.to_html
    end

    def content
      @content ||= @converter.convert(html_content)
    end

    def format_document
      <<~DOCUMENT
        ---
        path: #{relative_path}
        title: #{title}
        ---

        #{content.strip}

        ================================================================

      DOCUMENT
    end
  end
end
