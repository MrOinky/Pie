-- A mirror. Can reflect anything, no matter how illogical.
-- Shows how you can use reflect variables to create a reflecting item.

local item, super = Class(Item)

function item:init()
    super:init(self)

    -- Display name
    self.name = "Mirror"

    -- Item type (item, key, weapon, armor)
    self.type = "armor"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/armor"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "Inside is a clear reflection of yourself. Might reflect attacks back at the enemy."

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
        defense = 1,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = "Reflection"
    self.bonus_icon = "ui/menu/icon/up"

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {}

    -- Character reactions (key = party member id)
    self.reactions = {
        susie = "Looking good.",
        ralsei = "Oh, its shiny!",
        noelle = "(How is this useful???)",
    }

    -- Reflect variables

    -- 50% chance to reflect
    self.reflect_chance = 0.5

    -- Reflects ALL damage.
    self.reflect_damage_proprotion = 1;
end

return item