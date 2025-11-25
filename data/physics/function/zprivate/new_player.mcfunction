# Init
# (Important): LookingAtID is set to 0 because I run a "if 0" check. If it's not initialized, it'll stay unset forever. I could use "unless 1..", but that's slightly slower.
scoreboard players set @s Physics.Player.LookingAtID 0
execute store result score @s Physics.Player.ID run scoreboard players add #Physics Physics.Player.ID 1
