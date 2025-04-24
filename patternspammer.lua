-- Written by Swept for GTNH 2.7.3 in 2025

local component = require("component")
local sides = require("sides")
local dusts = dofile("/home/dusts.lua")
local fluids = dofile("/home/fluids.lua")
local patternutils = dofile("/home/lib/patternutils.lua")
local db = component.database
local ocp = component.oc_pattern_editor
local tr = component.transposer

-- Config
local BARRELSIDE = sides.north
local OCPSIDE = sides.west
local CHESTSIDE = sides.south

local index = 1
for idx, dust in ipairs(dusts) do
  print("Making recipe for:", dust.Label)
  tr.transferItem(BARRELSIDE, OCPSIDE, 1, 2, 1)

  db.set(1, dust.Name, dust.ID)
  db.set(2, "ae2fc:fluid_drop", 0, dust.Plasma)
  ocp.setInterfacePatternItemInput(1, db.address, 1, 1, 1)
  patternutils.cycle(1, db.address, 2, 144, true, true)

  tr.transferItem(OCPSIDE, CHESTSIDE, 1, 1, index)

  db.clear(1)
  db.clear(2)
  index = index + 1
end

for idx, fluid in ipairs(fluids) do
  print("Making recipe for:", fluid.Label)
  tr.transferItem(BARRELSIDE, OCPSIDE, 1, 2, 1)

  db.set(1, "ae2fc:fluid_drop", 0, fluid.Name)
  db.set(2, "ae2fc:fluid_drop", 0, fluid.Plasma)
  patternutils.cycle(1, db.address, 1, 144, true, false)
  patternutils.cycle(1, db.address, 2, 144, true, true)

  tr.transferItem(OCPSIDE, CHESTSIDE, 1, 1, index)

  db.clear(1)
  db.clear(2)
  index = index + 1
end