# site-to-md

[![Gem Version](https://badge.fury.io/rb/site-to-md.svg)](https://badge.fury.io/rb/site-to-md)
[![Tests](https://github.com/tmaier/site-to-md/workflows/Tests/badge.svg)](https://github.com/tmaier/site-to-md/actions?query=workflow%3ATests)
[![RuboCop](https://github.com/tmaier/site-to-md/workflows/RuboCop/badge.svg)](https://github.com/tmaier/site-to-md/actions?query=workflow%3ARuboCop)
[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE.txt)

This command-line tool aggregates content from HTML pages into a single, streamlined markdown file.
It removes unnecessary HTML elements to reduce token usage and provides an easily uploadable format for AI tools like Claude AI or ChatGPT.

This tool can also be used to create a [llms.txt or llms-full.txt](https://llmstxt.org/).
For this use case, consider to add this tool to the build pipeline of your satic website.

## Features

- Converts all HTML files in a directory (and subdirectories) to markdown
- Extracts content from `<main>` tag (falls back to `<body>` if not found)
- Preserves document structure with frontmatter metadata
- Maintains proper markdown formatting for:
  - Headers
  - Lists
  - Tables
  - Code blocks
  - Links
  - And more...
- Command-line interface for easy integration

## Installation

```bash
gem install site-to-md
```

Or add to your Gemfile:

```ruby
gem 'site-to-md'
```

## Usage

### Command Line

Basic usage:

```bash
site-to-md convert path/to/site
```

Specify output file:

```bash
site-to-md convert path/to/site -o output.md
```

Get help:

```bash
site-to-md help
```

### Docker Image

You can use the [site-to-md tool via a Docker image](https://github.com/tmaier/site-to-md/pkgs/container/site-to-md), making it convenient to include in your build pipeline for static websites.

#### Example: GitLab CI

Here's an example GitLab CI configuration.
This configuration includes a job `llms-full-txt` that uses the Docker image to convert HTML files in the public folder and generates the llms-full.txt file in the same folder. This

```yaml
llms-full-txt:
  image: ghcr.io/tmaier/site-to-md:latest
  script:
    - site-to-md convert public -o public/llms-full.txt
  artifacts:
    paths:
      - public/llms-full.txt
```

### Ruby API

```ruby
require 'site_to_md'

processor = SiteToMd::Processor.new('path/to/site', 'output.md')
processor.process
```

## Output Format

The generated markdown file contains all HTML documents concatenated with frontmatter metadata:

```markdown
---
path: relative/path/to/file.html
title: Page Title
---

# Content starts here

Document content in markdown format...

================================================================

---

path: another/file.html
title: Another Page

---

More content...
```

## Development

### Requirements

- Ruby 3.2 or higher
- Bundler

### Getting Started

1. Clone the repository
2. Open in VSCode with Dev Containers extension installed
3. Click "Reopen in Container" when prompted

The development container will set up everything you need:

- Ruby development environment
- Ruby LSP for code intelligence
- RuboCop for code style checking
- Development dependencies

Alternatively, you can run without Dev Containers:

```bash
bin/setup
```

### Testing

Run the test suite:

```bash
bun/rake test
```

Run the linter:

```bash
bin/rubocop
```

### Dependency Management

We use Dependabot to keep dependencies up to date.
Dependabot creates pull requests to update:

- Ruby gem dependencies (weekly)
- GitHub Actions (weekly)
- Dockerfile (weekly)

## Contributing

Bug reports and pull requests are welcome on GitHub at <https://github.com/tmaier/site-to-md>.
This project is intended to be a safe, welcoming space for collaboration.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Make your changes:
   - Add tests for new functionality
   - Update documentation if needed
   - Ensure tests pass (`rake test`)
   - Ensure code style checks pass (`bundle exec rubocop`)
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request

## License

The gem is available as open source under the terms of the [MIT License](LICENSE).

## About

site-to-md is maintained by [maier.io UG (haftungsbeschränkt)](https://maier.io) and [Tobias L. Maier](https://tobiasmaier.info).

## Related Projects

- [reverse_markdown](https://github.com/xijo/reverse_markdown) - The HTML to Markdown converter used by this gem