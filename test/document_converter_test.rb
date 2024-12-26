# frozen_string_literal: true

require 'test_helper'

class DocumentConverterTest < Minitest::Test
  include TestHelpers

  def setup
    @sample_site = fixture_path('sample_site')
    @markdown_converter = SiteToMd::HTMLConverter.new
  end

  def test_converts_document_with_main_tag # rubocop:disable Minitest/MultipleAssertions
    file_path = File.join(@sample_site, 'index.html')
    converter = SiteToMd::DocumentConverter.new(file_path, @sample_site, @markdown_converter)
    result = converter.convert

    assert_match(/^---$/, result)
    assert_match(/^path: index\.html$/, result)
    assert_match(/^title: Home Page$/, result)
    assert_match(/# Welcome/, result)
    assert_match(/This is a test page/, result)
  end

  def test_converts_document_without_main_tag # rubocop:disable Minitest/MultipleAssertions
    file_path = File.join(@sample_site, 'about.html')
    converter = SiteToMd::DocumentConverter.new(file_path, @sample_site, @markdown_converter)
    result = converter.convert

    assert_match(/^---$/, result)
    assert_match(/^path: about\.html$/, result)
    assert_match(/^title: About$/, result)
    assert_match(/About page content/, result)
  end

  def test_handles_missing_title
    html = '<html><body><p>Content</p></body></html>'
    temp_file = File.join(@sample_site, 'no_title.html')
    File.write(temp_file, html)

    begin
      converter = SiteToMd::DocumentConverter.new(temp_file, @sample_site, @markdown_converter)
      result = converter.convert

      assert_match(/^title: Untitled$/, result)
    ensure
      File.delete(temp_file)
    end
  end
end
