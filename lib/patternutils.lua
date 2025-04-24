-- Written by Swept for GTNH 2.7.3 in 2025

local patternutils = {}
local component = require("component")
local ocp = component.oc_pattern_editor

function patternutils.cycle(side, dbAddr, dbIndex, amount, isFluid, isOutput)
    local CHUNK_SIZE = 64
    local index = 1

    while amount > 0 do
        local thisChunk = math.min(CHUNK_SIZE, amount)

        if isFluid then
            if isOutput then
                ocp.setInterfacePatternFluidOutput(side, dbAddr, dbIndex, thisChunk, index)
            else
                ocp.setInterfacePatternFluidInput(side, dbAddr, dbIndex, thisChunk, index)
            end
        else
            if isOutput then
                ocp.setInterfacePatternItemOutput(side, dbAddr, dbIndex, thisChunk, index)
            else
                ocp.setInterfacePatternItemInput(side, dbAddr, dbIndex, thisChunk, index)
            end
        end

        amount = amount - thisChunk
        index = index + 1
    end
end

return patternutils