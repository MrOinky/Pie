-- An adaptaion of Undertale's Stained Apron.

local item, super = Class(Item)

function item:init()
    super:init(self)

    -- Display name
    self.name = "TensionAnklet"

    -- Item type (item, key, weapon, armor)
    self.type = "armor"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/armor"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "A tight, orange anklet. Hurts the bearer, but also gives Tension Points."

    -- Default shop price (sell price is halved)
    self.price = 150
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
    self.bonus_name = "TensionHeal"
    self.bonus_icon = "ui/menu/icon/up"

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {}

    -- Character reactions (key = party member id)
    self.reactions = {
        susie = "How tight is this thing?",
        ralsei = "Isn't there a bigger size?",
        noelle = "It hurts... but feels good...",
    }

    self.passive_tension = true
    
    self.passive_tension_amount = 15
    self.passive_tension_cost = 10
    self.passive_tension_frequency = 1
end

return item