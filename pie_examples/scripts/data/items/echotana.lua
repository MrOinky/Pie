-- An example of the onEnemyHit() callback usage.
-- Repeats attacks on enemies.

local item, super = Class(Item)

function item:init()
    super:init(self)

    -- Display name
    self.name = "Echotana"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/sword"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "A blue katana. It sounds like its...\nwhispering to you?"

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
    self.bonuses = {
        attack = 1,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = "Echo"
    self.bonus_icon = "ui/menu/icon/up"

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        kris = true,
    }

    -- Character reactions (key = party member id)
    self.reactions = {
        susie = "Talking swords? No thanks.",
        ralsei = "Hey, its copying me!",
        noelle = "It knows my name?!?!",
    }

    -- Whether an attack is currently being echoed.
    -- Necessary to prevent The Infinite Recursion of Doom.
    self.echoed = false
end

function item:onEnemyHit(battler, enemy, damage)
    -- Don't do anything if an echo is in progress.
    if self.echoed then
        return
    end
    self.echoed = true
    -- Hurt enemy after 0.5s.
    Game.battle.timer:after(1/2, function()
        enemy:hurt(damage, battler)
        Assets.playSound("damage")
        -- Set echoed to false afterwards.
        self.echoed = false
    end)
end

return item