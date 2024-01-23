core.register_on_dieplayer(function(player, reason)
	local victim = player:get_player_name()
	if reason.type == "punch" then
		local obj = reason.object
		if obj:is_player() then
			local killer = obj:get_player_name()
			--hud_add(killer,weap_tex.."^[resize:16x16",name)
		end
	end
end)
