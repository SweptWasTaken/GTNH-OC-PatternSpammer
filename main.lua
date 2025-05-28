local component = require("component")
local term      = require("term")
local io        = require("io")
local patternspammer = dofile("/home/patternspammer.lua")

local menus = {
  main = {
    "Parts",
    "Plasmas",
    "Quit"
  },
  Parts = {
    "LUV",
    "ZPM",
    "UV",
    "UHV",
    "UEV",
    "UIV",
    "UMV",
    "UXV",
    "Back"
  },
  Plasmas = {
    "Gluon",
    "Magmatter",
    "Back"
  }
}

-- Utility to draw a menu and return the chosen label
local function showMenu(title, items)
  while true do
    term.clear()
    term.setCursor(1, 1)
    print("=== " .. title .. " ===\n")
    for i, name in ipairs(items) do
      print(string.format("%2d. %s", i, name))
    end
    io.write("\nSelect an option > ")
    local choice = tonumber(io.read())
    if choice and items[choice] then
      return items[choice]
    else
      print("\nInvalid choice, press Enter to try again...")
      io.read()
    end
  end
end

-- Placeholder: hook this up to your actual patterning logic
-- Now 'subtype' will already be lowercase
local function runPattern(category, subtype)
  term.clear()
  term.setCursor(1,1)
  print("Running pattern script for ".. category .. " → " .. subtype)
    
  local entry = patternspammer[category]
  entry(subtype)

  print("Done! Press Enter to return to menu...")
  io.read()
end

-- Main loop
while true do
  local selection = showMenu("Main Menu", menus.main)

  if selection == "Quit" then
    term.clear()
    term.setCursor(1,1)
    print("Goodbye!")
    break

  elseif menus[selection] then
    -- enter submenu
    while true do
      local sub = showMenu(selection .. " Menu", menus[selection])
      if sub == "Back" then
        break
      else
        -- normalize subtype to lowercase here
        runPattern(selection:lower(), sub:lower())
      end
    end

  else
    print("Unknown selection. Exiting.")
    break
  end
end