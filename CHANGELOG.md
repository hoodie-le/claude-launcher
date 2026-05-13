# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.1.0] - 2026-05-14

### Added
- Interactive repo picker over a configurable workspaces directory (fzf when available, numbered menu fallback).
- Configurable number of Ghostty split panes with auto-equalize.
- Vertical (side-by-side) or horizontal (stacked) split direction.
- New-window or current-window launch modes.
- Configurable command to run in each pane (default: `claude --dangerously-skip-permissions`).
- Layered configuration: defaults < `~/.config/claude-launcher/config` < env vars < CLI flags.
- `--yes` non-interactive mode for scripting.
- Homebrew tap support.

[Unreleased]: https://github.com/hoodie-le/claude-launcher/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/hoodie-le/claude-launcher/releases/tag/v0.1.0
