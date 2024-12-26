# frozen_string_literal: true

require 'thor'

module SiteToMd
  # CLI class handles the command line interface for site-to-markdown conversion.
  class CLI < Thor
    desc 'convert DIRECTORY', 'Convert HTML files from DIRECTORY to markdown'
    method_option :output, aliases: '-o', desc: 'Output file path', default: 'site_content.md'
    def convert(directory)
      processor = Processor.new(directory, options[:output])
      processor.process
      puts "Successfully converted HTML files to #{options[:output]}"
    rescue StandardError => e
      puts "Error: #{e.message}"
      exit 1
    end

    def self.exit_on_failure?
      true
    end
  end
end
