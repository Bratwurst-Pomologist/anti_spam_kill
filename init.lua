local killspamthreshold = 5
local killspamwarningthreshold = 3 -- killspamwarningthreshold have to be smaller than killspamthreshold
local playerkills = {}
local resettimer = 300
local whitelistresettimer = 900
local timers = {}
local spamkillrequests = {}
local spamkillinvitations = {}
local whitelist = {}

minetest.register_chatcommand("skr", {
  params = "<player>",
  description = "Send a spamkillrequest to player.",
  func = function(name, param)
    local targetplayer = minetest.get_player_name(param)
    if targetplayer then
      spamkillrequests[targetplayer] = name
      minetest.chat_send_player(targetplayer, name .. " has sent you a spamkill request. Type /sky to accept or /skn to deny.")
      minetest.chat_send_player(name, "spamkill request sent to " .. targetplayer)
      else
      minetest.chat_send_player(name, "player not found or not online.")
    end
  end,
})

minetest.register_chatcommand("skhr", {
  params = "<player>",
  description = "Send a spamkill invitation to player.",
  func = function(name, param)
    local targetplayer = minetest.get_player_name(param)
    if targetplayer then
      spamkillinvitations[targetplayer] = name
      minetest.chat_send_player(targetplayer, name .. " has sent you a spamkill invitation. Type /sky to accept or /skn to deny.")
      minetest.chat_send_player(name, "spamkill invitation sent to " .. targetplayer)
      else
      minetest.chat_send_player(name, "player not found or not online.")
    end
  end,
})

minetest.register_chatcommand("sky",{
  description="Accepts a spamkill request/invitation.",
  func = function(name, param)
    if spamkillrequests[name] or spamkillinvitations[name] then
      local requester = (spamkillrequests[name] or spamkillinvitations[name])
      local requesterplayer = minetest.get_player_name(requester)
      local targetplayer = minetest.get_player_name(name)
      if requesterplayer and targetplayer then
        whitelist[requesterplayer] = true
        whitelist[targetplayer] = true 
        minetest.chat_send_player(requesterplayer, "Your spamkill request/invitation has been accepted by " .. targetplayer .. ". You both are free to kill each other for 15 min")
        minetest.chat_send_player(targetplayer, "You have accepted " .. requesterplayer .. "'s spamkill request/invitation. You are free to kill each other for 15 minutes.")
      end
    end
  end,
})

minetest.register_chatcommand("skn",{
  description = "Deny a spamkill request/invitation",
  func = function(name, param)
    if spamkillrequests[name] or spamkillinvitations[name] then
      local requester = (spamkillrequests[name] or spamkillinvitations[name])
      local requesterplayer = get_player_name(requester)
      local targetplayer = minetest.get_player_name(name)
      if requesterplayer and targetplayer then
        mintest.chat_send_player
})

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
	if playerkills[killer] == killspamwarningthreshold then
	  minetest.chat_send_player(killer, "**WARNING**: Spamkilling is not allowed! Send a request to player to disable punnish system.")
	  minetest.chat_send_player(killer, "type '/skr " .. victim .. "' to send a request.")
	elseif playerkills[killer] == killspamthreshold then
    minetest.chat_send_player(killer, "**LAST WARNING** stop spamkilling or send a request!")
	elseif playerkills[killer] > killspamthreshold then
    minetest.kick_player(killer, "You were kicked for spamming kills.")
  end
end)
