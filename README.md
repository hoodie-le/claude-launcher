# claude-launcher

> Open Ghostty with N equal split panes, each `cd`'d into a repo and running `claude --dangerously-skip-permissions`.

A tiny macOS CLI for developers who run **multiple Claude Code sessions in parallel** against the same repository (e.g. one writing tests while another refactors). Pick a repo from a fuzzy picker, choose how many panes, and `claude-launcher` opens [Ghostty](https://ghostty.org) with everything laid out and running.

```
┌────────┬────────┬────────┬────────┬────────┐
│        │        │        │        │        │
│ claude │ claude │ claude │ claude │ claude │
│   #1   │   #2   │   #3   │   #4   │   #5   │
│        │        │        │        │        │
└────────┴────────┴────────┴────────┴────────┘
        one Ghostty window, equal panes
```

## Features

- 🔍 **Fuzzy repo picker** over your workspaces directory (uses `fzf` if installed, falls back to a numbered menu).
- ✂️ **N equal splits** with auto-equalize — vertical (side-by-side) or horizontal (stacked).
- 🪟 **New window or current window** — your choice each time.
- ⚙️ **Configurable command** — defaults to `claude --dangerously-skip-permissions`, but anything goes (`pnpm dev`, `git status`, your own script).
- 📁 **Layered config** — defaults, config file, env vars, CLI flags (later wins).
- 🤫 **Non-interactive mode** (`-y`) for keyboard shortcuts and scripts.

## Requirements

- macOS (uses AppleScript to drive Ghostty)
- [Ghostty](https://ghostty.org) terminal
- `claude` CLI (or any command you want to run) on your `$PATH`
- Optional: [`fzf`](https://github.com/junegunn/fzf) for a nicer picker (`brew install fzf`)
- macOS **Accessibility permission** for your terminal app (System Settings → Privacy & Security → Accessibility) — needed to send `Cmd+V`, `Cmd+D`, etc. to Ghostty.

## Install

### Homebrew (recommended)

```bash
brew install hoodie-le/tap/claude-launcher
```

Or tap once and install short-form:

```bash
brew tap hoodie-le/tap
brew install claude-launcher
```

> The formula lives at [hoodie-le/homebrew-tap](https://github.com/hoodie-le/homebrew-tap).

### Manual

```bash
git clone https://github.com/hoodie-le/claude-launcher.git
cd claude-launcher
install -m 0755 bin/claude-launcher /usr/local/bin/claude-launcher
```

### Curl one-liner

```bash
curl -fsSL https://raw.githubusercontent.com/hoodie-le/claude-launcher/main/install.sh | bash
```

## Usage

Fully interactive (recommended for first run):

```bash
claude-launcher
```

You'll be asked, in order:

1. Which repo (fuzzy picker)
2. How many split panes (default `5`)
3. Split direction — `v` for side-by-side, `h` for stacked
4. Window mode — `n` for new Ghostty window, `c` for current

One-shot, non-interactive:

```bash
claude-launcher --dir ~/code/myapp --splits 3 --direction v --yes
```

Run a different command per pane (e.g. dev server):

```bash
claude-launcher --command 'git pull && pnpm install && pnpm dev'
```

## Configuration

Settings resolve in this order (later wins):

1. Built-in defaults
2. Config file `~/.config/claude-launcher/config`
3. Environment variables (`CLAUDE_LAUNCHER_*`)
4. CLI flags

### Config file

A shell-sourceable `KEY=VALUE` file. Create `~/.config/claude-launcher/config`:

```bash
WORKSPACES_DIR="$HOME/code"
SPLITS=3
DIRECTION=v
WINDOW=n
COMMAND="claude --dangerously-skip-permissions"
MAX_DEPTH=2
EQUALIZE=1
EXCLUDES='node_modules,.git,.next,dist,build,.venv,__pycache__'
```

### Environment variables

| Variable                          | Purpose                                  |
|-----------------------------------|------------------------------------------|
| `CLAUDE_LAUNCHER_WORKSPACES`      | Root directory to search for repos       |
| `CLAUDE_LAUNCHER_SPLITS`          | Number of panes                          |
| `CLAUDE_LAUNCHER_DIRECTION`       | `v` or `h`                               |
| `CLAUDE_LAUNCHER_WINDOW`          | `n` or `c`                               |
| `CLAUDE_LAUNCHER_COMMAND`         | Command to run in each pane              |
| `CLAUDE_LAUNCHER_MAX_DEPTH`       | Max directory search depth               |
| `CLAUDE_LAUNCHER_EQUALIZE`        | `0` to disable auto-equalize             |
| `CLAUDE_LAUNCHER_EXCLUDES`        | Comma-separated dir patterns to skip     |
| `CLAUDE_LAUNCHER_CONFIG`          | Alternate config file path               |

### CLI flags

```
claude-launcher [OPTIONS]

  -d, --dir DIR              Skip picker; use this directory directly
  -n, --splits N             Number of split panes
  -D, --direction v|h        Split direction
  -w, --window n|c           New or current Ghostty window
  -c, --command CMD          Command to run in each pane
  -W, --workspaces DIR       Root workspaces directory
      --depth N              Max search depth for repo picker
      --no-equalize          Skip equalizing split sizes
  -y, --yes                  Skip all interactive prompts (requires --dir)
  -h, --help                 Show help
  -V, --version              Show version
```

## Tips

- Add a short alias to `~/.zshrc`:
  ```bash
  alias cl='claude-launcher'
  ```
- Bind `claude-launcher --dir "$(pwd)" --yes` to a hotkey in [Raycast](https://raycast.com) or [Alfred](https://alfredapp.com) for instant launch from any directory.
- The picker excludes `node_modules`, `.git`, `dist`, etc. by default — tune via `EXCLUDES`.

## Troubleshooting

**Splits aren't equal sized.** `claude-launcher` triggers Ghostty's `equalize_splits` action via its default keybind `Cmd+Ctrl+=`. If you've remapped it in `~/.config/ghostty/config`, either restore the default or set `EQUALIZE=0` and equalize manually.

**Keystrokes seem to be lost.** macOS hasn't granted **Accessibility** permission to your terminal (the one running `claude-launcher`). Open *System Settings → Privacy & Security → Accessibility* and toggle the app on.

**Wrong tab/window gets the keystrokes.** Don't switch apps while `claude-launcher` is running — the script drives the focused app via System Events.

## Roadmap

- [ ] iTerm2 backend
- [ ] Warp backend
- [ ] Terminal.app backend
- [ ] Linux support (tmux / WezTerm)
- [ ] Per-pane different commands

PRs adding any of the above are very welcome.

## Contributing

Bug reports and PRs are welcome at <https://github.com/hoodie-le/claude-launcher/issues>.

For development:

```bash
git clone https://github.com/hoodie-le/claude-launcher.git
cd claude-launcher
shellcheck bin/claude-launcher
./bin/claude-launcher --help
```

## License

[MIT](./LICENSE) © Le Hoan Hao
