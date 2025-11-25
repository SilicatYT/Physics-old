# Teleport the interaction entity to the targeted position
data modify entity @s Pos set from storage physics:temp data.HitboxPos
scoreboard players operation @s Physics.Hitbox.Gametime = #Physics.Gametime Physics
scoreboard players add #Physics.SuccessfulTeleports Physics 1
return 1
