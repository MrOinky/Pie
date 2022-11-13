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

function HealItem:getFutureHealAmount(chara) return self.future_heal_amount end
function HealItem:getFutureHealTurns(chara) return self.future_heal_turns end

function HealItem:onWorldUse(target)
    if self.target == "ally" then
        -- Heal single party member
        local amount = self:getWorldHealAmount(target.id)
        amount = target:applyHealBonus(amount, self)
        Game.world:heal(target, amount)
        return true
    elseif self.target == "party" then
        -- Heal all party members
        for _,party_member in ipairs(target) do
            local amount = self:getWorldHealAmount(party_member.id)
            amount = party_member:applyHealBonus(amount, self)
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
        local amount = self:getBattleHealAmount(target.chara.id)
        amount = user.chara:applyHealBonus(amount, self)
        -- Healing will no longer occur if the item has 0 healing, unless the config specifically states to.
        if amount > 0 or Kristal.getLibConfig("passiveitemeffects", "alwaysDoHealItemHealing", true) then
            target:heal(amount)
        end
        -- Apply future healing
        if self.future_heal_amount ~= 0 then
            local amount = self:getFutureHealAmount(target.chara)
            amount = user.chara:applyHealBonus(amount, self)
            target.chara:futureHeal(amount, self:getFutureHealTurns(target.chara))
        end
    elseif self.target == "party" then
        -- Heal all party members
        for _,battler in ipairs(target) do
            local amount = self:getBattleHealAmount(battler.chara.id)
            amount = user.chara:applyHealBonus(amount, self)
            if amount > 0 or Kristal.getLibConfig("passiveitemeffects", "alwaysDoHealItemHealing", true) then
                battler:heal(amount)
            end
            -- Apply future healing to everyone!
            if self.future_heal_amount ~= 0 then
                local amount = self.future_heal_amount
                amount = user.chara:applyHealBonus(amount, self)
                battler.chara:futureHeal(amount, self.future_heal_turns)
            end
        end
    elseif self.target == "enemy" then
        -- Heal single enemy (why)
        local amount = self:getBattleHealAmount(target.id)
        amount = user.chara:applyHealBonus(amount, self)
        target:heal(amount)
    elseif self.target == "enemies" then
        -- Heal all enemies (why????)
        for _,enemy in ipairs(target) do
            local amount = self:getBattleHealAmount(enemy.id)
            amount = user.chara:applyHealBonus(amount, self)
            enemy:heal(amount)
        end
    else
        -- No target, do nothing
    end
end

return HealItem