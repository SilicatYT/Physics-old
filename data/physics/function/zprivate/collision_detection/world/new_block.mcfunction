# Add the block to the final storage
data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks append value {Pos:[I;0,0,0],Hitboxes:[]}
execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Pos[0] int 1 run scoreboard players get #Physics.BlockPos.x Physics
execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Pos[1] int 1 run scoreboard players get #Physics.BlockPos.y Physics
execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Pos[2] int 1 run scoreboard players get #Physics.BlockPos.z Physics

# Get the block's contacts from the previous tick for all hitboxes (If this is the first successful SAT for this block)
# (Important): This is setup for contact accumulation for touching blocks.
# (Important): If there is no data for this block from the previous tick, it will fail to copy over the data (still uses 1 macro...), so it keeps the previous block's data. This is why the data is cleared beforehand.
scoreboard players set #Physics.Touching Physics 1
function physics:zprivate/contact_generation/new_contact/world/get_previous_contacts with storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1]

# Set the coefficients of restitution & friction for the material pair
# (Important): Scaled up by 100x. It then takes the min of both coefficients in the hitbox check.
scoreboard players set #Physics.FrictionCoefficient Physics 50
scoreboard players set #Physics.RestitutionCoefficient Physics 30

#execute if block ~ ~ ~ #physics:material/dirt run scoreboard players set #Physics.FrictionCoefficient Physics 500
#execute if block ~ ~ ~ #physics:material/dirt run scoreboard players set #Physics.RestitutionCoefficient Physics 300

# TODO: Add more materials and optimize (maybe a binary search?)
