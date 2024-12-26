# frozen_string_literal: true

require 'test_helper'

class HTMLConverterTest < Minitest::Test
  def setup
    @converter = SiteToMd::HTMLConverter.new
  end

  def test_converts_basic_html
    html = '<h1>Title</h1><p>Content</p>'
    result = @converter.convert(html)

    assert_equal "# Title\n\nContent", result.strip
  end

  def test_converts_links
    html = '<a href="https://example.com">Link</a>'
    result = @converter.convert(html)

    assert_equal '[Link](https://example.com)', result.strip
  end

  def test_converts_lists
    html = '<ul><li>Item 1</li><li>Item 2</li></ul>'
    result = @converter.convert(html)

    assert_match(/- Item 1\n- Item 2/, result.strip)
  end

  def test_converts_tables
    html = '<table><tr><th>Header</th></tr><tr><td>Data</td></tr></table>'
    result = @converter.convert(html)

    assert_match(/\| Header \|/, result)
    assert_match(/\| Data \|/, result)
  end
end
