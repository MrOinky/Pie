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
---Returning true will stop the battler from being hurt.
---@param battler any The battler that is holding this item.
---@param damage any The amount of damage dealt in the attack.
---@param defending any Whether the battler is defending.
function Item:beforeHolderHurt(battler, damage, defending) end

---Code that is run when this battler is hurt,
---when this item is equipped.
---@param battler any The battler that is holding this item.
---@param damage any The amount of damage dealt in the attack.
---@param defending any Whether the battler is defending.
function Item:onHolderHurt(battler, damage, defending) end

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

return Item