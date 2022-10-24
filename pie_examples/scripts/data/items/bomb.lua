-- It's a bomb! When equipped it'll explode in your face.
-- Demonstrates how you can use callbacks - onActionsEnd() is
-- used here, but it'd work for just about anything!

local item, super = Class(Item)

function item:init()
    super:init(self)

    -- Display name
    self.name = "Bomb"

    -- Item type (item, key, weapon, armor)
    self.type = "armor"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/armor"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "Why are you holding this? It's going to explode!"

    -- Default shop price (sell price is halved)
    self.price = 100
    -- Whether the item can be sold
    self.can_sell = true

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "none"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil
    -- Will this item be instantly consumed in battles?
    self.instant = false

    -- Equip bonuses (for weapons and armor)
    self.bonuses = {}
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = "Boom"
    self.bonus_icon = "ui/menu/icon/up"

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        susie = false,
        ralsei = false,
        noelle = false,
    }

    -- Character reactions (key = party member id)
    self.reactions = {
        susie = "Are you TRYING to kill me?",
        ralsei = "Kris, that's dangerous!",
        noelle = "I'm not taking an exploding bomb!",
    }

    self:setFlag("exploded", false)
end

function item:onActionsEnd(battler)
    -- Make sure that it only explodes once.
    if self:getFlag("exploded", false) then
        return
    end

    -- Spawn explosion and kill holder
    local explosion = Sprite("misc/realistic_explosion", -battler.sprite.width, -battler.sprite.height)
    explosion:play(1/15, false, function()
        explosion:remove()
    end)
    battler:addChild(explosion)
    explosion:setLayer(BATTLE_LAYERS["above_battlers"])
    battler:hurt(999, true)
    Assets.playSound("badexplosion")
    self:setFlag("exploded", true)

    -- Remove the current action for the holder.
    for i,party in ipairs(Game.battle.party) do
        if battler == party then
            Game.battle:removeAction(i)
        end
    end
end

function item:onBattleEnd(battler)
    -- (The bomb has self regenerative capabilities)
    self:setFlag("exploded", false)
end

return item