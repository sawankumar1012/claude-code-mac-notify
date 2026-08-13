# claude-code-mac-notify

Native macOS notifications for [Claude Code](https://docs.anthropic.com/en/docs/claude-code). Get alerted with a sound and banner when Claude finishes a response or is waiting for your input.

![macOS](https://img.shields.io/badge/macOS-only-blue) ![npm](https://img.shields.io/npm/v/claude-code-mac-notify)

## Features

- Native macOS notifications via `osascript` (no dependencies required)
- Shows project name (current directory) in the notification
- Different messages for **Stop** (turn finished) and **Notification** (waiting for input) events
- Glass sound alert so you don't miss it
- Gracefully no-ops on Linux/Windows

## Install

```bash
npm install -g claude-code-mac-notify
```

Then add the plugin to your Claude Code settings (`~/.claude/settings.json`):

```json
{
  "plugins": ["claude-code-mac-notify"]
}
```

Or install directly as a Claude Code plugin:

```bash
claude plugin add claude-code-mac-notify
```

## How it works

The plugin registers hooks for two Claude Code events:

| Event | Notification |
|---|---|
| **Stop** | "Turn finished" — Claude completed its response |
| **Notification** | "Waiting for input" — Claude needs your attention |

Each notification shows:
- **Title:** Claude Code
- **Subtitle:** Your project folder name
- **Sound:** Glass

## Requirements

- macOS (silently skips on other platforms)
- Claude Code CLI
- Python 3 (pre-installed on macOS, used to parse hook payloads)

## License

MIT
