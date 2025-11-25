$scoreboard players set #Physics.Value Physics $(Value)
execute if score #Physics.Value Physics matches ..-251 run tellraw @s [{text:"Physics >> ",color:"#99EAD6"},{text:"The maximum separating velocity must not be below -250 (-0.25 blocks/tick).",color:"red"}]
execute if score #Physics.Value Physics matches ..-251 at @s run return run playsound minecraft:entity.villager.no master @s ~ ~ ~
execute if score #Physics.Value Physics matches 1.. run tellraw @s [{text:"Physics >> ",color:"#99EAD6"},{text:"The maximum separating velocity must not exceed 0 (0.0 blocks/tick).",color:"red"}]
execute if score #Physics.Value Physics matches 1.. at @s run return run playsound minecraft:entity.villager.no master @s ~ ~ ~

scoreboard players operation #Physics.Settings.Resolution.MaxSeparatingVelocity Physics = #Physics.Value Physics
execute at @s run playsound minecraft:ui.button.click master @s ~ ~ ~
function physics:settings/open
