local Item, super = Class(Item)

function Item:init()
    super:init(self)

    -- Amount of bonus healing when consuming items. (equipment)
    self.heal_bonus = 0

    -- Amount of HP restored when the battle is won. (equipment)
    self.victory_heal = 0

    -- Does item have passive healing (equipment)
    self.passive_heal = false
    -- Passive healing amount (equipment)
    self.passive_heal_amount = 0
    -- TP cost of passive heal. (equipment)
    self.passive_heal_cost = 0
    -- Frequency, in turns, of healing. (equipment)
    self.passive_heal_frequency = 1

    -- Does item have passive hurt (equipment)
    self.passive_hurt = false
    -- Amount of damage item deals. (equipment)
    self.passive_hurt_amount = 0
    -- Frequency, in turns, of passive damage. (equipment)
    self.passive_hurt_frequency = 1

    -- Does item have passive TP replenishment (equipment)
    self.passive_tension = false
    -- HP cost of passive TP. (equipment)
    self.passive_tension_amount = 0
    -- HP cost of passive heal. (equipment)
    self.passive_tension_cost = 0
    -- Frequency, in turns, of TP restore. (equipment)
    self.passive_tension_frequency = 1

    -- Does item create items passively (equipment)
    self.passive_item = false
    -- Name of item to give. (equipment)
    self.passive_item_name = ""
    -- TP cost of giving item. (equipment)
    self.passive_item_tensioncost = 0
    -- HP cost of giving item. (equipment)
    self.passive_item_healthcost = 0
    -- Frequency of giving item. (equipment)
    self.passive_item_frequency = 1

    -- The base chance of this item dodging. (equipment)
    self.dodge_chance = 0
    -- The bonus chance of this item dodging if the holder is defending. (equipment)
    self.dodge_defend_bonus = 0
    -- The sound played on dodge. using nil will play the default, and using "none" will play nothing. (equipment)
    self.dodge_sound = nil
    -- A table of the colors used in the miss message. (equipment)
    self.dodge_color = nil

    -- The base chance of this item activating thorns.
    self.thorns_chance = 0
    -- The bonus chance of this item activating thorns if this item is defending. (equipment)
    self.thorns_defend_bonus = 0
    -- Proportion of damage "thorned" onto attacker (equipment)
    self.thorns_damage_proportion = 0
    -- The sound played on thorns. using nil will play the default, and using "none" will play nothing. (equipment)
    self.thorns_sound = nil

    -- The base chance of this item deflecting damage to the attacker. (equipment)
    self.reflect_chance = 0
    -- The bonus chaance of this item deflecting damage if the holder is defending. (equipment)
    self.reflect_defend_bonus = 0
    -- Proportion of damage reflected onto attacker (equipment)
    self.reflect_damage_proprotion = 0
    -- The sound played on reflect. using nil will play the default, and using "none" will play nothing. (equipment)
    self.reflect_sound = nil
end

function Item:getHealBonus(chara) return self.heal_bonus end
function Item:getVictoryHealAmount(chara) return self.victory_heal end

function Item:doesPassiveHeal(chara) return self.passive_heal end
function Item:getPassiveHealAmount(chara) return self.passive_heal_amount end
function Item:getPassiveHealCost(chara) return self.passive_heal_cost end
function Item:getPassiveHealFrequency(chara) return self.passive_heal_frequency end

function Item:doesPassiveHurt(chara) return self.passive_hurt end
function Item:getPassiveHurtAmount(chara) return self.passive_hurt_amount end
function Item:getPassiveHurtFrequency(chara) return self.passive_hurt_frequency end

function Item:doesPassiveTension(chara) return self.passive_tension end
function Item:getPassiveTensionAmount(chara) return self.passive_tension_amount end
function Item:getPassiveTensionCost(chara) return self.passive_tension_cost end
function Item:getPassiveTensionFrequency(chara) return self.passive_tension_frequency end

function Item:doesPassiveItem(chara) return self.passive_item end
function Item:getPassiveItemName(chara) return self.passive_item_name end
function Item:getPassiveItemTensionCost(chara) return self.passive_item_tensioncost end
function Item:getPassiveItemHealthCost(chara) return self.passive_item_healthcost end
function Item:getPassiveItemFrequency(chara) return self.passive_item_frequency end

function Item:doesDodge(chara)
    -- If the item has greater than 0 dodge chance, then it can dodge.
    if self.dodge_chance > 0 or self.dodge_defend_bonus > 0 then
        return true
    end
end

function Item:getDodgeChance(chara, defending)
    if defending then
        return self.dodge_chance + self.dodge_defend_bonus
    else
        return self.dodge_chance
    end
end

function Item:getBaseDodgeChance(chara) return self.dodge_chance end
function Item:getDodgeDefendBonus(chara) return self.dodge_defend_bonus end
function Item:getDodgeSound(chara) return self.dodge_sound end
function Item:getDodgeColor(chara) return self.dodge_color end

function Item:doesThorns(chara)
    -- If the item has greater than 0 thorn chance, then it can trigger thorns.
    if self.thorns_chance > 0 or self.thorns_defend_bonus > 0 then
        return true
    end
end

function Item:getThornsChance(chara, defending)
    if defending then
        return self.thorns_chance + self.thorns_defend_bonus
    else
        return self.thorns_chance
    end
end

function Item:getBaseThornsChance(chara) return self.thorns_chance end
function Item:getThornsDefendBonus(chara) return self.thorns_defend_bonus end
function Item:getThornsDamageProportion(chara) return self.thorns_damage_proportion end
function Item:getThornsSound(chara) return self.thorns_sound end

function Item:doesReflect(chara)
    -- If the item has greater than 0 reflect chance, then it can reflect.
    if self.reflect_chance > 0 or self.reflect_defend_bonus > 0 then
        return true
    end
end

function Item:getReflectChance(chara, defending)
    if defending then
        return self.reflect_chance + self.reflect_defend_bonus
    else
        return self.reflect_chance
    end
end

function Item:getBaseReflectChance(chara) return self.reflect_chance end
function Item:getReflectDefendBonus(chara) return self.reflect_defend_bonus end
function Item:getReflectDamageProportion(chara) return self.reflect_damage_proprotion end
function Item:getReflectSound(chara) return self.reflect_sound end

---Code that is run when the battle finishes initializing,
---when this item is equipped.
---@param battler any The battler that is holding this item.
function Item:onBattleInit(battler) end

---Code that is run at the start of the battle,
---when this item is equipped.
---@param battler any The battler that is holding this item.
function Item:onBattleStart(battler) end

---Code that is run at the end of the battle,
---when this item is equipped.
---By default, this triggers on-victory healing
---for items with that effect.
---@param battler any The battler that is holding this item.
function Item:onBattleEnd(battler) 
    local amount = self:getVictoryHealAmount(battler.chara)
    if amount > 0 then
        battler:heal(amount)
    end
end

---Code that is run at the start of every turn,
---when this item is equipped.
---@param battler any The battler that is holding this item.
---@param turn integer Current battle turn.
function Item:onTurnStart(battler, turn) end

---Code that is run at the end of every turn,
---when this item is equipped.
---By default, this calls all passive behaviours.
---@param battler any The battler that is holding this item.
---@param turn integer Current battle turn.
function Item:onTurnEnd(battler, turn)
    self:passiveHeal(battler, turn)
    self:passiveHurt(battler,turn)
    self:passiveTensionRestore(battler, turn)
    self:passiveItem(battler, turn)
end

---Code that is run when the party begin their actions,
---when this item is equipped.
---@param battler any The battler that is holding this item.
function Item:onActionsStart(battler) end

---Code that is run when the party finish actions,
---when this item is equipped.
---@param battler any The battler that is holding this item.
function Item:onActionsEnd(battler) end

---Code that is run just before a state change in battle,
---when this item is equipped.
---@param battler any The battler that is holding this item.
---@param old string The state the battle was previously in.
---@param new string The state the battle is about to enter.
function Item:beforeStateChange(battler, old, new) end

---Code that is run as a state change occurs in battle,
---when this item is equipped.
---@param battler any The battler that is holding this item.
---@param old string The state the battle was previously in.
---@param new string The state the battle is about to enter.
function Item:onStateChange(battler, old, new) end

---Code that is run when all the party are downed in battle,
---when this item is equipped.
---Returning true will stop the game over process.
---@param battler any The battler that is holding this item.
function Item:beforeGameOver(battler) end

---Code that is run just before being game-overed, after the
---current battle wave has been stopped,
---when this item is equipped.
---Returning true will stop the game over process.
---@param battler any The battler that is holding this item.
function Item:onGameOver(battler) end

---Code that is run when this battler attacks an enemy,
---when this item is equipped.
---@param battler any The battler that is holding this item.
---@param enemy any The enemy that has been hit.
---@param damage any The amount of damage dealt in the attack.
function Item:onEnemyHit(battler, enemy, damage) end

---Code that is run before this battler is hurt,
---when this item is equipped.
---Responsible for triggering dodge and reflect effects.
---Returning true will stop the battler from being hurt.
---@param battler any The battler that is holding this item.
---@param damage any The amount of damage dealt in the attack.
---@param defending any Whether the battler is defending.
function Item:beforeHolderHurt(battler, damage, defending) 
    if self:doesDodge(battler.chara) then
        -- Get the actual dodge chance
        local chance = self:getDodgeChance(battler.chara, defending) * 100
        -- Then pull a random number between 1 and 100 and compare it to chance
        if love.math.random(1, 100) <= chance then
            -- Trigger callback and return true to block damage
            Item:onDodge(battler, defending)
            return true
        end
    end
    -- Something similar for reflects, but with a few changes.
    if self:doesReflect(battler.chara) then
        local chance = self:getReflectChance(battler.chara, defending) * 100
        if love.math.random(1, 100) <= chance then
            -- Calculate the amount of damage that is being reflected and being taken by the battler.
            local ref_amount = math.floor(damage * self:getReflectDamageProportion(battler.chara))
            local hurt_amount = damage - ref_amount
            -- Hurt the battler for the damage minus reflected amount.
            if hurt_amount > 0 then 
                battler:hurt(hurt_amount, true)
            end
            -- Then reflect the rest to an enemy.
            local enemy = Utils.pick(Game.battle.enemies)
            enemy:hurt(ref_amount)
            -- Trigger callback
            Item:onReflect(battler, damage, ref_amount, enemy, defending)
            -- Return true to block the original damage.
            return true
        end
    end
end

---Code that is run when this battler is hurt,
---when this item is equipped.
-- Responsible for handling the thorns effect.
---@param battler any The battler that is holding this item.
---@param damage any The amount of damage dealt in the attack.
---@param defending any Whether the battler is defending.
function Item:onHolderHurt(battler, damage, defending) 
    -- Very similar to reflect.
    if self:doesThorns(battler.chara) then
        local chance = self:getThornsChance(battler.chara, defending) * 100
        if love.math.random(1, 100) <= chance then
            -- Calculate the amount of damage that is being thorned.
            local amount = math.floor(damage * self:getThornsDamageProportion(battler.chara))
            -- Then deal it to an enemy.
            local enemy = Utils.pick(Game.battle.enemies)
            enemy:hurt(amount)
            Item:onThorns(battler, damage, amount, enemy, defennding)
        end
    end
end

---Code that is run before this battler is hurt,
---when this item is equipped.
---Returning true will stop the holder from being downed.
---@param battler any
function Item:beforeHolderDowned(battler) end

---Code that is run when this battler is downed,
---when this item is equipped.
---@param battler any The battler that is holding this item.
function Item:onHolderDowned(battler) end

---Controls passive healing behaviour for this item.
---@param battler any The battler that is holding this item.
---@param turn integer Current battle turn.
function Item:passiveHeal(battler, turn)
    -- Standard checks & check to only activate if not at max HP.
    if self:doesPassiveHeal(battler.chara) and turn % self:getPassiveHealFrequency(battler.chara) == 0 and battler.chara.health < battler.chara:getStat("health") then
        -- If the cost (TP) is less than or equal to the current party tension, the battler is healed and tension is removed.
        if self:getPassiveHealCost(battler.chara) <= Game.tension then
            battler:heal(self:getPassiveHealAmount(battler.chara))
            Game:removeTension(self:getPassiveHealAmount(battler.chara)) 
        end
    end
end

---Controls passive damage behaviour for this item.
---@param battler any The battler that is holding this item.
---@param turn integer Current battle turn.
function Item:passiveHurt(battler, turn)
    -- Standard checks & check that battler is not downed.
    if self:doesPassiveHurt(battler.chara) and turn % self:getPassiveHurtFrequency(battler.chara) == 0 and not battler.is_down then
        battler:hurt(self:getPassiveHurtAmount(battler.chara), true, {1, 1, 1}, {ignore_callback = true})
    end
end

---Controls passive TP replenishment behaviour for this item.
---@param battler any The battler that is holding this item.
---@param turn integer Current battle turn.
function Item:passiveTensionRestore(battler, turn)
    -- Standard checks and check to only activate if not at max TP.
    if self:doesPassiveTension(battler.chara) and turn % self:getPassiveHurtFrequency(battler.chara) == 0 and Game.tension < 100 then
        -- Since battler:hurt() deals a minimum of 1 damage, the HP cost must be checked to see if it is above 0.
        if self:getPassiveTensionCost(battler.chara) > 0 then
            -- If there is enough HP to cover the cost, then TP is given and the battler is hurt.
            if self:getPassiveTensionCost(battler.chara) < battler.chara.health then
                Game:giveTension(self:getPassiveTensionAmount(battler.chara))
                battler:hurt(self:getPassiveTensionCost(battler.chara), true, {1, 1, 1}, {ignore_callback = true})
            end
        -- If there is no cost, tp is given directly, and battler:hurt() is not called.
        else
            Game:giveTension(self:getPassiveTensionAmount(battler.chara))
        end
    end
end

---Controls passive item-giving-granting-whatever you like to call it behaviour.
---@param battler any The battler that is holding this item.
---@param turn integer Current battle turn.
function Item:passiveItem(battler, turn)
    if self:doesPassiveItem(battler.chara) and turn % self:getPassiveItemFrequency(battler.chara) == 0 then
        -- When giving an item, it can cost BOTH hp and tp, so both must be checked.
        local can_afford = (self:getPassiveItemTensionCost(battler.chara) <= Game.tension and self:getPassiveItemHealthCost(battler.chara) < battler.chara.health)

        -- If both checks pass then an attempt to add the item is made.
        if can_afford then
            local res_item = Game.inventory:addItemTo("items", self:getPassiveItemName(battler.chara), false)

            -- If the item is added successfully (there was space in the main inventory) then TP and HP are deducted.
            if res_item ~= nil then
                Game:removeTension(self:getPassiveItemTensionCost(battler.chara))
                -- Once again, only call battler:hurt() if there is a HP cost.
                if self:getPassiveItemHealthCost(battler.chara) > 0 then
                    battler:hurt(self.getPassiveItemHealthCost(battler.chara), true, {1, 1, 1}, {ignore_callback = true})
                end
            end
        end
    end
end

-- Damage effect callbacks below.
-- Extend these to add custom effects or messages when effects trigger!

---Triggered upon dodging any attack.
---Normally responsible for playing a sound and displaying a status message.
---@param battler any The battler that is holding this item.
---@param damage any The damage this battler would have taken.
---@param defending any Whether the battler was defending or not.
function Item:onDodge(battler, damage, defending)
    -- Retrieve sound and color
    local snd = self:getDodgeSound(battler.chara) or "mus_sfx_a_pullback"  -- This sound is asriel's sword pullback from UNDERTALE.
    local color = self:getDodgeColor(battler.chara) or {1, 1, 1}

    -- Make a "miss" status message and play sound cue.
    battler:statusMessage("msg", "miss", color)
    -- If the sound is none then don't play anything.
    if snd ~= "none" then
        Assets.playSound(snd)
    end
end

---Triggered upon thorns activating from an attack.
---Normally responsible for playing a sound if there is one.
---@param battler any The battler that is holding this item.
---@param damage any The damage that the battler has taken.
---@param thorned any The damage thorned onto the enemy.
---@param enemy any The enemy that has been struck.
---@param defending any Whether the battler was defending or not.
function Item:onThorns(battler, damage, thorned, enemy, defending)
    local snd = self:getThornsSound(battler.chara) or "screenshake"

    if snd ~= "none" then
        Assets.playSound(snd)
    end

end

---Triggered when damage is reflected by this item.
---Normally responsible for playing a sound if there is one.
---@param battler any The battler that is holding this item.
---@param damage any The damage that the battler has taken.
---@param thorned any The damage reflected onto the enemy.
---@param enemy any The enemy that has been struck.
---@param defending any Whether the battler was defending or not.
function Item:onReflect(battler, damage, reflected, enemy, defending)
    local snd = self:getReflectSound(battler.chara) or "bell_bounce_short"
    
    if snd ~= "none" then
        Assets.playSound(snd)
    end
end

return Item