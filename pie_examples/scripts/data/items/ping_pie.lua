-- This pie is slightly laggy and so it'll heal you 2 turns after eating it.
-- Shows how you can do a future heal in a HealItem.

local item, super = Class(HealItem)

function item:init()
    super:init(self)

    -- Display name
    self.name = "Ping Pie"
    -- Name displayed when used in battle (optional)
    self.use_name = "PING PIE"

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = "Healing...\neventually"
    -- Shop description
    self.shop = "Delayed healing"
    -- Menu description
    self.description = "This pie accidentally accumulated a large amount of latency. +90HP, eventually?"

    -- Amount healed (HealItem variable)
    self.heal_amount = 0

    -- Default shop price (sell price is halved)
    self.price = 80
    -- Whether the item can be sold
    self.can_sell = true

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "ally"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil
    -- Will this item be instantly consumed in battles?
    self.instant = false

    -- Equip bonuses (for weapons and armor)
    self.bonuses = {}
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = nil
    self.bonus_icon = nil

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {}

    -- Character reactions (key = party member id)
    self.reactions = {
        susie = "Hmm. Raspberry flavor.",
        ralsei = "The flavor takes a while to come out!",
        noelle = "Not as good as fruitcake!",
    }

    self.future_heal_amount = 90
    self.future_heal_turns = 2
end

return item