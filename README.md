# The Claude Code Phrasebook

*Everything Claude Code says to you, pulled out of the compiled binary.*

Claude Code talks to you at three moments, and all three are just plain strings
baked into the CLI binary:

- **While it works** → a whimsical spinner verb — **Thinking…**, **Brewing…**,
  **Flibbertigibbeting…**. These **Claude Code spinner words** (187 of them) are
  the protagonist here: the spinner is where the most personality leaks through.
  → [Spinner verbs](#spinner-verbs--while-it-works)
- **When it finishes** → a calmer past-tense line like `Crunched for 51s`
  (a hand-picked 8). → [Completion verbs](#completion-verbs--when-its-done)
- **At startup** → a rotating, genuinely useful tip like `Hit shift+tab to cycle
  between default mode, auto-accept edit mode, and plan mode` (~64).
  → [Startup tips](#startup-tips--at-startup) · [TIPS.md](./TIPS.md)

This phrasebook catalogs all three, plus a
**[per-version archive](#version-archive)** so you can watch the vocabulary
evolve across releases.

> Heads-up: these lists change between versions. Re-run [`extract.sh`](./extract.sh)
> against your own install to get the current set.

> 🤖 **Meta note.** This whole repo is Claude Code looking at itself. Every list
> here was extracted and reconstructed by **Claude Code (Opus 4.8) reading the
> compiled Claude Code binary** — across three versions of itself
> (2.1.181 / 183 / 185). The spinner verb it showed you while it did the work is,
> of course, in [`words.txt`](./words.txt). See the [Colophon](#colophon) for how
> it went.

---

## Spinner verbs — while it works

The present-tense verb next to the spinner. They're **purely cosmetic** —
picked at random, with *no* relationship to what Claude is actually doing
(reading files, running tools, etc.); they just reassure you something's
happening. As of **v2.1.185** there are **187**, and the best part is how the
list is built — a deliberate blend of genuine vocabulary, culinary terms, magic,
dance, physics, and total gibberish. Here's the same 187 words grouped by theme
so the personality comes through.

*이 목록의 묘미는 조합에 있습니다. 실제 어휘, 요리 용어, 마법, 춤, 물리학, 순수한 헛소리가 일부러 뒤섞여 있죠. 같은 187개 단어를 개성이 보이도록 테마별로 묶었습니다. 각 단어의 한국어 뜻은 아래 [전체 알파벳순 목록](#the-complete-alphabetical-list-187--전체-알파벳순-목록) 표에 있습니다.*

> **Fun facts**
> - 🍳 **Cooking is the single biggest theme** (~30 words) — Claude is, apparently, mostly a kitchen.
> - Longest verb: **`Whatchamacalliting`** (18 letters). Shortest: **`Doing`** (5).
> - 6 are hyphenated/apostrophe'd tongue-twisters: `Beboppin'` · `Dilly-dallying` · `Fiddle-faddling` · `Razzle-dazzling` · `Sock-hopping` · `Topsy-turvying`.

### 🍳 Cooking & baking · 요리 · 베이킹 — "something's simmering"

The largest theme. Claude as a kitchen. *(가장 큰 비중을 차지하는 테마. Claude는 거의 주방장 모드입니다.)*

`Baking` 굽기 · `Blanching` 데치기 · `Brewing` 우려내기 · `Bunning` 빵으로 빚기 (조어) · `Caramelizing` 캐러멜화하기 · `Churning` 휘젓기 · `Concocting` 이것저것 조제하기 · `Cooking` 요리하기 · `Crystallizing` 결정화하기 · `Drizzling` 솔솔 뿌리기 · `Fermenting` 발효시키기 · `Flambéing` 플람베하기 (불 붙이기) · `Frosting` 아이싱 바르기 · `Garnishing` 고명 올리기 · `Infusing` 우려내기 · `Julienning` 채 썰기 · `Kneading` 반죽하기 · `Leavening` 부풀리기 (발효) · `Marinating` 양념에 재워두기 · `Misting` 분무하기 · `Nebulizing` 안개처럼 분무하기 · `Percolating` (드립처럼) 우러나기 · `Pollinating` 수분(꽃가루받이)하기 · `Proofing` (반죽) 1차 발효시키기 · `Sautéing` 소테 (살짝 볶기) · `Seasoning` 간 맞추기 · `Simmering` 뭉근히 끓이기 · `Smooshing` 짓이기기 · `Stewing` 푹 졸이기 · `Tempering` (초콜릿) 템퍼링하기 · `Whisking` 거품 내어 젓기 · `Zesting` 껍질 갈아내기

### 🧠 Thinking & reasoning · 생각 · 추론 — the literal "I'm processing"

`Calculating` 계산하기 · `Cerebrating` 머리 굴리기 · `Cogitating` 곰곰이 궁리하기 · `Computing` 연산하기 · `Considering` 숙고하기 · `Contemplating` 사색하기 · `Deciphering` 해독하기 · `Deliberating` 심사숙고하기 · `Determining` 결정짓기 · `Elucidating` 명료하게 밝히기 · `Inferring` 추론하기 · `Mulling` 곱씹어 생각하기 · `Musing` 사색에 잠기기 · `Philosophising` 철학적으로 따지기 · `Pondering` 깊이 숙고하기 · `Pontificating` 단정적으로 일장연설하기 · `Processing` 처리하기 · `Puzzling` 골똘히 풀기 · `Ruminating` 되새김질하듯 곱씹기 · `Thinking` 생각하기 · `Working` 일하기

### ✨ Magic & transformation · 마법 · 변형 — making creation feel mystical

`Enchanting` 마법 걸기 · `Manifesting` 실체로 불러내기 · `Metamorphosing` 탈바꿈하기 · `Prestidigitating` 손재주 마술 부리기 · `Transfiguring` 변모시키기 · `Transmuting` (연금술처럼) 변성시키기 · `Levitating` 공중부양하기 · `Quantumizing` 양자화하기 (농담)

### 💃 Dance & motion · 춤 · 움직임 — playful movement

`Beboppin'` 비밥(재즈) 추기 · `Boogieing` 부기 춤추기 · `Frolicking` 까불며 뛰놀기 · `Gallivanting` 쏘다니기 · `Galloping` 질주하기 · `Grooving` 흥에 겨워 놀기 · `Jitterbugging` 지터버그 추기 · `Moonwalking` 문워크하기 · `Moseying` 어슬렁거리기 · `Shimmying` 어깨 흔들며 추기 · `Skedaddling` 후다닥 내빼기 · `Sock-hopping` 양말 신고 추기 (50년대 댄스) · `Swooping` 휙 내리덮치기 · `Twisting` 비틀기 · `Waddling` 뒤뚱뒤뚱 걷기 · `Zigzagging` 지그재그로 가기

### 🌦️ Nature & physics · 자연 · 물리 — weather, cosmos, phase changes

`Billowing` 뭉게뭉게 피어오르기 · `Cascading` 폭포처럼 쏟아지기 · `Coalescing` 하나로 응결되기 · `Ebbing` 썰물처럼 빠지기 · `Evaporating` 증발하기 · `Gusting` 돌풍처럼 불기 · `Hyperspacing` 초공간 도약하기 · `Ionizing` 이온화하기 · `Nucleating` 핵 생성하기 · `Orbiting` 궤도 돌기 · `Osmosing` 스며들 듯 익히기 · `Photosynthesizing` 광합성하기 · `Precipitating` 응결 / 촉발하기 · `Sublimating` 승화시키기 · `Thundering` 우르릉 천둥치기 · `Undulating` 물결치듯 일렁이기 · `Warping` 휘어 비틀기 · `Whirlpooling` 소용돌이 만들기 · `Whirring` 윙윙 돌아가기

### 🏗️ Building & making · 제작 · 작업 — the engineering register

`Accomplishing` 완수하기 · `Actioning` 실행에 옮기기 · `Actualizing` 실현하기 · `Architecting` 설계하기 · `Bootstrapping` 자력으로 띄우기 (부트스트랩) · `Composing` 작곡 / 구성하기 · `Crafting` 정성껏 만들기 · `Creating` 창조하기 · `Crunching` (데이터를) 으드득 처리하기 · `Forging` 벼리기 · `Forming` 빚어내기 · `Generating` 생성하기 · `Hashing` 해시 처리하기 / 잘게 다지기 · `Orchestrating` 총괄 지휘하기 · `Sketching` 스케치하기 · `Spinning` 빙빙 돌리기 · `Synthesizing` 합성 / 종합하기 · `Tinkering` 만지작 손보기 · `Wrangling` 씨름하듯 다루기

### 🐣 Life & creatures · 생물 · 동물 — nests, growth, animal antics

`Burrowing` 굴 파고들기 · `Canoodling` 시시덕거리기 · `Cultivating` 일구기 / 기르기 · `Germinating` 싹 틔우기 · `Hatching` 부화시키기 / 꾸미기 · `Herding` 몰아 모으기 · `Honking` 빵빵 울리기 · `Incubating` 품어 키우기 · `Nesting` 둥지 틀기 · `Pouncing` 와락 덮치기 · `Roosting` 홰에 앉기 · `Scampering` 종종걸음 치기 · `Scurrying` 부산히 내달리기 · `Slithering` 스르르 미끄러지기 · `Sprouting` 움 틔우기 · `Symbioting` 공생하기 (조어)

### 🤪 Nonsense & wordplay · 헛소리 · 말장난 — the real charm

Mostly not in any dictionary; chosen for sheer fun. *(대부분 사전에 없는 단어들입니다. 순전히 재미로 고른 말들이죠.)*

`Befuddling` 어리둥절하게 만들기 · `Combobulating` 정신 차리게 만들기 (조어) · `Discombobulating` 헷갈리게 만들기 · `Recombobulating` 다시 정신 차리게 만들기 (조어) · `Dilly-dallying` 꾸물대기 · `Fiddle-faddling` 시시한 일로 뭉그적대기 · `Flibbertigibbeting` 촐랑대기 (조어) · `Flummoxing` 당혹스럽게 만들기 · `Hullaballooing` 소란 피우기 · `Lollygagging` 빈둥거리기 · `Razzle-dazzling` 현란하게 홀리기 · `Razzmatazzing` 요란하게 뽐내기 · `Shenaniganing` 장난질하기 · `Tomfoolering` 바보짓하기 · `Topsy-turvying` 뒤죽박죽 뒤집기 · `Whatchamacalliting` '거시기'하기 (조어) · `Wibbling` 흔들흔들하기 (조어)

### 🤖 Claude in-jokes · Claude 관련 농담

- **`Clauding`** — “doing the Claude thing”, 자기 이름을 건 말장난
- **`Gitifying`** — git-flavored work, git 작업하는 느낌
- **`Vibing`** — the “vibe coding” meme, ‘바이브 코딩’ 밈

### …and the rest · 그 외

A grab-bag that didn’t neatly cluster. *(딱히 안 묶이는 잡동사니.)*

`Beaming` 환히 빛나기 / 전송하기 · `Bloviating` 일장연설하기 · `Boondoggling` 헛일에 매달리기 · `Booping` 콕 누르기 · `Catapulting` 투석기로 쏘아 올리기 · `Channeling` (영매처럼) 끌어내기 · `Channelling` 끌어내기 (영국식 철자) · `Choreographing` 안무 짜기 · `Determining` 결정짓기 · `Doing` 하기 · `Doodling` 끄적이기 · `Effecting` (변화를) 이루기 · `Embellishing` 꾸며 덧붙이기 · `Envisioning` 머릿속에 그려보기 · `Finagling` 잔꾀로 해내기 · `Flowing` 흐르기 · `Fluttering` 팔랑이기 · `Gesticulating` 손짓 발짓하기 · `Harmonizing` 조화시키기 · `Ideating` 아이디어 내기 · `Imagining` 상상하기 · `Improvising` 즉흥으로 해내기 · `Meandering` 굽이굽이 흐르기 · `Mustering` 끌어모으기 · `Newspapering` 신문지로 채우기 (조어) · `Noodling` 이리저리 굴려보기 · `Perambulating` 거닐기 · `Perusing` 정독하기 · `Propagating` 퍼뜨리기 · `Puttering` 만지작거리기 · `Reticulating` 그물망 짜기 (심시티 밈) · `Spelunking` 동굴 탐험하기 · `Swirling` 소용돌이치기 · `Unfurling` 펼쳐 내걸기 · `Unravelling` 술술 풀어내기 · `Wandering` 정처 없이 떠돌기

### The complete alphabetical list (187) · 전체 알파벳순 목록

<details>
<summary><b>📖 클릭해서 187개 전체 보기</b> &nbsp;·&nbsp; English + 한국어 뜻 &nbsp;👇</summary>

| # | Word | 뜻 | | # | Word | 뜻 |
|--:|------|----|---|--:|------|----|
| 1 | Accomplishing | 완수하기 | | 95 | Julienning | 채 썰기 |
| 2 | Actioning | 실행에 옮기기 | | 96 | Kneading | 반죽하기 |
| 3 | Actualizing | 실현하기 | | 97 | Leavening | 부풀리기 (발효) |
| 4 | Architecting | 설계하기 | | 98 | Levitating | 공중부양하기 |
| 5 | Baking | 굽기 | | 99 | Lollygagging | 빈둥거리기 |
| 6 | Beaming | 환히 빛나기 / 전송하기 | | 100 | Manifesting | 실체로 불러내기 |
| 7 | Beboppin' | 비밥(재즈) 추기 | | 101 | Marinating | 양념에 재워두기 |
| 8 | Befuddling | 어리둥절하게 만들기 | | 102 | Meandering | 굽이굽이 흐르기 |
| 9 | Billowing | 뭉게뭉게 피어오르기 | | 103 | Metamorphosing | 탈바꿈하기 |
| 10 | Blanching | 데치기 | | 104 | Misting | 분무하기 |
| 11 | Bloviating | 일장연설하기 | | 105 | Moonwalking | 문워크하기 |
| 12 | Boogieing | 부기 춤추기 | | 106 | Moseying | 어슬렁거리기 |
| 13 | Boondoggling | 헛일에 매달리기 | | 107 | Mulling | 곱씹어 생각하기 |
| 14 | Booping | 콕 누르기 | | 108 | Musing | 사색에 잠기기 |
| 15 | Bootstrapping | 자력으로 띄우기 (부트스트랩) | | 109 | Mustering | 끌어모으기 |
| 16 | Brewing | 우려내기 | | 110 | Nebulizing | 안개처럼 분무하기 |
| 17 | Bunning | 빵으로 빚기 (조어) | | 111 | Nesting | 둥지 틀기 |
| 18 | Burrowing | 굴 파고들기 | | 112 | Newspapering | 신문지로 채우기 (조어) |
| 19 | Calculating | 계산하기 | | 113 | Noodling | 이리저리 굴려보기 |
| 20 | Canoodling | 시시덕거리기 | | 114 | Nucleating | 핵 생성하기 |
| 21 | Caramelizing | 캐러멜화하기 | | 115 | Orbiting | 궤도 돌기 |
| 22 | Cascading | 폭포처럼 쏟아지기 | | 116 | Orchestrating | 총괄 지휘하기 |
| 23 | Catapulting | 투석기로 쏘아 올리기 | | 117 | Osmosing | 스며들 듯 익히기 |
| 24 | Cerebrating | 머리 굴리기 | | 118 | Perambulating | 거닐기 |
| 25 | Channeling | (영매처럼) 끌어내기 | | 119 | Percolating | (드립처럼) 우러나기 |
| 26 | Channelling | 끌어내기 (영국식 철자) | | 120 | Perusing | 정독하기 |
| 27 | Choreographing | 안무 짜기 | | 121 | Philosophising | 철학적으로 따지기 |
| 28 | Churning | 휘젓기 | | 122 | Photosynthesizing | 광합성하기 |
| 29 | Clauding | 'Claude 하기' (이름 말장난) | | 123 | Pollinating | 수분(꽃가루받이)하기 |
| 30 | Coalescing | 하나로 응결되기 | | 124 | Pondering | 깊이 숙고하기 |
| 31 | Cogitating | 곰곰이 궁리하기 | | 125 | Pontificating | 단정적으로 일장연설하기 |
| 32 | Combobulating | 정신 차리게 만들기 (조어) | | 126 | Pouncing | 와락 덮치기 |
| 33 | Composing | 작곡 / 구성하기 | | 127 | Precipitating | 응결 / 촉발하기 |
| 34 | Computing | 연산하기 | | 128 | Prestidigitating | 손재주 마술 부리기 |
| 35 | Concocting | 이것저것 조제하기 | | 129 | Processing | 처리하기 |
| 36 | Considering | 숙고하기 | | 130 | Proofing | (반죽) 1차 발효시키기 |
| 37 | Contemplating | 사색하기 | | 131 | Propagating | 퍼뜨리기 |
| 38 | Cooking | 요리하기 | | 132 | Puttering | 만지작거리기 |
| 39 | Crafting | 정성껏 만들기 | | 133 | Puzzling | 골똘히 풀기 |
| 40 | Creating | 창조하기 | | 134 | Quantumizing | 양자화하기 (농담) |
| 41 | Crunching | (데이터를) 으드득 처리하기 | | 135 | Razzle-dazzling | 현란하게 홀리기 |
| 42 | Crystallizing | 결정화하기 | | 136 | Razzmatazzing | 요란하게 뽐내기 |
| 43 | Cultivating | 일구기 / 기르기 | | 137 | Recombobulating | 다시 정신 차리게 만들기 (조어) |
| 44 | Deciphering | 해독하기 | | 138 | Reticulating | 그물망 짜기 (심시티 밈) |
| 45 | Deliberating | 심사숙고하기 | | 139 | Roosting | 홰에 앉기 |
| 46 | Determining | 결정짓기 | | 140 | Ruminating | 되새김질하듯 곱씹기 |
| 47 | Dilly-dallying | 꾸물대기 | | 141 | Sautéing | 소테 (살짝 볶기) |
| 48 | Discombobulating | 헷갈리게 만들기 | | 142 | Scampering | 종종걸음 치기 |
| 49 | Doing | 하기 | | 143 | Schlepping | 낑낑대며 나르기 |
| 50 | Doodling | 끄적이기 | | 144 | Scurrying | 부산히 내달리기 |
| 51 | Drizzling | 솔솔 뿌리기 | | 145 | Seasoning | 간 맞추기 |
| 52 | Ebbing | 썰물처럼 빠지기 | | 146 | Shenaniganing | 장난질하기 |
| 53 | Effecting | (변화를) 이루기 | | 147 | Shimmying | 어깨 흔들며 추기 |
| 54 | Elucidating | 명료하게 밝히기 | | 148 | Simmering | 뭉근히 끓이기 |
| 55 | Embellishing | 꾸며 덧붙이기 | | 149 | Skedaddling | 후다닥 내빼기 |
| 56 | Enchanting | 마법 걸기 | | 150 | Sketching | 스케치하기 |
| 57 | Envisioning | 머릿속에 그려보기 | | 151 | Slithering | 스르르 미끄러지기 |
| 58 | Evaporating | 증발하기 | | 152 | Smooshing | 짓이기기 |
| 59 | Fermenting | 발효시키기 | | 153 | Sock-hopping | 양말 신고 추기 (50년대 댄스) |
| 60 | Fiddle-faddling | 시시한 일로 뭉그적대기 | | 154 | Spelunking | 동굴 탐험하기 |
| 61 | Finagling | 잔꾀로 해내기 | | 155 | Spinning | 빙빙 돌리기 |
| 62 | Flambéing | 플람베하기 (불 붙이기) | | 156 | Sprouting | 움 틔우기 |
| 63 | Flibbertigibbeting | 촐랑대기 (조어) | | 157 | Stewing | 푹 졸이기 |
| 64 | Flowing | 흐르기 | | 158 | Sublimating | 승화시키기 |
| 65 | Flummoxing | 당혹스럽게 만들기 | | 159 | Swirling | 소용돌이치기 |
| 66 | Fluttering | 팔랑이기 | | 160 | Swooping | 휙 내리덮치기 |
| 67 | Forging | 벼리기 | | 161 | Symbioting | 공생하기 (조어) |
| 68 | Forming | 빚어내기 | | 162 | Synthesizing | 합성 / 종합하기 |
| 69 | Frolicking | 까불며 뛰놀기 | | 163 | Tempering | (초콜릿) 템퍼링하기 |
| 70 | Frosting | 아이싱 바르기 | | 164 | Thinking | 생각하기 |
| 71 | Gallivanting | 쏘다니기 | | 165 | Thundering | 우르릉 천둥치기 |
| 72 | Galloping | 질주하기 | | 166 | Tinkering | 만지작 손보기 |
| 73 | Garnishing | 고명 올리기 | | 167 | Tomfoolering | 바보짓하기 |
| 74 | Generating | 생성하기 | | 168 | Topsy-turvying | 뒤죽박죽 뒤집기 |
| 75 | Germinating | 싹 틔우기 | | 169 | Transfiguring | 변모시키기 |
| 76 | Gesticulating | 손짓 발짓하기 | | 170 | Transmuting | (연금술처럼) 변성시키기 |
| 77 | Gitifying | 'git화'하기 (조어) | | 171 | Twisting | 비틀기 |
| 78 | Grooving | 흥에 겨워 놀기 | | 172 | Undulating | 물결치듯 일렁이기 |
| 79 | Gusting | 돌풍처럼 불기 | | 173 | Unfurling | 펼쳐 내걸기 |
| 80 | Harmonizing | 조화시키기 | | 174 | Unravelling | 술술 풀어내기 |
| 81 | Hashing | 해시 처리하기 / 잘게 다지기 | | 175 | Vibing | 분위기 타기 (바이브) |
| 82 | Hatching | 부화시키기 / 꾸미기 | | 176 | Waddling | 뒤뚱뒤뚱 걷기 |
| 83 | Herding | 몰아 모으기 | | 177 | Wandering | 정처 없이 떠돌기 |
| 84 | Honking | 빵빵 울리기 | | 178 | Warping | 휘어 비틀기 |
| 85 | Hullaballooing | 소란 피우기 | | 179 | Whatchamacalliting | '거시기'하기 (조어) |
| 86 | Hyperspacing | 초공간 도약하기 | | 180 | Whirlpooling | 소용돌이 만들기 |
| 87 | Ideating | 아이디어 내기 | | 181 | Whirring | 윙윙 돌아가기 |
| 88 | Imagining | 상상하기 | | 182 | Whisking | 거품 내어 젓기 |
| 89 | Improvising | 즉흥으로 해내기 | | 183 | Wibbling | 흔들흔들하기 (조어) |
| 90 | Incubating | 품어 키우기 | | 184 | Working | 일하기 |
| 91 | Inferring | 추론하기 | | 185 | Wrangling | 씨름하듯 다루기 |
| 92 | Infusing | 우려내기 | | 186 | Zesting | 껍질 갈아내기 |
| 93 | Ionizing | 이온화하기 | | 187 | Zigzagging | 지그재그로 가기 |
| 94 | Jitterbugging | 지터버그 추기 | | | | |

> 💡 *(조어)* 표시는 사전에 없는, **재미로 만든 단어**입니다 (예: `Combobulating`, `Flibbertigibbeting`, `Whatchamacalliting`). `Clauding` · `Gitifying` · `Vibing`은 Claude 관련 농담입니다.

</details>

---

## Completion verbs — when it's done

When a task *finishes*, Claude Code swaps the live spinner for a past-tense
summary like `Crunched for 51s`. That word comes from a much smaller,
hand-picked set — just **8** verbs, stored the same way (a contiguous
`Baked … Worked` block):

`Baked` 구워냄 · `Brewed` 우려냄 · `Churned` 휘저어냄 · `Cogitated` 곰곰이 궁리함 · `Cooked` 요리함 · `Crunched` 으드득 처리함 · `Sautéed` 살짝 볶아냄 · `Worked` 일함

A nice bit of design: **187 playful verbs while it's thinking, but only 8 calm
ones when it's done** — and 6 of the 8 are culinary (Baked/Brewed/Churned/
Cooked/Sautéed), so the finished message always reads like something was just
served. (`Sautéed` truncates to `Saut` in `strings`, same multi-byte quirk as
`Sautéing`/`Flambéing`.)

```bash
./extract.sh --past
```

---

## Startup tips — at startup

The hints Claude Code rotates through at launch are baked into the binary too.
Here's a taste — the first of **8 groups**. All **64 tips**, grouped and boxed,
live in **[TIPS.md](./TIPS.md)**:

> [!TIP]
> **Getting started & workflow**
>
> 1. New to Claude Code? Run `/powerup` for a quick interactive tutorial
> 2. Start with small features or bug fixes, tell Claude to propose a plan, and verify its suggested edits
> 3. Ask Claude to create a todo list when working on complex tasks to track progress and remain on track
> 4. Hit Enter to queue up additional messages while Claude is working.
> 5. Send messages to Claude while it works to steer Claude in real-time
> 6. Run `claude --continue` or `claude --resume` to resume a conversation
> 7. Name your conversations with `/rename` to find them easily in `/resume` later
> 8. Use git worktrees to run multiple Claude sessions in parallel.
> 9. Running multiple Claude sessions? Use `/color` and `/rename` to tell them apart at a glance.
> 10. Running multiple Claude sessions? Run `claude agents` to see them all in one place, or press `shift+tab` twice on an empty prompt when Claude is idle

Pull them from your own install with:

```bash
./extract.sh --tips
```

**This one has a story.** Unlike the spinner verbs, tips are *not* a clean data
array, and the obvious approach is wrong:

- The `Tip: ` prefix you see on screen is **added by the renderer** — the stored
  text is just `Hit shift+tab to cycle between…`. So `grep '^Tip: '` finds the
  *wrong* set entirely (a few incidental, unrelated `Tip:` strings) and misses
  every real tip. This repo shipped that bug first; a user caught it by noticing
  a tip they could see (`Hit shift+tab to cycle…`) wasn't in the output.
- The real tips are a contiguous text region (with a parallel array of
  kebab-case slugs: `shift-tab`, `install-github-app`, `double-esc`, …). Some
  are **assembled at runtime** from a keybinding/command spliced between
  fragments, so they extract as leading-space pieces.
- And the encoding is **mixed** — most tips are ASCII, but a few
  (plugin-disuse, team-onboarding) are **UTF-16LE**, so an ASCII-only `strings`
  silently dropped their tails.

`extract.sh --tips` slices that region, decodes **both ASCII and UTF-16LE**,
walks the bytes in order, and **reconstructs each tip into one complete
sentence** — joining fragments, splicing in the runtime value (slash command,
keybinding, URL), and folding em-dash clauses. As regression guards it **asserts
two tips are present** — the visible shift+tab tip (ASCII) and a plugin-disuse
tip (UTF-16) — and fails loudly if a future version moves the region or breaks
the 16-bit decode.

👉 The archived `versions/<ver>/tips.txt` is this reconstructed list — **64
complete sentences** (a few tips show a small gap where a purely dynamic value,
like a credit amount, would be). **[TIPS.md](./TIPS.md)** is the grouped,
annotated reference.

---

## Make your own — change the spinner & tips

You don't have to reverse-engineer anything to *change* these. Claude Code reads
three settings from `~/.claude/settings.json`:

```json
{
  "spinnerVerbs": { "mode": "append", "verbs": ["Vibing", "Yak-shaving", "Bikeshedding"] },
  "spinnerTipsEnabled": true,
  "spinnerTipsOverride": { "excludeDefault": false, "tips": ["Stretch — this one might take a while"] }
}
```

- **`spinnerVerbs`** — `{ "mode": "append" | "replace", "verbs": [...] }`.
  `append` adds yours to the built-in 187; `replace` shows **only** yours.
- **`spinnerTipsEnabled`** — `true`/`false` to show or hide the `Tip: …` hints.
- **`spinnerTipsOverride`** — `{ "excludeDefault": true, "tips": [...] }` swaps in
  your own tips (`excludeDefault: true` drops the stock ones).

So you can make the spinner say whatever you want — your verb shows up right
after the `✻`. *(Schema taken verbatim from the settings strings in the
v2.1.185 binary — the same place this whole repo comes from.)*

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

## Colophon

A small note on the recursion, because it's the fun part: **this repo was made
by Claude Code reverse-engineering Claude Code.** An Opus 4.8 agent, running
*inside* Claude Code, `strings`-ed and byte-sliced the compiled Claude Code
binaries for three of its own past versions to recover the words it shows users
— while displaying those very words in its own status line as it worked.

It did not get there in one clean pass. The interesting findings came from a
human noticing things and pushing back:

- **Spinner verbs** were the easy win — a clean, alphabetically-sorted array,
  187 of them, extracted in one go.
- **Completion verbs** turned out to be a separate, curated set of just **8**
  past-tense words (`Crunched for 51s`) — calm where the spinner is playful.
- **Tips** were a saga. The first extraction grepped for `^Tip: ` and looked
  fine — until a user pointed at a tip they could *see* in their UI
  (`Hit shift+tab to cycle…`) that wasn't in the output. That one observation
  unravelled three separate bugs: tips aren't stored with a `Tip: ` prefix at
  all; sorting them scrambled the runtime-assembled fragments; and a few are
  stored as **UTF-16LE**, so an ASCII-only pass silently dropped their tails. An
  independent subagent re-derived the list from scratch to cross-check, and the
  extractor now **reconstructs each tip into a complete sentence** with a
  built-in regression assertion.

The lesson that kept repeating: *if you can see it on screen, it's in the binary
somewhere* — and "looks done" is not "is done" until you verify against what the
program actually shows. The full back-and-forth lives in the git history.

— *Written by Claude Code (Opus 4.8), about Claude Code.* 🤖

---

## License

Public domain / [The Unlicense](https://unlicense.org). The word list is
extracted from Anthropic's Claude Code for documentation and curiosity; all
trademarks belong to their owners.
