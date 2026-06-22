# Claude Code Spinner Words

While [Claude Code](https://claude.com/claude-code) works, it shows a whimsical
present-tense verb next to the spinner at the bottom of the screen —
**Thinking…**, **Pondering…**, **Brewing…**, **Flibbertigibbeting…** — along with
elapsed time and token usage.

These verbs are **purely cosmetic**. They're picked at random and have *no*
relationship to what Claude is actually doing (reading files, running tools,
etc.). They simply reassure you that something is happening. The fun is in the
mix: real dictionary words sit right next to deliberate nonsense and a few
in-jokes.

As of Claude Code **v2.1.185** there are **187** of them, stored as a contiguous,
alphabetically-sorted array of plain strings inside the compiled CLI binary.

This repo also tracks two companion lists baked into the same binary:
- **8 past-tense completion verbs** — the `Crunched for 51s` message you see *after*
  a task finishes ([bonus section](#bonus-the-completion-verbs-8-and-tips)).
- the **startup tips** (`Tip: …`).

And it keeps a **[per-version archive](#version-archive)** so you can watch the
vocabulary evolve across releases.

> Heads-up: these lists change between versions. Re-run [`extract.sh`](./extract.sh)
> against your own install to get the current set.

---

## How to extract them yourself

The words live as plain strings inside the Mach-O / native binary. Find your
install, `strings` it, and slice out the block that runs from `Accomplishing` to
`Zigzagging`:

```bash
# Auto-detect the newest installed version and print a numbered list
./extract.sh

# pick a list:  --present (default) | --past | --tips | --all
./extract.sh --all

# one word per line, no numbers (for diffing / scripting)
./extract.sh --past --plain

# …or point it at a specific binary
./extract.sh ~/.local/share/claude/versions/2.1.185
```

The one-liner at the heart of the script:

```bash
BIN=~/.local/share/claude/versions/2.1.185      # your install path

strings -n 4 "$BIN" \
  | awk '/^Accomplishing$/{g=1} g{print} /^Zigzagging$/{if(g)exit}' \
  | sed 's/^Flamb$/Flambéing/; s/^Saut$/Sautéing/' \
  | sort -u \
  | nl -w3 -s'. '
```

Notes:
- The binary stores **two copies** of the array — `sort -u` collapses them.
- `strings` truncates multi-byte accented characters, so `Flambéing` and
  `Sautéing` show up as `Flamb` / `Saut`. The `sed` step restores them.
- Find your install path with `readlink -f "$(which claude)"`.

---

## The verbs, by theme

The single best part of this list is how it's built — a deliberate blend of
genuine vocabulary, culinary terms, magic, dance, physics, and total gibberish.
Here's the same 187 words grouped so the personality comes through.

> **Fun facts**
> - 🍳 **Cooking is the single biggest theme** (~30 words) — Claude is, apparently, mostly a kitchen.
> - Longest verb: **`Whatchamacalliting`** (18 letters). Shortest: **`Doing`** (5).
> - Only 2 carry an accent — **`Flambéing`**, **`Sautéing`** — and both are (of course) cooking words.
> - 6 are hyphenated/apostrophe'd tongue-twisters: `Beboppin'` · `Dilly-dallying` · `Fiddle-faddling` · `Razzle-dazzling` · `Sock-hopping` · `Topsy-turvying`.

### 🍳 Cooking & baking — "something's simmering"
The largest theme. Claude as a kitchen.

`Baking` · `Blanching` (parboil) · `Brewing` · `Bunning` · `Caramelizing` ·
`Churning` · `Concocting` · `Cooking` · `Crystallizing` · `Drizzling` ·
`Fermenting` · `Flambéing` · `Frosting` · `Garnishing` · `Infusing` ·
`Julienning` (fine matchstick cut) · `Kneading` · `Leavening` · `Marinating` ·
`Misting` · `Nebulizing` (atomize into mist) · `Percolating` · `Pollinating` ·
`Proofing` (let dough rise) · `Sautéing` · `Seasoning` · `Simmering` ·
`Smooshing` · `Stewing` · `Tempering` (e.g. chocolate) · `Whisking` ·
`Zesting` (grate citrus peel)

### 🧠 Thinking & reasoning — the literal "I'm processing"
`Calculating` · `Cerebrating` (use the brain) · `Cogitating` (ponder deeply) ·
`Computing` · `Considering` · `Contemplating` · `Deciphering` · `Deliberating` ·
`Determining` · `Elucidating` (make clear) · `Inferring` · `Mulling` ·
`Musing` · `Philosophising` · `Pondering` · `Pontificating` (pronounce
dogmatically) · `Processing` · `Puzzling` · `Ruminating` (chew over) ·
`Thinking` · `Working`

### ✨ Magic & transformation — making creation feel mystical
`Enchanting` · `Manifesting` · `Metamorphosing` (transform) ·
`Prestidigitating` (sleight of hand) · `Transfiguring` · `Transmuting`
(alchemy) · `Levitating` · `Quantumizing` (joke)

### 💃 Dance & motion — playful movement
`Beboppin'` · `Boogieing` · `Frolicking` · `Gallivanting` (roam for fun) ·
`Galloping` · `Grooving` · `Jitterbugging` (a swing dance) · `Moonwalking` ·
`Moseying` (amble) · `Shimmying` · `Skedaddling` (scram) · `Sock-hopping`
(1950s dance) · `Swooping` · `Twisting` · `Waddling` · `Zigzagging`

### 🌦️ Nature & physics — weather, cosmos, phase changes
`Billowing` · `Cascading` · `Coalescing` (merge) · `Ebbing` (tide receding) ·
`Evaporating` · `Gusting` · `Hyperspacing` · `Ionizing` · `Nucleating` ·
`Orbiting` · `Osmosing` · `Photosynthesizing` · `Precipitating` ·
`Sublimating` (solid → gas) · `Thundering` · `Undulating` (ripple) · `Warping` ·
`Whirlpooling` · `Whirring`

### 🏗️ Building & making — the engineering register
`Accomplishing` · `Actioning` · `Actualizing` · `Architecting` ·
`Bootstrapping` · `Composing` · `Crafting` · `Creating` · `Crunching` ·
`Forging` · `Forming` · `Generating` · `Hashing` · `Orchestrating` ·
`Sketching` · `Spinning` · `Synthesizing` · `Tinkering` · `Wrangling`

### 🐣 Life & creatures — nests, growth, animal antics
`Burrowing` · `Canoodling` (cuddle — cheeky) · `Cultivating` · `Germinating` ·
`Hatching` · `Herding` · `Honking` · `Incubating` · `Nesting` · `Pouncing` ·
`Roosting` · `Scampering` · `Scurrying` · `Slithering` · `Sprouting` ·
`Symbioting`

### 🤪 Nonsense & wordplay — the real charm
Mostly not in any dictionary; chosen for sheer fun.

`Befuddling` · `Combobulating` / `Discombobulating` / `Recombobulating` (the
real word and its made-up siblings) · `Dilly-dallying` (dawdle) ·
`Fiddle-faddling` · `Flibbertigibbeting` (flighty chatter) · `Flummoxing`
(bewilder) · `Hullaballooing` (uproar) · `Lollygagging` (loaf about) ·
`Razzle-dazzling` / `Razzmatazzing` (flashy showmanship) · `Shenaniganing` ·
`Tomfoolering` · `Topsy-turvying` (upside-down) · `Whatchamacalliting`
(the-thingy-ing) · `Wibbling`

### 🤖 Claude in-jokes
- **`Clauding`** — "doing the Claude thing" (a pun on its own name)
- **`Gitifying`** — git-flavored work
- **`Vibing`** — the "vibe coding" meme

### …and the rest
A grab-bag that didn't neatly cluster: `Beaming` · `Bloviating` (speechify
windily) · `Boondoggling` (busywork) · `Booping` · `Catapulting` ·
`Channeling` / `Channelling` · `Choreographing` · `Determining` · `Doing` ·
`Doodling` · `Effecting` · `Embellishing` · `Envisioning` · `Finagling`
(wangle) · `Flowing` · `Fluttering` · `Gesticulating` · `Harmonizing` ·
`Ideating` · `Imagining` · `Improvising` · `Meandering` · `Mustering` ·
`Newspapering` · `Noodling` (improvise idly) · `Perambulating` (stroll) ·
`Perusing` · `Propagating` · `Puttering` · `Reticulating` (the classic
*SimCity* "reticulating splines" gag) · `Spelunking` (cave-explore) ·
`Swirling` · `Unfurling` · `Unravelling` · `Wandering`

---

## The complete alphabetical list (187)

<details>
<summary>Click to expand all 187</summary>

```
  1. Accomplishing      48. Discombobulating  95. Julienning       142. Scampering
  2. Actioning          49. Doing             96. Kneading         143. Schlepping
  3. Actualizing        50. Doodling          97. Leavening        144. Scurrying
  4. Architecting       51. Drizzling         98. Levitating       145. Seasoning
  5. Baking             52. Ebbing            99. Lollygagging      146. Shenaniganing
  6. Beaming            53. Effecting        100. Manifesting       147. Shimmying
  7. Beboppin'          54. Elucidating      101. Marinating        148. Simmering
  8. Befuddling         55. Embellishing     102. Meandering        149. Skedaddling
  9. Billowing          56. Enchanting       103. Metamorphosing    150. Sketching
 10. Blanching          57. Envisioning      104. Misting           151. Slithering
 11. Bloviating         58. Evaporating      105. Moonwalking       152. Smooshing
 12. Boogieing          59. Fermenting       106. Moseying          153. Sock-hopping
 13. Boondoggling       60. Fiddle-faddling  107. Mulling           154. Spelunking
 14. Booping            61. Finagling        108. Musing            155. Spinning
 15. Bootstrapping      62. Flambéing        109. Mustering         156. Sprouting
 16. Brewing            63. Flibbertigibbeting 110. Nebulizing       157. Stewing
 17. Bunning            64. Flowing          111. Nesting           158. Sublimating
 18. Burrowing          65. Flummoxing       112. Newspapering      159. Swirling
 19. Calculating        66. Fluttering       113. Noodling          160. Swooping
 20. Canoodling         67. Forging          114. Nucleating        161. Symbioting
 21. Caramelizing       68. Forming          115. Orbiting          162. Synthesizing
 22. Cascading          69. Frolicking       116. Orchestrating     163. Tempering
 23. Catapulting        70. Frosting         117. Osmosing          164. Thinking
 24. Cerebrating        71. Gallivanting     118. Perambulating     165. Thundering
 25. Channeling         72. Galloping        119. Percolating       166. Tinkering
 26. Channelling        73. Garnishing       120. Perusing          167. Tomfoolering
 27. Choreographing     74. Generating       121. Philosophising    168. Topsy-turvying
 28. Churning           75. Germinating      122. Photosynthesizing 169. Transfiguring
 29. Clauding           76. Gesticulating    123. Pollinating       170. Transmuting
 30. Coalescing         77. Gitifying        124. Pondering         171. Twisting
 31. Cogitating         78. Grooving         125. Pontificating     172. Undulating
 32. Combobulating      79. Gusting          126. Pouncing          173. Unfurling
 33. Composing          80. Harmonizing      127. Precipitating     174. Unravelling
 34. Computing          81. Hashing          128. Prestidigitating  175. Vibing
 35. Concocting         82. Hatching         129. Processing        176. Waddling
 36. Considering        83. Herding          130. Proofing          177. Wandering
 37. Contemplating      84. Honking          131. Propagating       178. Warping
 38. Cooking            85. Hullaballooing   132. Puttering         179. Whatchamacalliting
 39. Crafting           86. Hyperspacing     133. Puzzling          180. Whirlpooling
 40. Creating           87. Ideating         134. Quantumizing      181. Whirring
 41. Crunching          88. Imagining        135. Razzle-dazzling   182. Whisking
 42. Crystallizing      89. Improvising      136. Razzmatazzing     183. Wibbling
 43. Cultivating        90. Incubating       137. Recombobulating   184. Working
 44. Deciphering        91. Inferring        138. Reticulating      185. Wrangling
 45. Deliberating       92. Infusing         139. Roosting          186. Zesting
 46. Determining        93. Ionizing         140. Ruminating        187. Zigzagging
 47. Dilly-dallying     94. Jitterbugging    141. Sautéing
```

</details>

---

## Bonus: the completion verbs (8) and tips

### Past-tense completion verbs

When a task *finishes*, Claude Code swaps the live spinner for a past-tense
summary like `Crunched for 51s`. That word comes from a much smaller,
hand-picked set — just **8** verbs, stored the same way (a contiguous
`Baked … Worked` block):

```
Baked · Brewed · Churned · Cogitated · Cooked · Crunched · Sautéed · Worked
```

A nice bit of design: **187 playful verbs while it's thinking, but only 8 calm
ones when it's done** — and 6 of the 8 are culinary (Baked/Brewed/Churned/
Cooked/Sautéed), so the finished message always reads like something was just
served. (`Sautéed` truncates to `Saut` in `strings`, same multi-byte quirk as
`Sautéing`/`Flambéing`.)

```bash
./extract.sh --past
```

### Startup tips

The `Tip: …` hints shown when Claude Code launches are also embedded as plain
strings:

```bash
./extract.sh --tips
```

**Important caveat:** unlike the spinner verbs, tips are *not* a clean
contiguous array. `strings | grep '^Tip: '` is best-effort and the raw output is
messy for three reasons, which is why some lines look truncated:

1. **Runtime templates** — values are spliced in at display time, so `strings`
   only catches the first fragment. Reconstructed from the surrounding bytes:
   - `Tip: You have access to {N} with {N}x more context`
   - `Tip: The shorthand "{repo}" assumes github.com. For internal GitHub`
     `Enterprise, use the full URL: git@your-github-host.com:…`
   - `Tip: For more frequent updates, use the claude-code@latest cask:`
     `brew uninstall --cask … && brew install --cask claude-code@latest`
2. **Embedded newlines** — a tip split across lines breaks at the `\n`.
3. **False positives** — `Tip: to disable all smart filtering and make ripgrep
   behave a bit more like…` is **not a Claude Code tip at all** — it's the
   bundled **ripgrep** man page (the bytes right after it are `.SH REGEX SYNTAX`
   troff markup). It only matches because ripgrep ships inside the binary.

The fully-static, genuine Claude Code tips extract cleanly:

```
Tip: You can launch Claude Code with just `claude`
Tip: You can configure model switch behavior in /config
Tip: You can enable auto-connect to IDE in /config or with the --ide flag
Tip: run /code-review ultra (no number) to review your current branch instead.
Tip: run /code-review ultra <PR number> to fetch and review a specific GitHub PR instead.
Tip: the package name is from package.json, which can differ from the folder name.
```

> The archived `versions/<ver>/tips.txt` keeps the **raw** `grep '^Tip: '` output
> (warts and all) as a faithful record of what's in the binary — don't read it as
> a curated list.

---

## Version archive

The whole point of this repo over time: track how the vocabulary changes across
Claude Code releases.

```
versions/
  2.1.181/   spinner.txt · past.txt · tips.txt
  2.1.183/   spinner.txt · past.txt · tips.txt
  2.1.185/   spinner.txt · past.txt · tips.txt
```

[`CHANGELOG.md`](./CHANGELOG.md) summarizes the diffs. So far `2.1.181`,
`2.1.183`, and `2.1.185` are **byte-for-byte identical** (same `md5`) — a clean
baseline. The archive starts paying off the first release that moves a word.

### Adding a new version

```bash
# after upgrading Claude Code:
./snapshot.sh                               # snapshots every installed version
diff versions/2.1.185/spinner.txt \
     versions/<new>/spinner.txt             # see what moved
```

Then add a row + a diff note to `CHANGELOG.md` and commit the new
`versions/<new>/` folder. PRs with fresh versions are welcome.

---

## License

Public domain / [The Unlicense](https://unlicense.org). The word list is
extracted from Anthropic's Claude Code for documentation and curiosity; all
trademarks belong to their owners.
