-- An adaptaion of Undertale's Stained Apron.
-- Shows how you can use passive_heal variables to replicate its effect.

local item, super = Class(Item)

function item:init()
    super:init(self)

    -- Display name
    self.name = "Stained Apron"

    -- Item type (item, key, weapon, armor)
    self.type = "armor"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/armor"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "A very well used apron, covered in stains.\nHeals 20HP every other turn."

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
    self.bonus_name = "PassiveHealing"
    self.bonus_icon = "ui/menu/icon/up"

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {}

    -- Character reactions (key = party member id)
    self.reactions = {
        susie = "Do I HAVE to?",
        ralsei = "Perfect for baking cakes!",
        noelle = "(Reminds me of making fruitcake!)",
    }

    -- Passive Healing

    self.passive_heal = true

    -- Heals 20 HP...
    self.passive_heal_amount = 20
    -- Every two turns.
    self.passive_heal_frequency = 2
end

return item