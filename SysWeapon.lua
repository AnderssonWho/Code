local _ = game:GetService("PhysicsService");
local _ = game:GetService("RunService");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_LocalPlayer_0 = game.Players.LocalPlayer;
while not l_LocalPlayer_0.Character do
	wait(0.5);
end;
if not _G.GetDefaultPlayerWhiteList then
	_G.GetDefaultPlayerWhiteList =  function()
		local whitelist = {}
		for _, player in pairs(game.Players:GetPlayers()) do
			if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
				table.insert(whitelist, player.Character)
			end
		end
		return whitelist
	end
end;
local _ = require(game.ReplicatedStorage.GunLibrary.SHA1Module);
local Configuration = game.ReplicatedStorage.CustomCharacter.Configuration
local ConfigurationClient = game.ReplicatedStorage.CustomCharacter.Configuration.Client
local ConfigurationServer = game.ReplicatedStorage.CustomCharacter.Configuration.Server	
local CameraControllerService = require(script.Parent.CameraControllerService)
local SingalCameraControllerService = require(script.Parent.CameraControllerService.Signal)
CameraControllerService.CreateCameraController(l_LocalPlayer_0,"MainCamera")
script.Parent:WaitForChild("CustomCamera", 300);
local v5 = 0;
local v6 = false;
local v7 = false;
local v8 = false;
local v9 = false;
local v10 = true;
local v11 = Vector3.new();
local v12 = 0;
local v13 = 0;
local v14 = 0;
local v15 = 0;
local v16 = 0;
local v17 = 0;
local v18 = false;
local v19 = 0;
local v20 = 0;
local v21 = nil;
local v22 = 0;
local v23 = 0;
local v24 = 0;
local v25 = 0;
local v26 = false;
local v27 = false;
local v28 = 0;
local v29 = false;
local v30 = false;
local v31 = 1;
local v32 = 0;
local v33 = false;
local v34 = -1;
local v35 = 0;
local v36 = false;
local v37 = 0;
local v38 = false;
local v39 = false;
local v40 = 0;
local v41 = 0;
local v42 = nil;
local v43 = false;
local v44 = 1;
local v45 = false;
local v46 = false;
local v47 = nil;
local v48 = false;
local v49 = false;
local v50 = Vector3.new();
local v51 = Vector3.new();
local v52 = nil;
local v53 = 1;
local v54 = nil;
local v55 = nil;
local v56 = nil;
local v57 = nil;
local v58 = nil;
local v59 = nil;
local v60 = nil;
local v61 = CFrame.new();
local v62 = nil;
local v63 = 0;
local v64 = 0;
local v65 = {};
local v66 = 0;
local v67 = false;
local v68 = {};
local v69 = false;
local v70 = nil;
local v71 = nil;
local v72 = {};
local v73 = false;


local TypSlots = {
	Primary = {
		Slot = 1
	},
	Secundary = {
		Slot = 2
	},
	SideArm = {
		Slot = 3
	},
	Melee = {
		Slot = 4
	},
}

--Configuration
game.ReplicatedStorage.GunEvent.GunForceEnable.OnClientEvent:Connect(function()
	ConfigurationServer.sv_enable_on_join.Value = true  --	script.Configuration:WaitForChild("AutoEnable").Value = true;
	while not v73 do
		wait();
	end;
	print("ENABLING GUN FROM FORCE ENABLE");
	if _G.checkMenus() ~= true then
		script:FindFirstChild("IsEnabled").Value = true;
		takeoutWeapon(v53, true);
		script.ForceRunning.Value = false;
	end;
end);
local l_Folder_0 = Instance.new("Folder");
l_Folder_0.Name = "GunPlugins";
l_Folder_0.Parent = script;
print("Initializing Gun System");
getInventoryItem = function(v75)
	local l_Children_0 = getViewablePlayer().GunInventory:GetChildren();
	for v77 = 1, #l_Children_0 do
		local v78 = l_Children_0[v77];
		local l_Slot_0 = v78:FindFirstChild("Slot");
		if l_Slot_0 ~= nil and l_Slot_0.Value == v75 then
			--warn(v78)
			return v78;
		end;
	end;
	return nil;
end;
destroyWeapons = function(v80)
	v26 = false;
	local l_CurrentWeapon_0 = getCamera():FindFirstChild("CurrentWeapon");
	if l_CurrentWeapon_0 ~= nil then
		l_CurrentWeapon_0:Destroy();
	end;
	if v56 ~= nil then
		if not (v80 ~= nil) or not v80 then
			game.ReplicatedStorage.GunEvent.GunDestroy:FireServer();
		end;
		v56 = nil;
	end;
end;
local v82 = {};
takeoutWeapon = function(v83, v84)
	v84 = v84 or false;
	if getHumanoid() == nil then
		return;
	elseif getHumanoid().Health <= 0 then
		return;
	elseif v83 == v53 and v55 ~= nil and not v84 then
		return;
	elseif getInventoryItem(v83) == nil and not v84 then
		return;
	else
		
		v28 = workspace.DistributedGameTime +ConfigurationServer.sv_weapon_switch_transition_time.Value
		v65 = {};
		local v85 = getInventoryItem(v83);
		if v85 == nil then
			return;
		else
			local l_Value_0 = v85.Value;
			if l_Value_0 == nil then
				return;
			else
				v33 = true;
				v48 = v85.Rechambering.Value;
				v38 = false;
				v49 = false;
				v21 = nil;
				v65 = {};
				if v55 ~= nil and v52.Parent ~= nil then
					positionGun(0);
				end;
				destroyWeapons();
				if not (l_Value_0 ~= nil) or l_Value_0:FindFirstChild("ViewModel") == nil then
					return;
				else
					pcall(function()
						getPlayer():FindFirstChild("CurrentSelected").Value = v83;
						getPlayer():FindFirstChild("CurrentSelectedObject").Value = getPlayer():FindFirstChild("GunInventory")["Slot"..v83];
					end);
					local v87 = l_Value_0.ViewModel:Clone();
					local l_ObjectValue_0 = Instance.new("ObjectValue");
					l_ObjectValue_0.Name = "Pointer";
					l_ObjectValue_0.Value = l_Value_0;
					l_ObjectValue_0.Parent = v87;
					v87.Name = "CurrentWeapon";
					v87.Parent = getCamera();
					local l_v87_Descendants_0 = v87:GetDescendants();
					for _, v91 in pairs(l_v87_Descendants_0) do
						if v91:IsA("BasePart") then
							v91.CanCollide = false;
							v91.Anchored = false;
							v91.CastShadow = false;
						end;
					end;
					l_Folder_0:ClearAllChildren();
					local l_Plugins_0 = l_Value_0:FindFirstChild("Plugins");
					if l_Plugins_0 then
						local l_l_Plugins_0_Children_0 = l_Plugins_0:GetChildren();
						for _, v95 in pairs(l_l_Plugins_0_Children_0) do
							v95:Clone().Parent = l_Folder_0;
						end;
					end;
					v54 = v53;
					v53 = v83;
					v52 = l_Value_0;
					if v55 then
						v55:Destroy();
					end;
					v55 = v87;
					script.CurrentWeapon.Value = v52;
					game.ReplicatedStorage.GunEvent.ClientUpdate:FireServer(v53, script.Aimed.Value, v30, getHumanoid().JumpPower, getCamera().CFrame, v70 ~= nil, v72.Temp1 == v72.Temp2);
					script.Events.OnGunChange:Fire(l_Value_0, v55, v85);
					for _, v97 in pairs(v82) do
						v97:Disconnect();
					end;
					v82 = {};
					table.insert(v82, v85.BulletsInMagazine.Changed:Connect(function()

					end));
					table.insert(v82, v85.BulletsInReserve.Changed:Connect(function()

					end));
					local l_v52_0 = v52;
					game.ReplicatedStorage.GunEvent.GunCreate:FireServer(v83);
					local v99 = {};
					local l_Animations_0 = l_Value_0:FindFirstChild("Animations");
					for _, v102 in pairs(l_Animations_0:GetChildren()) do
						if not v68[v102] then
							v68[v102] = v102;
							v99[#v99 + 1] = v102;
						end;
					end;
					if #v99 > 0 then
						game:GetService("ContentProvider"):PreloadAsync(v99);
					end;
					local function _()
						if v52 ~= l_v52_0 then
							return v52;
						else
							setAnimation("Idle", true);
							positionGun(0);
							game:GetService("RunService").RenderStepped:wait();
							return;
						end;
					end;
					v69 = true;
					if not (v52 ~= l_v52_0) then
						setAnimation("Idle", true);
						positionGun(0);
						game:GetService("RunService").RenderStepped:wait();
					end;
					if not (v52 ~= l_v52_0) then
						setAnimation("Idle", true);
						positionGun(0);
						game:GetService("RunService").RenderStepped:wait();
					end;
					if not (v52 ~= l_v52_0) then
						setAnimation("Idle", true);
						positionGun(0);
						game:GetService("RunService").RenderStepped:wait();
					end;
					local v104 = 0;
					while v57 and v57.Length <= 0 and v52 == l_v52_0 and v104 < 16 do
						v104 = v104 + 1;
						if not (v52 ~= l_v52_0) then
							setAnimation("Idle", true);
							positionGun(0);
							game:GetService("RunService").RenderStepped:wait();
						end;
					end;
					v69 = false;
					if v52 ~= l_v52_0 then
						return v52;
					else
						local l_HumanoidRootPart_0 = v55:FindFirstChild("HumanoidRootPart");
						if l_HumanoidRootPart_0 == nil then
							return v52;
						else
							if v55:FindFirstChild("Weapon") and v55.Weapon:FindFirstChild("CAMERA") ~= nil then
								local l_CFrame_0 = l_HumanoidRootPart_0.CFrame;
								v61 = v55.Weapon.CAMERA.CFrame:toObjectSpace(l_CFrame_0);
							else
								v61 = CFrame.new(0, -2.125, 0);
							end;
							if v55:FindFirstChild("CameraBone") then
								v21 = v55:FindFirstChild("CameraBone").CFrame:toObjectSpace(l_HumanoidRootPart_0.CFrame);
							end;
							if v52 ~= l_v52_0 then
								return v52;
							else
								setAnimation("Draw", true);
								v67 = true;
								v33 = false;
								local v107 = nil;
								if (not getAnimation("Draw") or not getAnimation("Draw"):FindFirstChild("Initial")) and not l_Value_0.Sounds:FindFirstChild("Draw") then
									v107 = script.Data.Draw:Clone();
								elseif l_Value_0.Sounds:FindFirstChild("Draw") then
									v107 = l_Value_0.Sounds:FindFirstChild("Draw"):Clone();
								end;
								if v107 then
									v107.Parent = v55.HumanoidRootPart;
									if not v107.Playing then
										v107:Play();
									end;
								end;
								v67 = not v107;
								v56 = WorldCharacter():FindFirstChild("WorldModel");
								return v52;
							end;
						end;
					end;
				end;
			end;
		end;
	end;
end;
getAnimation = function(v108)
	if not v52 then
		return nil;
	elseif v52:FindFirstChild("Animations") == nil then
		return nil;
	else
		local l_FirstChild_0 = v52.Animations:FindFirstChild(v108);
		if l_FirstChild_0 == nil then
			return nil;
		else
			return l_FirstChild_0;
		end;
	end;
end;
tote = function(v110)
	if v110:IsA("BoolValue") then
		if v110.Value == true then
			return 1;
		else
			return 0;
		end;
	elseif v110:IsA("NumberValue") or v110:IsA("IntValue") then
		return v110.Value;
	elseif v110:IsA("StringValue") then
		local v111 = 0;
		for v112 = 1, string.len(v110.Value) do
			v111 = v111 + string.byte((string.sub(v110.Value, v112, v112)));
		end;
		return v111;
	else
		return 0;
	end;
end;
onAnimationFinish = function()
	IsCurrentAnimationFinished = true;
	getNextAnimationLogic();
	script.Events.OnGunAnimationFinish:Fire();
end;
getNextAnimationLogic = function()
	local v113 = getAnimation(v58);
	if v113 then
		local l_Finished_0 = v113:FindFirstChild("Finished");
		if l_Finished_0 and l_Finished_0.Value then
			setAnimation(l_Finished_0.Value.Name);
			return;
		end;
	end;
	if (not (v58 ~= "Shoot" and v58 ~= "Draw" and v58 ~= "ReloadEnd") or v58 == "Reload") and v48 then
		rechamberGun();
		return;
	elseif not (v58 ~= "Shoot" and v58 ~= "Draw" and v58 ~= "ReloadEnd" and v58 ~= "Reload") or v58 == "Special" then
		setAnimation("Idle", false, 0);
		clearReloadFlags();
		return;
	elseif v58 == "Rechamber" then
		onRechamberGun();
		setAnimation("Idle", false, 0);
		return;
	elseif v26 then
		if not v27 then
			setAnimation("Idle", false, 0);
			onReloadGun();
			clearReloadFlags();
			return;
		else
			reloadLogic();
			return;
		end;
	elseif not v57.Looped and (not (v58 ~= "Run") or v58 == "Idle") then
		IsCurrentAnimationFinished = false;
		v57.TimePosition = 0;
		v57:Play();
		return;
	else
		setAnimation("Idle", false, 0.2);
		return;
	end;
end;
isBaseAnimation = function(v115)
	return not v115 or v115 == "Run" or v115 == "Idle";
end;
local v116 = true;
setAnimation = function(v117, v118, v119, v120, v121)
	--warn(v117, v118, v119, v120, v121)
	v119 = v119 and v119 or 0;
	v120 = v120 and v120 or 1;
	v121 = v121 and v121 or nil;
	if v117 == "Draw" then
		v32 = 75;
	end;
	local v122 = v117 ~= v58;
	local _ = isBaseAnimation(v58);
	local v124 = isBaseAnimation(v117);
	if not (v118 or v116 or not v57 or v122) then
		return;
	else
		local v125 = getAnimation(v117);
		if not v125 then
			return;
		else
			local l_Humanoid_0 = v55:FindFirstChild("Humanoid");
			if not l_Humanoid_0 then
				return;
			else
				if v122 and v57 then
					if v57.Looped then
						v57:Stop(v119);
					else
						v57:Stop(0);
					end;
				end;
				if v124 then
					v38 = false;
				end;
				local v127 = v65[v125];
				if not v127 or v127.Length == 0 then
					v127 = l_Humanoid_0:LoadAnimation(v125);
					v65[v125] = v127;
				end;
				v57 = v127;
				v58 = v117;
				v116 = false;
				v57.TimePosition = 0;
				v57:Play(v119, 1, v120);
				if v124 then
					v57.Looped = true;
				end;
				if v121 ~= nil then
					v57.Looped = v121;
				end;
				if v59 ~= nil then
					v59:Disconnect();
					v60:Disconnect();
				end;
				v59 = v57.KeyframeReached:connect(keyFrameReachedFunc);
				v60 = v57.Stopped:Connect(onAnimationFinish);
				script.Events.OnGunAnimationChange:Fire(v125, v57);
				v67 = true;
				return;
			end;
		end;
	end;
end;
keyFrameReachedFunc = function(v128)
	if v128 == "Reload" then
		onReloadGun();
	end;
	if v128 == "Rechamber" then
		onRechamberGun();
	end;
	if string.len(v128) > 0 then
		local v129 = v58 .. v128;
		playGunSound(v129);
		playGunSoundKeyframe(v128);
	end;
end;
clearReloadFlags = function()
	v49 = false;
	v27 = false;
	v38 = false;
	v26 = false;
end;
rechamberGun = function()
	v38 = true;
	setAnimation("Rechamber", true);
	playGunSound("Rechamber");
	game.ReplicatedStorage.GunEvent.GunRechamber:FireServer();
end;
onRechamberGun = function()
	v48 = false;
	v38 = false;
	v26 = false;
end;
onReloadGun = function()
	if not v26 then
		return;
	else
		local v130 = getInventoryItem(v53);
		if not v130 then
			return;
		else
			local l_Value_1 = v130.BulletsInMagazine.Value;
			local l_Value_2 = v130.BulletsInReserve.Value;
			local v133 = v52.Stats.MagazineCapacity.Value - l_Value_1;
			if v27 then
				v133 = 1;
			end;
			if l_Value_2 - v133 < 0 then
				v133 = l_Value_2;
			end;
			v130.BulletsInMagazine.Value = v130.BulletsInMagazine.Value + v133;
			if not (v130.BulletsInReserve.Value >= 1073741824) then
				v130.BulletsInReserve.Value = v130.BulletsInReserve.Value - v133;
			end;
			game.ReplicatedStorage.GunEvent.GunReload:FireServer(v27);
			return;
		end;
	end;
end;
playGunSoundKeyframe = function(v134)
	if v56 == nil then
		return;
	elseif v56:FindFirstChild("Handle") == nil then
		return;
	else
		local v135 = getAnimation(v58) and getAnimation(v58):FindFirstChild(v134);
		if v135 then
			local v136 = v135:Clone();
			v136.Parent = WorldCharacter():FindFirstChild("HumanoidRootPart");
			v136:Play();
			game.Debris:AddItem(v136, v136.TimeLength);
			if game:GetService("SoundService").RespectFilteringEnabled then
				game.ReplicatedStorage.GunEvent.GunRequestSound:FireServer(v58 .. v135.Name, true);
			end;
			return v136;
		else
			return nil;
		end;
	end;
end;
playGunSound = function(v137, _, v139, v140)
	if v56 == nil then
		return;
	elseif v56:FindFirstChild("Handle") == nil then
		return;
	else
		local v141 = nil;
		local v142 = {};
		local l_Children_1 = v56.Handle:GetChildren();
		for v144 = 1, #l_Children_1 do
			local v145 = l_Children_1[v144];
			if v145.Name == v137 then
				v142[#v142 + 1] = v145;
				if not v145.Playing then
					v141 = v145;
				end;
			end;
		end;
		if v141 == nil and #v142 > 0 then
			v141 = v142[math.random(1, #v142)];
		end;
		if v141 ~= nil then
			v139 = v139 and v139 or 1;
			v140 = v140 and v140 or 1;
			local v146 = v141:Clone();
			v146.Parent = WorldCharacter().Head;
			v146.PlaybackSpeed = v141.PlaybackSpeed * v139;
			v146.Volume = v146.Volume * v140;
			v146:Play();
			game:GetService("Debris"):AddItem(v146, v146.TimeLength);
			if game:GetService("SoundService").RespectFilteringEnabled and v137 ~= "FireSound" then
				game.ReplicatedStorage.GunEvent.GunRequestSound:FireServer(v137);
			end;
			return v146;
		else
			return playGunSoundKeyframe(v137);
		end;
	end;
end;
stopGunSound = function(v147)
	if v56 == nil then
		return;
	elseif v56:FindFirstChild("Handle") == nil then
		return;
	else
		local l_FirstChild_1 = v56.Handle:FindFirstChild(v147);
		if l_FirstChild_1 ~= nil then
			l_FirstChild_1:Stop();
		end;
		return;
	end;
end;
getPlayer = function()
	return game:GetService("Players").LocalPlayer;
end;
WorldCharacter = function()
	local v149 = getPlayer();
	if not v149 then
		return nil;
	else
		local Respond = v149.Character:WaitForChild("WorldCharacter")
		return Respond
	end;
end;

CharacterRootModel = function()
	local v149 = getPlayer();
	if not v149 then
		return nil;
	else
		local Respond = v149.Character
		return Respond
	end;
end;

getCharacterServer = function()
	local v149 = getPlayer();
	if not v149 then
		return nil;
	else
		local Respond = v149.Character
		return Respond
	end;
end;

getRoot = function()
	local v150 = WorldCharacter();
	if not v150 then
		return nil;
	else
		return v150:FindFirstChild("HumanoidRootPart");
	end;
end;
getHumanoid = function()
	local v151 = getCharacterServer();
	if not v151 then
		return nil;
	else
		return v151:WaitForChild("Humanoid", 60);
	end;
end;
isJumping = function()
	if script.DisabledGun.Value then
		return false;
	else
		local v152 = true;
		if getHumanoid():GetState() ~= Enum.HumanoidStateType.FallingDown then
			v152 = true;
			if getHumanoid():GetState() ~= Enum.HumanoidStateType.Climbing then
				v152 = true;
				if getHumanoid():GetState() ~= Enum.HumanoidStateType.Ragdoll then
					v152 = true;
					if getHumanoid():GetState() ~= Enum.HumanoidStateType.Jumping then
						v152 = getHumanoid():GetState() == Enum.HumanoidStateType.Freefall;
					end;
				end;
			end;
		end;
		return v152;
	end;
end;
getCustomCamera = function()
	return script.Parent.CustomCamera;
end;
getDirection = function()
	return getCustomCamera().CurrentDirection.Value;
end;
getCamera = function()
	return game.Workspace.CurrentCamera;
end;
getMouse = function()
	return game.Players.LocalPlayer:GetMouse();
end;
tween = function(v153, v154, v155)
	v155 = math.min(1, (math.max(0, v155)));
	return v153 + (v154 - v153) * v155;
end;
updateAiming = function(v156)
	local l_Value_3 = script.Aimed.Value;
	if not script.DisabledGun.Value then
		script.Aimed.Value = v6 and v52.Stats.Zoom.CanZoom.Value and not v33 and not v46;
	end;
	if script.Spectating.Value ~= nil then
		script.Aimed.Value = script.Spectating.Value.Aiming.Value;
	end;
	if script.Aimed.Value ~= l_Value_3 then
		v43 = true;
	end;
	local l_Value_4 = v52.Stats.Zoom.AimSpeed.Value;
	local v159 = getAttachment("AttachmentReticle");
	if v159 and v159.Modifiers:FindFirstChild("AimSpeed") then
		l_Value_4 = l_Value_4 * v159.Modifiers.AimSpeed.Value;
	end;
	local l_v5_0 = v5;
	local v161 = -1;
	if not script.Aimed.Value or v26 then
		v161 = 1;
	end;
	v5 = math.max(0, (math.min(1, l_v5_0 + l_Value_4 * v161 * v156 * 5)));
end;
footStep = function()
	local v162 = WorldCharacter();
	if v162 == nil then
		return;
	else
		local l_Sound_0 = v162:FindFirstChild("Sound");
		if l_Sound_0 == nil then
			return;
		else
			local l_LocalSound_0 = l_Sound_0:FindFirstChild("LocalSound");
			if l_LocalSound_0 == nil then
				return;
			elseif isJumping() then
				return;
			elseif l_LocalSound_0:FindFirstChild("FootStep") == nil then
				return;
			else
				l_LocalSound_0.FootStep.Value = true;
				return;
			end;
		end;
	end;
end;
onHitGround = function()
	v41 = 0.05;
end;
local v165 = 0;
local v166 = 0;
local v167 = 0;
local v168 = 0;
local v169 = 0;
local v170 = 0;
local v171 = 0;
local v172 = 0;
local v173 = Vector3.new();
positionGun = function(_)
	if v52 == nil then
		return;
	else
		local l_HumanoidRootPart_1 = WorldCharacter():FindFirstChild("HumanoidRootPart");
		if l_HumanoidRootPart_1 == nil then
			return;
		else
			local l_LowerTorso_0 = WorldCharacter():FindFirstChild("LowerTorso");
			if not l_LowerTorso_0 then
				return;
			else
				v22 = tween(v22, 0, 0.2);
				v25 = tween(v25, 0, 0.2);
				v23 = v23 - 0.2;
				v24 = v24 + v23;
				if v24 < 0 then
					v24 = 0;
					v23 = 0;
				end;
				v41 = v41 - 0.005555555555555556;
				v40 = v40 + v41;
				if not (v40 >= 0) or script.DisabledGun.Value then
					v41 = 0;
					v40 = 0;
				end;
				if v40 > 1 then
					v40 = 1;
				end;
				v167 = tween(v167, 0, 0.15);
				v168 = tween(v168, 0, 0.15);
				local v177 = tween(0.00390625, 0.020833333333333332, v5);
				v167 = v167 - math.rad(getCustomCamera().MouseDeltaX.Value) * v177;
				v168 = v168 - math.rad(getCustomCamera().MouseDeltaY.Value) * v177;
				v169 = tween(v169, v167, 0.3);
				v170 = tween(v170, v168, 0.3);
				if v33 then
					v32 = 75;
				elseif v46 then
					v32 = tween(v32, 75, 0.1);
				else
					v32 = tween(v32, 0, 0.2);
				end;
				if not (v55 ~= nil) or v55:FindFirstChild("HumanoidRootPart") == nil then
					return;
				else
					v55.HumanoidRootPart.Anchored = true;
					v55.PrimaryPart = v55.HumanoidRootPart;
					v165 = v165 + v13 * (v18 and 0 or 1);
					local v178 = math.cos(v165 / 2);
					local v179 = math.abs((math.sin(v165 / 2)));
					v14 = v178;
					v15 = v179;
					if not (not (v172 > 0.9) or v178 >= 0.9) or v172 < -0.9 and v178 > -0.9 then
						footStep();
					end;
					v172 = v178;
					v20 = tween(v20, v13, 0.1);
					local v180 = tween(0.3, 0.06, 1 - v5);
					local v181 = v180 * v20 * v31;
					v14 = v14 * v181;
					v15 = v15 * v181;
					local _ = 1 - math.pow(1 - math.abs(v15), 2);
					local v183 = (l_HumanoidRootPart_1.Position.Z - l_LowerTorso_0.Position.Z) * v180;
					local v184 = Vector3.new(v14 * 0.88, v15 * 0.7 - v183, 0);
					v166 = v166 + (v9 and 0.1 or 1);
					local v185 = v39 and 4.5 or 1;
					v16 = math.cos(v166 / 240 * v185);
					v17 = math.cos(v166 / 120 * v185);
					v184 = v184 + Vector3.new(v16 * v180 * 0.05, v17 * v180 * 0.05, 0);
					local v186 = Vector3.new(-v14 * 0.7 + v16 * v180 * 0.2, -v15 * 0.7 + v17 * v180 * 0.2, 0);
					if not script.DisabledGun.Value then
						local _ = v186.X * 0.1;
						local _ = v186.Y * 0.1;
					end;
					if not v36 and not getHumanoid().Sit then
						getCustomCamera().BobOffset.Value = Vector3.new(v14 * 3, v15 * 3, 0);
					else
						v14 = 0;
						v15 = 0;
						v184 = Vector3.new();
						getCustomCamera().BobOffset.Value = Vector3.new();
					end;
					local l_Value_5 = getCustomCamera().Center.Value;
					if not (not v36 and not v39 and not getPlayer():WaitForChild("GunDrawDisabled").Value and not v69) or v32 > 40 then
						l_Value_5 = l_Value_5 - getCustomCamera().CurrentDirection.Value * 32;
					end;
					l_Value_5 = l_Value_5 + Vector3.new(0, -v40, 0);
					local v190 = CFrame.new(l_Value_5) * CFrame.fromEulerAnglesYXZ(getCustomCamera().CameraPitch.Value + getCustomCamera().CameraPitch.Offset.Value - math.rad(v32), getCustomCamera().CameraYaw.Value + getCustomCamera().CameraYaw.Offset.Value, 0) * CFrame.new(getCustomCamera().BobOffset.Value);
					v55.HumanoidRootPart.CFrame = v190;
					local l_Value_6 = v52.Stats.Offset.Value;
					local v192 = CFrame.new(l_Value_6 * Vector3.new(v5, v5, v5));
					local l_Value_7 = v52.Stats.Offset.ZoomOffset.Value;
					local v194 = 1;
					local v195 = getAttachment("AttachmentReticle");
					if v195 and v195.Modifiers:FindFirstChild("ZoomOffset") then
						l_Value_7 = v195.Modifiers.ZoomOffset.Value;
					end;
					if v195 and v195.Modifiers:FindFirstChild("IdleMultiplier") then
						v194 = tween(1, v195.Modifiers.IdleMultiplier.Value, 1 - v5);
					end;
					v192 = (v192 + Vector3.new(0, 0, -l_Value_7 * (1 - v5)) + Vector3.new(0, 0, v22 / 24 * tween(0.4, 1, v5))) * CFrame.fromEulerAnglesXYZ(-v15 * 0.25 + v22 / 600, -v14 * 0.125, 0) * CFrame.new(v184 * v194) * CFrame.fromEulerAnglesYXZ(v170, v169, 0);
					v55.HumanoidRootPart.CFrame = v55.HumanoidRootPart.CFrame * v192 * v61;
					local v196 = CFrame.new();
					for _, v198 in pairs(v55:GetChildren()) do
						if v198.Name == "AttachmentWorldData" then
							local l_AttachmentCamera_0 = v198:FindFirstChild("AttachmentCamera");
							if l_AttachmentCamera_0 and v55.Weapon:FindFirstChild("CAMERA") then
								local l_CFrame_1 = v55.Weapon.CAMERA.CFrame;
								v196 = CFrame.new(l_AttachmentCamera_0.CFrame.Position):toObjectSpace(l_CFrame_1);
							end;
						end;
					end;
					local v201 = CFrame.new(v196.Position * Vector3.new(1 - v5, 1 - v5, 1 - v5));
					v55.HumanoidRootPart.CFrame = v201 * v55.HumanoidRootPart.CFrame;
					if v21 then
						local l_CameraBone_0 = v55:FindFirstChild("CameraBone");
						local l_HumanoidRootPart_2 = v55:FindFirstChild("HumanoidRootPart");
						if l_CameraBone_0 and l_HumanoidRootPart_2 then
							local v204 = l_CameraBone_0.CFrame:toObjectSpace(l_HumanoidRootPart_2.CFrame):toObjectSpace(v21);
							getCustomCamera().CameraOffsetMatrix.Value = v204;
						elseif not l_HumanoidRootPart_2 then
							takeoutWeapon(v53, true);
						end;
					else
						getCustomCamera().CameraOffsetMatrix.Value = CFrame.new();
					end;
					local v205 = 128 / v52.Stats.Accuracy.Value + getSpeed() / v52.Stats.Accuracy.RunModifier.Value * 24;
					if v29 then
						v205 = v205 / v52.Stats.Accuracy.CrouchModifier.Value;
					end;
					v205 = tween(v205 / v52.Stats.Accuracy.AimModifier.Value, v205, v5 * v5) + v22;
					v171 = tween(v171, v205, 0.1);
					local v206 = false;
					if v5 < 0.02 then
						v206 = isScoped();
					end;
					v39 = v206;
					if v62 ~= nil then
						v206 = v171 * 3;
						local l_Center_0 = v62.Center;
						local v208 = true;
						if v5 <= 0.1 then
							v208 = v36 and not v39;
						end;
						l_Center_0.Visible = v208;
						v62.Scope.Visible = true;
						v62.Scope.Position = UDim2.new(0.5, 0, 0.5, _G.IS_PLAYING_CONSOLE() and 0 or -18);
						l_Center_0 = v50 + getCustomCamera().CurrentDirection.Value * 1024;
						v208 = Ray.new(v50, l_Center_0 - v50);
						local v209 = nil;
						local v210 = nil;
						local v211 = nil;
						if workspace:FindFirstChild("world_assets") then
							local l_workspace_PartOnRayWithWhitelist_0, v213, v214 = workspace:FindPartOnRayWithWhitelist(v208, {
								workspace.Terrain, 
								workspace:FindFirstChild("world_assets"):FindFirstChild("StaticObjects")
							});
							v209 = l_workspace_PartOnRayWithWhitelist_0;
							v210 = v213;
							v211 = v214;
						else
							local l_workspace_PartOnRayWithIgnoreList_0, v216, v217 = workspace:FindPartOnRayWithIgnoreList(v208, {
								workspace.Terrain, 
								WorldCharacter(), 
								getCamera(), 
								game.Workspace:FindFirstChild("IgnoreList")
							});
							v209 = l_workspace_PartOnRayWithIgnoreList_0;
							v210 = v216;
							v211 = v217;
						end;
						local v218 = getCamera():WorldToScreenPoint(v210);
						local v219 = getCamera():WorldToScreenPoint(l_Center_0);
						v51 = v210;
						v173 = tween(v173, v218, 0.4);
						v62.ReticleOffset.Position = UDim2.new(0, v173.X, 0, v173.Y);
						v62.Center.Position = UDim2.new(0, v219.X - 1, 0, v219.Y);
						local v220 = tween((1 - v5) * 4, 12, Vector2.new(v173.X - v219.X, v173.Y - v219.Y).Magnitude / 32);
						v62.ReticleOffset.Size = UDim2.new(0, v220, 0, v220);
						v62.ReticleOffset.ImageTransparency = (v36 and 0 or 1) * (1 - v5);
						local v221 = isScoped() and math.max(0, (math.min(1, (v5 - 0.001) * 5))) or 1;
						--warn("isScoped",v221)
						v62.Scope.ImageTransparency = v221;
						v62.Scope.Frame1.BackgroundTransparency = v221;
						v62.Scope.Frame2.BackgroundTransparency = v221;
						v62.Scope.Frame3.BackgroundTransparency = v221;
						v62.Scope.Frame4.BackgroundTransparency = v221;
						v62.Scope.Blur.ImageTransparency = v221;
						local l_Center_1 = v62:FindFirstChild("Center");
						if l_Center_1 ~= nil then
							l_Center_1.Crosshairs.BottomHair.Position = UDim2.new(0.5, 0, 0.5, v206);
							l_Center_1.Crosshairs.TopHair.Position = UDim2.new(0.5, 0, 0.5, -(v206 - 1));
							l_Center_1.Crosshairs.LeftHair.Position = UDim2.new(0.5, -(v206 - 1), 0.5, 0);
							l_Center_1.Crosshairs.RightHair.Position = UDim2.new(0.5, v206, 0.5, 0);
						end;
					end;
					return;
				end;
			end;
		end;
	end;
end;
getAttachment = function(v223)
	local v224 = getInventoryItem(v53);
	if not v224 then
		return;
	else
		local l_v224_FirstChild_0 = v224:FindFirstChild(v223);
		if not l_v224_FirstChild_0 then
			return;
		else
			return l_v224_FirstChild_0.Value;
		end;
	end;
end;
getAttachments = function()
	local v226 = getInventoryItem(v53);
	if not v226 then
		return {};
	else
		local v227 = {};
		for _, v229 in pairs(v226:GetChildren()) do
			if v229:IsA("ObjectValue") and v229.Value and string.find(v229.Name, "Attachment") then
				v227[#v227 + 1] = v229.Value;
			end;
		end;
		return v227;
	end;
end;
enable = function()
	if script:FindFirstChild("IsEnabled").Value then
		return;
	else
		script:FindFirstChild("IsEnabled").Value = true;
		return;
	end;
end;
disable = function()
	if not script:FindFirstChild("IsEnabled").Value then
		return;
	else
		script:FindFirstChild("IsEnabled").Value = false;
		return;
	end;
end;
reloadLogic = function()
	local v230 = getInventoryItem(v53);
	if not v230 then
		return;
	elseif v230.BulletsInReserve.Value > 0 and v230.BulletsInMagazine.Value < v52.Stats.MagazineCapacity.Value and not v49 then
		if v52.Stats.NeedsAmmo:FindFirstChild("RequiresManualRechamber") and v52.Stats.NeedsAmmo.RequiresManualRechamber.Value and v230.BulletsInMagazine.Value == 0 then
			v48 = true;
		end;
		local l_ReloadSingularBullet_0 = v52.Stats.NeedsAmmo:FindFirstChild("ReloadSingularBullet");
		if not l_ReloadSingularBullet_0 or not l_ReloadSingularBullet_0.Value then
			if v230.BulletsInMagazine.Value == 0 and v52.Animations:FindFirstChild("ReloadEmpty") ~= nil then
				setAnimation("ReloadEmpty", false, 0, 1);
				playGunSound("ReloadEmptySound", false, 1);
			else
				setAnimation("Reload", false, 0, 1);
				playGunSound("ReloadSound", false, 1);
			end;
			if not string.find(v58, "Reload") then
				v26 = true;
				onReloadGun();
				setAnimation("Idle");
				v26 = false;
				clearReloadFlags();
				return false;
			end;
		else
			v27 = true;
			if v26 then
				setAnimation("ReloadLoop", true, 0.1, 1);
				v57.Looped = false;
				playGunSound("ReloadLoop", false, 1);
			else
				setAnimation("ReloadStart", false, 0.1, 1);
				playGunSound("ReloadStart", false, 1);
			end;
		end;
		return true;
	else
		if v27 then
			v57:Stop();
			setAnimation("ReloadEnd", true, 0.1, 1);
			playGunSound("ReloadEnd", false, 1);
		end;
		clearReloadFlags();
		return false;
	end;
end;
reload = function()
	if not v26 and v52 ~= nil then

		if ConfigurationClient.cl_reload_cancel_running.Value then--script.Configuration.CanRunWhileReloading.CancelRunOnReload.Value
			v30 = false;
		end;
		v27 = false;
		if reloadLogic() then
			v26 = true;
		end;
	end;
end;
doReloadCancel = function()
	if not v26 then
		return;
	else
		v26 = false;
		v27 = false;
		stopGunSound("ReloadSound");
		setAnimation("Idle", true);
		return;
	end;
end;
onClickDown = function(v232)
	if getViewableCharacter() ~= WorldCharacter() then
		return;
	elseif script.DisabledGun.Value then
		return;
	elseif getCustomCamera().ForceFreeMouse.Value then
		return;
	else
		if v232 == 0 then
			v7 = true;
		end;
		if v232 == 1 then
			v6 = true;
		end;
		return;
	end;
end;
onClickUp = function(v233)
	if getViewableCharacter() ~= WorldCharacter() then
		return;
	elseif script.DisabledGun.Value then
		return;
	else
		local v234 = getInventoryItem(v53);
		if not v234 then
			return;
		else
			if v233 == 0 then
				v7 = false;
				local l_Value_8 = ConfigurationClient.cl_auto_reload.Value;  --script.Configuration.AutoReload.Value;
				if v52 ~= nil and v234.BulletsInMagazine.Value == 0 and l_Value_8 then
					reload();
				end;
			end;
			if v233 == 1 then
				v6 = false;
			end;
			return;
		end;
	end;
end;
onKeyPress = function(v236, v237)
	if getViewableCharacter() ~= WorldCharacter() then
		return;
	elseif script.DisabledGun.Value then
		return;
	elseif not v236 then
		return;
	else
		local l_KeyCode_0 = v236.KeyCode;
		if getPlayer().PlayerGui:FindFirstChild("PauseGui") ~= nil then
			return;
		elseif getCustomCamera().ForceFreeMouse.Value then
			return;
		elseif l_KeyCode_0 == Enum.KeyCode.Unknown then
			return;
		else
			local v239 = nil and true or false;
			if script:FindFirstChild("IsEnabled").Value and l_KeyCode_0 == Enum.KeyCode.LeftShift and not v239 then
				if v52 ~= nil then
					local v240 = isScoped();
					if not (not v240 or v6) or not v240 then
						v6 = false;
						v29 = false;
					end;
				end;
				v9 = true;
				v30 = true;
				script.Events.OnPlayerRequestSprinting:Fire();
				warn("Sprinting")
			
				if v30 and 	ConfigurationClient.cl_reload_cancel_on_run.Value then --script.Configuration.CanRunWhileReloading.CancelReloadOnRun.Value
					doReloadCancel();
				end;
				
			end;
			if not v237 then
				if l_KeyCode_0 == Enum.KeyCode.P then
					enable();
				end;
				if l_KeyCode_0 == Enum.KeyCode.L and ConfigurationServer.sv_gun_can_disable .value then --script.Configuration.UserCanDisable.Value
					disable();
				end;
				if l_KeyCode_0 == Enum.KeyCode.V and ConfigurationServer.sv_thirdperson_enabled.Value  and script:FindFirstChild("IsEnabled").Value then --script.Configuration.AllowThirdPerson.Value
					v36 = not v36;
				end;
				if script:FindFirstChild("IsEnabled").Value and not v239 then
					if l_KeyCode_0 == Enum.KeyCode.LeftControl then
						v29 = true;
					end;
					if l_KeyCode_0 == Enum.KeyCode.C then
						v29 = not v29;
						warn("C")
					end;
					if l_KeyCode_0 == Enum.KeyCode.R then
						reload();
					end;
				end;
			end;
			if l_KeyCode_0 == Enum.KeyCode.W then
				v8 = true;
			end;
			return;
		end;
	end;
end;
onKeyRelease = function(v241, v242)
	if getViewableCharacter() ~= WorldCharacter() then
		return;
	--elseif l_LocalPlayer_0.Spectator.Spectating.Value then
	--	return false;
	elseif script.DisabledGun.Value then
		return;
	else
		if v241.KeyCode == Enum.KeyCode.Space then
			v10 = true;
		end;
		local l_KeyCode_1 = v241.KeyCode;
		if l_KeyCode_1 == Enum.KeyCode.W then
			v8 = false;
		end;
		if v242 then
			return;
		elseif l_KeyCode_1 == Enum.KeyCode.Unknown then
			return;
		else
			if l_KeyCode_1 == Enum.KeyCode.LeftShift then
				v9 = false;
			end;
			if l_KeyCode_1 == Enum.KeyCode.LeftControl then
				v29 = false;
			end;
			return;
		end;
	end;
end;
onDeath = function()
	script.Died.Value = true;
	v39 = false;
	v5 = 1;
	getCustomCamera().CameraOffset.Value = 0;
	getCustomCamera().CameraPitch.Value = 0;
	destroyWeapons();
	pcall(function()
		if v62 ~= nil then
			v62.Scope.Visible = false;
		end;
	end);
end;
local v244 = nil;
onRespawn = function()
	if not script:FindFirstChild("IsEnabled").Value then
		return;
	else
		v63 = 0;
		getHumanoid().Died:Connect(onDeath);
		getCustomCamera().CameraOffset.Value = 0;
		getCustomCamera().CameraOffset.CanZoom.Value = false;
		getCustomCamera().CameraPitch.Maximum.Value = 1.4707963267948965;
		getCustomCamera().CameraPitch.Minimum.Value = -1.4707963267948965;
		getCustomCamera().CameraPitch.Value = 0;
		getCustomCamera().CameraYaw.Offset.Value = 0;
		getCustomCamera().CameraPitch.Offset.Value = 0;
		getCustomCamera():FindFirstChild("IsEnabled").Value = true;
		if v55 then
			v55:Destroy();
		end;
		v52 = nil;
		v55 = nil;
		v53 = 1;
		v43 = true;
		v5 = 0;
		v6 = false;
		takeoutWeapon(TypSlots.Melee.Slot, true);
		v29 = false;
		getHumanoid().AutoRotate = false;
		v10 = true;
		if v244 ~= nil then
			v244:Disconnect();
		end;
		v244 = getHumanoid().Changed:connect(function(v245)
			if not (v245 ~= "Jump") or v245 == "JumpReplicate" then
				if getHumanoid().Jump then
					if v37 > 0 and v44 <= 0 or v29 or not v10 and not ConfigurationClient.cl_auto_jump.Value   then --script.Configuration.AllowAutoJump.Value
						v37 = 3;
						getHumanoid().Jump = false;
						v29 = false;
					else
						v44 = v44 - 0.5;
					end;
					if v245 == "JumpReplicate" then
						v10 = false;
						return;
					end;
				else
					v10 = false;
				end;
			end;
		end);
		if v42 ~= nil then
			v42:Disconnect();
			v42 = nil;
		end;
		v42 = getHumanoid().StateChanged:Connect(function(v246, v247)
			if v247 == Enum.HumanoidStateType.Freefall then
				v18 = true;
			end;
			if v246 == Enum.HumanoidStateType.Freefall and v247 ~= Enum.HumanoidStateType.Freefall then
				v18 = false;
				onHitGround();
			end;
		end);
		script.Events.OnRespawn:Fire(getHumanoid());
		return;
	end;
end;
canShoot = function(v248)
	if v248 == nil then
		v248 = v53;
	end;
	local v249 = getInventoryItem(v248);
	if v249 == nil then
		return false;
	elseif not script.CanShoot.Value or script.DisabledGun.Value then
		return false;
	else
		local l_Value_9 = v249.BulletsInMagazine.Value;
		if v248 == v53 then
			l_Value_9 = v249.BulletsInMagazine.Value;
		end;
		if l_Value_9 <= 0 and v249.Value.Stats.NeedsAmmo.Value then
			return false;
		elseif game.Workspace.DistributedGameTime - v28 < 0 then
			warn(v28)
			return false;
		elseif v56 == nil then
			warn(v56)
			return false;
		else
			warn(v56)
			return true;
		end;
	end;
end;
hitmarkerSound = function(v251)
	v251 = v251 or false;
	v35 = 15;
	if v251 then
		if l_LocalPlayer_0.MainStorage.HeadshotSound.Value == "Bullseye" then
			script.Data.Headshot2:Play();
			return;
		else
			script.Data.Headshot:Play();
			return;
		end;
	else
		script.Data.Hitmarker:Play();
		return;
	end;
end;
isScoped = function()
	if v52.Stats.Scoped.Value then
		return true;
	else
		local v252 = getAttachment("AttachmentReticle");
		if v252 and v252.Modifiers:FindFirstChild("Scoped") and v252.Modifiers.Scoped.Value then
			return true;
		else
			return false;
		end;
	end;
end;
getShootAnimation = function()
	if v52.Stats:FindFirstChild("Special") and v52.Stats.Special.Value and true or false then
		return "Special";
	else
		local v253 = script.Events.IsAimed:Invoke();
		local v254 = getAttachment("AttachmentReticle");
		if v253 then
			if v254 then
				local v255 = getAnimation("Shoot" .. v254.AttachmentType.Value);
				if v255 then
					return v255.Name;
				end;
			else
				local v256 = getAnimation("ShootADS");
				if v256 then
					return v256.Name;
				end;
			end;
		end;
		return "Shoot";
	end;
end;
shootGun = function()
	v30 = false;
	if v58 == "ReloadEnd" then
		return;
	elseif v27 and v38 then
		v49 = true;
		return;
	elseif v38 then
		return;
	elseif not v38 and v48 then
		if v26 then
			v49 = true;
			return;
		else
			rechamberGun();
			return;
		end;
	else
		local v257 = getInventoryItem(v53);
		if not v257 then
			return;
		elseif v257.Rechambering.Value then
			v48 = true;
			return;
		else
			local v258 = v52.Stats.RPM.Value * 1;
			v28 = game.Workspace.DistributedGameTime + 1 / (v258 / 60);
			if v52.Stats:FindFirstChild("NeedsAmmo") and v52.Stats:FindFirstChild("NeedsAmmo").Value then
				v257.BulletsInMagazine.Value = v257.BulletsInMagazine.Value - 1;
			end;
			if not v52.Stats.Auto.Value then
				v7 = false;
			end;
			local v259 = 0;
			for _, v261 in pairs(v52.Stats:GetDescendants()) do
				v259 = v259 + tote(v261);
			end;
			setAnimation(getShootAnimation(), true, 0, 1, false);
			if v52.Stats:FindFirstChild("NeedsAmmo") and v52.Stats.NeedsAmmo:FindFirstChild("RequiresManualRechamber") and v52.Stats.NeedsAmmo.RequiresManualRechamber.Value then
				v48 = true;
			end;
			local v262 = getAttachments();
			local v263 = nil;
			local v264 = true;
			for _, v266 in pairs(v262) do
				local l_ShootSound_0 = v266.Modifiers:FindFirstChild("ShootSound");
				if l_ShootSound_0 then
					v263 = l_ShootSound_0;
				end;
				local l_MuzzleFlash_0 = v266.Modifiers:FindFirstChild("MuzzleFlash");
				if l_MuzzleFlash_0 and not l_MuzzleFlash_0.Value then
					v264 = false;
				end;
			end;
			if not v263 then
				playGunSound("FireSound", false, 1);
			else
				local v269 = v263:Clone();
				v269.Parent = WorldCharacter().Head;
				v269:Play();
				game:GetService("Debris"):AddItem(v269, v269.TimeLength);
				playGunSound("FireSound", false, 1, 0.1);
			end;
			v22 = v52.Stats.Recoil.Value * 20;
			v23 = v52.Stats.Recoil.Value * tween(0.9, 1.1, math.random());
			v25 = v25 + (math.random() - math.random()) * (v52.Stats.Recoil.Value * 0.33);
			if v55:FindFirstChild("Weapon") and v264 then
				_G.muzzleFlash(getPlayer(), (v36 and v56 or v55.Weapon):FindFirstChild("Main"), true);
			end;
			local l_Value_10 = v52.Stats.Pellets.Value;
			local l_Value_11 = v52.Stats.Accuracy.Value;
			if v29 then
				l_Value_11 = l_Value_11 * v52.Stats.Accuracy.CrouchModifier.Value;
			end;
			if v12 > 0.1 then
				l_Value_11 = l_Value_11 * v52.Stats.Accuracy.RunModifier.Value;
			end;
			if isJumping() then
				local l_JumpModifier_0 = v52.Stats.Accuracy:FindFirstChild("JumpModifier");
				l_Value_11 = if l_JumpModifier_0 ~= nil then l_Value_11 * l_JumpModifier_0.Value else l_Value_11 * 0.25;
			end;
			local v273 = 1 - math.pow(1 - v5, 14);
			l_Value_11 = l_Value_11 * tween(v52.Stats.Accuracy.AimModifier.Value, 1, v273);
			local v274 = if v5 > 0.7 then v52.Stats:FindFirstChild("Special") and v52.Stats.Special.Value and true or false else v52.Stats:FindFirstChild("Special") and v52.Stats.Special.Value and true or false;
			if v52.Stats:FindFirstChild("Melee") and v52.Stats:FindFirstChild("Melee").Value then
				local l_BindableEvent_0 = Instance.new("BindableEvent");
				l_BindableEvent_0.Event:Connect(function()
					wait(0.1);
					local v276, v277, v278, v279, v280, v281 = require(game.ReplicatedStorage.Library:WaitForChild("MeleeModule")):TestMelee(game.Players.LocalPlayer, v52);
					if v277 then
						game.ReplicatedStorage.GunEvent.GunMelee:FireServer(v276, v277, v278, v279, v280, v281);
					end;
				end);
				l_BindableEvent_0:Fire();
				l_BindableEvent_0:Destroy();
				return;
			else
				local l_v66_0 = v66;
				v66 = v66 + 1;
				game.ReplicatedStorage.GunEvent.GunFire:FireServer(l_v66_0, v50, getCustomCamera().CurrentDirection.Value, l_Value_11, v53, v52, v52.Stats.RPM.Value, not v36, v259);
				if not (v52.Stats.BulletSettings:FindFirstChild("ServerSided") and v52.Stats.BulletSettings:FindFirstChild("ServerSided").Value) and not v274 then
					local v283 = Random.new(l_v66_0);
					for _ = 1, l_Value_10 do
						local l_Value_12 = v52.Stats.BulletSettings.MaxDistance.Value;
						local v286 = (v283:NextNumber() - v283:NextNumber()) / l_Value_11;
						local v287 = (v283:NextNumber() - v283:NextNumber()) / l_Value_11;
						local v288 = (v283:NextNumber() - v283:NextNumber()) / l_Value_11;
						local v289 = getDirection() + Vector3.new(v286, v287, v288);
						local l_v50_0 = v50;
						local v291 = v289 * l_Value_12;
						local v292 = require(game.ReplicatedStorage.Library.BulletModule);
						local l_BindableEvent_1 = Instance.new("BindableEvent");
						l_BindableEvent_1.Event:Connect(function()
							local _, _, v296, v297, v298, v299 = v292:BulletSimulation(getPlayer(), l_v50_0, v289, v52, false);
							local v300 = v296 and v296.Position or nil;
							game.ReplicatedStorage.GunEvent.BulletHole:FireServer(l_v66_0, l_v50_0 + v291, v296, v297, v298, v299, v300);
						end);
						l_BindableEvent_1:Fire();
						l_BindableEvent_1:Destroy();
					end;
				end;
				return;
			end;
		end;
	end;
end;
getViewableCharacter = function()
	local v301 = WorldCharacter();
	if script.Spectating.Value ~= nil then
		local l_Character_0 = script.Spectating.Value.Character;
		if l_Character_0 ~= nil then
			v301 = l_Character_0;
		end;
	end;
	return v301;
end;
getViewablePlayer = function()
	if script.Spectating.Value ~= nil then
		return script.Spectating.Value;
	else
		return getPlayer();
	end;
end;
local v303 = false;
onEnableChange = function()
	if script:FindFirstChild("IsEnabled").Value then
		v303 = true;
		script.DisabledGun.Value = false;
		v10 = true;
		onRespawn();
		return;
	else
		if v303 then
			if v55 ~= nil then
				v55:Destroy();
			end;
			if v56 ~= nil then
				v56:Destroy();
			end;
			if v62 then
				v62:Destroy();
				v62 = nil;
			end;
			script.CurrentWeapon.Value = nil;
			getCustomCamera():FindFirstChild("IsEnabled").Value = false;
		end;
		while getHumanoid() == nil do
			wait(0.1);
		end;
		getHumanoid().AutoRotate = true;
		v303 = false;
		return;
	end;
end;
local l_Team_0 = getPlayer().Team;
local v305 = 0;
onStep = function(v306)
	local v307 = v306 * 60;
	v19 = v19 + v307;
	v35 = v35 - v307;
	v37 = v37 - v307;
	if not v70 then
		return;
	elseif not script:FindFirstChild("IsEnabled").Value then
		return;
	elseif not (getHumanoid() ~= nil) or getHumanoid().Health <= 0 then
		return;
	else
		script.Events.OnStep:Fire(v306);
		v56 = CharacterRootModel():FindFirstChild("WorldModel");
		--warn(v56)
		v44 = math.min(1, (math.max(-1, v44 + v306 * 1.2)));
		if not getHumanoid().Sit then
			getHumanoid().JumpPower = tween(18, 25, v44 * 1.3);
		end;
		local v308 = getInventoryItem(v53);
		if v308 ~= nil and v308.Value ~= v52 then
			print("Server sided inventory is not the same!");
			takeoutWeapon(v53, true);
		elseif v308 == nil then
			takeoutWeapon(1, true);
		end;
		if tick() - v305 > 1 then
			v305 = tick();
			v63 = v63 + v307;
		end;
		if v33 or v46 then
			return;
		elseif WorldCharacter():FindFirstChild("HumanoidRootPart") == nil then
			return;
		else
			if not v62 or not v62.Parent then
				v62 = script.Data.Crosshair:Clone();
				v62.Parent = getPlayer().PlayerGui;
			else
				v62.Hitmarker.Visible = v35 > 0;
				v62.Enabled = script:FindFirstChild("IsEnabled").Value;
			end;
			if v43 or tick() - v64 > 0.1 then
				v64 = tick();
				v43 = false;
				game.ReplicatedStorage.GunEvent.ClientUpdate:FireServer(v53, script.Aimed.Value, v30, getHumanoid().JumpPower, getCamera().CFrame, v70 ~= nil, v72.Temp1 == v72.Temp2);
				if getHumanoid().JumpPower > 30 then
					getHumanoid().JumpPower = 30;
				end;
			end;
			if getPlayer().Team ~= l_Team_0 then
				l_Team_0 = getPlayer().Team;
				if game.Teams:FindFirstChild("Spectator") and l_Team_0 == game.Teams.Spectator then
					script:FindFirstChild("IsEnabled").Value = false;
					script:FindFirstChild("IsEnabled").Value = true;
					return;
				elseif v52 ~= nil and v52:FindFirstChild("ViewModel") ~= nil then
					takeoutWeapon(v53);
				else
					takeoutWeapon(1);
				end;
			end;
			if not (v52 ~= nil) or #v52:GetChildren() == 0 then
				return;
			else
				if v7 then
					warn("Request/Shoot")
					if canShoot() then
						warn("Request/Shoot/true")
						if not v26 or v26 and v27 then
							if v52.Stats:FindFirstChild("Burst") and v52.Stats.Burst.Value == true then
								shootGun();
								wait(0.1);
								shootGun();
								wait(0.1);
								shootGun();
								wait(0.1);
							else
								shootGun();
							end;
						end;
					else
						local v309 = getInventoryItem(v53);
						if not v309 then
							return;
						elseif v309.BulletsInMagazine.Value == 0 and v56 ~= nil and v52.Stats.NeedsAmmo.Value then
							playGunSound("DrySound");
							v7 = false;
						end;
					end;
					script.Events.OnPlayerRequestShoot:Fire()
				end;
				if (not (not v29 and v8) or v39) and not isJumping() then
					v30 = false;
					--v9 = false
					--game.Players.LocalPlayer.CharData.RunState.Value = v30;
				end;
				v31 = 1;
				local _ = v30;
				local v311 = not ConfigurationClient.cl_reload_can_run.Value  and v26; --script.Configuration.CanRunWhileReloading.Value
				if v30 and not v311 and not script.Aimed.Value and v32 < 1 then
					--game.Players.LocalPlayer.CharData.RunState.Value = v30;
					v31 = v31 * ConfigurationClient.BaseWalkSpeed.SprintModifier.Value; --script.Configuration.BaseWalkSpeed.SprintModifier.Value
					--if v9 then
					--	game.Players.LocalPlayer.CharData.RunState.Value = true;
					--else
					--	game.Players.LocalPlayer.CharData.RunState.Value = false;
					--end
				end;
				if game.Players.LocalPlayer:WaitForChild("Crouched") then
					game.Players.LocalPlayer.Crouched.Value = v29;
					if v29 then
						v31 = v31 * ConfigurationClient.BaseWalkSpeed.CrouchModifier.Value; --script.Configuration.BaseWalkSpeed.CrouchModifier.Value
					end;
				end;
				local v312 = 1;
				if v52 ~= nil and v52.Stats:FindFirstChild("SpeedMultiplier") ~= nil then
					v312 = v52.Stats.SpeedMultiplier.Value;
				end;
				local v313 = getHumanoid();
				if v313 ~= nil then
					local l_CanMove_0 = v313:FindFirstChild("CanMove");
					if not (not (l_CanMove_0 ~= nil) or not l_CanMove_0.Value) or l_CanMove_0 == nil then
						local v315 = tween(0.5, 1, v44 + 1);
						local l_Value_13 = ConfigurationClient.BaseWalkSpeed.Value; --script.Configuration.BaseWalkSpeed.Value;
						local l_Value_14 = ConfigurationClient.BaseWalkSpeed.AimModifier.Value; --script.Configuration.BaseWalkSpeed.AimModifier.Value;
						v313.WalkSpeed = l_Value_13 * tween(1, l_Value_14, (1 - v5) * (v18 and 0 or 1)) * v31 * v315 * v312;
						
					end;
				end;
				local l_Animate_0 = WorldCharacter():FindFirstChild("Animate");
				if l_Animate_0 and l_Animate_0:FindFirstChild("Pitch") and l_Animate_0:FindFirstChild("Yaw") and l_Animate_0:FindFirstChild("GunType") then
					l_Animate_0.Pitch.Value = math.deg((getCustomCamera().GetPitch:Invoke()));
					l_Animate_0.Yaw.Value = math.deg((getCustomCamera().GetYaw:Invoke()));
					l_Animate_0.GunType.Value = v52.Stats.HoldAnimation.Value;
					if script.Aimed.Value then
						l_Animate_0.GunType.Value = l_Animate_0.GunType.Value .. "Aim";
					end;
				end;
				if not v56 or not v56.Parent then
					v56 = CharacterRootModel:FindFirstChild("WorldModel");
				end;
				if v32 < 40 and v67 then
					v67 = false;
					local v319 = playGunSound("Initial");
					if v319 then
						v319.Parent = v55.HumanoidRootPart;
					end;
				end;
				return;
			end;
		end;
	end;
end;
local v320 = 0;
getSpeed = function()
	return (math.max(v12, v320));
end;
setLocalTransparencyRecursive = function(v321, v322)
	if v321 == nil then
		return;
	else
		if v321:IsA("BasePart") then
			v321.LocalTransparencyModifier = v322;
		end;
		local l_v321_Children_0 = v321:GetChildren();
		for v324 = 1, #l_v321_Children_0 do
			local v325 = l_v321_Children_0[v324];
			setLocalTransparencyRecursive(v325, v322);
		end;
		return;
	end;
end;



local v326 = 0;
local v327 = 0;
local v328 = nil;
local v329 = nil;
onSpectateChange = function(v330)
	if v328 ~= nil then
		v328:Disconnect();
	end;
	if v329 ~= nil then
		v329:Disconnect();
	end;
	if v330 == getPlayer() then
		return;
	else
		v328 = v330.CurrentSelected.Changed:Connect(function(v331)
			takeoutWeapon(v331, true);
		end);
		v329 = v330.Character.ChildAdded:Connect(function(v332)
			setLocalTransparencyRecursive(v332, 0);
		end);
		return;
	end;
end;
onUpdate1 = function(_)
	v70 = workspace.CurrentCamera.CFrame;
end;
onUpdate2 = function(_)
	v71 = workspace.CurrentCamera.CFrame;
	v72.Temp1 = v70;
	v72.Temp2 = v71;
end;
onRender = function(v335)
	if not script:FindFirstChild("IsEnabled").Value then
		return;
	elseif not (WorldCharacter():FindFirstChild("HumanoidRootPart") ~= nil and getHumanoid() ~= nil) or getHumanoid().Health <= 0 then
		return;
	elseif not (v52 ~= nil) or #v52:GetChildren() == 0 then
		return;
	else
		script.Events.OnRender:Fire(v335);
		local l_Value_15 = v52.Stats.Zoom.SensitivityMultiplier.Value;
		local v337 = getAttachment("AttachmentReticle");
		if v337 and v337.Modifiers:FindFirstChild("SensitivityMultiplier") then
			l_Value_15 = l_Value_15 * v337.Modifiers.SensitivityMultiplier.Value;
		end;
		
		CameraControllerService.Enable(true)
		
		getCustomCamera():FindFirstChild("IsEnabled").Value = true;
		getCustomCamera().MouseLookEnabled.Value = true;
		local v338 = tween(ConfigurationClient.cl_sensitivity_aim_multiplier.Value * l_Value_15, 1, v5);  --tween(script.Configuration.AimedSensitivityMultiplier.Value * l_Value_15, 1, v5);
		getCustomCamera().Sensitivity.Value = ConfigurationClient.cl_sensitivity.Value / v338;  --etCustomCamera().Sensitivity.Value = script.Configuration.Sensitivity.Value / v338;
		local v339 = getViewableCharacter();
		if v339:FindFirstChild("Head") ~= nil then
			local v340 = false;
			if getCustomCamera().CameraOffset.Value < 1 then
				v340 = (getCustomCamera().CurrentPosition.Value - v339.Head.Position).magnitude < 8;
			end;
			v45 = v340;
			if v339 ~= v47 then
				onSpectateChange(getViewablePlayer());
			end;
			if v45 then
				setLocalTransparencyRecursive(getViewableCharacter(), 1);
			else
				setLocalTransparencyRecursive(getViewableCharacter(), 0);
			end;
		end;
		--warn(v30)
		local l_v30_1 = v30;
		
		if script.Spectating.Value ~= nil then
			l_v30_1 = script.Spectating.Value.Running.Value;
		end;
		if script.DisabledGun.Value and l_v30_1 then
			v12 = 0.32;
		end;
		local v342 = nil;
		if l_v30_1 and not v26 and not v38 and not script.Aimed.Value and not isJumping() and v32 < 1 and getSpeed() > 0.25 then
			v342 = true;
			--warn("true")
		end;
		if v58 == "Run" and (not (l_v30_1 and not script.Aimed.Value and not isJumping()) or getSpeed() <= 0.02) then
			v342 = false;
		end;
		if not isBaseAnimation(v58) then
			v342 = nil;
		end;
		if v342 ~= nil then
			--warn(v342)
			setAnimation(v342 and "Run" or "Idle", false, 0.2);
		end;
		updateAiming(v335);
		if v52 ~= nil and v52:FindFirstChild("Stats") ~= nil and getHumanoid().Health > 0 then
			local l_Value_16 = ConfigurationServer.sv_height_normal.Value;  -- script.Configuration.HeightStandOffset.Value;
			local l_Value_17 = ConfigurationServer.sv_height_crouch.Value; -- script.Configuration.HeightCroughOffset.Value
			local v345 = v29 and l_Value_17 or l_Value_16;
			if v34 == -1 then
				v34 = v345;
			end;
			v34 = tween(v34, v345, 0.15);
			local v346 = 0;
			local v347 = getHumanoid().Sit and 12 or 10;
			if v36 then
				v346 = if isScoped() then tween(0, v347, v5) else v347;
			end;
			--warn("CameraOffset",v346)
			getCustomCamera().CameraOffset.Value = v346;
			getCustomCamera().CameraPitch.Offset.Value = 0;
			local v348 = getViewableCharacter();
			if not script.DisabledGun.Value then
				local l_HumanoidRootPart_3 = v348:FindFirstChild("HumanoidRootPart");
				if l_HumanoidRootPart_3 ~= nil then
					v50 = l_HumanoidRootPart_3.Position + Vector3.new(0, v34 - v40 * 2, 0);
				end;
				if not v36 then
					getCustomCamera().Center.Value = v50;
				else
					local v350 = tween(0.75, 1, v5);
					if isScoped() then
						v350 = tween(0, 1, v5);
					end;
					v350 = v350 * 1.5;
					local v351 = -getCustomCamera().CameraYaw.Value;
					getCustomCamera().Center.Value = v50 + Vector3.new(math.cos(v351) * v350, v350 * 0.7, math.sin(v351) * v350);
				end;
				local v352 = _G.IS_PLAYING_CONSOLE() and 0.5 or 1;
				getCustomCamera().CameraPitch.Value = getCustomCamera().CameraPitch.Value + math.rad(v23 * v352 * tween(v5, 1, 0.75));
				getCustomCamera().CameraYaw.Value = getCustomCamera().CameraYaw.Value + math.rad(v25 * v352 * tween(v5, 1, 0.4));
			end;
			local v353 = 1 - math.pow(1 - v5, 2.5);
			local l_Value_18 = v52.Stats.Zoom.Value;
			local v355 = getAttachment("AttachmentReticle");
			if v355 and v355.Modifiers:FindFirstChild("FOV") then
				l_Value_18 = v355.Modifiers:FindFirstChild("FOV").Value;
			end;
			local v356 = 1;
			if v355 and v355.Modifiers:FindFirstChild("FOVMultiplier") then
				v356 = getInventoryItem(v53).AttachmentReticle.Value.Modifiers.FOVMultiplier.Value;
			end;
			getCustomCamera().CameraFOV.Value = tween(l_Value_18 * v356, 65, v353);
			v320 = v12;
			v12 = (getCustomCamera().Center.Value - v11).Magnitude;
			local v357 = getCustomCamera().Center.Value - v11;
			v13 = (v357 - Vector3.new(0, v357.Y, 0)).Magnitude;
			v11 = getCustomCamera().Center.Value;
			if v348 == WorldCharacter() then
				if not getHumanoid().Sit and script.RotateCharacter.Value then
					local v358 = CFrame.fromEulerAnglesXYZ(0, getCustomCamera().CameraYaw.Value, 0);
					WorldCharacter().HumanoidRootPart.CFrame = CFrame.new(WorldCharacter().HumanoidRootPart.CFrame.p) * v358;
				end;
				v47 = nil;
			else
				local v359 = getCustomCamera();
				local l_Value_19 = getViewablePlayer().CameraYaw.Value;
				local l_Value_20 = getViewablePlayer().CameraPitch.Value;
				v326 = v326 + (l_Value_19 - v326) * 0.4;
				v327 = v327 + (l_Value_20 - v327) * 0.4;
				v359.CameraYaw.Value = v326;
				v359.CameraPitch.Value = v327;
				v359.CameraYaw.Offset.Value = 0;
				v359.CameraPitch.Offset.Value = 0;
				v47 = v348;
			end;
		end;
		positionGun(compatabilityTickrate);
		return;
	end;
end;
onStart = function()
	print("Starting Gun System");
	--CameraControllerService.CreateCameraController(l_LocalPlayer_0,"MainCamera")
	game.ReplicatedStorage:WaitForChild("GunData", 600);
	getPlayer().CharacterAdded:connect(function(v362)
		local _ = v362:WaitForChild("Humanoid", 1);
		onRespawn();
		if getHumanoid():FindFirstChild("CanMove") == nil then
			local l_BoolValue_0 = Instance.new("BoolValue");
			l_BoolValue_0.Value = true;
			l_BoolValue_0.Name = "CanMove";
			l_BoolValue_0.Parent = getHumanoid();
		end;
	end);
	script:FindFirstChild("IsEnabled").Changed:connect(onEnableChange);
	onEnableChange();
	if ConfigurationServer.sv_enable_on_join.Value then
		script:FindFirstChild("IsEnabled").Value = true;
	end;
	game:GetService("UserInputService").InputBegan:Connect(function(v365, _)
		if l_UserInputService_0.MouseBehavior ~= Enum.MouseBehavior.LockCenter then
			return;
		else
			if v365.UserInputType == Enum.UserInputType.MouseButton1 then
				onClickDown(0);
			end;
			if v365.UserInputType == Enum.UserInputType.MouseButton2 then
				onClickDown(1);
			end;
			return;
		end;
	end);
	game:GetService("UserInputService").InputEnded:Connect(function(v367, _)
		if v367.UserInputType == Enum.UserInputType.MouseButton1 then
			onClickUp(0);
		end;
		if v367.UserInputType == Enum.UserInputType.MouseButton2 then
			onClickUp(1);
		end;
	end);
	l_UserInputService_0.InputBegan:connect(onKeyPress);
	l_UserInputService_0.InputEnded:connect(onKeyRelease);
	game:GetService("RunService"):BindToRenderStep("GunRendering2", Enum.RenderPriority.Camera.Value, onUpdate1);
	game:GetService("RunService"):BindToRenderStep("GunRendering3", Enum.RenderPriority.Camera.Value + 1e999, onUpdate2);
	game:GetService("RunService"):BindToRenderStep("GunRendering1", Enum.RenderPriority.Camera.Value - 1024, onRender);
	game:GetService("RunService").Heartbeat:Connect(onStep);
	while not WorldCharacter() do
		wait();
	end;
	wait(0.5);
	v73 = true;
	print("Gun System started");
end;
onStart();
script.Events.IsActive.OnInvoke = function()
	if getViewableCharacter() ~= WorldCharacter() then
		return false;
	--elseif l_LocalPlayer_0.Spectator.Spectating.Value then
	--	return false;
	elseif script:FindFirstChild("DisabledGun") ~= nil and script.DisabledGun.Value then
		return false;
	elseif not script:FindFirstChild("IsEnabled").Value then
		return false;
	else
		return true;
	end;
end;
script.Events.CanShootGun.OnInvoke = function(v369)
	return canShoot(v369);
end;
script.Events.GetCurrentGunSlot.OnInvoke = function()
	return v53;
end;
script.Events.GetCurrentInventoryData.OnInvoke = function()
	return getInventoryItem(v53);
end;
script.Events.GetCurrentGunData.OnInvoke = function()
	return v52;
end;
script.Events.GetGunViewModel.OnInvoke = function()
	return v55;
end;
script.Events.GetGunAnimation.OnInvoke = function()
	return v57;
end;
script.Events.GetWorldLookAtPos.OnInvoke = function()
	return v51;
end;
script.Events.GetGunAnimationName.OnInvoke = function()
	return v58;
end;
--script.Events.OnPlayerRequestSprinting.Event:Connect(function()



--end)

script.Events.SetAimed.Event:Connect(function(v370)
	v6 = v370 == true;
end);
script.Events.SetSprinting.Event:Connect(function(v371)
	v371 = v371 == true;
	v8 = v371;
	v30 = v371;
end);
script.Events.GetSpeed.OnInvoke = function()
	return v12;
end;
script.Events.IsMobile.OnInvoke = function()
	return script:WaitForChild("Mobile").Value;
end;
script.Events.GetAimTween.OnInvoke = function()
	return 1 - v5;
end;
script.Events.IsJumping.OnInvoke = function()
	return isJumping();
end;
script.Events.IsThirdPerson.OnInvoke = function()
	return v36;
end;
script.Events.IsSprinting.OnInvoke = function()
	return v30;
end;

-----------------
script.Events.IsViewModelEnabled.OnInvoke = function()
	return true
end;

------------------------------------------

script.Events.IsReloading.OnInvoke = function()
	return v26;
end;
script.Events.IsAimed.OnInvoke = function()
	return v6;
end;
script.Events.PlayGunSound.Event:Connect(function(v372)
	pcall(function()
		local v373 = 0;
		while v56 == nil and v373 < 100 do
			wait();
			v373 = v373 + 1;
		end;
		if v56 == nil then
			return;
		else
			playGunSound(v372);
			return;
		end;
	end);
end);
script.Events.SetGunAnimation.Event:Connect(function(v374)
	setAnimation(v374, true, 0);
end);
script.Events.TakeoutWeapon.Event:Connect(function(v375, v376)
	v376 = v376 or false;
	if not script:FindFirstChild("IsEnabled").Value and ConfigurationServer.sv_enable_on_join.Value and _G.checkMenus() ~= true then
		script:FindFirstChild("IsEnabled").Value = true;
	end;
	doReloadCancel();
	takeoutWeapon(v375, v376);
end);
script.Events.SetBlocked.Event:Connect(function(v377)
	v46 = v377;
end);
game.ReplicatedStorage.GunEvent.GunForceTakeout.OnClientEvent:Connect(function(v378)
	print("Server force gun change. " .. tostring(v378) .. " / " .. tostring(v53));
	if _G.checkMenus() ~= true then
		script:FindFirstChild("Enabled").Value = true;
		if v378 == v53 then
			return;
		else
			takeoutWeapon(v378, true);
		end;
	end;
end);
game.ReplicatedStorage:WaitForChild("GunSystemSetCharacterRotate").OnClientEvent:Connect(function(v379)
	script.RotateCharacter.Value = v379;
end);
game.ReplicatedStorage.GunEvent.GunForceDisable.OnClientEvent:Connect(function()
	script:FindFirstChild("IsEnabled").Value = false;
end);
game.ReplicatedStorage.GunEvent.GunForceRefresh.OnClientEvent:Connect(function()
	if getInventoryItem(v53) == nil then
		return;
	else
		if not v52 then
			warn("TakeoutWeapon🧷✅")
			script.Events.TakeoutWeapon:Fire(4, true);
		end;
		if not v52 then
			return;
		else
			return;
		end;
	end;
end);
game.ReplicatedStorage.GunEvent.GunForceHitmarker.OnClientEvent:Connect(function(v380)
	hitmarkerSound(v380);
end);
wait(1);
local function _(v381, v382, v383)
	print(v381);
	return v381 == Enum.UserInputState.Begin and v382 or v383;
end;
local l_ContextActionService_0 = game:GetService("ContextActionService");
l_ContextActionService_0:BindActionAtPriority("ControllerReload", function(_, v387)
	local l_onKeyPress_0 = onKeyPress;
	local l_onKeyRelease_0 = onKeyRelease;
	print(v387);
	(v387 == Enum.UserInputState.Begin and l_onKeyPress_0 or l_onKeyRelease_0)({
		KeyCode = Enum.KeyCode.R
	}, false);
	return Enum.ContextActionResult.Pass;
end, false, 1, Enum.KeyCode.ButtonX);
l_ContextActionService_0:BindAction("ControllerLeftclick", function(_, v391)
	local l_onClickDown_0 = onClickDown;
	local l_onClickUp_0 = onClickUp;
	print(v391);
	(v391 == Enum.UserInputState.Begin and l_onClickDown_0 or l_onClickUp_0)(0);
	return Enum.ContextActionResult.Pass;
end, false, Enum.KeyCode.ButtonR2);
l_ContextActionService_0:BindAction("ControllerRightclick", function(_, v395)
	local l_onClickDown_1 = onClickDown;
	local l_onClickUp_1 = onClickUp;
	print(v395);
	(v395 == Enum.UserInputState.Begin and l_onClickDown_1 or l_onClickUp_1)(1);
	return Enum.ContextActionResult.Pass;
end, false, Enum.KeyCode.ButtonL2);
l_ContextActionService_0:BindActionAtPriority("ControllerJump", function(_, v399)
	local l_onKeyPress_1 = onKeyPress;
	local l_onKeyRelease_1 = onKeyRelease;
	print(v399);
	(v399 == Enum.UserInputState.Begin and l_onKeyPress_1 or l_onKeyRelease_1)({
		KeyCode = Enum.KeyCode.Space
	}, false);
	return Enum.ContextActionResult.Pass;
end, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.ButtonA);
l_ContextActionService_0:BindActionAtPriority("ControllerCrouch", function(_, v403)
	local l_onKeyPress_2 = onKeyPress;
	local l_onKeyRelease_2 = onKeyRelease;
	print(v403);
	(v403 == Enum.UserInputState.Begin and l_onKeyPress_2 or l_onKeyRelease_2)({
		KeyCode = Enum.KeyCode.C
	}, false);
	return Enum.ContextActionResult.Pass;
end, false, 1, Enum.KeyCode.ButtonB);
l_ContextActionService_0:BindActionAtPriority("ControllerSprint", function(_, v407)
	local l_onKeyPress_3 = onKeyPress;
	local l_onKeyRelease_3 = onKeyRelease;
	print(v407);
	(v407 == Enum.UserInputState.Begin and l_onKeyPress_3 or l_onKeyRelease_3)({
		KeyCode = Enum.KeyCode.LeftShift
	}, false);
	if v407 == Enum.UserInputState.Begin then
		if v8 then
			onKeyRelease({
				KeyCode = Enum.KeyCode.W
			}, false);
		else
			onKeyPress({
				KeyCode = Enum.KeyCode.W
			}, false);
		end;
	end;
	return Enum.ContextActionResult.Pass;
end, false, 1, Enum.KeyCode.ButtonL3);
l_ContextActionService_0:BindActionAtPriority("ControllerKnife", function(_, v411)
	local l_onKeyPress_4 = onKeyPress;
	local l_onKeyRelease_4 = onKeyRelease;
	print(v411);
	(v411 == Enum.UserInputState.Begin and l_onKeyPress_4 or l_onKeyRelease_4)({
		KeyCode = Enum.KeyCode.F
	}, false);
	return Enum.ContextActionResult.Pass;
end, false, 1, Enum.KeyCode.ButtonR3);
if l_LocalPlayer_0.PlayerGui:FindFirstChild("MobileUI") then
	local l_Frame_0 = l_LocalPlayer_0.PlayerGui.MobileUI:WaitForChild("Frame");
	local l_AimButton_0 = l_Frame_0:FindFirstChild("AimButton");
	local l_CrouchButton_0 = l_Frame_0:FindFirstChild("CrouchButton");
	local l_ReloadButton_0 = l_Frame_0:FindFirstChild("ReloadButton");
	local l_ShootButton_0 = l_Frame_0:FindFirstChild("ShootButton");
	l_AimButton_0.MouseButton1Down:Connect(function()
		if v6 == false then
			onClickDown(1);
			return;
		else
			onClickUp(1);
			return;
		end;
	end);
	l_CrouchButton_0.MouseButton1Down:Connect(function()
		onKeyPress({
			KeyCode = Enum.KeyCode.C
		}, false);
	end);
	l_ReloadButton_0.MouseButton1Down:Connect(function()
		onKeyPress({
			KeyCode = Enum.KeyCode.R
		}, false);
	end);
	l_ShootButton_0.MouseButton1Down:Connect(function()
		onClickDown(0);
	end);
	game:GetService("UserInputService").InputEnded:Connect(function(_, _)
		onClickUp(0);
	end);
end;
script.SystemLoaded.Value = true;
print("Gun Script compiled");