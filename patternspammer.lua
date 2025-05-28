-- Written by Swept for GTNH 2.7.3 in 2025

local component = require("component")
local sides = require("sides")
local term = require("term")
local plasmaDusts = dofile("/home/resources/plasmas/dusts.lua")
local plasmaFluids = dofile("/home/resources/plasmas/fluids.lua")
local patternutils = dofile("/home/lib/patternutils.lua")
local db = component.database
local ocp = component.oc_pattern_editor
local tr = component.transposer

-- Config
local BARRELSIDE = sides.north
local OCPSIDE = sides.west
local CHESTSIDE = sides.south

local spammer = {}

-- Yes i'm not using patternutils.cycle for this because I rewrote it to handle parts and am too lazy to reformat the lua tables. Deal with it.
function spammer.plasmas(s)
	local index = 1
	local dusts = plasmaDusts[s]
	local fluids = plasmaFluids[s]

	for idx, dust in ipairs(dusts) do
	  print("Making recipe for:", dust.Label)
	  tr.transferItem(BARRELSIDE, OCPSIDE, 1, 2, 1)

	  db.set(1, dust.Name, dust.ID)
	  db.set(2, "ae2fc:fluid_drop", 0, dust.Plasma)
        
	  ocp.setInterfacePatternItemInput(1, db.address, 1, 1, 1)
      ocp.setInterfacePatternItemOutput(1, db.address, 2, 64, 1)
      ocp.setInterfacePatternItemOutput(1, db.address, 2, 64, 2)
      ocp.setInterfacePatternItemOutput(1, db.address, 2, 16, 3)

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
        
      ocp.setInterfacePatternItemInput(1, db.address, 1, 64, 1)
      ocp.setInterfacePatternItemInput(1, db.address, 1, 64, 2)
      ocp.setInterfacePatternItemInput(1, db.address, 1, 16, 3)
        
      ocp.setInterfacePatternItemOutput(1, db.address, 2, 64, 1)
      ocp.setInterfacePatternItemOutput(1, db.address, 2, 64, 2)
      ocp.setInterfacePatternItemOutput(1, db.address, 2, 16, 3)
        
	  tr.transferItem(OCPSIDE, CHESTSIDE, 1, 1, index)

	  db.clear(1)
	  db.clear(2)
	  index = index + 1
	end
  print("Done.")
end

function spammer.parts(s)
  -- Hacky so I don't have to reformat the lua tables to have the output item be the final table entry. Loads & append each part’s external output.
  local parts = dofile("/home/resources/parts/" .. s .. ".lua")
  for _, part in pairs(parts) do
    table.insert(part.recipe, {
      Name   = part.Name,
      ID     = part.ID,
      Amount = 1,
      Fluid  = false,
      Label  = part.Label,
    })
  end

  local dbChannel = 1
  local cardSlot  = 1
  local outIndex  = 1

  for _, part in pairs(parts) do
    print("\n=== Generating patterns for:", part.Label, "===")

    patternutils.setOutputSlot(1)

    -- Pull dummy pattern
    tr.transferItem(BARRELSIDE, OCPSIDE, 1, 2, cardSlot)
    if not ocp.getInterfacePattern(cardSlot) then
      error("No blank pattern card in slot "..cardSlot)
    end

    patternutils.reset(cardSlot)
        
    for i, ingr in ipairs(part.recipe) do
      print(string.format("Slot %d → %s (×%d)", i, ingr.Label, ingr.Amount))

      -- Seed DB
      if ingr.Fluid then
        db.set(dbChannel, "ae2fc:fluid_drop", 0, ingr.Name)
      else
        db.set(dbChannel, ingr.Name, ingr.ID)
      end

      local isLast = (i == #part.recipe)
      patternutils.cycle(
        cardSlot,
        db.address,
        dbChannel,
        ingr.Amount,
        ingr.Fluid,
        isLast
      )

      db.clear(dbChannel)
    end

    -- Ejection
    tr.transferItem(OCPSIDE, CHESTSIDE, 1, 1, outIndex)
    outIndex = outIndex + 1
  end

  print("\nAll part patterns done.")
end

return spammer