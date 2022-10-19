local PartyMember, super = Class(PartyMember)

function PartyMember:init()
    super:init(self)

    -- Table of currently queued future heals.
    self.future_heals = {}
end

--- Calculates bonus healing based on equipment.
function PartyMember:getHealBonus()
    local equipment = self:getEquipment()
    local amount = 0

    for _,item in ipairs(equipment) do
        amount = amount + item.heal_bonus
    end

    return amount
end

---Registers a future heal for this party member.
---Only works in battles.
---@param amount integer Amount of HP to restore.
---@param turns integer Amount of turns this heal happens in.
function PartyMember:futureHeal(amount, turns)
    table.insert(self.future_heals, {amount = amount, turns = turns})
end

return PartyMember