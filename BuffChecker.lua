ItsUp = ItsUp or {}

ItsUp.ActiveBuffs = {}

--Update table of Active auras on the player
function ItsUp.UpdateActiveBuffs(DesiredBuffs)
    local aura = nil

    for i = 1, #DesiredBuffs do
        for j = 1, 40 do
            aura = C_UnitAuras.GetBuffDataByIndex("player", j)

            if aura and aura.name == DesiredBuffs[i] then
                table.insert(ItsUp.ActiveBuffs, aura.name)
                break
            end
        end
    end

    return ItsUp.ActiveBuffs
end