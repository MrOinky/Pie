-- The Cactus Scarf.
-- It hurts!

local item, super = Class(Item)

function item:init()
    super:init(self)

    -- Display name
    self.name = "Cactus Scarf"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/scarf"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "Placed in the top 10 of a \"World's worst Inventions\" list. Highly impractical."

    -- Default shop price (sell price is halved)
    self.price = 400
    -- Whether the item can be sold
    self.can_sell = false

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
        defense = -2,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = "Pain"
    self.bonus_icon = "ui/menu/icon/up"

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        ralsei = true,
    }

    -- Character reactions
    self.reactions = {
        susie = "Wouldn't want to wear that!",
        ralsei = "Ow! Not my kind of scarf!",
        noelle = "So prickly! ... I like it!",
    }

    self.passive_hurt = true

    self.passive_hurt_amount = 20
    self.passive_heal_frequency = 1
end

return item