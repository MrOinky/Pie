-- This sword increases your healing power and gives you a pastry every other turn.
-- Demonstrates how you could use the passive_item variables and item-specific heal bonuses.

local item, super = Class(Item)

function item:init()
    super:init(self)

    -- Display name
    self.name = "Baker's Blade"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/sword"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "A sharp oak blade that doubles as a rolling pin. Boosts healing and creates magical pastries."

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
        attack = 3,
    }

    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = "Pastry&Healing"
    self.bonus_icon = "ui/menu/icon/up"

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        kris = true
    }

    -- Character reactions (key = party member id)
    self.reactions = {
        susie = "What? A rolling pin?",
        ralsei = "We can bake later!",
        noelle = "Umm... Kris? I cant use this!",
    }

    -- Healing boost
    self.heal_bonuses = {
        pastry = 20
    }

    self.passive_item = true

    self.passive_item_name = "pastry"
    self.passive_item_frequency = 2
end

return item