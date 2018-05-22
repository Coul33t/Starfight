import strutils

type

  ship_type* = enum
    corvette, destroyer, cruiser

  module_type* = enum
    atk, def, uti

  damage_type* = enum
    kinetic, energy, missile, torpedo

  defense_type* = enum
    armor, shield

  Spaceship* = ref object of RootObj
    name*: string
    ship_type*: ship_type
    nb_offense_slot*: int
    nb_offense_mod*: int
    nb_defense_slot*: int
    nb_defense_mod*: int
    nb_utility_slot*: int
    nb_utility_mod*: int
    mod_onboard*: seq[Module]
    hull_hp*: int

  Module* = ref object of RootObj
    name*: string
    mod_type*: module_type

  Module_Offense = ref object of Module
    dmg*: int
    dmg_type*: damage_type
    priority*: int
    rate_of_fire*: int

  Module_Defense = ref object of Module
    def*: int
    def_type*: defense_type


proc newCorvette *: Spaceship =
  new result
  result.name = "Corvette"
  result.nb_offense_slot = 2
  result.nb_defense_slot = 1
  result.nb_utility_slot = 1
  result.nb_offense_mod = 0
  result.nb_defense_mod = 0
  result.nb_utility_mod = 0
  result.hull_hp = 200

proc newGaussCannon *: Module_Offense =
  new result
  result.name = "Gauss Cannon"
  result.mod_type = atk
  result.dmg = 10
  result.dmg_type = kinetic
  result.priority = 10
  result.rate_of_fire = 5

proc newTitaniumArmor *: Module_Defense =
  new result
  result.name = "Titanium armor"
  result.mod_type = def
  result.def = 100
  result.def_type = armor

proc add_module *(ss: Spaceship, mod_name: string): bool =
  case mod_name
  of "GaussCannon":
    if ss.nb_offense_mod < ss.nb_offense_slot:
      var module = newGaussCannon()
      ss.mod_onboard.add(module)
      return true
    else:
      return false
  of "TitaniumArmor":
    if ss.nb_defense_mod < ss.nb_defense_slot:
      var module = newTitaniumArmor()
      ss.mod_onboard.add(module)
      return true
    else:
      return false
