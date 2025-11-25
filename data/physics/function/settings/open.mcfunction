# Open the settings menu
execute store result storage physics:temp data.Settings.DefaultPlayerStrength short 1 run scoreboard players get #Physics.Settings.DefaultPlayerStrength Physics
execute store result storage physics:temp data.Settings.DefaultGravity short 1 run scoreboard players get #Physics.Settings.DefaultGravity Physics
execute store result storage physics:temp data.Settings.LinearDamping byte 1 run scoreboard players get #Physics.Settings.LinearDamping Physics
execute store result storage physics:temp data.Settings.AngularDamping byte 1 run scoreboard players get #Physics.Settings.AngularDamping Physics
execute store result storage physics:temp data.Settings.Accumulation_MinPenetrationDepth short 1 run scoreboard players get #Physics.Settings.Accumulation.MinPenetrationDepth Physics
execute store result storage physics:temp data.Settings.Resolution_MinPenetrationDepth short 1 run scoreboard players get #Physics.Settings.Resolution.MinPenetrationDepth Physics
execute store result storage physics:temp data.Settings.Resolution_MaxSeparatingVelocity short 1 run scoreboard players get #Physics.Settings.Resolution.MaxSeparatingVelocity Physics
execute store result storage physics:temp data.Settings.Resolution_RestitutionThreshold short 1 run scoreboard players get #Physics.Settings.Resolution.RestitutionThreshold Physics

function physics:zprivate/settings/open with storage physics:temp data.Settings
