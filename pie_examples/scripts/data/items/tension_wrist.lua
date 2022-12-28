-- A small armband that grants the wearer tension at the start of battle.
-- Shows how you can use starting_tension variables to start the battle with some TP.

local item, super = Class(Item)

function item:init()
    super:init(self)

    -- Display name
    self.name = "TensionWrist"

    -- Item type (item, key, weapon, armor)
    self.type = "armor"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/armor"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "A strange enegy pulses out of this small armband.\nGrants 20% TP at the start of battle."

    -- Default shop price (sell price is halved)
    self.price = 300
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
    self.bonus_name = "StartTension"
    self.bonus_icon = "ui/menu/icon/up"

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        susie = false
    }

    -- Character reactions (key = party member id)
    self.reactions = {
        susie = "It's too small!",
        ralsei = "This will come in handy!",
        noelle = "Is this part of some ritual?",
    }

    self.starting_tension = 20
end

return item