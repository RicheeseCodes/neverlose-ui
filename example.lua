local Library = loadstring(game:HttpGet("YOUR_RAW_LINK_HERE"))()

local CheatName = "RemadeHub"
Library.Folders = {
    Directory = CheatName,
    Configs = CheatName .. "/Configs",
    Assets = CheatName .. "/Assets",
}

local Accent = Color3.fromRGB(255, 65, 65)
local Gradient = Color3.fromRGB(180, 0, 0)

Library.Theme.Accent = Accent
Library.Theme.AccentGradient = Gradient
Library:ChangeTheme("Accent", Accent)
Library:ChangeTheme("AccentGradient", Gradient)

local Window = Library:Window({
    Name = "Remade Hub",
    SubName = "Premium Script",
    Logo = "120959262762131"
})

local KeybindList = Library:KeybindList("Active Keybinds")

Window:Category("Combat & Legit")

local CombatPage = Window:Page({Name = "Aimbot", Icon = "138827881557940"})
local AimSection = CombatPage:Section({Name = "Main Settings", Side = 1})

local SilentAim = AimSection:Toggle({
    Name = "Silent Aim",
    Flag = "SilentAim",
    Default = false,
    Callback = function(Val)
        print("Silent Aim:", Val)
    end
})

SilentAim:Keybind({
    Flag = "SilentAimBind",
    Default = Enum.KeyCode.E,
    Mode = "Toggle",
    Callback = function(Val)
        print("Silent Bind:", Val)
    end
})

AimSection:Keybind({
    Name = "Trigger Bot (Hold)",
    Flag = "TriggerBind",
    Default = Enum.KeyCode.X,
    Mode = "Hold",
    Callback = function(Val)
        print("TriggerBot Active:", Val)
    end
})

AimSection:Slider({
    Name = "FOV Radius",
    Flag = "FovRadius",
    Min = 0,
    Max = 500,
    Default = 100,
    Suffix = "px",
    Callback = function() end
})

Window:Category("Visuals & ESP")

local VisualsPage = Window:Page({Name = "ESP", Icon = "100050851789190"})
local EspSection = VisualsPage:Section({Name = "Player ESP", Side = 1})

EspSection:Toggle({
    Name = "Box ESP",
    Flag = "BoxEsp",
    Default = true,
    Callback = function() end
}):Colorpicker({
    Flag = "BoxColor",
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function() end
})

local ChatSection = VisualsPage:Section({Name = "Global Chat", Side = 2})
local GlobalChat = VisualsPage:GlobalChat(2)

local ChatUsers = {
    {Name = "Admin", Icon = "rbxassetid://78993485446406"},
    {Name = "User123", Icon = "rbxassetid://136061992085389"},
    {Name = "Hacker", Icon = "rbxassetid://92657697206261"}
}

local ChatIndex = 1

GlobalChat:OnMessageSendPressed(function()
    local User = ChatUsers[ChatIndex]
    GlobalChat:SendMessage(User.Icon, User.Name, GlobalChat:GetTypedMessage(), true)
    GlobalChat:ClearText()
    ChatIndex += 1
    if ChatIndex > #ChatUsers then
        ChatIndex = 1
    end
end)

Window:Category("Miscellaneous")

local MiscPage = Window:Page({Name = "Settings", Icon = "103180437044643"})
local MiscSection = MiscPage:Section({Name = "Character", Side = 1})

local SpeedToggle = MiscSection:Toggle({
    Name = "Speedhack (Open Settings)",
    Flag = "SpeedToggle",
    Default = false,
    Callback = function() end
})

local SpeedSettings = SpeedToggle:Settings(200)

SpeedSettings:Slider({
    Name = "WalkSpeed",
    Flag = "WalkSpeedVal",
    Min = 16,
    Max = 500,
    Default = 16,
    Callback = function(Val)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Val
    end
})

SpeedSettings:Label("Extra Options")

SpeedSettings:Toggle({
    Name = "Auto Jump",
    Flag = "AutoJump",
    Default = false,
    Callback = function() end
})

MiscSection:Dropdown({
    Name = "Multi Selection",
    Flag = "MultiDrop",
    Items = {"Legit", "Rage", "HvH", "Semi-Rage"},
    Default = {"Legit"},
    Multi = true,
    Callback = function(Val)
        for _, v in pairs(Val) do
            print(v)
        end
    end
})

local ListSection = MiscPage:Section({Name = "Player List (Listbox)", Side = 2})

local PlayerList = ListSection:Listbox({
    Flag = "PlayerList",
    Size = 200,
    Items = {},
    Multi = false,
    Callback = function(Val)
        print("Selected Player:", Val)
    end
})

for _, Player in pairs(game.Players:GetPlayers()) do
    PlayerList:Add(Player.Name)
end

ListSection:Button({
    Name = "Refresh Players",
    Callback = function()
        for _, Player in pairs(game.Players:GetPlayers()) do
            print(Player.Name)
        end
    end
})

local SettingsPage = Library:CreateSettingsPage(Window, KeybindList)

Library:Notification({
    Title = "Welcome",
    Description = "Script loaded successfully!",
    Duration = 5,
    Icon = "120959262762131"
})

Window:Init()
