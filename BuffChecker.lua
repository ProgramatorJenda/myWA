IU = IU or {}

IU.ActiveBuffs = {}

--Update table of Active auras on the player
function IU.UpdateActiveBuffs(DesiredBuffs)
    local aura = nil

    for i = 1, #DesiredBuffs do
        for j = 1, 40 do
            aura = C_UnitAuras.GetBuffDataByIndex("player", j)

            if aura and aura.name == DesiredBuffs[i] then
                table.insert(IU.ActiveBuffs, aura.name)
                break
            end
        end
    end

    return IU.ActiveBuffs
end

--[[
TODO: change parameter to take in a table of all checked checkboxes then update the table with checked ones

]]
function IU.updateDesiredTable(checkbox, label)
    if checkbox.checked then
        table.insert(IU.DesiredBuffs, label)
    else
        for i, v in ipairs(IU.DesiredBuffs) do
            if v == label then
                table.remove(IU.DesiredBuffs, i)
                break
            end
        end
    end
end