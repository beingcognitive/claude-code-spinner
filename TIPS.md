# Claude Code startup tips

The hints Claude Code rotates through under the prompt (rendered as `Tip: …`).
Verified against **v2.1.185**.

Every tip below is a **complete sentence** — reconstructed from the binary and
cross-checked two independent ways (see [Verification](#verification)). Values
spliced in at runtime are shown `like this`, or as `{placeholder}` when the value
is genuinely dynamic (a count, a credit amount).

## How tips are *actually* stored (and why earlier attempts truncated)

The spinner verbs are a clean, contiguous **data array** — `strings` extracts
them perfectly. Tips are not, and three things conspired to make a naive
extraction look broken:

1. **No `"Tip: "` prefix.** The `Tip: ` you see is added by the renderer; the
   stored text is just `Hit shift+tab to cycle…`. So `grep '^Tip: '` finds the
   *wrong* set entirely and misses every real tip. (This repo's first bug — a
   user caught it by noticing a tip they could see wasn't in the output.)
2. **Runtime assembly.** Many tips are built in order from fragments with a
   value spliced between them: `Hit ` + keybinding `shift+tab` + ` to cycle…`.
   Extracting then **sorting** scrambled those fragments so the list looked
   truncated from line 1. Fix: preserve file order.
3. **Mixed encodings.** Most tips are single-byte ASCII, but a few newer ones
   (the two plugin-disuse tips and the team-onboarding tip) are stored as
   **UTF-16LE**, so an ASCII-only `strings` silently dropped their tails.

The real tips live in a contiguous text region (bytes `191,216,352 →
191,524,160` in this build), with a parallel array of kebab-case slugs
(`shift-tab`, `install-github-app`, `double-esc`, …).

## The tips (in file order)

### Getting started & workflow
1. New to Claude Code? Run `/powerup` for a quick interactive tutorial
2. Start with small features or bug fixes, tell Claude to propose a plan, and verify its suggested edits
3. Ask Claude to create a todo list when working on complex tasks to track progress and remain on track
4. Hit Enter to queue up additional messages while Claude is working.
5. Send messages to Claude while it works to steer Claude in real-time
6. Run `claude --continue` or `claude --resume` to resume a conversation
7. Name your conversations with `/rename` to find them easily in `/resume` later
8. Use git worktrees to run multiple Claude sessions in parallel.
9. Running multiple Claude sessions? Use `/color` and `/rename` to tell them apart at a glance.
10. Running multiple Claude sessions? Run `claude agents` to see them all in one place, or press `shift+tab` twice on an empty prompt when Claude is idle

### Modes & permissions
11. Hit `shift+tab` to cycle between default mode, auto-accept edit mode, and plan mode
12. Use Plan Mode to prepare for a complex request before making changes. Press `shift+tab` twice to enable.
13. Your default model setting is Opus Plan Mode. Press `shift+tab` twice to activate Plan Mode and plan with Claude Opus.
14. Use `/config` to change your default permission mode (including Plan Mode)
15. Use `/permissions` to pre-approve and pre-deny bash, edit, and MCP tools

### Slash commands & features
16. Use `/memory` to view and manage Claude memory
17. Use `/theme` to change the color theme
18. Use `/statusline` to set up a custom status line that will display beneath the input box
19. Use `/agents` to optimize specific tasks. Eg. Software Architect, Code Writer, Code Reviewer
20. Use `--agent <agent_name>` to directly start a conversation with a subagent
21. Use `/voice` to enable push-to-talk dictation
22. Use `/feedback` to help us improve!
23. Set an objective with `/goal`
24. `/loop` runs any prompt on a recurring schedule. Great for monitoring deploys, babysitting PRs, or polling status.
25. Say `"fan out subagents"` and Claude sends a team. Each one digs deep so nothing gets missed.
26. Create skills by adding .md files to .claude/skills/ in your project or ~/.claude/skills/ for skills that work in any project
27. Run `/team-onboarding` to turn your Claude usage into an onboarding guide — share it with your `{team}`

### Images & rewind
28. Did you know you can drag and drop image files into your terminal?
29. Paste images into Claude Code using control+v (not cmd+v!)
30. Use `ctrl+v` to paste images from your clipboard
31. Double-tap esc to rewind the conversation to a previous point in time
32. Double-tap esc to rewind the code and/or conversation to a previous point in time

### Terminal setup *(platform / wording variants)*
33. Run `/terminal-setup` to enable convenient terminal integration like Option + Enter for new line and more
34. Run `/terminal-setup` to enable convenient terminal integration like Shift + Enter for new line and more
35. Run `/terminal-setup` to enable Option+Enter for new lines
36. Run `/terminal-setup` to enable Shift+Enter for new lines
37. Press Option+Enter to send a multi-line message
38. Press Shift+Enter to send a multi-line message
39. Corrupted terminal glyphs? Disable terminal GPU acceleration in settings or run `/terminal-setup`
40. Try setting environment variable COLORTERM=truecolor for richer colors
41. Set CLAUDE_CODE_USE_POWERSHELL_TOOL=1 to enable the PowerShell tool (preview)

### IDE integration
42. Open the Command Palette (Cmd+Shift+P) and run "Shell Command: Install '`code`' command in PATH" to enable IDE integration
43. Connect Claude to your IDE — `/ide`
44. Run `/install-github-app` to tag @claude right from your Github issues and PRs
45. Run `/install-slack-app` to use Claude in Slack

### Desktop / mobile / cloud
46. Run Claude Code locally or remotely using the Claude desktop app: clau.de/desktop
47. Continue your session in Claude Code Desktop with `/desktop`
48. Working on UI? See a live preview in Claude Code Desktop — run `/desktop`
49. Working on UI? Claude Code Desktop has live preview and inline images — clau.de/desktop
50. Use Claude Design to mock up screens before you build — claude.ai/design
51. Run tasks in the cloud while you keep coding locally — clau.de/web
52. Control this session from the Claude mobile app — run `/remote-control`
53. Get pinged on your phone when long tasks finish — enable push notifications in `/config`

### Build / plugins / sharing
54. Build your AI product with Claude API. Run `/claude-api` to get started
55. Working with HTML/CSS? Install the frontend-design plugin: `/plugin install frontend-design@{marketplace}`
56. You haven't used the `{plugin}` plugin in a while. It still adds startup and context cost — review it with `/plugin`
57. You have `{count}` plugins you haven't used in a while. They still add startup and context cost — review them with `/plugin`
58. Share Claude Code and earn `{credits}` in usage credits — `/passes`
59. You have `{count}` free guest passes to share

## Excluded — tip-like strings in the region that are NOT tips

Verified to be errors, logs, or render markers rather than startup tips:

- `Failed to check default-permission-mode-config tip relevance:` — internal log (paired with `warn`)
- `Cannot destructure property 'eligible' from null or undefined value` — runtime error (guest-pass eligibility check)
- `Claude Code can't auto-update` + `run /doctor` — updater warning
- `plugin suggestion: {plugin} — /plugin` — the marketplace-upsell render *template*, shown as a banner rather than a numbered tip (borderline; tokens `marketplace-plugin-suggestion`, `upsell`)
- Telemetry slugs (`tengu_*`, `c4e-*`, `Apple_Terminal`, `opusplan`), render markers (`suggestion`, `chat:cycleMode`, `chat:imagePaste`, `Chat`), module names (`fs/promises`, `crypto`), command/sentiment **regexes** (`\bgit\s+push\b`, `\btelnet\b`, `\bnot what I (asked|wanted)\b`, …), and glob/config keys (`**/.claude/…`, `tipsHistory`)

## Verification

This list was cross-checked two independent ways, plus an encoding check:

1. **Ordered byte-slice.** Dump the region `New to Claude Code? Run … tipsHistory`
   in file order (`dd | strings -n 2`, **no sort**) and walk it top-to-bottom,
   joining each tip's fragments + interpolated value.
2. **Independent subagent.** A separate agent re-derived the list from the binary
   from scratch; results matched, and it surfaced the UTF-16 tails below.
3. **UTF-16LE decode.** Confirmed the plugin-disuse (#56/#57) and team-onboarding
   (#27) tails with a 16-bit decode:
   `perl -0777 -ne 'while(/((?:[\x20-\x7e]\x00){12,})/g){my $s=$1;$s=~s/\x00//g;print "$s\n"}' BIN`

**QA anchor:** the visible `Hit shift+tab to cycle between default mode,
auto-accept edit mode, and plan mode` tip (#11) is present and complete.
`extract.sh` asserts this on every run (`tips_check`).

> The archived `versions/<ver>/tips.raw.txt` is the raw, order-preserving
> extraction (ASCII **and** UTF-16LE, merged by byte offset) — so the UTF-16
> tails are now captured too. It's still fragmentary by nature (assembled tips
> span several lines); this file stitches those fragments into complete
> sentences.
