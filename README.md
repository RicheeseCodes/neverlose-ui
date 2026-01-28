# 🎨 "Like Neverlose" Library

> A optimized, and fully customizable UI Library for Roblox, inspired by the Neverlose cheat menu.

![Lua](https://img.shields.io/badge/Language-Lua-blue.svg) ![Platform](https://img.shields.io/badge/Platform-Roblox-red.svg) ![Status](https://img.shields.io/badge/Status-Active-success.svg)

## ✨ Overview

**CSGO UI Library** is a modern Roblox UI framework focused on performance, flexibility, and clean visuals. It provides a full cheat-style interface with advanced configuration support, dynamic UI elements, draggable widgets, and a redesigned settings system.

---

## 📖 Table of Contents

- [Getting Started](#-getting-started)
- [Window & Tabs](#-window--tabs)
- [UI Elements](#-ui-elements)
  - [Toggle & Addons](#toggle--addons)
  - [Sliders & Buttons](#sliders--buttons)
  - [Dropdowns & Lists](#dropdowns--lists)
  - [Inputs & Labels](#inputs--labels)
- [Special Modules](#-special-modules)
  - [Global Chat](#global-chat)
  - [Watermark](#watermark)
  - [Keybind List](#keybind-list)
- [Settings System](#-settings--config-system)

---

## 🚀 Getting Started

### 1. Load the Library

```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/ImInsane-1337/neverlose-ui/refs/heads/main/source/library.lua"))()
```

### 2. Setup Directories & Theme

> ⚠️ **Note:** It is recommended to set up the theme **before** creating the window to prevent color flickering on startup.

```lua
local CheatName = "MyProject"

-- 1. Setup Folders for Configs
Library.Folders = {
    Directory = CheatName,
    Configs = CheatName .. "/Configs",
    Assets = CheatName .. "/Assets",
}

-- 2. Define Theme Colors
local Accent = Color3.fromRGB(0, 116, 224)        -- Main Color
local Gradient = Color3.fromRGB(0, 195, 255)      -- Gradient End Color

-- 3. Apply Theme
Library.Theme.Accent = Accent
Library.Theme.AccentGradient = Gradient
Library:ChangeTheme("Accent", Accent)
Library:ChangeTheme("AccentGradient", Gradient)
```

---

## 🖥️ Window & Tabs

### Create Window

```lua
local Window = Library:Window({
    Name = "Project Name",
    SubName = "Best script hub",
    Logo = "120959262762131" -- rbxassetid (Numbers only)
})
```

### Create Page (Tab)

```lua
local CombatTab = Window:Page({
    Name = "Combat",
    Icon = "138827881557940", -- rbxassetid
    Columns = 2 -- 1 or 2 columns
})
```

### Create Section

```lua
local AimbotSection = CombatTab:Section({
    Name = "Aimbot",
    Side = 1, -- 1 = Left Column, 2 = Right Column
    EnableToggle = true -- Allows the user to collapse the section
})
```

---

## 🧩 UI Elements

### Toggle & Addons

Toggles can have sub-elements like Colorpickers and Keybinds attached to them.

```lua
local Toggle = AimbotSection:Toggle({
    Name = "Enabled",
    Flag = "AimToggle",
    Default = false,
    Callback = function(Value)
        print("Toggle:", Value)
    end
})

-- Add Colorpicker
Toggle:Colorpicker({
    Flag = "AimColor",
    Default = Color3.fromRGB(255, 0, 0),
    Alpha = 1, -- Transparency (0-1)
    Callback = function(Color, Alpha) end
})

-- Add Keybind
Toggle:Keybind({
    Flag = "AimBind",
    Default = Enum.KeyCode.E,
    Mode = "Toggle", -- Options: "Hold", "Toggle", "Always"
    Callback = function(State) end
})
```

### Sliders & Buttons

```lua
-- Slider
AimbotSection:Slider({
    Name = "FOV",
    Flag = "FovSlider",
    Min = 0,
    Max = 100,
    Default = 90,
    Decimals = 1,
    Suffix = "°",
    Callback = function(Value) end
})

-- Button
AimbotSection:Button({
    Name = "Refresh",
    Callback = function()
        print("Button Clicked")
    end
})
```

### Dropdowns & Lists

Dropdowns support dynamic refreshing at runtime.

```lua
-- Dropdown
local SkinSelector = AimbotSection:Dropdown({
    Name = "Select Skin",
    Flag = "SkinDrop",
    Items = {"Default"},
    Default = "Default",
    Callback = function(Value)
        print("Selected:", Value)
    end
})

-- Dynamic Refresh Example
AimbotSection:Button({
    Name = "Refresh Skins",
    Callback = function()
        -- Refresh(NewList, DefaultValue)
        SkinSelector:Refresh({"Redline", "Asiimov", "Dragon Lore"}, "Redline")
    end
})

-- Listbox (Scrollable list)
local List = AimbotSection:Listbox({
    Flag = "Configs",
    Items = {"Legit", "Rage", "HvH"},
    Size = 150 -- Height in pixels
})

List:Add("New Config")
```

### Inputs & Labels

```lua
-- Textbox
AimbotSection:Textbox({
    Flag = "Input",
    Placeholder = "Enter text...",
    Finished = true -- Only callback when Enter is pressed
})

-- Label
AimbotSection:Label("This is a simple text label")
```

---

## 🛠️ Special Modules

### Global Chat
A visual chat interface that attaches to a **Page** (not a Section).

```lua
local Chat = CombatTab:GlobalChat(1) -- 1 = Left Side, 2 = Right Side

-- Sending a message programmatically
Chat:SendMessage("rbxassetid://AVATAR_ID", "User", "Hello!", false)

-- Handling user input
Chat:OnMessageSendPressed(function()
    local msg = Chat:GetTypedMessage()
    if msg ~= "" then
        Chat:SendMessage("rbxassetid://YOUR_ID", "You", msg, true)
        Chat:ClearText()
    end
end)
```

### Watermark
A draggable, auto-resizing status bar. Hidden by default (enable via Settings or Script).

```lua
-- Initialize
Library:Watermark({
    "Cheat Name",
    "User",
    1234567890 -- Logo ID
})

-- Update Loop (Optimized)
task.spawn(function()
    while true do
        local FPS = math.floor(1 / game:GetService("RunService").RenderStepped:Wait())
        Library:Watermark({
            "MyCheat",
            "User",
            123554105934637,
            "FPS: " .. FPS
        })
        task.wait(0.5)
    end
end)
```

### Keybind List
Displays active keybinds. Hidden by default.

```lua
local KeybindList = Library:KeybindList("Active Binds")
```

---

## ⚙️ Settings & Config System

The library includes a built-in generator for a Settings tab. This automatically creates:
1.  **Config Manager (Left):** Create, Save, Load, Delete configs.
2.  **UI Settings (Right):** Theme colors, Watermark toggle, Keybind list toggle, Unload button.

```lua
-- Pass the Window and KeybindList to generate the page
local SettingsTab = Library:CreateSettingsPage(Window, KeybindList)
```

---

## 🏁 Finalizing

Always call `Init()` at the very end of your script to apply layouts and load the UI.

```lua
Window:Init()
```
