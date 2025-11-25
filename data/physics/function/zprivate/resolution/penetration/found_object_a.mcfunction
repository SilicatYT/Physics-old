# Tag the object data for this object so it can be copied over in its entirety (& remove the original)
execute store result storage physics:temp data.A int 1 run scoreboard players get @s Physics.Object.ID
function physics:zprivate/resolution/penetration/get_object_data with storage physics:temp data
data modify storage physics:resolution Object set from storage physics:zprivate ContactGroups[{R:1b}]
data remove storage physics:zprivate ContactGroups[{R:1b}]
data remove storage physics:resolution Object.R

#execute store result score #Physics.HowMany Physics if data storage physics:resolution Object.Objects[0].Blocks[].Hitboxes[].Contacts[{HasMaxPenetrationDepth:0b}]
#tellraw @p ["FoundObjectA (Penetration): ",{score:{name:"#Physics.HowMany",objective:"Physics"}}]

# Select the type of contact that needs to be resolved (World or object-object)
execute store result score #Physics.ContactType Physics if data storage physics:resolution Object.Objects[0].Blocks[].Hitboxes[].Contacts[{HasMaxPenetrationDepth:0b}]
execute if score #Physics.ContactType Physics matches 1 run return run function physics:zprivate/resolution/penetration/world/main
function physics:zprivate/resolution/penetration/object/main

# PROBLEM: HasMaxPenetrationDepth wird nicht korrekt gesetzt
