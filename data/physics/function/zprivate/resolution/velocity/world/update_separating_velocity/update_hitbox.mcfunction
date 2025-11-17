# Iterate over every contact of the current hitbox to update its ContactVelocity and SeparatingVelocity
# (Important): Just like in accumulation, I decided that 6 contacts per hitbox is the upper limit, so I don't need recursion.
# (Important): Don't update invalid contacts.
$execute store result score #Physics.ContactCount Physics if data storage physics:temp data.UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[]

# Contact 1
$execute if data storage physics:temp data.UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[0].SeparatingVelocity run function physics:zprivate/resolution/velocity/world/update_separating_velocity/update_contact_0 {Index:$(Index)}
execute if score #Physics.ContactCount Physics matches 1 run return 0

# Contact 2
$execute if data storage physics:temp data.UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[1].SeparatingVelocity run function physics:zprivate/resolution/velocity/world/update_separating_velocity/update_contact_1 {Index:$(Index)}
execute if score #Physics.ContactCount Physics matches 2 run return 0

# Contact 3
$execute if data storage physics:temp data.UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[2].SeparatingVelocity run function physics:zprivate/resolution/velocity/world/update_separating_velocity/update_contact_2 {Index:$(Index)}
execute if score #Physics.ContactCount Physics matches 3 run return 0

# Contact 4
$execute if data storage physics:temp data.UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[3].SeparatingVelocity run function physics:zprivate/resolution/velocity/world/update_separating_velocity/update_contact_3 {Index:$(Index)}
execute if score #Physics.ContactCount Physics matches 4 run return 0

# Contact 5
$execute if data storage physics:temp data.UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[4].SeparatingVelocity run function physics:zprivate/resolution/velocity/world/update_separating_velocity/update_contact_4 {Index:$(Index)}

# Contact 6
$execute unless score #Physics.ContactCount Physics matches 5 if data storage physics:temp data.UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[5].SeparatingVelocity run function physics:zprivate/resolution/velocity/world/update_separating_velocity/update_contact_5 {Index:$(Index)}
