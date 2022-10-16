-- Healitem extension - Minor change to application of healing; getHealBonus() must
-- be called to allow for items to boost healing effects.

local HealItem, super = Class(HealItem)

function HealItem:init()
    super:init(self)
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
            local amount = self:getWorldHealAmount(party_member.id) + target:getHealBonus()
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
    elseif self.target == "party" then
        -- Heal all party members
        for _,battler in ipairs(target) do
            local amount = self:getBattleHealAmount(battler.chara.id) + user.chara:getHealBonus()
            battler:heal(amount)
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