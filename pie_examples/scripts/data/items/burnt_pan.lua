-- An adaptaion of Undertale's Burnt Pan.

local item, super = Class(Item)

function item:init()
    super:init(self)

    -- Display name
    self.name = "Burnt Pan"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/sword"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "This pan suffered third-degree burns, and now thinks it's a sword. Boosts healing."

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
        attack = 4,
        defense = 1,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = "Healing UP"
    self.bonus_icon = "ui/menu/icon/up"

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        kris = true
    }

    -- Character reactions (key = party member id)
    self.reactions = {
        susie = "I am NOT your chef.",
        ralsei = "We can make cake later, Kris!",
        noelle = "(Why are they hitting me!?)",
    }

    -- Healing boost
    self.heal_bonus = 15
end

return item