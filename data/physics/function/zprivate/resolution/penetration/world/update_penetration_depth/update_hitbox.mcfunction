# Iterate over every contact of the current hitbox to update its PenetrationDepth
# (Important): Just like in accumulation, I decided that 6 contacts per hitbox is the upper limit, so I don't need recursion.
# (Important): Don't update invalid contacts.
# (Important): Make contacts invalid if PenetrationDepth becomes positive but the ContactPoint is in an invalid location.
$execute store result score #Physics.ContactCount Physics if data storage physics:temp data.UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[]

# Contact 1
$execute if data storage physics:temp data.UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[0].PenetrationDepth run function physics:zprivate/resolution/penetration/world/update_penetration_depth/update_contact_0 {Index:$(Index)}
execute if score #Physics.ContactCount Physics matches 1 run return 0

# Contact 2
$execute if data storage physics:temp data.UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[1].PenetrationDepth run function physics:zprivate/resolution/penetration/world/update_penetration_depth/update_contact_1 {Index:$(Index)}
execute if score #Physics.ContactCount Physics matches 2 run return 0

# Contact 3
$execute if data storage physics:temp data.UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[2].PenetrationDepth run function physics:zprivate/resolution/penetration/world/update_penetration_depth/update_contact_2 {Index:$(Index)}
execute if score #Physics.ContactCount Physics matches 3 run return 0

# Contact 4
$execute if data storage physics:temp data.UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[3].PenetrationDepth run function physics:zprivate/resolution/penetration/world/update_penetration_depth/update_contact_3 {Index:$(Index)}
execute if score #Physics.ContactCount Physics matches 4 run return 0

# Contact 5
$execute if data storage physics:temp data.UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[4].PenetrationDepth run function physics:zprivate/resolution/penetration/world/update_penetration_depth/update_contact_4 {Index:$(Index)}

# Contact 6
$execute unless score #Physics.ContactCount Physics matches 5 if data storage physics:temp data.UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[5].PenetrationDepth run function physics:zprivate/resolution/penetration/world/update_penetration_depth/update_contact_5 {Index:$(Index)}
