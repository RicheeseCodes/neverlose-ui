# Neverlose UI

A clean and powerful UI library inspired by **Neverlose** aesthetics, designed for Roblox scripts. Built for flexibility, configurability, and a modern cheat-style interface.

---

## Features

* CS:GO / Neverlose–inspired design
* Window, pages, sections system
* Rich UI elements (toggles, sliders, dropdowns, etc.)
* Built-in **Settings Page** (theme, menu bind, configs)
* **Global Chat** component (visual)
* Config & keybind support

---

## Installation

Load the library using `loadstring`.

```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main/source.lua"))()
```

> ⚠️ Make sure to use a **RAW** link (GitHub, Gist, Pastebin).

---

## 🪟 Creating a Window

```lua
local Window = Library:Window({
    Name = "Cheat Name",
    SubName = "best cheat",
    Logo = "120959262762131" -- Image ID (numbers only)
})
```

---

## 📑 Pages (Tabs)

```lua
local RageTab = Window:Page({Name = "Rage", Icon = "138827881557940", Columns = 2})
local VisualsTab = Window:Page({Name = "Visuals", Icon = "100050851789190", Columns = 2})
```

* `Columns`: `1` or `2`

---

## 📦 Sections

```lua
local MainSection = RageTab:Section({
    Name = "Main Settings",
    Description = "Core settings",
    Icon = "123944728972740",
    Side = 1 -- 1 = left, 2 = right
})
```

---

## 🧩 UI Elements

### Toggle

```lua
local Toggle = MainSection:Toggle({
    Name = "Enable Feature",
    Flag = "FeatureToggle",
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
    Flag = "FeatureColor",
    Default = Color3.fromRGB(255, 0, 0),
    Alpha = false
})
```

**Keybind**

```lua
Toggle:Keybind({
    Flag = "FeatureBind",
    Default = Enum.KeyCode.E,
    Mode = "Toggle" -- Toggle / Hold / Always
})
```

---

### Slider

```lua
MainSection:Slider({
    Name = "WalkSpeed",
    Flag = "Speed",
    Min = 16,
    Max = 200,
    Default = 16,
    Decimals = 1,
    Suffix = " studs",
    Callback = function(Value)
        print(Value)
    end
})
```

---

### Button

```lua
MainSection:Button({
    Name = "Execute",
    Callback = function()
        print("Clicked")
    end
})
```

---

### Dropdown

```lua
MainSection:Dropdown({
    Name = "Target",
    Flag = "TargetPart",
    Items = {"Head", "Torso", "Legs"},
    Default = "Head",
    Multi = false
})
```

---

### Textbox

```lua
MainSection:Textbox({
    Flag = "Input",
    Placeholder = "Enter text...",
    Finished = true
})
```

---

### Listbox

```lua
local List = MainSection:Listbox({
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
MainSection:Label("Simple text label")
```

---

## Global Chat (Module)

Created **inside a Page**, not a Section.

```lua
local Chat = RageTab:GlobalChat(1) -- 1 = left, 2 = right

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

## ⚙️ Settings Page

Automatically creates a settings tab (theme, menu key, configs).

```lua
local KeybindList = Library:KeybindList("Keybinds")
Library:CreateSettingsPage(Window, KeybindList)
```

---

## 🚀 Full Example

```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/YOUR_GITHUB/REPO/main/CSGO_UI_Fixed.lua"))()

local Window = Library:Window({
    Name = "Neverlose.lua",
    SubName = "Release Build",
    Logo = "120959262762131"
})

local KeybindList = Library:KeybindList("Active Binds")

local CombatTab = Window:Page({Name = "Combat", Columns = 2})
local SettingsTab = Library:CreateSettingsPage(Window, KeybindList)

local Section = CombatTab:Section({Name = "Aimbot", Side = 1})

Section:Toggle({
    Name = "Enabled",
    Flag = "Aimbot",
    Callback = function(v)
        print(v)
    end
})

Window:Init()
```
