-- A mystical belt that can cloak the wearer in darkness to shield them from attacks.
-- Now shows how you can use dodge variables to make a dodge effect. (Used to be a custom callback)

local item, super = Class(Item)

function item:init()
    super:init(self)

    -- Display name
    self.name = "ShadowBelt"

    -- Item type (item, key, weapon, armor)
    self.type = "armor"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/armor"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "It radiates a dark aura.\nMight dodge attacks."

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
        defense = 2,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = "DodgeChance"
    self.bonus_icon = "ui/menu/icon/up"

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {}

    -- Character reactions (key = party member id)
    self.reactions = {
        susie = "Spooky.",
        ralsei = "I feel like a karate master!",
        noelle = "It looks... weird.",
    }

    -- Dodge variables

    -- 25% chance to dodge
    self.dodge_chance = 0.25

    -- Set a custom miss msg color.
    self.dodge_color = {1, 0, 1}
end

return item