-- What? The ping pie isn't good enough for you? Fine, have this one instead.
-- Shows how you can future heal the entire party with a HealItem.

local item, super = Class(HealItem)

function item:init()
    super:init(self)

    -- Display name
    self.name = "Quantum Pie"
    -- Name displayed when used in battle (optional)
    self.use_name = "QUANTUM PIE"

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = "More\nhealing...\nsometime?"
    -- Shop description
    self.shop = "True form of Ping Pie."
    -- Menu description
    self.description = "True form of Ping Pie. Has transcended science and duplicated from having absurd latency."

    -- Amount healed (HealItem variable)
    self.heal_amount = 0

    -- Default shop price (sell price is halved)
    self.price = 115
    -- Whether the item can be sold
    self.can_sell = true

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "party"
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
        susie = "Why's this thing flickering?",
        ralsei = "Kris, what is this!?",
        noelle = "(Where do they get these things?)",
    }

    self.future_heal_amount = 90
    self.future_heal_turns = 3
end

return item