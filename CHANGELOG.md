# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.0.1] - 2024-12-27

## [1.0.0] - 2024-12-26

### Added

- Command-line interface (CLI) for converting HTML files to a single markdown document
- Support for extracting content from `<main>` tag with `<body>` fallback
- Preservation of frontmatter metadata in markdown output
- Removal of unnecessary HTML elements to optimize markdown for AI tools
- Enhanced description emphasizing the tool's ease of use for AI tools like Claude AI or ChatGPT
- Initial test suite for ensuring code quality and reliability
- Continuous Integration (CI) setup using GitHub Actions
- Dockerfile to make the CLI tool available as a Docker image (useful for CI)
- Dependabot configuration for automated dependency updates
