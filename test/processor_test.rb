# frozen_string_literal: true

require 'test_helper'

class ProcessorTest < Minitest::Test
  include TestHelpers

  def setup
    @temp_dir = create_temp_dir
    @sample_site = fixture_path('sample_site')
    @output_file = File.join(@temp_dir, 'output.md')
    @processor = SiteToMd::Processor.new(@sample_site, @output_file)
  end

  def teardown
    remove_temp_dir(@temp_dir)
  end

  def test_raises_error_for_nonexistent_directory
    assert_raises(ArgumentError) do
      SiteToMd::Processor.new('nonexistent_directory')
    end
  end

  def test_processes_html_files # rubocop:disable Minitest/MultipleAssertions
    @processor.process

    assert_path_exists @output_file
    content = File.read(@output_file)

    assert_match(/path: index\.html/, content)
    assert_match(/title: Home Page/, content)
    assert_match(/# Welcome/, content)
    assert_match(/This is a test page/, content)
  end

  def test_handles_files_without_main_tag
    @processor.process
    content = File.read(@output_file)

    assert_match(/path: about\.html/, content)
    assert_match(/title: About/, content)
    assert_match(/About page content/, content)
  end
end
