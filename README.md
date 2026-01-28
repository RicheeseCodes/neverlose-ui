# 🎨 CSGO UI Library

> A premium, optimized, and fully customizable UI Library for Roblox, inspired by Neverlose cheat menu.

![Lua](https://img.shields.io/badge/Language-Lua-blue.svg) ![Platform](https://img.shields.io/badge/Platform-Roblox-red.svg) ![Status](https://img.shields.io/badge/Status-Active-success.svg)

---

## ✨ Overview

**CSGO UI Library** is a modern Roblox UI framework focused on performance, flexibility, and clean visuals. It provides a full cheat-style interface with advanced configuration support, dynamic UI elements, and a redesigned settings system.

---

## 🚀 Getting Started

### 1. Load the Library

```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/ImInsane-1337/neverlose-ui/refs/heads/main/source/library.lua"))()
```

---

### 2. Setup Directories & Theme

> ⚠️ Recommended to do **before** creating the window to avoid color flickering.

```lua
local CheatName = "MyProject"

-- Folder setup
Library.Folders = {
    Directory = CheatName,
    Configs = CheatName .. "/Configs",
    Assets = CheatName .. "/Assets",
}

-- Theme colors
local Accent = Color3.fromRGB(0, 116, 224)
local Gradient = Color3.fromRGB(0, 195, 255)

Library.Theme.Accent = Accent
Library.Theme.AccentGradient = Gradient

Library:ChangeTheme("Accent", Accent)
Library:ChangeTheme("AccentGradient", Gradient)
```

---

### 3. Create Window

```lua
local Window = Library:Window({
    Name = "Project Name",
    SubName = "Best script hub",
    Logo = "120959262762131" -- rbxassetid (numbers only)
})
```

---

## 📑 Pages (Tabs)

```lua
local CombatTab = Window:Page({
    Name = "Combat",
    Icon = "138827881557940",
    Columns = 2
})
```

* `Columns`: `1` or `2`

---

## 📦 Sections

```lua
local AimbotSection = CombatTab:Section({
    Name = "Aimbot",
    Side = 1, -- 1 = Left, 2 = Right
    EnableToggle = true -- Allows collapsing
})
```

---

## 🧩 UI Elements

### Toggle

```lua
local Toggle = AimbotSection:Toggle({
    Name = "Enabled",
    Flag = "AimToggle",
    Default = false,
    Callback = function(Value)
        print(Value)
    end
})
```

#### Toggle Addons

**Colorpicker**

```lua
Toggle:Colorpicker({
    Flag = "AimColor",
    Default = Color3.fromRGB(255, 0, 0),
    Alpha = 1,
    Callback = function(Color, Alpha) end
})
```

**Keybind**

```lua
Toggle:Keybind({
    Flag = "AimBind",
    Default = Enum.KeyCode.E,
    Mode = "Toggle", -- Hold / Toggle / Always
    Callback = function(State) end
})
```

---

### Slider

```lua
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
```

---

### Button

```lua
AimbotSection:Button({
    Name = "Refresh",
    Callback = function()
        print("Clicked")
    end
})
```

---

### Dropdown (Dynamic)

```lua
local SkinSelector = AimbotSection:Dropdown({
    Name = "Select Skin",
    Flag = "SkinDrop",
    Items = {"Default"},
    Default = "Default",
    Callback = function(Value)
        print("Selected:", Value)
    end
})

-- Dynamic refresh example
AimbotSection:Button({
    Name = "Refresh Skins",
    Callback = function()
        SkinSelector:Refresh({"Redline", "Asiimov", "Dragon Lore"}, "Redline")
    end
})
```

---

### Textbox

```lua
AimbotSection:Textbox({
    Flag = "Input",
    Placeholder = "Enter text...",
    Finished = true
})
```

---

### Listbox

```lua
local List = AimbotSection:Listbox({
    Flag = "Configs",
    Items = {"Legit", "Rage", "HvH"},
    Size = 150
})

List:Add("New Config")
List:Refresh({"A", "B"})
```

---

### Label

```lua
AimbotSection:Label("Simple text label")
```

---

## 💬 Global Chat Module

> Created **inside a Page**, not a Section.

```lua
local Chat = CombatTab:GlobalChat(1) -- 1 = Left, 2 = Right

Chat:SendMessage("rbxassetid://AVATAR_ID", "User", "Hello!", false)

Chat:OnMessageSendPressed(function()
    local msg = Chat:GetTypedMessage()
    if msg ~= "" then
        Chat:SendMessage("rbxassetid://YOUR_ID", "You", msg, true)
        Chat:ClearText()
    end
end)
```

---

## 💧 Watermark

Hidden by default. Can be enabled via Settings Page or script. Fully draggable and optimized.

```lua
Library:Watermark({
    "Cheat Name",
    "User",
    1234567890
})

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

---

## ⌨️ Keybind List

```lua
local KeybindList = Library:KeybindList("Active Binds")
```

Hidden by default. Can be toggled in Settings.

---

## ⚙️ Settings & Config System

Automatically generates a Settings tab with:

* **Config Manager (Left)** — Create, Save, Load, Delete
* **UI Settings (Right)** — Theme colors, Watermark toggle, Keybind list toggle, Unload button

```lua
local SettingsTab = Library:CreateSettingsPage(Window, KeybindList)
```

---

## 🏁 Finalizing

Always call `Init()` at the very end of your script.

```lua
Window:Init()
```
