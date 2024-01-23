local killspamthreshold = 5
local killspamwarningthreshold = 3 -- killspamwarningthreshold have to be smaller than killspamthreshold
local playerkills = {}

core.register_on_dieplayer(function(player, reason)
	local victim = player:get_player_name()
	if reason.type == "punch" then
		local obj = reason.object
		if obj:is_player() then
			local killer = obj:get_player_name()
			--hud_add(killer,weap_tex.."^[resize:16x16",name)
		end
	end
	if killer then
	  playerKills[killer] + 1
	end
	if playerKills[killer] = killspamwarningthreshold then
	  minetest.chat_send_player(killer, "**WARNING**: Spamkilling is not allowed! Send a request to player to disable punnish system.")
	  minetest.chat_send_player(killer, "type '/skr " .. victim .. "' to send a request.")
	elseif playerKills[killer] = killspamthreshold then
    minetest.chat_send_player(killer, "**LAST WARNING** stop spamkilling or send a request!")
	else playerKills[killer] > killspamthreshold then
    minetest.kick_player(killer, "You were kicked for spamming kills.")
  end
end)

