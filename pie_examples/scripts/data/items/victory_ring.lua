-- An adaptaion of Undertale's Stained Apron.

local item, super = Class(Item)

function item:init()
    super:init(self)

    -- Display name
    self.name = "VictoryRing"

    -- Item type (item, key, weapon, armor)
    self.type = "armor"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/armor"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = "Some circles call this the \"Destroyer of Money Holes\"."
    -- Menu description
    self.description = "A small, gold ring. Holds no defensive value, but gives big HP when winning battles!"

    -- Default shop price (sell price is halved)
    self.price = 10000000
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
        defense = 0,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = "VictoryHeal"
    self.bonus_icon = "ui/menu/icon/up"

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {}

    -- Character reactions (key = party member id)
    self.reactions = {
        susie = "(How did they afford this?!)",
        ralsei = "Ooh, its so shiny!",
        noelle = "Kris, don't tell me you stole this!",
    }

    self.victory_heal = 100
end

return item