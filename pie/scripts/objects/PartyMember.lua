local PartyMember, super = Class(PartyMember)

--- Calculates bonus healing based on equipment.
function PartyMember:getHealBonus()
    local equipment = self:getEquipment()
    local amount = 0

    for _,item in ipairs(equipment) do
        amount = amount + item.heal_bonus
    end

    return amount
end

return PartyMember