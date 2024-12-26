# frozen_string_literal: true

require 'nokogiri'

module SiteToMd
  # DocumentConverter is responsible for converting individual HTML documents to markdown format.
  class DocumentConverter
    def initialize(file_path, base_directory, markdown_converter)
      @file_path = file_path
      @base_directory = base_directory
      @markdown_converter = markdown_converter
    end

    def convert
      return nil if content_element.nil? || markdown_content.strip.empty?

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

    def markdown_content
      @markdown_content ||= @markdown_converter.convert(content_element.to_html)
    end

    def format_document
      <<~DOCUMENT
        ---
        path: #{relative_path}
        title: #{title}
        ---

        #{markdown_content.strip}

        ================================================================

      DOCUMENT
    end
  end
end
