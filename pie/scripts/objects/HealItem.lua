-- Healitem extension - Minor change to application of healing; getHealBonus() must
-- be called to allow for items to boost healing effects, and future heals are added
-- if they exist for the item.

local HealItem, super = Class(HealItem)

function HealItem:init()
    super:init(self)

    -- The amount of hp this item heals in the future.
    self.future_heal_amount = 0
    -- The amount of turns into the future where this
    -- item future heals the target.
    self.future_heal_turns = 0
end

function HealItem:onWorldUse(target)
    if self.target == "ally" then
        -- Heal single party member
        local amount = self:getWorldHealAmount(target.id) + target:getHealBonus()
        Game.world:heal(target, amount)
        return true
    elseif self.target == "party" then
        -- Heal all party members
        for _,party_member in ipairs(target) do
            local amount = self:getWorldHealAmount(party_member.id) + party_member:getHealBonus()
            Game.world:heal(party_member, amount)
        end
        return true
    else
        -- No target or enemy target (?), do nothing
        return false
    end
end

function HealItem:onBattleUse(user, target)
    if self.target == "ally" then
        -- Heal single party member
        local amount = self:getBattleHealAmount(target.chara.id) + user.chara:getHealBonus()
        target:heal(amount)
        -- Apply future healing
        if self.future_heal_amount ~= 0 then
            local amount = self.future_heal_amount + user.chara:getHealBonus()
            target.chara:futureHeal(amount, self.future_heal_turns)
        end
    elseif self.target == "party" then
        -- Heal all party members
        for _,battler in ipairs(target) do
            local amount = self:getBattleHealAmount(battler.chara.id) + user.chara:getHealBonus()
            battler:heal(amount)
            -- Apply future healing to everyone!
            if self.future_heal_amount ~= 0 then
                local amount = self.future_heal_amount + user.chara:getHealBonus()
                battler.chara:futureHeal(amount, self.future_heal_turns)
            end
        end
    elseif self.target == "enemy" then
        -- Heal single enemy (why)
        local amount = self:getBattleHealAmount(target.id) + user.chara:getHealBonus()
        target:heal(amount)
    elseif self.target == "enemies" then
        -- Heal all enemies (why????)
        for _,enemy in ipairs(target) do
            local amount = self:getBattleHealAmount(enemy.id) + user.chara:getHealBonus()
            enemy:heal(amount)
        end
    else
        -- No target, do nothing
    end
end

return HealItem