# NEMESIS — AI Handoff & Sync File

> **Purpose:** This file lets any AI (Claude, Z code, GPT, Gemini, etc.) pick up work on Nemesis exactly where the last AI left off. Read this first, then `PROJECT_MEMORY.txt` for deep context.

---

## 🤖 FOR THE AI READING THIS

**You are continuing work on the Nemesis Roblox UI library.** Multiple AIs share this project. Before touching code:

1. ✅ Read this file fully
2. ✅ Read `PROJECT_MEMORY.txt` (full project history)
3. ✅ Run `git log --oneline -10` to see recent commits
4. ✅ Run `git status` to see uncommitted work from a previous AI
5. ✅ Check **"⚠️ HANDOFF NOTE"** section below for any open work

After you finish ANY change:
1. Commit with a `Co-Authored-By: <your-model-name> <noreply@example.com>` trailer
2. Push to fork (`git push fork main`)
3. **The post-commit hook auto-updates this file** (last commit, last AI, log entry)
4. Only manually edit **"⚠️ HANDOFF NOTE"** if leaving in-progress work
5. Only manually edit **"📍 CURRENT STATE"** if "what works / pending" changed

### 🔄 AUTO-COORDINATION SYSTEM

This repo has a git post-commit hook (`.githooks/post-commit`) that automatically:
- Updates "Last commit" + "Last AI" + "Date" in this file
- Prepends a new line to the AI Coordination Log

**First-time setup on a new machine:** `bash setup-hooks.sh`

**To brief a new AI quickly:** Run `./brief.sh | pbcopy` and paste to them.

---

## 👤 USER

- **Name:** Rudraksh Kotwar
- **GitHub:** RicheeseCodes
- **Executor:** Opiumware (Roblox)
- **Vibe:** Casual ("bro", "bruh"), wants working code, no long explanations
- **Hates:** Being told "it should work" — test it. Floating panels. Vertical sidebar collapse. Verbose answers.
- **Loves:** Rayfield aesthetics, smooth animations, single working scripts

---

## 📂 PROJECT BASICS

| Thing | Value |
|---|---|
| **Project name** | Nemesis (rebranded from Neverlose 2026-06-20) |
| **Main file** | `source/library.lua` (~8641 lines, Roblox Luau) |
| **Local path** | `/Users/rudrakshkotwar/NEW UI 100D` |
| **Repo** | https://github.com/RicheeseCodes/neverlose-ui *(repo name unchanged)* |
| **Branch** | `main` |
| **Push command** | `git push fork main` *(NOT origin — origin is upstream)* |
| **Load via** | `loadstring(game:HttpGet("https://raw.githubusercontent.com/RicheeseCodes/neverlose-ui/main/source/library.lua"))()` |

---

## 📍 CURRENT STATE

**Last commit:** `e0d0a59` — Listbox redesign: unified card, no scrollbar, flat search
**Last AI to touch this:** Claude Opus 4.7
**Date:** 2026-06-21

### What works right now:
- ✅ Nemesis crimson theme (Accent RGB 230,57,70)
- ✅ Topbar with 4 icons (Search, Settings, Minimize, Close)
- ✅ Sidebar tabs (rounded cards + sliding accent bar, hover effects)
- ✅ Horizontal sidebar wipe minimize/maximize
- ✅ Hide/Unhide with smooth fade
- ✅ Configurable keybind (default K)
- ✅ Rayfield-style staggered notifications
- ✅ Settings page IN content area (not floating)
- ✅ Toggle (pill switch with sliding knob)
- ✅ **NEW** Checkbox (square box with checkmark)
- ✅ Button (rounded, stroke, crimson press)
- ✅ Slider (thin crimson track, white circular thumb)
- ✅ Dropdown (single AND multi-select)

### What's still pending:
- ⏳ Remove debug logging (`warn("[Nemesis] Library loaded successfully")` and pcall wrappers around `Window:SetCenter()` and `Window:SetOpen(true)`)
- ⏳ Search bar filtering logic (UI animation works, no filter connected to actual page list)
- ⏳ Category system in sidebar (Rayfield-style collapsible groups) — not requested yet

---

## ⚠️ HANDOFF NOTE

> *(Edit this section when leaving work mid-task)*

**Status:** Clean — no in-progress work. Safe to start anything new.

---

## 🎨 ELEMENT API CHEAT SHEET

```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/RicheeseCodes/neverlose-ui/main/source/library.lua"))()

local Window = Library:Window({ Name = "Nemesis", SubName = "v1" })
local Page = Window:Page({ Name = "Main", Icon = "100050851789190" })
local Section = Page:Section({ Name = "Tests", Side = "Left" })

-- Switch (sliding pill)
Section:Toggle({ Name = "Switch", Default = false, Callback = function(v) end })

-- Checkbox (square w/ checkmark)
Section:Checkbox({ Name = "Checkbox", Default = false, Callback = function(v) end })

-- Button (rounded card)
Section:Button({ Name = "Press Me", Callback = function() end })

-- Slider (thin track + circular thumb)
Section:Slider({ Name = "Volume", Min = 0, Max = 100, Default = 50, Suffix = "%", Callback = function(v) end })

-- Single Dropdown
Section:Dropdown({ Name = "Choose", Items = {"A","B","C"}, Default = "A", Callback = function(v) end })

-- Multi Dropdown
Section:Dropdown({ Name = "Pick Many", Items = {"A","B","C"}, Multi = true, Callback = function(v) end })

-- Notification (Rayfield-style staggered)
Library:Notification({ Title = "Hey", Description = "Hello!", Duration = 4 })
```

---

## 🚫 HARD RULES (don't break these — past AIs got burned)

1. **Never use `ImageButton`** — `Instances:Create` doesn't support it. Use `TextButton` + child `ImageLabel`.
2. **Never use `Interactable` property** — not supported.
3. **No `UICorner` on LeftTabs (sidebar)** — creates visible gaps at junctions.
4. **Sidebar minimize = horizontal wipe** (width → 0). NEVER vertical collapse.
5. **Settings goes IN content area** as a real page. NEVER as a floating dropdown panel.
6. **LeftTabs and Content overlap topbar by 1px** (Position Y = 44, not 45).
7. **Loadstring alone shows NOTHING.** User must also call `Library:Window()` etc. Always give a COMPLETE test script.
8. **Push to `fork` remote**, not `origin` (origin is upstream).
9. **Don't commit `.DS_Store`, `.claude/`, `merged/`, `neverlose/`, `obsidian/`, `rayfield/`, `scratch/`** — those are reference files.
10. **Animation timing convention:**
    - Opens: `TweenInfo.new(0.5, Enum.EasingStyle.Exponential)`
    - Closes: `TweenInfo.new(0.3, Enum.EasingStyle.Quint)`
    - Hover: `TweenInfo.new(0.3-0.7, Exponential)`

---

## 🎨 NEMESIS THEME PALETTE

| Token | RGB | Use |
|---|---|---|
| `Accent` | `230, 57, 70` | Primary crimson — toggles on, slider fill, accent bar |
| `AccentGradient` | `255, 77, 90` | Lighter gradient endpoint |
| `Background` | `13, 13, 18` | Deep blue-black main bg |
| `Background 2` | `10, 10, 15` | Even deeper bg |
| `Section Top` | `17, 17, 24` | Section header bg |
| `Section Background 2` | `22, 22, 30` | Sidebar tabs / alt sections |
| `Element` | `22, 22, 30` | Element card bg |
| `ElementHover` | `28, 28, 38` | Element hover state |
| `Text` | `234, 234, 240` | Primary text |
| `SubText` | `136, 136, 160` | Muted text |
| `Outline` | `34, 34, 46` | Subtle borders |
| `ToggleOff` | `74, 74, 90` | Toggle knob when off |
| `InputBackground` | `16, 16, 22` | Textbox bg |
| `ErrorRed` | `85, 0, 0` | Error flash |

---

## 🤝 AI COORDINATION LOG

> *Each AI logs ONE LINE when they finish working. Most recent on top.*


- **[2026-06-21]** Claude Opus 4.7: Listbox redesign: unified card, no scrollbar, flat search (`e0d0a59`)

- **[2026-06-21]** Claude Opus 4.7: Dropdown popup dot: Neverlose-style — only visible when selected (`3a9a796`)

- **[2026-06-21]** Claude Opus 4.7: Dropdown: shorter box (95px) + left-flowing layout (`4415b44`)

- **[2026-06-21]** Claude Opus 4.7: Listbox checkbox: add white checkmark + bigger box (`afc47d9`)

- **[2026-06-21]** Claude Opus 4.7: Dropdown: right-anchor the box at 50% width — fully visible, no clipping (`7503014`)

- **[2026-06-21]** Claude Opus 4.7: Listbox default height 220 -> 260 so all items fit without scroll (`b322700`)

- **[2026-06-21]** Claude Opus 4.7: Dropdown layout: left-flowing instead of right-anchored (`121abf9`)

- **[2026-06-21]** Claude Opus 4.7: Add selection dots/checkboxes to dropdown popup + listbox rows (`eb13434`)

- **[2026-06-21]** Claude Opus 4.7: Dropdown layout fix: fixed-width box + breathing wrapper (`f050ee9`)

- **[2026-06-21]** Claude Opus 4.7: Fix dropdown + listbox visibility — visible bg, killed Liner & filler (`013fd74`)

- **[2026-06-21]** Claude Opus 4.7: Dropdown sizing fix: relative width + breathing margin (`9a1c8f2`)

- **[2026-06-21]** Z code (GLM-5.2): Match dropdown/listbox option row height to toggle rows (24px) (`1647ec4`)

- **[2026-06-21]** Z code (GLM-5.2): Fix hover state sticking after dropdown close — reset Hovering flag (`0e30e14`)

- **[2026-06-21]** Z code (GLM-5.2): Remove dropdown/listbox '|' bars and background highlight — text-only hover glow (`b4d3558`)

- **[2026-06-21]** Z code (GLM-5.2): Fix notification layout bug that broke rendering (removed UIListLayout) (`7a5c145`)

- **[2026-06-20]** Z code (GLM-5.2): Fix notification text position and overflow (`920c37e`)

- **[2026-06-20]** Z code (GLM-5.2): Fix notification placement, animation, and icon to match Rayfield (`3efe531`)

- **[2026-06-20]** Z code (GLM-5.2): Replace notification with Rayfield-exact look and animation (`6dea006`)

- **[2026-06-20]** Z code (GLM-5.2): Polish slider + dropdown: knob drag color, min fill, selected-row bg, option hover (`1485fcd`)

- **[2026-06-20]** Claude Opus 4.7: Cooler dropdown open animation: pop + vertical row cascade (`461ae5e`)

- **[2026-06-20]** Claude Opus 4.7: Move notifications to bottom-right (Rayfield position) + restyle (`b8b7fdd`)

- **[2026-06-20]** Claude Opus 4.7: Tighter sidebar tab spacing + snappy spam-safe page switching (`638ae20`)

- **[2026-06-20]** Claude Opus 4.7: Polish all interactive elements to Rayfield/Neverlose quality (`5cf8ee0`)

- **[2026-06-20]** Z code (GLM-5.2): Polish Toggle switch — theme tokens + slightly bigger pill (`f20e199`)

- **[2026-06-20]** Z code (GLM-5.2): Force-hide corner repairs on minimize so pill corners stay rounded (`25574d7`)

- **[2026-06-20]** Z code (GLM-5.2): Make minimized pill rounded on all 4 corners (`804e2fe`)

- **[2026-06-20]** Z code (GLM-5.2): Remove MainFrame UICorner — fixes '2 dots' in minimized pill (`a29fd32`)

- **[2026-06-20]** Z code (GLM-5.2): Remove old Neverlose pixel frames causing visible '2 dots' artifact (`a42367a`)

- **[2026-06-20]** Z code (GLM-5.2): Fix minimized pill bottom corners — fade BottomCornerRepair out/in (`8c51fa6`)

- **[2026-06-20]** Z code (GLM-5.2): Fix missing search icon — use reliable classic Roblox icon ID (`8068397`)

- **[2026-06-20]** Z code (GLM-5.2): Remove bottom rounded corners from the entire menu (`86c4b32`)

- **[2026-06-20]** Z code (GLM-5.2): Fix minimized topbar corners — fade CornerRepair in/out with minimize (`35f6a19`)

- **[2026-06-20]** Z code (GLM-5.2): Fix topbar bottom corners — add CornerRepair to square them off (`114a43e`)

- **[2026-06-20]** Z code (GLM-5.2): Wire search bar to filter sidebar tabs; remove debug logging (`19a68e3`)

- **[2026-06-20]** Claude Opus 4.7: Rounded minimized topbar + flat text-only sidebar tabs (`9fabb40`)

- **[2026-06-20]** Claude Opus 4.7: Fix close flicker + smoother minimize + better search icon (`f32afb9`)

- **[2026-06-20]** Claude Opus 4.7: Disable glass blur effect entirely — was creating visible halo outline (`19317ad`)

- **[2026-06-20]** Claude Opus 4.7: Fix blur ghost, bigger Rayfield icons + hover pulse, smoother minimize (`3dc689e`)

- **[2026-06-20]** Claude Opus 4.7: Smoother minimize/open animations + centralized topbar icons (`77ab0b5`)

- **[2026-06-20]** Claude Opus 4.7: Make NEMESIS.md auto-log a real commit so working tree stays clean (`71e3999`)

- **[2026-06-20]** Claude Opus 4.7: Fix post-commit hook regex to only match real Co-Authored-By trailers (`500e44e`)

- **[2026-06-20]** Claude Opus 4.7: Add auto-coordination system for multi-AI workflow (`0424254`)
- **[2026-06-20]** Claude (Opus 4.6→4.7): Added Checkbox element, finalized Z code's rebrand work, committed `7ae466a`, pushed.
- **[2026-06-20]** Z code (GLM-5.2): Did Nemesis rebrand + restyled Tabs/Toggle/Button/Slider/Dropdown. Left uncommitted. Missed Checkbox.
- **[2026-06-20]** Claude (Opus 4.6): Replaced floating settings panel with content-area settings page. Commit `5b3b2b1`.
- **[2026-06-19]** Claude (Opus 4.6): Layout gaps fix + horizontal sidebar minimize. Commit `858ad36`.
- **[2026-06-19]** Claude (Opus 4.6): Notifications + settings panel + keybind. Commit `968b646`.
- **[2026-06-19]** Claude (Opus 4.6): Smooth Rayfield animations for minimize/hide. Commit `84f16ff`.
- **[2026-06-19]** Claude (Opus 4.6): Topbar 4 icons + fix ImageButton bug. Commits `02bfc49`, `3c6f5f9`.

---

## 📚 REFERENCE DIRECTORIES (read-only, don't edit)

| Folder | What |
|---|---|
| `source/library.lua` | **THE main file** — only one that gets pushed |
| `rayfield/source.lua` | Rayfield UI source — design/animation reference |
| `neverlose/library.lua` | Original Neverlose source — base architecture |
| `obsidian/Library.lua` | Obsidian UI — used for merged variant only |
| `merged/library_merged.lua` | Neverlose + Obsidian merged variant |
| `scratch/library.lua` | Separate from-scratch variant |
| `PROJECT_MEMORY.txt` | **DEEP project memory** — read after this file |

---

## 🆘 TESTING SCRIPT (copy-paste ready)

```lua
local Library = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/RicheeseCodes/neverlose-ui/main/source/library.lua"
))()

local Window = Library:Window({ Name = "Nemesis Test", SubName = "v1.0" })
local Page = Window:Page({ Name = "Main", Icon = "100050851789190" })

local Left = Page:Section({ Name = "Switches & Boxes", Side = "Left" })
Left:Toggle({ Name = "Auto Aim", Default = false, Callback = function(v) print("Toggle:", v) end })
Left:Checkbox({ Name = "Team Check", Default = true, Callback = function(v) print("Check:", v) end })
Left:Checkbox({ Name = "Visibility Check", Default = false })
Left:Slider({ Name = "FOV", Min = 10, Max = 360, Default = 90, Suffix = "°" })

local Right = Page:Section({ Name = "Controls", Side = "Right" })
Right:Button({ Name = "Test Notification", Callback = function()
    Library:Notification({ Title = "Nemesis", Description = "Working perfectly!", Duration = 4 })
end })
Right:Dropdown({ Name = "Target Part", Items = {"Head","Torso","HumanoidRootPart"}, Default = "Head" })
Right:Dropdown({ Name = "Priorities", Items = {"Distance","Health","FOV"}, Multi = true })

task.delay(1, function()
    Library:Notification({ Title = "Welcome", Description = "Nemesis loaded.", Duration = 5 })
end)
```

---

**END OF SYNC FILE.** Update the "CURRENT STATE", "HANDOFF NOTE", and "AI COORDINATION LOG" sections after every work session.
