# Invalid contact point
# (Important): This is necessary because the penetration depth could be positive even if the edges aren't intersecting. So if they aren't, the contact should be ignored during resolution, but it should still be stored because we can't be sure whether the hitboxes are only slightly distanced or far away.
# (Important): The contact point is valid if both the point on EdgeA and the point on EdgeB are within the respective edge's bounds.
# (Important): If this check fails, the contact is still kept for later ticks, but it will be completely ignored during resolution.
$data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts append value {FeatureB:$(Edge)b,Invalid:1b}
execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].FeatureA byte 1 run scoreboard players get #Physics.Contact.FeatureA Physics
