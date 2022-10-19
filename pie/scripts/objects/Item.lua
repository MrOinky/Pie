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
    self.passive_tp = false
    -- HP cost of passive TP. (equipment)
    self.passive_tp_amount = 0
    -- HP cost of passive heal. (equipment)
    self.passive_tp_cost = 0
    -- Frequency, in turns, of TP restore. (equipment)
    self.passive_tp_frequency = 1

    -- Does item create items passively (equipment)
    self.passive_item = false
    -- Name of item to give. (equipment)
    self.passive_item_name = ""
    -- TP cost of giving item. (equipment)
    self.passive_item_tpcost = 0
    -- HP cost of giving item. (equipment)
    self.passive_item_hpcost = 0
    -- Frequency of giving item. (equipment)
    self.passive_item_frequency = 1
end

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
    if self.victory_heal > 0 then
        battler:heal(self.victory_heal)
    end
end

---Controls passive healing behaviour for this item.
---@param battler any The battler that is holding this item.
---@param turn integer Current battle turn.
function Item:passiveHeal(battler, turn)
    -- Standard checks & check to only activate if not at max HP.
    if self.passive_heal and turn % self.passive_heal_frequency == 0 and battler.chara.health < battler.chara:getStat("health") then
        -- If the cost (TP) is less than or equal to the current party tension, the battler is healed and tension is removed.
        if self.passive_heal_cost <= Game.tension then
            battler:heal(self.passive_heal_amount) 
            Game:removeTension(self.passive_heal_cost) 
        end
    end
end

---Controls passive damage behaviour for this item.
---@param battler any The battler that is holding this item.
---@param turn integer Current battle turn.
function Item:passiveHurt(battler, turn)
    if self.passive_hurt and turn % self.passive_hurt_frequency == 0 then
        battler:hurt(self.passive_hurt_amount)
    end
end

---Controls passive TP replenishment behaviour for this item.
---@param battler any The battler that is holding this item.
---@param turn integer Current battle turn.
function Item:passiveTPRestore(battler, turn)
    if self.passive_tp and turn % self.passive_tp_frequency == 0 and Game.tension < 100 then
        -- Since battler:hurt() deals a minimum of 1 damage, the HP cost must be checked to see if it is above 0.
        if self.passive_tp_cost > 0 then
            -- If there is enough HP to cover the cost, then TP is given and the battler is hurt.
            if self.passive_tp_cost < battler.chara.health then
                Game:giveTension(self.passive_tp_amount)
                battler:hurt(self.passive_tp_cost, true)
            end
        -- If there is no cost, tp is given directly, and battler:hurt() is not called.
        else
            Game:giveTension(self.passive_tp_amount)
        end
    end
end

---Controls passive item-giving-granting-whatever you like to call it behaviour.
---@param battler any The battler that is holding this item.
---@param turn integer Current battle turn.
function Item:passiveItem(battler, turn)
    if self.passive_item and turn % self.passive_item_frequency == 0 then
        -- When giving an item, it can cost BOTH hp and tp, so both must be checked.
        local can_afford = (self.passive_item_tpcost <= Game.tension and self.passive_item_hpcost < battler.chara.health)

        -- If both checks pass then an attempt to add the item is made.
        if can_afford then
            local res_item = Game.inventory:addItemTo("items", self.passive_item_name, false)

            -- If the item is added successfully (there was space in the main inventory) then TP and HP are deducted.
            if res_item ~= nil then
                Game:removeTension(self.passive_item_tpcost)
                -- Once again, only call battler:hurt() if there is a HP cost.
                if self.passive_item_hpcost > 0 then
                    battler:hurt(self.passive_item_hpcost, true)
                end
            end
        end
    end
end

---Code that is run at the end of every turn,
---when this item is equipped.
---By default, this calls all passive behaviours.
---@param battler any The battler that is holding this item.
---@param turn integer Current battle turn.
function Item:onTurnEnd(battler, turn)
    self:passiveHeal(battler, turn)
    self:passiveHurt(battler,turn)
    self:passiveTPRestore(battler, turn)
    self:passiveItem(battler, turn)
end

return Item