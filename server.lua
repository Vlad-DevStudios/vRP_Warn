------------------------CREDITS------------------------
------------- Script made by Vlad, H3cker -------------
--         Script made for Diamond Romania RP        --
--          Discord: H3cker | DevStudios.store       --
--   Copyright 2019 © H3cker. All rights served      --
-------------------------------------------------------
MySQL = module("vrp_mysql", "MySQL")
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_warns")

MySQL.createCommand("vRP/warn_init_user","INSERT IGNORE INTO vrp_warns(user_id) VALUES(@user_id)")

MySQL.createCommand("vRP/get_warns","SELECT * FROM vrp_warns WHERE user_id = @user_id")
MySQL.createCommand("vRP/get_bonus","SELECT * FROM vrp_users WHERE id = @id")
MySQL.createCommand("vRP/get_idoff","SELECT * FROM vrp_users WHERE id = @id")

MySQL.createCommand("vRP/set_warn","UPDATE vrp_warns SET warns = warns + 1 WHERE user_id = @user_id")
MySQL.createCommand("vRP/set_unwarn","UPDATE vrp_warns SET warns = warns - 1 WHERE user_id = @user_id")
MySQL.createCommand("vRP/set_default","UPDATE vrp_warns SET warns = 0 WHERE user_id = @user_id")

MySQL.createCommand("vRP/set_warnid1","UPDATE vrp_warns SET warnid1 = @warnid1 WHERE user_id = @user_id")
MySQL.createCommand("vRP/set_warnid2","UPDATE vrp_warns SET warnid2 = @warnid2 WHERE user_id = @user_id")
MySQL.createCommand("vRP/set_warnid3","UPDATE vrp_warns SET warnid3 = @warnid3 WHERE user_id = @user_id")

MySQL.createCommand("vRP/set_warnr1","UPDATE vrp_warns SET warnr1 = @warnr1 WHERE user_id = @user_id")
MySQL.createCommand("vRP/set_warnr2","UPDATE vrp_warns SET warnr2 = @warnr2 WHERE user_id = @user_id")
MySQL.createCommand("vRP/set_warnr3","UPDATE vrp_warns SET warnr3 = @warnr3 WHERE user_id = @user_id")

AddEventHandler("vRP:playerJoin",function(user_id,source,name,last_login)
	MySQL.execute("vRP/warn_init_user", {user_id = user_id}, function(affected)
	end)
	MySQL.query("vRP/get_bonus", {id = user_id}, function(rows, affected)
		bouns = rows[1].bouns
		if bonus == "none" then
			if user_id < 2001 then
				vRP.giveMoney({user_id,20000000})
				vRPclient.Bonus(user_id,{"Ai primit ~g~20 Mil. bonus ~w~pentru ca server-ul a primit wipe si ai ~g~ID sub 2000~w~!"})
			end
		end
	end)
end)

RegisterCommand("warns", function(source)
	user_id = vRP.getUserId({source})
	MySQL.query("vRP/get_warns", {user_id = user_id}, function(rows, affected)
		warns = rows[1].warns
		vRPclient.notify(source,{"~r~Ai ".. warns .." warn(uri)!"})
	end)
end)

local function warnp(player,choice)
	local ID = vRP.getUserId({player})
	vRP.prompt({player, "Jucator ID:", "", function(player, user_id)
		user_id = tonumber(user_id)
		if user_id ~= nil and user_id ~= "" then 
			if user_id == 1 or user_id == 2 then
				vRPclient.notify(player,{"~r~NU"})
			else
				if user_id == ID then
					vRPclient.notify(player,{"~r~Nu poti sa iti dai warn singur"})
				else
			    	vRP.prompt({player, "Motiv:", "", function(player, motivr)
				    	if motivr ~= "" then
				    		motivr = motivr
				        	MySQL.query("vRP/set_warn", {user_id = user_id})
				        	MySQL.query("vRP/get_warns", {user_id = user_id}, function(rows, affected)
					        	motiv = rows[1].warnr1
					        	if motiv == "none" then
									MySQL.query("vRP/set_warnr1", {user_id = user_id, warnr1 = motivr})
									MySQL.query("vRP/set_warnid1", {user_id = user_id, warnid1 = ID})
						        	MySQL.query("vRP/get_idoff", {id = user_id}, function(rows, affected)
										idoff = rows[1].username
										idoff2 = rows[1].id
							    		vRPclient.notify(player,{"~w~[~b~Diamond~w~] I-ai dat Warn 1/3 lui ~b~".. idoff .."!"})
							    		TriggerClientEvent('chatMessage', -1, '^5[WARN] ^0[^1'.. idoff2 ..'^0] ^1'.. idoff ..' ^0a primit 1/3 warn de la ^0[^2'.. ID ..'^0] ^2'.. GetPlayerName(player) ..'^0!')
						    			TriggerClientEvent('chatMessage', -1, '^5[WARN] ^5Motiv: ^0'..motivr)
						    		end)
					    		else
						    		motiv2 = rows[1].warnr2
						        	if motiv2 == "none" then
										MySQL.query("vRP/set_warnr2", {user_id = user_id, warnr2 = motivr})
										MySQL.query("vRP/set_warnid2", {user_id = user_id, warnid2 = ID})
							        	MySQL.query("vRP/get_idoff", {id = user_id}, function(rows, affected)
											idoff = rows[1].username
											idoff2 = rows[1].id
							            	vRPclient.notify(player,{"~w~[~b~Diamond~w~] I-ai dat Warn 2/3 lui ~b~".. idoff .."!"})
						                	TriggerClientEvent('chatMessage', -1, '^5[WARN] ^0[^1'.. idoff2 ..'^0] ^1'.. idoff ..' ^0a primit 2/3 warn de la ^0[^2'.. ID ..'^0] ^2'.. GetPlayerName(player) ..'^0!')
							          		TriggerClientEvent('chatMessage', -1, '^5[WARN] ^5Motiv: ^0'..motivr)
							   	 		end)
						    		else
							    		motiv3 = rows[1].warnr3
							        	if motiv3 == "none" then
											MySQL.query("vRP/set_warnr3", {user_id = user_id, warnr3 = motivr})
											MySQL.query("vRP/set_warnid3", {user_id = user_id, warnid3 = ID})
							          		MySQL.query("vRP/get_idoff", {id = user_id}, function(rows, affected)
												idoff = rows[1].username
												idoff2 = rows[1].id
								    			local motivban = "Ai Peste 3 Warn-uri!\n\nDupa 7 Zile Puteti Face Cerere UnBan Pe Discord!"
						      					DropPlayer(user_id,motivban)
							    				vRP.setBanned({user_id,true})
							    				vRPclient.notify(player,{"~w~[~b~Diamond~w~] I-ai dat Warn 3/3 si BAN 7 Zile lui ~b~".. idoff .."!"})
								        		TriggerClientEvent('chatMessage', -1, '^8[WARN] ^0[^1'.. idoff2 ..'^0] ^1'.. idoff ..' ^8A Primit ^2Ban 7 Zile ^8Pentru ^23 Warn-uri de la ^0[^2'.. ID ..'^0] ^2'.. GetPlayerName(player)..'!')
							    				TriggerClientEvent('chatMessage', -1, '^5[WARN] ^5Motiv: ^0'..motivr)
								    		end)
							    		else
								    		vRPclient.notify(player,{"~w~[~b~Diamond~w~] ~r~ID: [~b~".. user_id .."~r~] Are deja 3 Warn-uri si BAN!"})
							    		end
						    		end
					    		end
				     		end)
			    		else
				    		vRPclient.notify(player,{"~r~Motivul este obligatoriu"})
				    		return
			    		end
					end})
				end
			end
		else
			vRPclient.notify(player,{"~r~Nici un ID selectat!"})
		end
	end})
end

local function unwarnp(player,choice)
	local ID = vRP.getUserId({player})
	vRP.prompt({player, "Jucator ID:", "", function(player, user_id)
		user_id = tonumber(user_id)
		if user_id ~= nil and user_id ~= "" then 
			MySQL.query("vRP/get_warns", {user_id = user_id}, function(rows, affected)
				motiv3 = rows[1].warnr3
				motiv2 = rows[1].warnr2
				motiv1 = rows[1].warnr1
				if motiv3 == "none" then
					if motiv2 == "none" then
						if motiv1 == "none" then
							vRPclient.notify(player,{"~r~Jucatorul are 0 Warn-uri!"})
						else
							MySQL.query("vRP/set_warnr1", {user_id = user_id, warnr1 = "none"})
							MySQL.query("vRP/set_warnid1", {user_id = user_id, warnid1 = "none"})
							MySQL.query("vRP/set_unwarn", {user_id = user_id})
							MySQL.query("vRP/get_idoff", {id = user_id}, function(rows, affected)
								idoff = rows[1].username
								idoff2 = rows[1].id
								MySQL.query("vRP/get_warns", {user_id = user_id}, function(rows, affected)
									warns = rows[1].warns
									vRP.setBanned({user_id,false})
									vRPclient.notify(player,{"~w~[~b~Diamond~w~] ~g~I-ai scos un Warn lui ~b~".. idoff .." ~g~acum are ~y~".. warns .."!"})
									vRPclient.notify(user_id,{"~w~[~b~Diamond~w~] ~b~"..GetPlayerName(player).." ~g~ti-a scos un Warn~b~!\n~w~acum ai ~y~".. warns .."~w~!"})
									TriggerClientEvent('chatMessage', -1, '^8[WARN] ^0[^1'.. ID ..'^0] ^1'.. GetPlayerName(player)..' ^0i-a scos un Warn lui [^2'.. idoff2 ..'^0] ^2'.. idoff ..' ^0acum are ^3'.. warns ..'^0!')
								end)
							end)
						end
					else
						MySQL.query("vRP/set_warnr2", {user_id = user_id, warnr2 = "none"})
						MySQL.query("vRP/set_warnid2", {user_id = user_id, warnid2 = "none"})
						MySQL.query("vRP/set_unwarn", {user_id = user_id})
						MySQL.query("vRP/get_idoff", {id = user_id}, function(rows, affected)
							idoff = rows[1].username
							idoff2 = rows[1].id
							MySQL.query("vRP/get_warns", {user_id = user_id}, function(rows, affected)
								warns = rows[1].warns
								idoff2 = rows[1].id
								vRPclient.notify(player,{"~w~[~b~Diamond~w~] ~g~I-ai scos un Warn lui ~b~".. idoff .." ~g~acum are ~y~".. warns .."!"})
								vRPclient.notify(user_id,{"~w~[~b~Diamond~w~] ~b~"..GetPlayerName(player).." ~g~ti-a scos un Warn~b~!\n~w~acum ai ~y~".. warns .."~w~!"})
								TriggerClientEvent('chatMessage', -1, '^8[WARN] ^0[^1'.. ID ..'^0] ^1'.. GetPlayerName(player)..' ^0i-a scos un Warn lui [^2'.. idoff2 ..'^0] ^2'.. idoff ..' ^0acum are ^3'.. warns ..'^0!')
							end)
						end)
					end
				else
					MySQL.query("vRP/set_warnr3", {user_id = user_id, warnr3 = "none"})
					MySQL.query("vRP/set_warnid3", {user_id = user_id, warnid3 = "none"})
					MySQL.query("vRP/set_unwarn", {user_id = user_id})
					MySQL.query("vRP/get_idoff", {id = user_id}, function(rows, affected)
						idoff = rows[1].username
						idoff2 = rows[1].id
						MySQL.query("vRP/get_warns", {user_id = user_id}, function(rows, affected)
							warns = rows[1].warns
							vRPclient.notify(player,{"~w~[~b~Diamond~w~] ~g~I-ai scos un Warn lui ~b~".. idoff .." ~g~acum are ~y~".. warns .."!"})
							vRPclient.notify(user_id,{"~w~[~b~Diamond~w~] ~b~"..GetPlayerName(player).." ~g~ti-a scos un Warn~b~!\n~w~acum ai ~y~".. warns .."~w~!"})
							TriggerClientEvent('chatMessage', -1, '^8[WARN] ^0[^1'.. ID ..'^0] ^1'.. GetPlayerName(player)..' ^0i-a scos un Warn lui [^2'.. idoff2 ..'^0] ^2'.. idoff ..' ^0acum are ^3'.. warns ..'^0!')
						end)
					end)
				end
			end)
		else
			vRPclient.notify(player,{"~r~Nici un ID selectat!"})
		end
	end})
end

local function resetwarn(player,choice)
	local ID = vRP.getUserId({player})
	vRP.prompt({player, "Jucator ID:", "", function(player, user_id)
		user_id = tonumber(user_id)
		if user_id ~= nil and user_id ~= "" then 
			MySQL.query("vRP/get_warns", {user_id = user_id}, function(rows, affected)
				motiv3 = rows[1].warnr3
				motiv2 = rows[1].warnr2
				motiv1 = rows[1].warnr1
				if motiv1 == "none" then
					vRPclient.notify(player,{"~r~Jucatorul are 0 Warn-uri!"})
				else
					MySQL.query("vRP/set_warnr1", {user_id = user_id, warnr1 = "none"})
					MySQL.query("vRP/set_warnr2", {user_id = user_id, warnr2 = "none"})
					MySQL.query("vRP/set_warnr3", {user_id = user_id, warnr3 = "none"})

					MySQL.query("vRP/set_warnid1", {user_id = user_id, warnid1 = "none"})
					MySQL.query("vRP/set_warnid2", {user_id = user_id, warnid2 = "none"})
					MySQL.query("vRP/set_warnid3", {user_id = user_id, warnid3 = "none"})

					MySQL.query("vRP/set_default", {user_id = user_id})
					MySQL.query("vRP/get_idoff", {id = user_id}, function(rows, affected)
						idoff = rows[1].username
						MySQL.query("vRP/get_warns", {user_id = user_id}, function(rows, affected)
							warns = rows[1].warns
							vRP.setBanned({user_id,false})
							vRPclient.notify(player,{"~w~[~b~Diamond~w~] ~g~I-ai resetat warn-urile lui ~b~".. idoff})
							vRPclient.notify(user_id,{"~w~[~b~Diamond~w~] ~b~"..GetPlayerName(player).." ~g~ti-a resetat Warnurile~b~!"})
							TriggerClientEvent('chatMessage', -1, '^8[WARN] ^0[^1'.. ID ..'^0] ^1'.. GetPlayerName(player)..' ^0i-a resetat warn-urile lui [^2'.. idoff2 ..'^0] ^2'.. idoff ..'^0!')
						end)
					end)
				end
			end)
		else
			vRPclient.notify(player,{"~r~Nici un ID selectat!"})
		end
	end})
end

local function searchwarn(player,choice)
	local ID = vRP.getUserId({player})
	vRP.prompt({player, "Jucator ID:", "", function(player, user_id)
		user_id = tonumber(user_id)
		if user_id ~= nil and user_id ~= "" then 
			MySQL.query("vRP/get_warns", {user_id = user_id}, function(rows, affected)
				warns = rows[1].warns
				motiv3 = rows[1].warnr3
				motiv2 = rows[1].warnr2
				motiv1 = rows[1].warnr1

				warnid3 = rows[1].warnid3
				warnid2 = rows[1].warnid2
				warnid1 = rows[1].warnid1
				
				MySQL.query("vRP/get_idoff", {id = user_id}, function(rows, affected)
					idoff = rows[1].username
					idoff2 = rows[1].id
					vRP.closeMenu({player})
					    SetTimeout(250, function()
		           	 	vRP.buildMenu({"ID Search", {player = player}, function(menu)
			        	menu.name = "ID Search"
			       	 	menu.css={top="75px",header_color="rgba(200,0,0,0.75)"}
						menu.onclose = function(player) vRP.closeMenu({player}) end
						if warns == 0 then
							menu["NU ARE WARN-URI"] = {none,""}
						end
						if warns >= 1 then
							menu["Warn 1"] = {none,"By Admin ID: <font color='#33b5e5'>"..warnid1.."</font><br><font color='white'>Motiv: <font color='#33b5e5'>"..motiv1.."</font><br>Nume/ID:</font> <font color='#33b5e5'>[</font><font color='red'>".. idoff2.."</font><font color='#33b5e5'>] "..idoff .."</font><br>Warn-uri: <font color='#33b5e5'>"..warns.."</font><font color='white'>/</font><font color='#33b5e5'>3</font>!"}
						end
						if warns >= 2 then
							menu["Warn 2"] = {none,"By Admin ID: <font color='#33b5e5'>"..warnid2.."</font><br><font color='white'>Motiv: <font color='#33b5e5'>"..motiv2.."</font><br>Nume/ID:</font> <font color='#33b5e5'>[</font><font color='red'>".. idoff2.."</font><font color='#33b5e5'>] "..idoff .."</font><br>Warn-uri: <font color='#33b5e5'>"..warns.."</font><font color='white'>/</font><font color='#33b5e5'>3</font>!"}
						end
						if warns >= 3 then
							menu["Warn 3"] = {none,"By Admin ID: <font color='#33b5e5'>"..warnid3.."</font><br><font color='white'>Motiv: <font color='#33b5e5'>"..motiv3.."</font><br>Nume/ID:</font> <font color='#33b5e5'>[</font><font color='red'>".. idoff2.."</font><font color='#33b5e5'>] "..idoff .."</font><br>Warn-uri: <font color='#33b5e5'>"..warns.."</font><font color='white'>/</font><font color='#33b5e5'>3</font>!"}
						end
						vRP.openMenu({player,menu}) 
		        	end})
	        	end)
			end)
		end)
	else
		vRPclient.notify(player,{"~r~Nici un ID selectat!"})
	end
	end})
end

local function warnmenu(player,choice)
	vRP.closeMenu({player})
		SetTimeout(250, function()
			vRP.buildMenu({"Admin Warn", {player = player}, function(menu)
				menu.name = "Admin Warn"
				menu.css={top="75px",header_color="rgba(200,0,0,0.75)"}
				menu.onclose = function(player) vRP.closeMenu({player}) end
				menu["Warn Jucator"] = {warnp, "Da-i Warn Unui Jucator Online/Offline"}
				menu["Warn Search"] = {searchwarn, "Cauta Warn-urile/Motivele pentru care a primit Warn"}
				menu["UnWarn Jucator"] = {unwarnp, "Da-i UnWarn Unui Jucator Online/Offline"}
				menu["Warn Reset"] = {resetwarn, "Da-i reset la warnurile unui jucator"}			
			vRP.openMenu({player,menu})
		end})
	end)
end

vRP.registerMenuBuilder({"admin", function(add, data)
	local user_id = vRP.getUserId({data.player})
	if user_id ~= nil then
		local choices = {}
		if(vRP.isUserHelper({user_id}))then
			choices["Admin Warn"] = {warnmenu, "Admin Warn Menu"}
		end
		add(choices)
	end
end})