# Claude Code startup tips

The hints Claude Code rotates through under the prompt (rendered as `Tip: …`).
Verified against **v2.1.185**.

## How tips are *actually* stored (and why the first attempt was wrong)

The spinner verbs are a clean, contiguous **data array** — `strings` extracts
them perfectly. Tips are not:

- **No `"Tip: "` prefix.** The `Tip: ` you see on screen is added by the
  renderer. The stored text is just `Hit shift+tab to cycle between…`. So a
  `grep '^Tip: '` finds the *wrong* set — only a handful of incidental,
  unrelated `Tip:` strings — and misses every real tip. (That was this repo's
  first, embarrassing, bug.)
- **Parallel slug + text arrays.** Each tip has a kebab-case slug
  (`shift-tab`, `install-github-app`, `double-esc`, `permissions`, …) sitting in
  one array, with the human text in another.
- **Some are assembled at runtime** from a keybinding (or slash command, URL,
  credit amount) spliced between text fragments — so those come out of `strings`
  as leading-space fragments like `​ to cycle between default mode…`.

The real tips live in a contiguous text region; [`extract.sh --tips`](./extract.sh)
slices it and filters out the slugs/config-keys/URLs/error strings.

> **QA anchor (suggested by a user):** the **shift+tab** tip is visible in the
> live UI, so the extractor asserts that `to cycle between default mode` appears
> in its output. If a future version moves the region, that check fails loudly
> instead of silently dropping tips. See `tips_check()` in `extract.sh`.

[`versions/<ver>/tips.raw.txt`](./versions/) keeps the raw (filtered) extraction
— ~70 lines including the leading-space fragments — as a faithful record. This
file is the cleaned, human-reconstructed version.

## Assembled tips (keybinding / command spliced in)

The interesting ones — reconstructed from their fragments:

```
Hit shift+tab to cycle between default mode, auto-accept edit mode, and plan mode   ← QA anchor
Use Plan Mode to prepare for a complex request before making changes. Press shift+tab twice to enable.
Your default model setting is Opus Plan Mode. Press shift+tab twice to activate Plan Mode and plan with Claude Opus.
New to Claude Code? Run /powerup for a quick interactive tutorial
Build your AI product with Claude API. Run /claude-api to get started
Running multiple Claude sessions? Run `claude agents` to see them all in one place, or press shift+tab twice on an empty prompt when Claude is idle
Get pinged on your phone when long tasks finish — enable push notifications in {settings}
Share Claude Code and earn {amount} in usage credits
Set an objective with /goal
Continue your session in Claude Code Desktop with /desktop
Control this session from the Claude mobile app
{/loop} runs any prompt on a recurring schedule. Great for monitoring deploys, babysitting PRs, or polling status.
{Fan out subagents} and Claude sends a team. Each one digs deep so nothing gets missed.
```

## Self-contained tips (stored as complete strings)

```
Ask Claude to create a todo list when working on complex tasks to track progress and remain on track
Corrupted terminal glyphs? Disable terminal GPU acceleration in settings or run /terminal-setup
Did you know you can drag and drop image files into your terminal?
Double-tap esc to rewind the conversation to a previous point in time
Double-tap esc to rewind the code and/or conversation to a previous point in time
Hit Enter to queue up additional messages while Claude is working.
Name your conversations with /rename to find them easily in /resume later
Paste images into Claude Code using control+v (not cmd+v!)
Press Option+Enter to send a multi-line message
Press Shift+Enter to send a multi-line message
Run /install-github-app to tag @claude right from your Github issues and PRs
Run /install-slack-app to use Claude in Slack
Run /terminal-setup to enable convenient terminal integration like Option + Enter for new line and more
Run Claude Code locally or remotely using the Claude desktop app: clau.de/desktop
Run claude --continue or claude --resume to resume a conversation
Run tasks in the cloud while you keep coding locally — clau.de/web
Running multiple Claude sessions? Use /color and /rename to tell them apart at a glance.
Send messages to Claude while it works to steer Claude in real-time
Set CLAUDE_CODE_USE_POWERSHELL_TOOL=1 to enable the PowerShell tool (preview)
Start with small features or bug fixes, tell Claude to propose a plan, and verify its suggested edits
Try setting environment variable COLORTERM=truecolor for richer colors
Use --agent <agent_name> to directly start a conversation with a subagent
Use /agents to optimize specific tasks. Eg. Software Architect, Code Writer, Code Reviewer
Use /config to change your default permission mode (including Plan Mode)
Use /feedback to help us improve!
Use /memory to view and manage Claude memory
Use /permissions to pre-approve and pre-deny bash, edit, and MCP tools
Use /statusline to set up a custom status line that will display beneath the input box
Use /theme to change the color theme
Use /voice to enable push-to-talk dictation
Use Claude Design to mock up screens before you build
Use git worktrees to run multiple Claude sessions in parallel.
Working on UI? See a live preview in Claude Code Desktop
Working with HTML/CSS? Install the frontend-design plugin: /plugin install frontend-design@…
You have free guest passes to share
```

## Known limitations

- A few assembled tips can't be reconstructed perfectly from `strings` alone
  (the interpolated value — a count, a credit amount, a settings path — isn't a
  static string). Those are shown with `{…}` placeholders.
- The raw extraction may still include 1–2 non-tip strings that happen to live
  in the region; the curated lists above are hand-checked.
