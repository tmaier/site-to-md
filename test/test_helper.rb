# frozen_string_literal: true

require 'fileutils'
require 'minitest/autorun'
require 'minitest/pride'
require 'site_to_md'

module TestHelpers
  def fixture_path(path)
    File.join(File.expand_path('fixtures', __dir__), path)
  end

  def create_temp_dir
    dir = File.join(Dir.tmpdir, "site-to-md-#{Time.now.to_i}")
    FileUtils.mkdir_p(dir)
    dir
  end

  def remove_temp_dir(dir)
    FileUtils.rm_rf(dir) if dir && File.directory?(dir)
  end
end
