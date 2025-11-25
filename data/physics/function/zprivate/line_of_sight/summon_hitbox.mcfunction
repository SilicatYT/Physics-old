# Summon hitbox
scoreboard players add #Physics.InteractionCount Physics 1
scoreboard players operation @s Physics.Player.ID = #Physics.NewHitbox Physics.Player.ID
scoreboard players operation @s Physics.Hitbox.Gametime = #Physics.Gametime Physics

data modify storage physics:temp data.HitboxData.Pos set from storage physics:temp data.HitboxPos
data modify entity @s {} merge from storage physics:temp data.HitboxData

tag @s add Physics.Hitbox
