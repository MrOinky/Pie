local PartyMember, super = Class(PartyMember)

function PartyMember:init()
    super:init(self)

    -- Table of currently queued future heals.
    self.future_heals = {}
end

---Applies all item healing bonuses to the starting amount.
---An integer representing the heal value after applying bonuses is returned.
---@param amount integer The amount of base healing for the item.
---@param item any The item object in question - can be used to selectively apply bonuses.
function PartyMember:applyHealBonus(amount, item)
    -- Check to see whether this item allows heal bonuses, return original amount if it does not.
    if item.block_heal_bonus then
        return amount
    end

    -- Doesn't apply bonuses if the original heal amount is 0, unless the config overrides this.
    if amount == 0 and not Kristal.getLibConfig("passiveitemeffects", "alwaysApplyHealBonus", true) then
        return 0
    end

    local equipment = self:getEquipment()
    local final_amount = amount

    for _,equipitem in ipairs(equipment) do
        final_amount = equipitem:applyHealBonus(self, amount, final_amount, item)
    end

    return final_amount
end

---Registers a future heal for this party member.
---Only works in battles.
---@param amount integer Amount of HP to restore.
---@param turns integer Amount of turns this heal happens in.
function PartyMember:futureHeal(amount, turns)
    table.insert(self.future_heals, {amount = amount, turns = turns})
end

return PartyMember