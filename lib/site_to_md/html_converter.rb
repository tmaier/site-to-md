# frozen_string_literal: true

require 'reverse_markdown'

module SiteToMd
  # HTMLConverter uses ReverseMarkdown to convert HTML to markdown.
  class HTMLConverter
    def initialize
      @config = {
        unknown_tags: :bypass,
        github_flavored: true,
        tables: true,
        tag_border: ' '
      }
    end

    def convert(html)
      ReverseMarkdown.convert(html, @config)
    end
  end
end
