local component = require("component")
local ocp       = component.oc_pattern_editor

local patternutils = {
  outputSlot = 1,
  nextSlot   = 2,
}

function patternutils.setOutputSlot(slot)
  assert(type(slot) == "number" and slot >= 1, "setOutputSlot needs a positive integer")
  patternutils.outputSlot = slot
end

function patternutils.reset(peSlot)
  ocp.clearInterfacePatternInput(1, 1)
  ocp.clearInterfacePatternOutput(1, 1) 
  patternutils.nextSlot = patternutils.outputSlot + 1
end

function patternutils.cycle(peSlot, dbAddr, dbChannel, amount, isFluid, isOutput)
  local CHUNK = 64
  local remaining = amount

  while remaining > 0 do
    local thisChunk = math.min(CHUNK, remaining)
    local slotIndex = isOutput and
      patternutils.outputSlot or
      patternutils.nextSlot

    local method = (isFluid
      and (isOutput and "setInterfacePatternFluidOutput"
                    or  "setInterfacePatternFluidInput")
      or (isOutput and "setInterfacePatternItemOutput"
                    or  "setInterfacePatternItemInput")
    )

    -- Write
    ocp[method](peSlot, dbAddr, dbChannel, thisChunk, slotIndex)

    remaining = remaining - thisChunk
    if not isOutput then
      patternutils.nextSlot = patternutils.nextSlot + 1
    end
  end
end

return patternutils