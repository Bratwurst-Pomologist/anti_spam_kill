local killspamthreshold = 5
local killspamwarningthreshold = 3 -- killspamwarningthreshold have to be smaller than killspamthreshold
local playerkills = {}
local resettimer = 300
local timers = {}


core.register_on_dieplayer(function(player, reason)
	local victim = player:get_player_name()
	if reason.type == "punch" then
		local obj = reason.object
		if obj:is_player() then
			local killer = obj:get_player_name()

		end
	end
	if killer then
    playerkills[killer] = (playerkills[killer] or 0) + 1

    if not timers[killer] then
      timers[killer] = minetest.get_us_time() / 1000000 -- store current time in seconds
    else
      local current_time = minetest.get_us_time() / 1000000
      if current_time - timers[killer] > resettimer then
        playerkills[killer] = 0  -- reset kills if more than 300 seconds have passed
      end

     timers[killer] = current_time  -- update the timer
    end
  end
	if playerKills[killer] == killspamwarningthreshold then
	  minetest.chat_send_player(killer, "**WARNING**: Spamkilling is not allowed! Send a request to player to disable punnish system.")
	  minetest.chat_send_player(killer, "type '/skr " .. victim .. "' to send a request.")
	elseif playerKills[killer] == killspamthreshold then
    minetest.chat_send_player(killer, "**LAST WARNING** stop spamkilling or send a request!")
	else playerKills[killer] > killspamthreshold then
    minetest.kick_player(killer, "You were kicked for spamming kills.")
  end
end)