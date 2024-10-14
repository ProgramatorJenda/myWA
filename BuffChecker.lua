ItsUp = ItsUp or {}

function ItsUp.UpdateActiveBuffs(DesiredBuffs)
    local ActiveBuffs = {}
    local buffTexture = nil
    local aura = nil

    for i = 1, #DesiredBuffs do
        for j = 1, 40 do
            aura = C_UnitAuras.GetBuffDataByIndex("player", j)

            if aura and aura.name == DesiredBuffs[i] then
                table.insert(ActiveBuffs, aura.name)
                break
            end
        end
    end

    return ActiveBuffs
end