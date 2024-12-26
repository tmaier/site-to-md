# frozen_string_literal: true

require_relative 'lib/site_to_md/version'

Gem::Specification.new do |spec| # rubocop:disable Metrics/BlockLength
  spec.name          = 'site-to-md'
  spec.version       = SiteToMd::VERSION
  spec.authors       = ['maier.io']
  spec.email         = ['hello@maier.io']

  spec.summary       = 'Convert static site HTML to a single markdown file'
  spec.description = <<~DESC
    A tool that extracts and combines text from HTML files into a single, streamlined markdown document.
    It provides a command-line interface for easy usage, removes unnecessary HTML elements to reduce
    token usage, and creates an easily uploadable format for AI tools like Claude AI or ChatGPT.
    The tool preserves document structure and includes frontmatter metadata.
  DESC
  spec.homepage = 'https://github.com/tmaier/site-to-md'
  spec.license = 'MIT'

  spec.required_ruby_version = '>= 3.2.0'

  spec.metadata = {
    'homepage_uri' => spec.homepage,
    'source_code_uri' => spec.homepage,
    'changelog_uri' => "#{spec.homepage}/blob/main/CHANGELOG.md",
    'bug_tracker_uri' => "#{spec.homepage}/issues",
    'documentation_uri' => "#{spec.homepage}/blob/main/README.md",
    'rubygems_mfa_required' => 'true'
  }

  spec.files = Dir.glob('{exe,lib,test}/**/*') +
               %w[README.md LICENSE CHANGELOG.md]

  spec.bindir        = 'exe'
  spec.executables   = ['site-to-md']
  spec.require_paths = ['lib']

  spec.add_dependency 'nokogiri', '~> 1.18'
  spec.add_dependency 'reverse_markdown', '~> 3.0'
  spec.add_dependency 'thor', '~> 1.3'
end
