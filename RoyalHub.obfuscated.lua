local v0 = getgenv();
local v1 = getfenv().STATE;
local v2 = "__ROYALHUB_RUNTIME_V2";
local function v3()
	local v251 = v0[v2];
	if ((type(v251) == "table") and (type(v251.cleanup) == "function")) then
		pcall(v251.cleanup);
	end
	local v252 = true;
	local v253 = {};
	local v254 = {};
	local v255 = {};
	v255.alive = function()
		return v252;
	end;
	v255.connect = function(v967, v968)
		local v969 = v967:Connect(v968);
		table.insert(v253, v969);
		return v969;
	end;
	v255.onCleanup = function(v970)
		table.insert(v254, v970);
	end;
	v255.cleanup = function()
		if not v252 then
			return;
		end
		v252 = false;
		for v1237 = #v254, 1, -1 do
			pcall(v254[v1237]);
		end
		table.clear(v254);
		for v1238, v1239 in ipairs(v253) do
			pcall(function()
				v1239:Disconnect();
			end);
		end
		table.clear(v253);
		if (v0[v2] == v255) then
			v0[v2] = nil;
		end
	end;
	v0[v2] = v255;
	return v255;
end
local v4 = v1 or v3();
local v5 = v1 == nil;
local v6 = game:GetService("Players");
local v7 = game:GetService("RunService");
local v8 = game:GetService("TweenService");
local v9 = game:GetService("UserInputService");
local v10 = game:GetService("VirtualInputManager");
local v11 = game:GetService("VirtualUser");
local v12 = game:GetService("HttpService");
local v13 = game:GetService("Lighting");
local v14 = game:GetService("TeleportService");
local v15 = game:GetService("ReplicatedStorage");
local v16 = game:GetService("CollectionService");
local function v17(v261, v262, v263)
	local v264 = v261:WaitForChild(v262, v263 or 30);
	assert(v264, string.format("[RoyalHub] Recurso obrigatório ausente: %s.%s", v261:GetFullName(), v262));
	return v264;
end
local v18 = v6.LocalPlayer;
local v19 = v17(workspace, "_WorldOrigin");
local v20 = v17(workspace, "Enemies");
local v21 = v17(v19, "EnemySpawns");
local v22 = v17(v15, "Remotes");
local v23 = v17(v22, "CommF_");
local v24 = v17(v17(v15, "Modules"), "Net");
local v25 = v17(v24, "RE/RegisterAttack");
local v26 = v17(v24, "RE/RegisterHit");
local v27 = require(v17(v15, "Global"));
local v28 = require(v17(v15, "Quests"));
local v29 = require(v17(v15, "GuideModule"));
local v30 = gethui();
local v31 = {movementEnabled=false,walkSpeed=36,jumpPower=62.5,infiniteJump=false,noclip=false,walkOnWater=false,farmEnabled=false,farmMode="Auto Level",autoQuest=true,skipBosses=true,selectedMob="Automático",movementMode="Suave",useEntrances=true,travelSpeed=350,hoverHeight=18,followOffset=3,attackInterval=0.1,remoteAttackRange=160,maxCombatTargets=4,combatGroupRadius=120,targetTimeout=20,stuckTimeout=8,autoEquip=true,selectedTool="Automático",autoAura=true,autoObservation=false,autoRaceAbility=false,skillZ=false,skillX=false,skillC=false,skillV=false,skillInterval=2.5,fovEnabled=false,fov=70,fullBright=false,fullBrightBrightness=3,fullBrightExposure=0.25,noFog=false,npcEsp=false,fruitEsp=false,chestEsp=false,islandEsp=false,espMaxDistance=2500,espMaxObjects=80,espShowLabels=true,espOffscreenIndicators=true,antiAfk=false,autoStats=false,statName="Melee",statProfile="Atributo único",statBatch=1,chestFarm=false,fruitCollector=false,smartCollector=false,collectorPriority="Frutas primeiro",collectorMaxDistance=1500,collectorResumeFarm=true,rareFruitAlerts=true,autoStoreFruit=false,manualTravel=false,autoSetSpawn=false,autoRollFruit=false,disableGameNotifications=false,disableDamageCounter=false,fpsBoost=false,staffAlerts=false,prioritizeNaturalGroups=false,autoSecondSea=false,autoThirdSea=false,statReserve=0,statCap=2550,interfaceTheme="Dark",interfaceScale=1,interfaceTransparency=true,language="Português",selectedProfile="Padrão",favoriteIslandsCsv="",recentDestinationsCsv="",panelKey="K",emergencyKey="End",updateChannel="Stable"};
local v32 = "2.0.0";
local v33 = ((type(v0.__ROYALHUB_RELEASE) == "table") and v0.__ROYALHUB_RELEASE) or {};
local v34 = tostring(v33.manifestUrl or v0.ROYALHUB_MANIFEST_URL or "");
local v35 = "RoyalHub";
local v36 = v35 .. "/settings.json";
local v37 = "RealMCPProfessional/settings.json";
local v38 = v35 .. "/profiles";
local v39 = {movementEnabled=true,infiniteJump=true,noclip=true,walkOnWater=true,farmEnabled=true,chestFarm=true,fruitCollector=true,smartCollector=true,autoStoreFruit=true,manualTravel=true,autoSetSpawn=true,autoRollFruit=true,autoStats=true,autoSecondSea=true,autoThirdSea=true,autoObservation=true,autoRaceAbility=true,antiAfk=true,fovEnabled=true,fullBright=true,noFog=true,npcEsp=true,fruitEsp=true,chestEsp=true,islandEsp=true,disableGameNotifications=true,disableDamageCounter=true,fpsBoost=true,staffAlerts=true};
local function v40()
	return (type(isfile) == "function") and (type(readfile) == "function") and (type(writefile) == "function") and (type(makefolder) == "function");
end
local function v41()
	if not v40() then
		return false;
	end
	pcall(makefolder, v35);
	pcall(makefolder, v38);
	return true;
end
local function v42()
	local v265 = {};
	for v971, v972 in pairs(v31) do
		if (not v39[v971] and ((type(v972) == "string") or (type(v972) == "number") or (type(v972) == "boolean"))) then
			v265[v971] = v972;
		end
	end
	return v265;
end
local function v43(v266)
	if (type(v266) ~= "table") then
		return 0;
	end
	local v267 = 0;
	for v973, v974 in pairs(v266) do
		if ((v31[v973] ~= nil) and not v39[v973] and (type(v974) == type(v31[v973]))) then
			v31[v973] = v974;
			v267 = v267 + 1;
		end
	end
	for v975 in pairs(v39) do
		if ((v31[v975] ~= nil) and (type(v31[v975]) == "boolean")) then
			v31[v975] = false;
		end
	end
	return v267;
end
local v44 = false;
local v45 = "Persistência indisponível";
if (v41() and (isfile(v36) or isfile(v37))) then
	local v976 = (isfile(v36) and v36) or v37;
	local v977, v978 = pcall(function()
		return v12:JSONDecode(readfile(v976));
	end);
	if (v977 and (type(v978) == "table")) then
		local v1635 = v43(v978.settings or v978);
		v44 = true;
		v45 = string.format("%d configurações seguras restauradas%s", v1635, ((v976 == v37) and " e migradas") or "");
	else
		v45 = "Arquivo de configuração inválido; padrões aplicados";
	end
elseif v40() then
	v45 = "Primeira execução; padrões aplicados";
end
local function v46()
	if not v41() then
		return false, "filesystem indisponível";
	end
	local v268 = {version=v32,savedAt=os.time(),placeId=game.PlaceId,settings=v42()};
	local v269, v270 = pcall(function()
		return v12:JSONEncode(v268);
	end);
	if not v269 then
		return false, tostring(v270);
	end
	local v271, v272 = pcall(writefile, v36, v270);
	return v271, (v271 and v36) or tostring(v272);
end
local v47 = {sessionStartedAt=os.clock(),configLoaded=v44,configLoadMessage=v45,lastConfigFingerprint=nil,lastConfigSave=0,lastTelemetryUpdate=0,lastLabelUpdate=0,telemetryInitialized=false,framesThisSecond=0,currentFps=0,lastFpsSample=os.clock(),npcsDefeated=0,chestsCollected=0,fruitsCollected=0,targetSwitches=0,targetAcquiredAt=0,lastTargetProgress=0,lastTargetDistance=math.huge,npcBlacklist=setmetatable({}, {__mode="k"}),activityJournal={},lastWorldCounts={npcs=0,chests=0,fruits=0},lastFruitSeen="nenhuma",lastChestSeen="nenhum",collectionOverride=false,collectionQueueSize=0,collectionTarget=nil,collectionTargetPart=nil,collectionTargetType=nil,collectionTargetSince=0,collectionIgnoredUntil=setmetatable({}, {__mode="k"}),travelStartedAt=0,travelInitialDistance=0,travelEta=0,recentDestinations={},favoriteIslands={},profileApplyCount=0,espLabels=setmetatable({}, {__mode="k"}),espTrackedParents=setmetatable({}, {__mode="k"}),trackedNpcDeaths=setmetatable({}, {__mode="k"}),rareFruitAlerted=setmetatable({}, {__mode="k"}),lastAttack=0,lastSkill=0,lastAura=0,lastObservation=0,lastRaceAbility=0,lastStatPoint=0,lastFruitStore=0,lastFruitRoll=0,lastSetSpawn=0,lastSeaProgress=0,comboIndex=0,combatTarget=nil,combatTargetHealth=nil,combatGroupSize=0,combatGroupCursor=0,combatHealthByTarget=setmetatable({}, {__mode="k"}),combatGeneration=0,lastDamageObserved=0,remoteFallbackUntil=0,remoteFailureCount=0,lastQuestAction=0,lastPlanRefresh=0,lastEntrance=0,skillIndex=0,farmPlan=nil,farmState="Parado",farmDetail="Auto Level desligado",preFarmTool=nil,preFarmAura=nil,auraActivatedByFarm=false,travelTween=nil,travelTweenConnection=nil,travelTweenRoot=nil,travelTweenTarget=nil,travelTweenEndpoint=nil,travelAnchor=nil,lastServerCorrection=0,serverCorrectionCount=0,safeTravelUntil=0,travelRetryAfter=0,travelGeneration=0,flightStabilizer=nil,spawnIndex=0,spawnTargetName=nil,lastSpawnAdvance=0,createdUi={},uiReady=false,unloading=false,syncingUi=false,iterationErrorCount=0,lastRuntimeError=nil,totalRuntimeErrors=0,collisionOriginals=setmetatable({}, {__mode="k"}),fullBrightOriginals=nil,fogOriginals=nil,atmosphereOriginals=setmetatable({}, {__mode="k"}),atmosphereStorage=nil,collectionState="Parado",collectionDetail="Coletores desligados",fruitStoreRetryAt={},manualTravelName=nil,manualTravelPosition=nil,selectedIsland=nil,lastSpawnIsland=nil,notificationOriginals=setmetatable({}, {__mode="k"}),damageCounterOriginal=nil,fpsPartOriginals=setmetatable({}, {__mode="k"}),fpsEffectOriginals=setmetatable({}, {__mode="k"}),fpsTerrainOriginals=nil,staffAlerted={},waterPlatform=nil,seaFarmTarget=nil,statFailureCount=0,statPointsRequested=0,lastStatTarget=nil,statHistory={},questProgressText="",questProgressCurrent=nil,questProgressTotal=nil,questProgressRate=0,questProgressSampleAt=0,updateStatus=(((v34 ~= "") and "Pronto para verificar") or "Manifest não configurado"),availableVersion=nil,updateCompatible=nil,fruitRollAttempts=0,fruitRollSuccesses=0,lastFruitRollMessage="Nenhuma tentativa nesta sessão",lastSpawnRequestStatus="Não solicitado nesta sessão"};
local v48 = {};
for v273 in v31.favoriteIslandsCsv:gmatch("[^|]+") do
	v47.favoriteIslands[v273] = true;
end
for v275 in v31.recentDestinationsCsv:gmatch("[^|]+") do
	table.insert(v47.recentDestinations, v275);
end
local v49 = {cameraFov=((workspace.CurrentCamera and workspace.CurrentCamera.FieldOfView) or 70),lighting={Ambient=v13.Ambient,Brightness=v13.Brightness,EnvironmentDiffuseScale=v13.EnvironmentDiffuseScale,EnvironmentSpecularScale=v13.EnvironmentSpecularScale,ExposureCompensation=v13.ExposureCompensation,FogColor=v13.FogColor,FogEnd=v13.FogEnd,FogStart=v13.FogStart,GlobalShadows=v13.GlobalShadows,OutdoorAmbient=v13.OutdoorAmbient},walkSpeed=16,jumpPower=50,useJumpPower=true,equippedTool=nil};
local v50 = {};
local v51;
local v52;
local v53;
local function v54(v276, v277, v278, v279)
	if v52 then
		pcall(function()
			v52:Notify({Title=v276,Content=v277,Icon=(v278 or "info"),Duration=(v279 or 4)});
		end);
	end
end
local v55 = {["Português"]={active="Ativo",stopped="Parado",none="nenhum",session="Sessão",world="Mundo carregado",configSaved="Configuração salva",profileApplied="Perfil aplicado"},English={active="Active",stopped="Stopped",none="none",session="Session",world="Loaded world",configSaved="Settings saved",profileApplied="Profile applied"}};
local function v56(v280)
	local v281 = v55[v31.language] or v55["Português"];
	return v281[v280] or v55["Português"][v280] or v280;
end
v48.formatDuration = function(v282)
	v282 = math.max(0, math.floor(v282 or 0));
	local v283 = math.floor(v282 / 3600);
	local v284 = math.floor((v282 % 3600) / 60);
	local v285 = v282 % 60;
	if (v283 > 0) then
		return string.format("%02dh %02dm %02ds", v283, v284, v285);
	end
	return string.format("%02dm %02ds", v284, v285);
end;
local v58 = {K=Enum.KeyCode.K,L=Enum.KeyCode.L,M=Enum.KeyCode.M,RightShift=Enum.KeyCode.RightShift,Insert=Enum.KeyCode.Insert,Home=Enum.KeyCode.Home,End=Enum.KeyCode.End,Delete=Enum.KeyCode.Delete};
v48.getShortcutKeyCode = function(v286, v287)
	return v58[v286] or v287;
end;
v48.parseVersion = function(v288)
	local v289, v290, v291 = tostring(v288 or "0.0.0"):match("^(%d+)%.(%d+)%.(%d+)");
	return tonumber(v289) or 0, tonumber(v290) or 0, tonumber(v291) or 0;
end;
v48.isVersionNewer = function(v292, v293)
	local v294, v295, v296 = v48.parseVersion(v292);
	local v297, v298, v299 = v48.parseVersion(v293);
	if (v294 ~= v297) then
		return v294 > v297;
	elseif (v295 ~= v298) then
		return v295 > v298;
	end
	return v296 > v299;
end;
v48.isReleaseCompatible = function(v300)
	if (type(v300) ~= "table") then
		return false, "canal ausente";
	end
	if ((type(v300.placeIds) == "table") and (#v300.placeIds > 0) and not table.find(v300.placeIds, game.PlaceId)) then
		return false, "PlaceId não listado";
	end
	local v301 = tonumber(v300.minPlaceVersion);
	local v302 = tonumber(v300.maxPlaceVersion);
	if (v301 and (game.PlaceVersion < v301)) then
		return false, "jogo anterior à versão mínima testada";
	elseif (v302 and (game.PlaceVersion > v302)) then
		return false, "jogo posterior à versão máxima testada";
	end
	return true, "compatível";
end;
v48.checkForUpdates = function()
	if (v34 == "") then
		v47.updateStatus = "Defina ROYALHUB_MANIFEST_URL ou use o loader oficial";
		return false, v47.updateStatus;
	end
	local v303, v304 = pcall(function()
		return game:HttpGet(v34);
	end);
	if not v303 then
		v47.updateStatus = "Falha ao baixar manifest: " .. tostring(v304);
		return false, v47.updateStatus;
	end
	local v305, v306 = pcall(function()
		return v12:JSONDecode(v304);
	end);
	if (not v305 or (type(v306) ~= "table")) then
		v47.updateStatus = "Manifest JSON inválido";
		return false, v47.updateStatus;
	end
	local v307 = ((v31.updateChannel == "Beta") and "beta") or "stable";
	local v308 = v306[v307];
	local v309, v310 = v48.isReleaseCompatible(v308);
	if ((type(v308) ~= "table") or (type(v308.version) ~= "string")) then
		v47.updateStatus = "Canal " .. v307 .. " não publicado";
		return false, v47.updateStatus;
	end
	v47.availableVersion = v308.version;
	v47.updateCompatible = v309;
	v47.updateRelease = v308;
	v47.updateStatus = (v48.isVersionNewer(v308.version, v32) and string.format("v%s disponível | %s", v308.version, v310)) or string.format("v%s é a mais recente | %s", v32, v310);
	return true, v47.updateStatus, v308;
end;
v48.appendActivity = function(v316, v317)
	table.insert(v47.activityJournal, 1, {time=(os.clock() - v47.sessionStartedAt),kind=v316,message=tostring(v317)});
	while #v47.activityJournal > 40 do
		table.remove(v47.activityJournal);
	end
end;
v48.getActivityHistory = function(v318)
	local v319 = {};
	for v979 = 1, math.min(v318 or 12, #v47.activityJournal) do
		local v980 = v47.activityJournal[v979];
		table.insert(v319, string.format("[%s] %s: %s", v48.formatDuration(v980.time), v980.kind, v980.message));
	end
	return ((#v319 > 0) and table.concat(v319, "\n")) or "Nenhuma atividade registrada";
end;
v48.getNetworkPingMilliseconds = function()
	local v320, v321 = pcall(function()
		return v18:GetNetworkPing() * 1000;
	end);
	return (v320 and v321) or 0;
end;
v48.sanitizeProfileName = function(v322)
	local v323 = tostring(v322 or "Padrão"):gsub("[^%w_-]", "_");
	return ((v323 ~= "") and v323:sub(1, 32)) or "Padrao";
end;
v48.saveProfile = function(v324)
	if not v41() then
		return false, "filesystem indisponível";
	end
	local v325 = v38 .. "/" .. v48.sanitizeProfileName(v324) .. ".json";
	local v326 = {version=v32,profile=v324,savedAt=os.time(),settings=v42()};
	local v327, v328 = pcall(function()
		return v12:JSONEncode(v326);
	end);
	if not v327 then
		return false, tostring(v328);
	end
	local v329, v330 = pcall(writefile, v325, v328);
	if v329 then
		v48.appendActivity("Perfil", "Salvo: " .. tostring(v324));
	end
	return v329, (v329 and v325) or tostring(v330);
end;
v48.loadProfile = function(v331)
	if not v40() then
		return false, "filesystem indisponível";
	end
	local v332 = v38 .. "/" .. v48.sanitizeProfileName(v331) .. ".json";
	if not isfile(v332) then
		return false, "perfil ainda não foi salvo";
	end
	local v333, v334 = pcall(function()
		return v12:JSONDecode(readfile(v332));
	end);
	if (not v333 or (type(v334) ~= "table")) then
		return false, "arquivo de perfil inválido";
	end
	local v335 = v43(v334.settings or v334);
	v47.profileApplyCount = v47.profileApplyCount + 1;
	v48.appendActivity("Perfil", string.format("Aplicado: %s (%d opções)", v331, v335));
	return true, v335;
end;
local v70 = {["Padrão"]={travelSpeed=350,hoverHeight=18,attackInterval=0.1,remoteAttackRange=160,maxCombatTargets=4,combatGroupRadius=120,targetTimeout=20,stuckTimeout=8,collectorPriority="Frutas primeiro",collectorMaxDistance=1500,espMaxDistance=2500,espMaxObjects=80},Farm={travelSpeed=400,hoverHeight=18,attackInterval=0.1,remoteAttackRange=160,maxCombatTargets=6,combatGroupRadius=140,targetTimeout=18,stuckTimeout=7},Travel={travelSpeed=500,movementMode="Suave",useEntrances=true,collectorMaxDistance=1200},FPS={espMaxDistance=1200,espMaxObjects=30,espShowLabels=false,interfaceTransparency=false},Visual={fov=75,fullBrightBrightness=3,fullBrightExposure=0.25,espMaxDistance=3000,espMaxObjects=100,espShowLabels=true}};
v48.applyBuiltInProfile = function(v337)
	local v338 = v70[v337];
	if not v338 then
		return false, 0;
	end
	local v339 = v43(v338);
	v47.profileApplyCount = v47.profileApplyCount + 1;
	v48.appendActivity("Perfil", string.format("Preset aplicado: %s (%d opções)", v337, v339));
	return true, v339;
end;
v48.appendActivity("Sistema", string.format("RoyalHub v%s iniciado | %s", v32, v45));
local v72 = "não carregada";
local v73 = {{version="1.6.62 (estável)",url="https://github.com/Footagesus/WindUI/releases/download/1.6.62/main.lua"},{version="1.6.66 (fallback)",url="https://github.com/Footagesus/WindUI/releases/download/1.6.66/main.lua"}};
local function v74()
	local v341 = "fonte não consultada";
	for v981, v982 in ipairs(v73) do
		for v1244 = 1, 2 do
			local v1245, v1246 = pcall(function()
				return game:HttpGet(v982.url);
			end);
			if (v1245 and (type(v1246) == "string") and (#v1246 > 1000)) then
				local v1713, v1714 = loadstring(v1246);
				if v1713 then
					local v1896, v1897 = pcall(v1713);
					if (v1896 and (type(v1897) == "table")) then
						v72 = v982.version;
						return v1897;
					end
					v341 = tostring(v1897);
				else
					v341 = tostring(v1714);
				end
			else
				v341 = tostring(v1246);
			end
			if (v1244 < 2) then
				task.wait(0.35);
			end
		end
	end
	error("[RoyalHub] Não foi possível carregar a WindUI: " .. v341);
end
local function v75()
	local v342 = v18.Character;
	if not v342 then
		return nil, nil, nil;
	end
	return v342, v342:FindFirstChildOfClass("Humanoid"), v342:FindFirstChild("HumanoidRootPart");
end
local function v76()
	local v343, v344 = v75();
	if v344 then
		v49.walkSpeed = v344.WalkSpeed;
		v49.jumpPower = v344.JumpPower;
		v49.useJumpPower = v344.UseJumpPower;
		if not v31.movementEnabled then
			v31.walkSpeed = v344.WalkSpeed;
			v31.jumpPower = v344.JumpPower;
		end
		local v1253 = v343 and v343:FindFirstChildOfClass("Tool");
		v49.equippedTool = (v1253 and v1253.Name) or nil;
	end
	v47.collisionOriginals = setmetatable({}, {__mode="k"});
end
local function v77()
	local v346, v347 = v75();
	if (v347 and v31.movementEnabled) then
		v347.WalkSpeed = v31.walkSpeed;
		v347.UseJumpPower = true;
		v347.JumpPower = v31.jumpPower;
	end
end
local function v78()
	local v348, v349 = v75();
	if v349 then
		v349.WalkSpeed = v49.walkSpeed;
		v349.UseJumpPower = v49.useJumpPower;
		v349.JumpPower = v49.jumpPower;
		v349:Move(Vector3.zero, false);
	end
end
local function v79()
	local v350 = v18.Character;
	if not v350 then
		return;
	end
	for v983, v984 in ipairs(v350:GetDescendants()) do
		if v984:IsA("BasePart") then
			if (v47.collisionOriginals[v984] == nil) then
				v47.collisionOriginals[v984] = v984.CanCollide;
			end
			v984.CanCollide = false;
		end
	end
end
local function v80()
	for v985, v986 in pairs(v47.collisionOriginals) do
		if (v985 and v985.Parent) then
			v985.CanCollide = v986;
		end
	end
	v47.collisionOriginals = setmetatable({}, {__mode="k"});
end
local function v81()
	if v47.waterPlatform then
		pcall(function()
			v47.waterPlatform:Destroy();
		end);
	end
	v47.waterPlatform = nil;
end
local function v82()
	local v353, v354, v355 = v75();
	if (not v31.walkOnWater or not v353 or not v354 or not v355 or (v354.Health <= 0)) then
		v81();
		return;
	end
	local v356 = RaycastParams.new();
	v356.FilterType = Enum.RaycastFilterType.Exclude;
	v356.FilterDescendantsInstances = {v353,v47.waterPlatform};
	v356.IgnoreWater = false;
	local v361 = workspace:Raycast(v355.Position + Vector3.new(0, 5, 0), Vector3.new(0, -22, 0), v356);
	if (not v361 or (v361.Material ~= Enum.Material.Water)) then
		v81();
		return;
	end
	local v362 = v47.waterPlatform;
	if (not v362 or not v362.Parent) then
		v362 = Instance.new("Part");
		v362.Name = "RoyalHub_WaterPlatform";
		v362.Size = Vector3.new(12, 0.8, 12);
		v362.Anchored = true;
		v362.CanCollide = true;
		v362.CanQuery = false;
		v362.CanTouch = false;
		v362.Transparency = 1;
		v362.Parent = workspace;
		v47.waterPlatform = v362;
	end
	v362.CFrame = CFrame.new(v355.Position.X, v361.Position.Y - 0.2, v355.Position.Z);
end
local function v83()
	v47.fullBrightOriginals = {Ambient=v13.Ambient,Brightness=v13.Brightness,EnvironmentDiffuseScale=v13.EnvironmentDiffuseScale,EnvironmentSpecularScale=v13.EnvironmentSpecularScale,ExposureCompensation=v13.ExposureCompensation,GlobalShadows=v13.GlobalShadows,OutdoorAmbient=v13.OutdoorAmbient};
end
local function v84()
	local v365 = v47.fullBrightOriginals;
	if v365 then
		v13.Ambient = v365.Ambient;
		v13.Brightness = v365.Brightness;
		v13.EnvironmentDiffuseScale = v365.EnvironmentDiffuseScale;
		v13.EnvironmentSpecularScale = v365.EnvironmentSpecularScale;
		v13.ExposureCompensation = v365.ExposureCompensation;
		v13.GlobalShadows = v365.GlobalShadows;
		v13.OutdoorAmbient = v365.OutdoorAmbient;
	end
	v47.fullBrightOriginals = nil;
end
local function v85(v367)
	if not v47.atmosphereOriginals[v367] then
		v47.atmosphereOriginals[v367] = {Density=v367.Density,Haze=v367.Haze,Parent=v367.Parent};
	end
end
local function v86()
	v47.fogOriginals = {FogColor=v13.FogColor,FogEnd=v13.FogEnd,FogStart=v13.FogStart};
	v47.atmosphereOriginals = setmetatable({}, {__mode="k"});
	local v370 = Instance.new("Folder");
	v370.Name = "RoyalHub_AtmosphereStorage";
	v370.Parent = v30;
	v47.atmosphereStorage = v370;
	for v987, v988 in ipairs(v13:GetChildren()) do
		if v988:IsA("Atmosphere") then
			v85(v988);
		end
	end
end
local function v87()
	local v374 = v47.fogOriginals;
	if v374 then
		v13.FogColor = v374.FogColor;
		v13.FogEnd = v374.FogEnd;
		v13.FogStart = v374.FogStart;
	end
	for v989, v990 in pairs(v47.atmosphereOriginals) do
		pcall(function()
			v989.Density = v990.Density;
			v989.Haze = v990.Haze;
			v989.Parent = (v990.Parent and (v990.Parent.Parent ~= nil) and v990.Parent) or v13;
		end);
	end
	if v47.atmosphereStorage then
		v47.atmosphereStorage:Destroy();
	end
	v47.fogOriginals = nil;
	v47.atmosphereOriginals = setmetatable({}, {__mode="k"});
	v47.atmosphereStorage = nil;
end
local function v88()
	if v31.fullBright then
		if not v47.fullBrightOriginals then
			v83();
		end
		v13.Ambient = Color3.new(1, 1, 1);
		v13.OutdoorAmbient = Color3.new(1, 1, 1);
		v13.Brightness = v31.fullBrightBrightness;
		v13.ExposureCompensation = v31.fullBrightExposure;
		v13.EnvironmentDiffuseScale = 1;
		v13.EnvironmentSpecularScale = math.max(v13.EnvironmentSpecularScale, 0.5);
		v13.GlobalShadows = false;
	end
	if v31.noFog then
		if not v47.fogOriginals then
			v86();
		end
		v13.FogStart = 0;
		v13.FogEnd = 1000000;
		for v1638, v1639 in ipairs(v13:GetChildren()) do
			if v1639:IsA("Atmosphere") then
				v85(v1639);
				v1639.Parent = v47.atmosphereStorage;
			end
		end
	end
end
local function v89()
	local v378 = workspace.CurrentCamera;
	if v378 then
		v378.FieldOfView = v49.cameraFov;
	end
end
local function v90()
	local v379 = v18:FindFirstChildOfClass("PlayerGui");
	local v380 = v379 and v379:FindFirstChild("Notifications");
	if (v380 and v380:IsA("ScreenGui")) then
		if (v47.notificationOriginals[v380] == nil) then
			v47.notificationOriginals[v380] = v380.Enabled;
		end
		v380.Enabled = false;
	end
end
local function v91()
	for v991, v992 in pairs(v47.notificationOriginals) do
		if v991.Parent then
			pcall(function()
				v991.Enabled = v992;
			end);
		end
	end
	v47.notificationOriginals = setmetatable({}, {__mode="k"});
end
local function v92()
	local v382 = v27.dmgCounter;
	if (v382 and (v382.Enabled ~= nil)) then
		if (v47.damageCounterOriginal == nil) then
			v47.damageCounterOriginal = v382.Enabled;
		end
		v382.Enabled = false;
	end
end
local function v93()
	local v383 = v27.dmgCounter;
	if (v383 and (v383.Enabled ~= nil) and (v47.damageCounterOriginal ~= nil)) then
		pcall(function()
			v383.Enabled = v47.damageCounterOriginal;
		end);
	end
	v47.damageCounterOriginal = nil;
end
local function v94(v385)
	local v386 = workspace:FindFirstChild("Map");
	local v387 = workspace:FindFirstChild("_WorldOrigin");
	if (v385:IsA("BasePart") and ((v386 and v385:IsDescendantOf(v386)) or (v387 and v385:IsDescendantOf(v387)))) then
		if not v47.fpsPartOriginals[v385] then
			v47.fpsPartOriginals[v385] = {Material=v385.Material,Reflectance=v385.Reflectance,CastShadow=v385.CastShadow};
		end
		v385.Material = Enum.Material.SmoothPlastic;
		v385.Reflectance = 0;
		v385.CastShadow = false;
	elseif (v385:IsA("ParticleEmitter") or v385:IsA("Trail") or v385:IsA("Beam") or v385:IsA("Smoke") or v385:IsA("Fire") or v385:IsA("Sparkles") or v385:IsA("PostEffect")) then
		if (v47.fpsEffectOriginals[v385] == nil) then
			v47.fpsEffectOriginals[v385] = v385.Enabled;
		end
		v385.Enabled = false;
	end
end
local function v95()
	if not v47.fpsTerrainOriginals then
		local v1320 = workspace:FindFirstChildOfClass("Terrain");
		if v1320 then
			v47.fpsTerrainOriginals = {WaterWaveSize=v1320.WaterWaveSize,WaterWaveSpeed=v1320.WaterWaveSpeed,WaterReflectance=v1320.WaterReflectance};
			v1320.WaterWaveSize = 0;
			v1320.WaterWaveSpeed = 0;
			v1320.WaterReflectance = 0;
		end
	end
	for v993, v994 in ipairs(workspace:GetDescendants()) do
		v94(v994);
	end
	for v995, v996 in ipairs(v13:GetDescendants()) do
		v94(v996);
	end
end
local function v96()
	for v997, v998 in pairs(v47.fpsPartOriginals) do
		if v997.Parent then
			pcall(function()
				v997.Material = v998.Material;
				v997.Reflectance = v998.Reflectance;
				v997.CastShadow = v998.CastShadow;
			end);
		end
	end
	for v999, v1000 in pairs(v47.fpsEffectOriginals) do
		if v999.Parent then
			pcall(function()
				v999.Enabled = v1000;
			end);
		end
	end
	local v388 = workspace:FindFirstChildOfClass("Terrain");
	if (v388 and v47.fpsTerrainOriginals) then
		pcall(function()
			v388.WaterWaveSize = v47.fpsTerrainOriginals.WaterWaveSize;
			v388.WaterWaveSpeed = v47.fpsTerrainOriginals.WaterWaveSpeed;
			v388.WaterReflectance = v47.fpsTerrainOriginals.WaterReflectance;
		end);
	end
	v47.fpsPartOriginals = setmetatable({}, {__mode="k"});
	v47.fpsEffectOriginals = setmetatable({}, {__mode="k"});
	v47.fpsTerrainOriginals = nil;
end
local function v97(v392)
	return v392:IsA("Highlight") and (v392.Name == "RoyalHub_NpcHighlight");
end
v48.getEspObjectCount = function()
	local v393 = 0;
	for v1001, v1002 in pairs(v47.espTrackedParents) do
		if (v1001.Parent and v1002 and v1002.Parent) then
			v393 = v393 + 1;
		else
			v47.espTrackedParents[v1001] = nil;
		end
	end
	return v393;
end;
v48.addEspLabel = function(v394, v395, v396, v397, v398, v399)
	if (not v31.espShowLabels or not v394 or not v395 or v394:FindFirstChild(v396)) then
		return;
	end
	if (v48.getEspObjectCount() >= v31.espMaxObjects) then
		return;
	end
	local v400, v400, v401 = v75();
	if (v401 and ((v401.Position - v395.Position).Magnitude > v31.espMaxDistance)) then
		return;
	end
	local v402 = Instance.new("BillboardGui");
	v402.Name = v396;
	v402.Adornee = v395;
	v402.AlwaysOnTop = true;
	v402.Size = UDim2.fromOffset(220, 42);
	v402.StudsOffset = Vector3.new(0, 3.5, 0);
	v402.MaxDistance = v31.espMaxDistance;
	local v410 = Instance.new("TextLabel");
	v410.Name = "Text";
	v410.BackgroundTransparency = 1;
	v410.Size = UDim2.fromScale(1, 1);
	v410.Font = Enum.Font.GothamMedium;
	v410.TextColor3 = Color3.fromRGB(255, 255, 255);
	v410.TextStrokeColor3 = Color3.fromRGB(15, 15, 20);
	v410.TextStrokeTransparency = 0.2;
	v410.TextSize = 14;
	v410.TextWrapped = true;
	v410.Parent = v402;
	v402.Parent = v394;
	v47.espLabels[v394] = {gui=v402,label=v410,adornee=v395,displayName=(v397 or v394.Name),humanoid=v398,color=(v399 or Color3.fromRGB(255, 255, 255))};
end;
v48.removeEspLabels = function(v424)
	for v1003, v1004 in pairs(v47.espLabels) do
		if (not v424 or (v1004.gui and (v1004.gui.Name == v424))) then
			pcall(function()
				v1004.gui:Destroy();
			end);
			if v1004.indicator then
				pcall(function()
					v1004.indicator:Destroy();
				end);
			end
			v47.espLabels[v1003] = nil;
		end
	end
end;
local function v101()
	for v1005, v1006 in ipairs(v20:GetDescendants()) do
		if v97(v1006) then
			v1006:Destroy();
		end
	end
	v48.removeEspLabels("RoyalHub_NpcLabel");
end
local function v102(v425)
	if (not v31.npcEsp or not v425:IsA("Model") or v6:GetPlayerFromCharacter(v425)) then
		return;
	end
	local v426 = v425:FindFirstChildOfClass("Humanoid");
	local v427 = v425:FindFirstChild("HumanoidRootPart");
	if (not v426 or not v427 or (v426.Health <= 0) or v425:FindFirstChild("RoyalHub_NpcHighlight")) then
		return;
	end
	local v428, v428, v429 = v75();
	if (v429 and ((v429.Position - v427.Position).Magnitude > v31.espMaxDistance)) then
		return;
	end
	if (v48.getEspObjectCount() >= v31.espMaxObjects) then
		return;
	end
	local v430 = Instance.new("Highlight");
	v430.Name = "RoyalHub_NpcHighlight";
	v430.Adornee = v425;
	v430.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
	v430.FillColor = Color3.fromRGB(255, 92, 92);
	v430.FillTransparency = 0.65;
	v430.OutlineColor = Color3.fromRGB(255, 255, 255);
	v430.OutlineTransparency = 0.1;
	v430.Parent = v425;
	v47.espTrackedParents[v425] = v430;
	v48.addEspLabel(v425, v427, "RoyalHub_NpcLabel", v425.Name, v426, v430.FillColor);
end
local function v103()
	v101();
	if v31.npcEsp then
		for v1650, v1651 in ipairs(v20:GetChildren()) do
			v102(v1651);
		end
	end
end
local function v104(v441)
	for v1007, v1008 in ipairs(workspace:GetDescendants()) do
		if (v1008:IsA("Highlight") and (v1008.Name == v441)) then
			v47.espTrackedParents[v1008.Parent] = nil;
			v1008:Destroy();
		end
	end
	v48.removeEspLabels(v441:gsub("Highlight$", "Label"));
end
local function v105(v442, v443, v444, v445)
	if (not v442 or not v443 or v442:FindFirstChild(v444)) then
		return;
	end
	local v446 = Instance.new("Highlight");
	v446.Name = v444;
	v446.Adornee = v443;
	v446.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
	v446.FillColor = v445;
	v446.FillTransparency = 0.55;
	v446.OutlineColor = Color3.fromRGB(255, 255, 255);
	v446.OutlineTransparency = 0.05;
	v446.Parent = v442;
	v47.espTrackedParents[v442] = v446;
	local v457 = v444:gsub("Highlight$", "Label");
	v48.addEspLabel(v442, v443, v457, v442.Name, nil, v445);
end
local v106 = {fruits=setmetatable({}, {__mode="k"}),chests=setmetatable({}, {__mode="k"})};
local v107 = {SilverChest="Baú de Prata",GoldChest="Baú de Ouro",DiamondChest="Baú de Diamante",MirageChest="Baú Miragem",FragmentChest="Baú de Fragmentos",XmasChest="Baú de Natal",Chest1="Baú de Prata",Chest2="Baú de Ouro",Chest3="Baú de Diamante",DiamondChestMarker="Baú Miragem",FragChest="Baú de Fragmentos"};
local function v108(v458)
	if not v458 then
		return nil;
	end
	if v458:IsA("BasePart") then
		return v458;
	end
	local v459 = v458:FindFirstChild("Handle", true) or v458:FindFirstChild("RootPart", true) or v458:FindFirstChild("PrimaryPart", true);
	if (v459 and v459:IsA("BasePart")) then
		return v459;
	end
	return v458:FindFirstChildWhichIsA("BasePart", true);
end
local function v109(v460)
	local v461 = workspace:FindFirstChild("Characters");
	if (v461 and v460:IsDescendantOf(v461)) then
		return true;
	end
	return v460:IsDescendantOf(v20);
end
local function v110(v462)
	local v463 = v462.Name:lower();
	if (v463:find("fruit", 1, true) or v463:find("physical", 1, true)) then
		return true;
	end
	if v462:IsA("Tool") then
		local v1321 = v462.ToolTip:lower();
		if v1321:find("fruit", 1, true) then
			return true;
		end
	end
	for v1009, v1010 in pairs(v462:GetAttributes()) do
		local v1011 = (tostring(v1009) .. " " .. tostring(v1010)):lower();
		if v1011:find("fruit", 1, true) then
			return true;
		end
	end
	return false;
end
local function v111(v464)
	if (not v464:IsA("Tool") or not v464:IsDescendantOf(workspace) or v109(v464) or not v110(v464)) then
		return false;
	end
	return v108(v464) ~= nil;
end
local function v112(v465)
	if (not v465:IsDescendantOf(workspace) or v109(v465)) then
		return false;
	end
	if v465:IsA("Tool") then
		return v111(v465);
	end
	if not v110(v465) then
		return false;
	end
	local v466 = workspace:FindFirstChild("Map");
	local v467 = v19:FindFirstChild("FruitSpawns");
	if ((v466 and v465:IsDescendantOf(v466)) or (v467 and v465:IsDescendantOf(v467))) then
		return false;
	end
	if v465:IsA("Model") then
		return (v108(v465) ~= nil) and ((v465:FindFirstChild("Handle", true) ~= nil) or (v465:FindFirstChildWhichIsA("TouchTransmitter", true) ~= nil) or (v465:FindFirstChildWhichIsA("ProximityPrompt", true) ~= nil));
	end
	return v465:IsA("BasePart") and ((v465:FindFirstChildWhichIsA("TouchTransmitter") ~= nil) or (v465:FindFirstChildWhichIsA("ProximityPrompt") ~= nil));
end
local function v113(v468)
	if not v468:IsDescendantOf(workspace) then
		return false;
	end
	if v468:IsA("Model") then
		local v1322 = workspace:FindFirstChild("ChestModels");
		return (v1322 ~= nil) and (v468.Parent == v1322) and (v468.Name:lower():find("chest", 1, true) ~= nil) and (v108(v468) ~= nil);
	end
	if not v468:IsA("BasePart") then
		return false;
	end
	local v469 = (v468.Name == "Chest1") or (v468.Name == "Chest2") or (v468.Name == "Chest3") or (v468.Name == "DiamondChest") or (v468.Name == "FragChest") or (v468.Name == "XmasChest");
	if not v469 then
		return false;
	end
	return v468.Transparency < 1;
end
local function v114(v470)
	local v471, v472;
	local v473 = v470;
	for v1012 = 1, 7 do
		if (not v473 or (v473 == workspace)) then
			break;
		end
		if (v473:IsA("Tool") or v473:IsA("Model") or v473:IsA("BasePart")) then
			if (not v471 and v112(v473)) then
				v106.fruits[v473] = true;
				v471 = v473;
			end
			if (not v472 and v113(v473)) then
				v106.chests[v473] = true;
				v472 = v473;
			end
		end
		v473 = v473.Parent;
	end
	return v471, v472;
end
local function v115(v474)
	return v107[v474.Name] or v474.Name;
end
local function v116(v475)
	local v476 = v475.Name;
	if ((v476 == "DiamondChest") or (v476 == "MirageChest")) then
		return Color3.fromRGB(80, 210, 255);
	elseif ((v476 == "Chest3") or (v476 == "DiamondChestMarker")) then
		return Color3.fromRGB(70, 235, 190);
	elseif ((v476 == "Chest2") or (v476 == "GoldChest")) then
		return Color3.fromRGB(255, 220, 70);
	end
	return Color3.fromRGB(205, 205, 205);
end
local function v117()
	v104("RoyalHub_FruitHighlight");
	if not v31.fruitEsp then
		return;
	end
	for v1014 in pairs(v106.fruits) do
		if v112(v1014) then
			local v1653 = v108(v1014);
			if v1653 then
				v105(v1014, v1653, "RoyalHub_FruitHighlight", Color3.fromRGB(255, 92, 92));
			end
		else
			v106.fruits[v1014] = nil;
		end
	end
end
local function v118()
	v104("RoyalHub_ChestHighlight");
	if not v31.chestEsp then
		return;
	end
	for v1015 in pairs(v106.chests) do
		if v113(v1015) then
			local v1655 = v108(v1015);
			if v1655 then
				v105(v1015, v1655, "RoyalHub_ChestHighlight", v116(v1015));
			end
		else
			v106.chests[v1015] = nil;
		end
	end
end
local function v119()
	v104("RoyalHub_IslandHighlight");
end
local function v120()
	v119();
	if not v31.islandEsp then
		return;
	end
	local v477 = workspace:FindFirstChild("_WorldOrigin");
	local v478 = v477 and v477:FindFirstChild("Locations");
	for v1016, v1017 in ipairs((v478 and v478:GetChildren()) or {}) do
		local v1018 = (v1017:IsA("Model") and v1017) or (v1017:IsA("BasePart") and v1017) or v1017:FindFirstChildWhichIsA("BasePart", true);
		if v1018 then
			v105(v1017, v1018, "RoyalHub_IslandHighlight", Color3.fromRGB(70, 220, 255));
		end
	end
end
local function v121()
	v103();
	v117();
	v118();
	v120();
end
local function v122(v479)
	local v480, v481, v482;
	v482 = math.huge;
	for v1019 in pairs(v106.chests) do
		if v113(v1019) then
			local v1657 = v108(v1019);
			local v1658 = (v1657 and (v479 - v1657.Position).Magnitude) or math.huge;
			if (v1658 < v482) then
				v480 = v1019;
				v481 = v1657;
				v482 = v1658;
			end
		else
			v106.chests[v1019] = nil;
		end
	end
	return v480, v481, v482;
end
local function v123(v484)
	local v485, v486, v487;
	v487 = math.huge;
	for v1020 in pairs(v106.fruits) do
		if v112(v1020) then
			local v1660 = v108(v1020);
			local v1661 = (v1660 and (v484 - v1660.Position).Magnitude) or math.huge;
			if (v1661 < v487) then
				v485 = v1020;
				v486 = v1660;
				v487 = v1661;
			end
		else
			v106.fruits[v1020] = nil;
		end
	end
	return v485, v486, v487;
end
for v489, v490 in ipairs(workspace:GetDescendants()) do
	if (v490:IsA("Tool") or v490:IsA("Model") or (v490:IsA("BasePart") and (v110(v490) or v490.Name:find("Chest", 1, true)))) then
		v114(v490);
	end
end
local v124 = {"dragon","leopard","kitsune","yeti","gas","control","spirit","venom","shadow","dough","t-rex","mammoth","gravity","blizzard"};
local function v125(v491)
	local v492 = tostring(v491):lower();
	for v1021, v1022 in ipairs(v124) do
		if v492:find(v1022, 1, true) then
			return true;
		end
	end
	return false;
end
local function v126()
	local v493, v494 = 0, 0;
	for v1023 in pairs(v106.fruits) do
		if v112(v1023) then
			v493 = v493 + 1;
		else
			v106.fruits[v1023] = nil;
		end
	end
	for v1024 in pairs(v106.chests) do
		if v113(v1024) then
			v494 = v494 + 1;
		else
			v106.chests[v1024] = nil;
		end
	end
	return v493, v494;
end
local function v127(v495)
	local v496 = os.clock();
	local v497 = {};
	local function v498(v1025, v1026, v1027, v1028, v1029)
		if (v1027 and (v1028 <= v31.collectorMaxDistance) and (v496 >= (v47.collectionIgnoredUntil[v1026] or 0))) then
			table.insert(v497, {kind=v1025,instance=v1026,part=v1027,distance=v1028,rare=(v1029 == true)});
		end
	end
	for v1030 in pairs(v106.fruits) do
		if v112(v1030) then
			local v1665 = v108(v1030);
			v498("Fruta", v1030, v1665, (v1665 and (v495 - v1665.Position).Magnitude) or math.huge, v125(v1030.Name));
		end
	end
	for v1031 in pairs(v106.chests) do
		if v113(v1031) then
			local v1666 = v108(v1031);
			v498("Baú", v1031, v1666, (v1666 and (v495 - v1666.Position).Magnitude) or math.huge, false);
		end
	end
	table.sort(v497, function(v1032, v1033)
		if (v1032.rare ~= v1033.rare) then
			return v1032.rare;
		end
		if ((v31.collectorPriority == "Frutas primeiro") and (v1032.kind ~= v1033.kind)) then
			return v1032.kind == "Fruta";
		elseif ((v31.collectorPriority == "Baús primeiro") and (v1032.kind ~= v1033.kind)) then
			return v1032.kind == "Baú";
		end
		return v1032.distance < v1033.distance;
	end);
	v47.collectionQueueSize = #v497;
	return v497[1], v497;
end
v48.isCollectionTargetValid = function(v500, v501)
	if (not v500 or not v500.Parent) then
		return false;
	end
	if (v501 == "Fruta") then
		return v112(v500);
	elseif (v501 == "Baú") then
		return v113(v500);
	end
	return false;
end;
v48.clearSmartCollectionTarget = function(v502, v503)
	local v504 = v47.collectionTarget;
	local v505 = v47.collectionTargetType;
	if (v504 and v502) then
		if (v505 == "Baú") then
			v47.chestsCollected = v47.chestsCollected + 1;
		elseif (v505 == "Fruta") then
			v47.fruitsCollected = v47.fruitsCollected + 1;
		end
		v48.appendActivity("Coletor", string.format("%s concluído: %s", v505 or "Objeto", v504.Name));
	elseif (v504 and v503) then
		v48.appendActivity("Coletor", string.format("%s: %s", v503, v504.Name));
	end
	v47.collectionTarget = nil;
	v47.collectionTargetPart = nil;
	v47.collectionTargetType = nil;
	v47.collectionTargetSince = 0;
end;
local function v130(v510)
	local v511 = v510:gsub("^Physical%s+", ""):gsub("%s+Fruit$", "");
	local v512 = {Chop="Blade-Blade",Falcon="Eagle-Eagle",Door="Portal-Portal",Paw="Pain-Pain",Soul="Spirit-Spirit",Kilo="Rocket-Rocket"};
	if v512[v511] then
		return v512[v511];
	end
	if v511:find("-", 1, true) then
		return v511;
	end
	if (v511 ~= "") then
		return v511 .. "-" .. v511;
	end
	return nil;
end
local function v131()
	local v513 = v18.Character;
	local v514 = v18:FindFirstChildOfClass("Backpack");
	local v515 = {};
	if v513 then
		table.insert(v515, v513);
	end
	if v514 then
		table.insert(v515, v514);
	end
	local v516 = os.clock();
	for v1034, v1035 in ipairs(v515) do
		for v1323, v1324 in ipairs(v1035:GetChildren()) do
			local v1325 = v47.fruitStoreRetryAt[v1324.Name] or 0;
			if (v1324:IsA("Tool") and v1324.Name:lower():find("fruit", 1, true) and (v516 >= v1325)) then
				local v1738 = v130(v1324.Name);
				if v1738 then
					local v1901, v1902 = pcall(function()
						return v23:InvokeServer("StoreFruit", v1738, v1324);
					end);
					if (not v1901 or (v1902 == false)) then
						v47.fruitStoreRetryAt[v1324.Name] = v516 + 10;
					else
						v47.fruitStoreRetryAt[v1324.Name] = v516 + 3;
					end
				end
			end
		end
	end
end
local v132 = {"KITT_RESET","Sub2Fer999","Magicbus","kittgaming","SECRET_ADMIN","SUB2GAMERROBOT_EXP1","Sub2NoobMaster123","Sub2UncleKizaru","Sub2Daigrock","Axiore","TantaiGaming","StrawHatMaine","THEGREATACE","Sub2OfficialNoobie","Starcodeheo","Bluxxy","Enyu_is_Pro","JCWK","fudd10_v2","FUDD10","BIGNEWS"};
local function v133()
	local v517 = nil;
	for v1036 = 1, 4 do
		local v1037 = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&excludeFullGames=true&limit=100%s", game.PlaceId, (v517 and ("&cursor=" .. v12:UrlEncode(v517))) or "");
		local v1038 = v12:JSONDecode(game:HttpGet(v1037));
		for v1326, v1327 in ipairs(v1038.data or {}) do
			if ((v1327.id ~= game.JobId) and (v1327.playing < v1327.maxPlayers)) then
				return v1327.id;
			end
		end
		v517 = v1038.nextPageCursor;
		if not v517 then
			break;
		end
	end
	return nil;
end
local function v134()
	local v518 = v18:FindFirstChild("Data");
	local v519 = v518 and v518:FindFirstChild("Level");
	return (v519 and v519.Value) or 1;
end
local function v135()
	local v520 = v18:FindFirstChildOfClass("PlayerGui") or v18:FindFirstChild("PlayerGui");
	local v521 = v520 and v520:FindFirstChild("Main");
	return v521 and v521:FindFirstChild("Quest");
end
local function v136()
	local v522 = v135();
	local v523 = v522 and v522:FindFirstChild("Container");
	local v524 = v523 and v523:FindFirstChild("QuestTitle");
	local v525 = v524 and v524:FindFirstChild("Title");
	return (v525 and v525.Text) or "";
end
v48.getQuestProgress = function()
	local v526 = v135();
	if (not v526 or not v526.Visible) then
		return "", nil, nil;
	end
	for v1040, v1041 in ipairs(v526:GetDescendants()) do
		if (v1041:IsA("TextLabel") and v1041.Visible) then
			local v1667, v1668 = v1041.Text:match("(%d+)%s*/%s*(%d+)");
			if (v1667 and v1668) then
				return v1041.Text, tonumber(v1667), tonumber(v1668);
			end
		end
	end
	return "", nil, nil;
end;
v48.updateQuestTelemetry = function(v527)
	local v528, v529, v530 = v48.getQuestProgress();
	if (v529 and v530) then
		if ((v47.questProgressCurrent ~= nil) and (v529 > v47.questProgressCurrent) and (v47.questProgressSampleAt > 0)) then
			local v1739 = math.max(0.1, v527 - v47.questProgressSampleAt);
			local v1740 = (v529 - v47.questProgressCurrent) / v1739;
			v47.questProgressRate = ((v47.questProgressRate > 0) and ((v47.questProgressRate * 0.65) + (v1740 * 0.35))) or v1740;
		end
		if (v47.questProgressCurrent ~= v529) then
			v47.questProgressSampleAt = v527;
		end
		v47.questProgressText = v528;
		v47.questProgressCurrent = v529;
		v47.questProgressTotal = v530;
	else
		v47.questProgressText = "";
		v47.questProgressCurrent = nil;
		v47.questProgressTotal = nil;
		v47.questProgressRate = 0;
		v47.questProgressSampleAt = 0;
	end
end;
v48.getQuestProgressSummary = function()
	local v531 = v47.questProgressCurrent;
	local v532 = v47.questProgressTotal;
	if (not v531 or not v532) then
		return "";
	end
	local v533 = "";
	if ((v47.questProgressRate > 0) and (v531 < v532)) then
		v533 = string.format(" | ETA %.0fs", (v532 - v531) / v47.questProgressRate);
	end
	return string.format(" | missão %d/%d%s", v531, v532, v533);
end;
local function v140(v534)
	return v534:match("^(.-)%s*%[Lv%.") or v534;
end
local v141 = {};
local function v142(v535, v536)
	if (not v535 or not v536) then
		return;
	end
	local v537 = v141[v535];
	if not v537 then
		v537 = {};
		v141[v535] = v537;
	end
	for v1042, v1043 in ipairs(v537) do
		if ((v1043 - v536).Magnitude <= 35) then
			return;
		end
	end
	table.insert(v537, v536);
end
local function v143()
	for v1044, v1045 in ipairs(v21:GetChildren()) do
		if v1045:IsA("BasePart") then
			v142(v140(v1045.Name), v1045.Position);
		end
	end
	for v1046, v1047 in ipairs(v20:GetChildren()) do
		if (v1047:IsA("Model") and not v6:GetPlayerFromCharacter(v1047)) then
			local v1669 = v1047:FindFirstChild("HumanoidRootPart");
			if v1669 then
				v142(v140(v1047.Name), v1669.Position);
			end
		end
	end
end
local function v144(v538)
	local v539 = v141[v538] or {};
	return table.clone(v539);
end
local function v145(v540)
	if (#v540 == 0) then
		return nil;
	end
	local v541 = Vector3.zero;
	for v1048, v1049 in ipairs(v540) do
		v541 += v1049
	end
	return v541 / #v540;
end
local function v146(v542, v543)
	local v544 = {};
	local v545 = (v29.Data and v29.Data.NPCList) or {};
	for v1050, v1051 in pairs(v545) do
		if (v1051.InternalQuestName == v542) then
			local v1670 = v543 == nil;
			for v1743, v1744 in ipairs(v1051.Levels or {}) do
				if (v1744 == v543) then
					v1670 = true;
					break;
				end
			end
			if v1670 then
				table.insert(v544, v1051.Position);
			end
		end
	end
	return v544;
end
local function v147(v546)
	for v1052, v1053 in pairs(v546.Task or {}) do
		return v1052, v1053;
	end
	return nil, 0;
end
local function v148(v547, v548)
	local v549, v550;
	for v1054, v1055 in ipairs(v547) do
		local v1056 = (v548 and (v1055 - v548).Magnitude) or 0;
		if (not v550 or (v1056 < v550)) then
			v549 = v1055;
			v550 = v1056;
		end
	end
	return v549;
end
local function v149()
	v143();
	local v551 = v134();
	local v552 = {};
	for v1057, v1058 in pairs(v28) do
		if (type(v1058) == "table") then
			for v1745, v1746 in pairs(v1058) do
				if ((type(v1746) == "table") and (type(v1746.LevelReq) == "number") and (v1746.LevelReq <= v551)) then
					local v1903, v1904 = v147(v1746);
					local v1905 = v146(v1057, v1746.LevelReq);
					local v1906 = v1904 <= 1;
					if (v1903 and (#v1905 > 0) and (not v31.skipBosses or not v1906)) then
						local v1957 = v144(v1903);
						if (#v1957 > 0) then
							table.insert(v552, {mode="Auto Level",level=v551,requiredLevel=v1746.LevelReq,questName=v1057,questTier=v1745,targetName=v1903,targetAmount=v1904,isBoss=v1906,spawnPositions=v1957,spawnPosition=v145(v1957),giverPositions=v1905});
						end
					end
				end
			end
		end
	end
	table.sort(v552, function(v1059, v1060)
		if (v1059.requiredLevel == v1060.requiredLevel) then
			return (tonumber(v1059.questTier) or 0) > (tonumber(v1060.questTier) or 0);
		end
		return v1059.requiredLevel > v1060.requiredLevel;
	end);
	local v553 = v552[1];
	if v553 then
		v553.questPosition = v148(v553.giverPositions, v553.spawnPosition);
	end
	return v553;
end
local function v150()
	v143();
	if (v31.selectedMob == "Automático") then
		return v149();
	end
	local v554 = v144(v31.selectedMob);
	if (#v554 == 0) then
		return nil;
	end
	return {mode="Mob selecionado",level=v134(),targetName=v31.selectedMob,spawnPositions=v554,spawnPosition=v145(v554)};
end
local function v151(v555)
	if (v555 or not v47.farmPlan or ((os.clock() - v47.lastPlanRefresh) >= 2)) then
		v47.lastPlanRefresh = os.clock();
		if (v31.farmMode == "Auto Level") then
			v47.farmPlan = v149();
		else
			v47.farmPlan = v150();
		end
	end
	return v47.farmPlan;
end
local function v152(v556, v557)
	if ((v47.farmState == v556) and (v47.farmDetail == v557)) then
		return;
	end
	v47.farmState = v556;
	v47.farmDetail = v557;
	if v50.farmStatus then
		pcall(function()
			v50.farmStatus:SetTitle("Status: " .. v556);
			v50.farmStatus:SetDesc(v557);
		end);
	end
end
local function v153(v560)
	local v561 = v47.npcBlacklist[v560];
	if not v561 then
		return false;
	end
	if (os.clock() >= v561) then
		v47.npcBlacklist[v560] = nil;
		return false;
	end
	return true;
end
local function v154(v562, v563)
	if not v562 then
		return;
	end
	v47.npcBlacklist[v562] = os.clock() + 12;
	v47.targetSwitches = v47.targetSwitches + 1;
	v48.appendActivity("Farm", string.format("Alvo trocado: %s (%s)", v562.Name, v563 or "sem progresso"));
end
local function v155(v566)
	local v567, v567, v568 = v75();
	if (not v568 or not v566) then
		return nil, nil, nil, math.huge;
	end
	local v569 = v47.combatTarget;
	if (v569 and (v569.Parent == v20) and v569:IsA("Model") and not v153(v569) and not v6:GetPlayerFromCharacter(v569) and (v140(v569.Name) == v566.targetName)) then
		local v1340 = v569:FindFirstChildOfClass("Humanoid");
		local v1341 = v569:FindFirstChild("HumanoidRootPart");
		if (v1340 and v1341 and (v1340.Health > 0)) then
			local v1749 = (v568.Position - v1341.Position).Magnitude;
			local v1750 = math.max(v31.remoteAttackRange * 4, 1200);
			if (v1749 <= v1750) then
				return v569, v1340, v1341, v1749;
			end
		end
	end
	local v570, v571, v572;
	local v573 = math.huge;
	local v574 = math.huge;
	for v1061, v1062 in ipairs(v20:GetChildren()) do
		if (v1062:IsA("Model") and not v153(v1062) and not v6:GetPlayerFromCharacter(v1062) and (v140(v1062.Name) == v566.targetName)) then
			local v1671 = v1062:FindFirstChildOfClass("Humanoid");
			local v1672 = v1062:FindFirstChild("HumanoidRootPart");
			if (v1671 and v1672 and (v1671.Health > 0)) then
				local v1878 = (v568.Position - v1672.Position).Magnitude;
				local v1879 = v1878;
				if v31.prioritizeNaturalGroups then
					local v1947 = 0;
					for v1958, v1959 in ipairs(v20:GetChildren()) do
						if ((v1959 ~= v1062) and (v140(v1959.Name) == v566.targetName)) then
							local v1991 = v1959:FindFirstChildOfClass("Humanoid");
							local v1992 = v1959:FindFirstChild("HumanoidRootPart");
							if (v1991 and v1992 and (v1991.Health > 0) and ((v1992.Position - v1672.Position).Magnitude <= 45)) then
								v1947 = v1947 + 1;
							end
						end
					end
					v1879 = v1878 - (math.min(v1947, 5) * 18);
				end
				if (v1879 < v574) then
					v574 = v1879;
					v573 = v1878;
					v570 = v1062;
					v571 = v1671;
					v572 = v1672;
				end
			end
		end
	end
	return v570, v571, v572, v573;
end
local function v156(v575, v576, v577)
	local v578, v578, v579 = v75();
	local v580 = v576 and v576:FindFirstChild("HumanoidRootPart");
	if (not v579 or not v580 or not v575) then
		return {};
	end
	local v581 = {};
	for v1063, v1064 in ipairs(v20:GetChildren()) do
		if (v1064:IsA("Model") and not v6:GetPlayerFromCharacter(v1064) and (v140(v1064.Name) == v575.targetName)) then
			local v1673 = v1064:FindFirstChildOfClass("Humanoid");
			local v1674 = v1064:FindFirstChild("HumanoidRootPart");
			if (v1673 and v1674 and (v1673.Health > 0)) then
				local v1880 = (v579.Position - v1674.Position).Magnitude;
				local v1881 = (v580.Position - v1674.Position).Magnitude;
				if ((v1880 <= v577) and ((v1064 == v576) or (v1881 <= v31.combatGroupRadius))) then
					table.insert(v581, {model=v1064,groupDistance=v1881,playerDistance=v1880,primary=(v1064 == v576)});
				end
			end
		end
	end
	table.sort(v581, function(v1065, v1066)
		if (v1065.primary ~= v1066.primary) then
			return v1065.primary;
		end
		if (v1065.groupDistance == v1066.groupDistance) then
			return v1065.playerDistance < v1066.playerDistance;
		end
		return v1065.groupDistance < v1066.groupDistance;
	end);
	local v582 = {};
	local v583 = math.clamp(math.floor(v31.maxCombatTargets), 1, 6);
	for v1067 = 1, math.min(v583, #v581) do
		table.insert(v582, v581[v1067].model);
	end
	return v582;
end
local function v157(v584, v585, v586)
	local v587 = v584.spawnPositions or {v584.spawnPosition};
	if (#v587 == 0) then
		return v584.spawnPosition;
	end
	if ((v47.spawnTargetName ~= v584.targetName) or (v47.spawnIndex < 1) or (v47.spawnIndex > #v587)) then
		v47.spawnTargetName = v584.targetName;
		v47.spawnIndex = 1;
		local v1345 = math.huge;
		for v1675, v1676 in ipairs(v587) do
			local v1677 = (v585 - v1676).Magnitude;
			if (v1677 < v1345) then
				v1345 = v1677;
				v47.spawnIndex = v1675;
			end
		end
		v47.lastSpawnAdvance = v586;
	end
	local v588 = v587[v47.spawnIndex];
	if (((v585 - v588).Magnitude <= 25) and ((v586 - v47.lastSpawnAdvance) >= 2.5) and (#v587 > 1)) then
		v47.spawnIndex = (v47.spawnIndex % #v587) + 1;
		v47.lastSpawnAdvance = v586;
		v588 = v587[v47.spawnIndex];
	end
	return v588;
end
local function v158()
	if v47.travelTweenConnection then
		pcall(function()
			v47.travelTweenConnection:Disconnect();
		end);
	end
	v47.travelTweenConnection = nil;
end
local function v159(v590)
	local v591 = v47.travelTween;
	local v592 = v47.travelTweenRoot;
	local v593 = v47.travelAnchor;
	v158();
	v47.travelTween = nil;
	v47.travelTweenRoot = nil;
	v47.travelTweenTarget = nil;
	v47.travelTweenEndpoint = nil;
	v47.travelGeneration = v47.travelGeneration + 1;
	if v591 then
		pcall(function()
			v591:Cancel();
		end);
	end
	if ((v590 ~= false) and v592 and v592.Parent and v593 and v593.Parent) then
		v593.CFrame = v592.CFrame;
	end
end
local function v160()
	if v47.travelAnchor then
		pcall(function()
			v47.travelAnchor:Destroy();
		end);
	end
	v47.travelAnchor = nil;
end
local function v161(v600)
	local v601 = v47.travelAnchor;
	if (not v601 or not v601.Parent) then
		v601 = Instance.new("Part");
		v601.Name = "RoyalHub_TravelAnchor";
		v601.Size = Vector3.one;
		v601.Anchored = true;
		v601.CanCollide = false;
		v601.CanQuery = false;
		v601.CanTouch = false;
		v601.Transparency = 1;
		v601.CFrame = v600.CFrame;
		v601.Parent = workspace;
		v47.travelAnchor = v601;
	elseif (not v47.travelTween and ((v601.Position - v600.Position).Magnitude > 6)) then
		v601.CFrame = v600.CFrame;
	end
	return v601;
end
local function v162()
	if v47.flightStabilizer then
		pcall(function()
			v47.flightStabilizer:Destroy();
		end);
	end
	v47.flightStabilizer = nil;
end
local function v163(v603)
	local v604 = v47.flightStabilizer;
	if (v604 and (v604.Parent ~= v603)) then
		v162();
		v604 = nil;
	end
	if not v604 then
		v604 = Instance.new("BodyVelocity");
		v604.Name = "RoyalHub_FarmStabilizer";
		v604.MaxForce = Vector3.new(math.huge, math.huge, math.huge);
		v604.P = 1250;
		v604.Velocity = Vector3.zero;
		v604.Parent = v603;
		v47.flightStabilizer = v604;
	end
	return v604;
end
local function v164(v605, v606)
	if (not v31.useEntrances or (v606.Y < 4000)) then
		return false;
	end
	local v607 = v605.Position.Y;
	if ((v607 >= 3000) and (v607 <= 8000)) then
		return false;
	end
	if ((v606 - v605.Position).Magnitude < 2500) then
		return false;
	end
	if ((os.clock() - v47.lastEntrance) < 3) then
		v152("Aguardando portal", "Sincronizando a entrada de SkyArea2");
		return true;
	end
	local v608 = workspace:FindFirstChild("Map");
	local v609 = v608 and v608:FindFirstChild("SkyArea2");
	local v610 = v609 and v609:FindFirstChild("PathwayHouse");
	local v611 = v610 and v610:FindFirstChild("EntrancePoint");
	if (not v611 or not v611:IsA("BasePart")) then
		return false;
	end
	v47.lastEntrance = os.clock();
	v159();
	v152("Usando portal", "Entrada oficial para SkyArea2");
	pcall(function()
		v23:InvokeServer("requestEntrance", v611.Position);
	end);
	return true;
end
local function v165(v613, v614, v615)
	if ((typeof(v614) ~= "Vector3") or (v614.X ~= v614.X) or (v614.Y ~= v614.Y) or (v614.Z ~= v614.Z) or (v614.Magnitude > 1000000)) then
		v159();
		v152("Rota inválida", "O destino foi descartado com segurança");
		return false;
	end
	if v164(v613, v614) then
		v162();
		return false;
	end
	v163(v613);
	local v616 = v161(v613);
	local v617 = v614 - v613.Position;
	local v618 = v617.Magnitude;
	if (v618 <= 6) then
		v159();
		v613.AssemblyLinearVelocity = Vector3.zero;
		v613.AssemblyAngularVelocity = Vector3.zero;
		return true;
	end
	if (os.clock() < v47.travelRetryAfter) then
		return false;
	end
	local v619 = not v47.travelTweenTarget or ((v47.travelTweenTarget - v614).Magnitude > (v615 or 18)) or (v47.travelTweenRoot ~= v613);
	local v620 = v47.travelTween and (v47.travelTween.PlaybackState == Enum.PlaybackState.Playing);
	if (v620 and not v619) then
		return false;
	end
	v159();
	v616.CFrame = v613.CFrame;
	v617 = v614 - v616.Position;
	v618 = v617.Magnitude;
	local v624 = ((v31.movementMode == "Rápido") and math.max(v31.travelSpeed, 650)) or v31.travelSpeed;
	if ((os.clock() - v47.lastServerCorrection) < 3) then
		v624 = math.min(v624, 280);
	end
	local v625 = os.clock() < v47.safeTravelUntil;
	if v625 then
		v624 = math.min(v624, 180);
	end
	local v626 = (v625 and 220) or ((v31.movementMode == "Rápido") and 650) or 450;
	local v627 = v616.Position + (v617.Unit * math.min(v618, v626));
	local v628 = math.max((v627 - v616.Position).Magnitude / v624, 0.08);
	local v629 = Vector3.new(v617.X, 0, v617.Z);
	if (v629.Magnitude <= 0.01) then
		v629 = Vector3.zAxis;
	end
	local v630 = CFrame.lookAt(v627, v627 + v629.Unit);
	local v631 = v8:Create(v616, TweenInfo.new(v628, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {CFrame=v630});
	v47.travelGeneration = v47.travelGeneration + 1;
	local v633 = v47.travelGeneration;
	v47.travelTween = v631;
	v47.travelTweenRoot = v613;
	v47.travelTweenTarget = v614;
	v47.travelTweenEndpoint = v627;
	v47.travelTweenConnection = v631.Completed:Connect(function(v1068)
		if ((v47.travelTween ~= v631) or (v47.travelGeneration ~= v633)) then
			return;
		end
		v158();
		v47.travelTween = nil;
		v47.travelTweenRoot = nil;
		v47.travelTweenTarget = nil;
		v47.travelTweenEndpoint = nil;
		if ((v1068 == Enum.PlaybackState.Completed) and v613.Parent and v616.Parent and (v31.farmEnabled or v31.chestFarm or v31.fruitCollector or v31.smartCollector or v31.manualTravel)) then
			v613.AssemblyLinearVelocity = Vector3.zero;
			v613.AssemblyAngularVelocity = Vector3.zero;
			v613.CFrame = v616.CFrame;
		elseif (v613.Parent and v616.Parent) then
			v616.CFrame = v613.CFrame;
		end
	end);
	v613.AssemblyLinearVelocity = Vector3.zero;
	v613.AssemblyAngularVelocity = Vector3.zero;
	v631:Play();
	return false;
end
local function v166(v642)
	local v643 = v642.CFrame.LookVector;
	local v644 = Vector3.new(v643.X, 0, v643.Z);
	if (v644.Magnitude <= 0.01) then
		v644 = Vector3.zAxis;
	else
		v644 = v644.Unit;
	end
	local v645 = v642.AssemblyLinearVelocity;
	local v646 = Vector3.new(v645.X, 0, v645.Z);
	local v647 = Vector3.zero;
	if (v646.Magnitude > 1) then
		v647 = v646.Unit * math.min(v646.Magnitude * 0.12, 4);
	end
	return (v642.Position - (v644 * v31.followOffset)) + v647 + Vector3.new(0, v31.hoverHeight, 0);
end
local function v167(v648, v649)
	if (#v648 <= 1) then
		return v166(v649);
	end
	local v650 = Vector3.zero;
	local v651 = Vector3.zero;
	local v652 = 0;
	for v1073, v1074 in ipairs(v648) do
		local v1075 = v1074:FindFirstChild("HumanoidRootPart");
		local v1076 = v1074:FindFirstChildOfClass("Humanoid");
		if (v1075 and v1076 and (v1076.Health > 0)) then
			v650 = v650 + v1075.Position;
			v651 = v651 + v1075.AssemblyLinearVelocity;
			v652 = v652 + 1;
		end
	end
	if (v652 <= 1) then
		return v166(v649);
	end
	local v653 = v649.CFrame.LookVector;
	local v654 = Vector3.new(v653.X, 0, v653.Z);
	v654 = ((v654.Magnitude > 0.01) and v654.Unit) or Vector3.zAxis;
	local v655 = v651 / v652;
	local v656 = Vector3.new(v655.X, 0, v655.Z);
	local v657 = ((v656.Magnitude > 1) and (v656.Unit * math.min(v656.Magnitude * 0.12, 4))) or Vector3.zero;
	return ((v650 / v652) - (v654 * v31.followOffset)) + v657 + Vector3.new(0, v31.hoverHeight, 0);
end
local function v168(v658)
	local v659 = v135();
	if (not v658 or not v659 or not v659.Visible) then
		return false;
	end
	return v136():upper():find(v658.targetName:upper(), 1, true) ~= nil;
end
local function v169(v660)
	v10:SendKeyEvent(true, v660, false, game);
	task.wait(0.03);
	v10:SendKeyEvent(false, v660, false, game);
end
local function v170()
	local v661 = {};
	if v31.skillZ then
		table.insert(v661, Enum.KeyCode.Z);
	end
	if v31.skillX then
		table.insert(v661, Enum.KeyCode.X);
	end
	if v31.skillC then
		table.insert(v661, Enum.KeyCode.C);
	end
	if v31.skillV then
		table.insert(v661, Enum.KeyCode.V);
	end
	if (#v661 == 0) then
		return;
	end
	v47.skillIndex = (v47.skillIndex % #v661) + 1;
	v169(v661[v47.skillIndex]);
end
local function v171(v663)
	return v663 and v663:IsA("Tool") and (v663.ToolTip ~= "Wear");
end
local function v172(v664)
	local v665 = v18.Character;
	local v666 = v18:FindFirstChildOfClass("Backpack");
	return (v665 and v665:FindFirstChild(v664)) or (v666 and v666:FindFirstChild(v664));
end
local function v173()
	local v667, v668 = v75();
	if not v668 then
		return;
	end
	v668:UnequipTools();
	if v49.equippedTool then
		local v1377 = v172(v49.equippedTool);
		if v1377 then
			v668:EquipTool(v1377);
		end
	end
end
local function v174()
	local v669 = v18.Character;
	local v670 = v669 and v669:FindFirstChildOfClass("Tool");
	v47.preFarmTool = (v670 and v670.Name) or false;
	v47.preFarmAura = (v669 and (v669:FindFirstChild("HasBuso") ~= nil)) or false;
	v47.auraActivatedByFarm = false;
end
local function v175()
	local v674, v675 = v75();
	if (not v675 or (v47.preFarmTool == nil)) then
		v47.preFarmTool = nil;
		return;
	end
	v675:UnequipTools();
	if v47.preFarmTool then
		local v1379 = v172(v47.preFarmTool);
		if v1379 then
			v675:EquipTool(v1379);
		end
	end
	v47.preFarmTool = nil;
end
local function v176()
	local v677 = v18.Character;
	if (v47.auraActivatedByFarm and (v47.preFarmAura == false) and v677 and v677:FindFirstChild("HasBuso")) then
		pcall(function()
			v23:InvokeServer("Buso");
		end);
	end
	v47.preFarmAura = nil;
	v47.auraActivatedByFarm = false;
end
local function v177(v680, v681)
	local v682 = v680:FindFirstChildOfClass("Tool");
	if (v31.selectedTool == "Equipado") then
		return (v171(v682) and v682) or nil;
	end
	local v683;
	local v684 = v31.selectedTool:match("^Categoria: (.+)$");
	if v684 then
		if (v171(v682) and (v682.ToolTip == v684)) then
			v683 = v682;
		else
			local v1753 = v18:FindFirstChildOfClass("Backpack");
			for v1885, v1886 in ipairs((v1753 and v1753:GetChildren()) or {}) do
				if (v171(v1886) and (v1886.ToolTip == v684)) then
					v683 = v1886;
					break;
				end
			end
		end
	elseif (v31.selectedTool ~= "Automático") then
		v683 = v172(v31.selectedTool);
	else
		local v1754 = {"Melee","Sword"};
		if v171(v682) then
			for v1948, v1949 in ipairs(v1754) do
				if (v682.ToolTip == v1949) then
					v683 = v682;
					break;
				end
			end
		end
		local v1755 = v18:FindFirstChildOfClass("Backpack");
		if (not v683 and v1755) then
			for v1950, v1951 in ipairs(v1754) do
				for v1960, v1961 in ipairs(v1755:GetChildren()) do
					if (v171(v1961) and (v1961.ToolTip == v1951)) then
						v683 = v1961;
						break;
					end
				end
				if v683 then
					break;
				end
			end
		end
		if (not v683 and v171(v682)) then
			v683 = v682;
		end
		if not v683 then
			if v1755 then
				for v1983, v1984 in ipairs(v1755:GetChildren()) do
					if v171(v1984) then
						v683 = v1984;
						break;
					end
				end
			end
		end
	end
	if (v683 and (v683.Parent ~= v680)) then
		if not v31.autoEquip then
			return nil;
		end
		v681:EquipTool(v683);
	end
	return v683;
end
local function v178(v685)
	if (not v685 or (v685.Parent ~= v20) or v6:GetPlayerFromCharacter(v685)) then
		return nil;
	end
	return v685:FindFirstChild("RightHand") or v685:FindFirstChild("LeftHand") or v685:FindFirstChild("UpperTorso") or v685:FindFirstChild("Torso") or v685:FindFirstChild("HumanoidRootPart") or v685:FindFirstChildWhichIsA("BasePart", true);
end
local function v179(v686, v687)
	if not v686 then
		return false;
	end
	local v688 = ((type(v687) == "table") and v687) or {v687};
	local v689 = v688[1];
	local v690 = v18.Character;
	local v691 = v690 and v690:FindFirstChild("HumanoidRootPart");
	local v692 = v691 and ((v691:FindFirstChild("Buddha") or v691:FindFirstChild("Buddha2")) ~= nil);
	local v693 = v689;
	if (not v692 and (#v688 > 1)) then
		v47.combatGroupCursor = (v47.combatGroupCursor % #v688) + 1;
		v693 = v688[v47.combatGroupCursor];
	end
	local v694 = v693 and v693:FindFirstChildOfClass("Humanoid");
	local v695 = v178(v693);
	if (not v694 or (v694.Health <= 0) or not v695) then
		return false;
	end
	local v696 = v47.combatGeneration;
	v47.comboIndex = (v47.comboIndex % 2) + 1;
	local v698 = pcall(function()
		v25:FireServer(0.5, v47.comboIndex);
	end);
	if not v698 then
		return false;
	end
	task.delay(0.06, function()
		if (not v4.alive() or not v31.farmEnabled or (v47.combatGeneration ~= v696) or (v47.combatTarget ~= v689) or not v695.Parent or (v694.Health <= 0)) then
			return;
		end
		local v1077 = {};
		if v692 then
			for v1756 = 2, #v688 do
				local v1757 = v688[v1756];
				local v1758 = v1757 and v1757:FindFirstChildOfClass("Humanoid");
				local v1759 = v178(v1757);
				if (v1758 and (v1758.Health > 0) and v1759) then
					table.insert(v1077, {v1757,v1759});
				end
			end
		end
		pcall(function()
			if (typeof(v27.SendHitsToServer) == "function") then
				v27.SendHitsToServer(v695, v1077);
			else
				v26:FireServer(v695, v1077);
			end
		end);
	end);
	return true;
end
local function v180(v699, v700)
	if not v699 then
		return;
	end
	v47.syncingUi = true;
	pcall(function()
		v699:Set(v700);
	end);
	v47.syncingUi = false;
end
local function v181(v702)
	v31.farmEnabled = false;
	v47.combatGeneration = v47.combatGeneration + 1;
	if (not v31.chestFarm and not v31.fruitCollector and not v31.smartCollector and not v31.manualTravel) then
		v159();
		v160();
	end
	v162();
	v47.farmPlan = nil;
	v47.spawnIndex = 0;
	v47.spawnTargetName = nil;
	v47.combatTarget = nil;
	v47.combatTargetHealth = nil;
	v47.combatGroupSize = 0;
	v47.combatGroupCursor = 0;
	v47.seaFarmTarget = nil;
	v47.combatHealthByTarget = setmetatable({}, {__mode="k"});
	v47.lastDamageObserved = 0;
	v47.remoteFallbackUntil = 0;
	v47.remoteFailureCount = 0;
	v47.serverCorrectionCount = 0;
	v47.safeTravelUntil = 0;
	v47.travelRetryAfter = 0;
	v152("Parado", "Auto farm desligado");
	local v720, v721 = v75();
	if v721 then
		v721:Move(Vector3.zero, false);
	end
	if not v31.noclip then
		v80();
	end
	v175();
	v176();
	if v702 then
		v180(v50.farmToggle, false);
	end
end
local function v182(v722)
	v181(v722);
	v31.movementEnabled = false;
	v31.infiniteJump = false;
	v31.noclip = false;
	v31.walkOnWater = false;
	v31.fovEnabled = false;
	v31.fullBright = false;
	v31.noFog = false;
	v31.npcEsp = false;
	v31.fruitEsp = false;
	v31.chestEsp = false;
	v31.islandEsp = false;
	v31.antiAfk = false;
	v31.autoObservation = false;
	v31.autoRaceAbility = false;
	v31.autoStats = false;
	v31.chestFarm = false;
	v31.fruitCollector = false;
	v31.smartCollector = false;
	v31.autoStoreFruit = false;
	v31.manualTravel = false;
	v31.autoSetSpawn = false;
	v31.autoRollFruit = false;
	v31.disableGameNotifications = false;
	v31.disableDamageCounter = false;
	v31.fpsBoost = false;
	v31.staffAlerts = false;
	v31.autoSecondSea = false;
	v31.autoThirdSea = false;
	v47.collectionState = "Parado";
	v47.collectionDetail = "Coletores desligados";
	v47.collectionOverride = false;
	v47.collectionTarget = nil;
	v47.collectionTargetPart = nil;
	v47.collectionTargetType = nil;
	v47.fruitStoreRetryAt = {};
	v47.manualTravelName = nil;
	v47.manualTravelPosition = nil;
	v159();
	v160();
	v78();
	v80();
	v81();
	v89();
	v84();
	v87();
	v91();
	v93();
	v96();
	v101();
	v104("RoyalHub_FruitHighlight");
	v104("RoyalHub_ChestHighlight");
	v119();
	v173();
	if v722 then
		v180(v50.movementToggle, false);
		v180(v50.jumpToggle, false);
		v180(v50.noclipToggle, false);
		v180(v50.waterWalkToggle, false);
		v180(v50.fovToggle, false);
		v180(v50.fullBrightToggle, false);
		v180(v50.noFogToggle, false);
		v180(v50.espToggle, false);
		v180(v50.fruitEspToggle, false);
		v180(v50.chestEspToggle, false);
		v180(v50.islandEspToggle, false);
		v180(v50.antiAfkToggle, false);
		v180(v50.observationToggle, false);
		v180(v50.raceAbilityToggle, false);
		v180(v50.autoStatsToggle, false);
		v180(v50.chestFarmToggle, false);
		v180(v50.fruitCollectorToggle, false);
		v180(v50.smartCollectorToggle, false);
		v180(v50.autoStoreFruitToggle, false);
		v180(v50.autoSetSpawnToggle, false);
		v180(v50.autoRollFruitToggle, false);
		v180(v50.gameNotificationsToggle, false);
		v180(v50.damageCounterToggle, false);
		v180(v50.fpsBoostToggle, false);
		v180(v50.staffAlertsToggle, false);
		v180(v50.secondSeaToggle, false);
		v180(v50.thirdSeaToggle, false);
	end
end
local function v183()
	v143();
	local v760 = {};
	for v1078 in pairs(v141) do
		v760[v1078] = true;
	end
	local v761 = {"Automático"};
	for v1080 in pairs(v760) do
		table.insert(v761, v1080);
	end
	table.sort(v761, function(v1081, v1082)
		if (v1081 == "Automático") then
			return true;
		elseif (v1082 == "Automático") then
			return false;
		end
		return v1081:lower() < v1082:lower();
	end);
	return v761;
end
local function v184()
	local v762 = {["Automático"]=true,Equipado=true,["Categoria: Melee"]=true,["Categoria: Sword"]=true,["Categoria: Blox Fruit"]=true,["Categoria: Gun"]=true};
	local v763 = {"Automático","Equipado","Categoria: Melee","Categoria: Sword","Categoria: Blox Fruit","Categoria: Gun"};
	local function v764(v1083)
		if not v1083 then
			return;
		end
		for v1382, v1383 in ipairs(v1083:GetChildren()) do
			if (v171(v1383) and not v762[v1383.Name]) then
				v762[v1383.Name] = true;
				table.insert(v763, v1383.Name);
			end
		end
	end
	v764(v18.Character);
	v764(v18:FindFirstChildOfClass("Backpack"));
	return v763;
end
local v185 = {};
local function v186()
	table.clear(v185);
	local v765 = v19:FindFirstChild("Locations");
	local v766 = {};
	local v767 = {};
	for v1084, v1085 in ipairs((v765 and v765:GetChildren()) or {}) do
		if (v1085:IsA("BasePart") and (v1085.Name ~= "Sea") and (v1085.Name ~= "Whirlpool") and (v1085.Name ~= "Underwater City")) then
			v767[v1085.Name] = (v767[v1085.Name] or 0) + 1;
			table.insert(v766, v1085);
		end
	end
	table.sort(v766, function(v1086, v1087)
		if (v1086.Name == v1087.Name) then
			return v1086.Position.Y < v1087.Position.Y;
		end
		return v1086.Name < v1087.Name;
	end);
	local v768 = {};
	for v1088, v1089 in ipairs(v766) do
		local v1090 = v1089.Name;
		if (v767[v1089.Name] > 1) then
			v1090 = string.format("%s (alt. %.0f)", v1089.Name, v1089.Position.Y);
		end
		v185[v1090] = v1089.Position;
		table.insert(v768, v1090);
	end
	return v768;
end
local v187 = v186();
local function v188(v769)
	local v770, v771;
	for v1093, v1094 in pairs(v185) do
		local v1095 = (Vector3.new(v769.X, 0, v769.Z) - Vector3.new(v1094.X, 0, v1094.Z)).Magnitude;
		if (not v771 or (v1095 < v771)) then
			v770 = v1093;
			v771 = v1095;
		end
	end
	return v770, v771 or math.huge;
end
do
	local v772, v772, v773 = v75();
	v31.selectedIsland = (v773 and v188(v773.Position)) or v187[1];
end
local function v189()
	local v775 = {};
	for v1096, v1097 in pairs(v47.favoriteIslands) do
		if v1097 then
			table.insert(v775, v1096);
		end
	end
	table.sort(v775);
	v31.favoriteIslandsCsv = table.concat(v775, "|");
	v31.recentDestinationsCsv = table.concat(v47.recentDestinations, "|");
end
local function v190(v778)
	local v779 = table.find(v47.recentDestinations, v778);
	if v779 then
		table.remove(v47.recentDestinations, v779);
	end
	table.insert(v47.recentDestinations, 1, v778);
	while #v47.recentDestinations > 8 do
		table.remove(v47.recentDestinations);
	end
	v189();
end
local function v191(v780)
	v31.manualTravel = false;
	v47.manualTravelName = nil;
	v47.manualTravelPosition = nil;
	v47.travelEta = 0;
	v159();
	v160();
	v162();
	if (not v31.noclip and not v31.farmEnabled and not v31.chestFarm and not v31.fruitCollector and not v31.smartCollector) then
		v80();
	end
	if v50.travelStatus then
		pcall(function()
			v50.travelStatus:SetTitle("Travel: Parado");
			v50.travelStatus:SetDesc(v780 or "Nenhuma rota manual ativa");
		end);
	end
end
local function v192(v785, v786)
	if (typeof(v786) ~= "Vector3") then
		return false;
	end
	v31.manualTravel = false;
	v181(true);
	v31.chestFarm = false;
	v31.fruitCollector = false;
	v31.smartCollector = false;
	v180(v50.chestFarmToggle, false);
	v180(v50.fruitCollectorToggle, false);
	v180(v50.smartCollectorToggle, false);
	v159();
	v160();
	v47.manualTravelName = v785;
	v47.manualTravelPosition = v786;
	v47.travelStartedAt = os.clock();
	local v794, v794, v795 = v75();
	v47.travelInitialDistance = (v795 and (v795.Position - v786).Magnitude) or 0;
	v47.travelEta = v47.travelInitialDistance / math.max(v31.travelSpeed, 1);
	v190(v785);
	v48.appendActivity("Travel", "Iniciado: " .. tostring(v785));
	v31.manualTravel = true;
	if v50.travelStatus then
		pcall(function()
			v50.travelStatus:SetTitle("Travel: Em rota");
			v50.travelStatus:SetDesc(v785);
		end);
	end
	return true;
end
local v193 = {["Atributo único"]=nil,["Melee + Defense"]={"Melee","Defense"},["Melee + Defense + Sword"]={"Melee","Defense","Sword"},["Melee + Defense + Fruit"]={"Melee","Defense","Demon Fruit"},["Todos balanceados"]={"Melee","Defense","Sword","Gun","Demon Fruit"}};
local function v194()
	if (v31.statProfile == "Atributo único") then
		local v1384 = v18:FindFirstChild("Data");
		local v1385 = v1384 and v1384:FindFirstChild("Stats");
		local v1386 = v1385 and v1385:FindFirstChild(v31.statName);
		local v1387 = v1386 and v1386:FindFirstChild("Level");
		return (v1387 and (v1387.Value < v31.statCap) and v31.statName) or nil;
	end
	local v798 = v18:FindFirstChild("Data");
	local v799 = v798 and v798:FindFirstChild("Stats");
	local v800 = v193[v31.statProfile] or {v31.statName};
	local v801, v802;
	for v1098, v1099 in ipairs(v800) do
		local v1100 = v799 and v799:FindFirstChild(v1099);
		local v1101 = v1100 and v1100:FindFirstChild("Level");
		if (v1101 and v1101:IsA("IntValue") and (v1101.Value < v31.statCap) and ((v802 == nil) or (v1101.Value < v802))) then
			v801 = v1099;
			v802 = v1101.Value;
		end
	end
	return v801;
end
v48.recordStatAllocation = function(v803, v804)
	local v805 = v47.statHistory[1];
	if (v805 and (v805.name == v803)) then
		v805.amount = v805.amount + v804;
		v805.time = os.clock() - v47.sessionStartedAt;
	else
		table.insert(v47.statHistory, 1, {name=v803,amount=v804,time=(os.clock() - v47.sessionStartedAt)});
	end
	while #v47.statHistory > 12 do
		table.remove(v47.statHistory);
	end
end;
v48.getStatHistoryText = function()
	local v806 = {};
	for v1102 = 1, math.min(8, #v47.statHistory) do
		local v1103 = v47.statHistory[v1102];
		table.insert(v806, string.format("[%s] %s: +%d", v48.formatDuration(v1103.time), v1103.name, v1103.amount));
	end
	return ((#v806 > 0) and table.concat(v806, "\n")) or "Nenhum ponto distribuído nesta sessão";
end;
v48.buildStatPreview = function()
	local v807 = v18:FindFirstChild("Data");
	local v808 = v807 and v807:FindFirstChild("Points");
	local v809 = v807 and v807:FindFirstChild("Stats");
	local v810 = math.max(0, ((v808 and v808.Value) or 0) - v31.statReserve);
	local v811 = {};
	for v1104, v1105 in ipairs({"Melee","Defense","Sword","Gun","Demon Fruit"}) do
		local v1106 = v809 and v809:FindFirstChild(v1105);
		local v1107 = v1106 and v1106:FindFirstChild("Level");
		v811[v1105] = (v1107 and v1107.Value) or v31.statCap;
	end
	local v812 = ((v31.statProfile == "Atributo único") and {v31.statName}) or v193[v31.statProfile] or {v31.statName};
	local v813 = {};
	local v814 = 0;
	while (v810 > 0) and (v814 < 1000) do
		local v1109, v1110;
		for v1390, v1391 in ipairs(v812) do
			local v1392 = v811[v1391];
			if ((v1392 < v31.statCap) and ((v1110 == nil) or (v1392 < v1110))) then
				v1109 = v1391;
				v1110 = v1392;
			end
		end
		if not v1109 then
			break;
		end
		local v1111 = math.min(v31.statBatch, v810, v31.statCap - v811[v1109]);
		v811[v1109] = v811[v1109] + v1111;
		v813[v1109] = (v813[v1109] or 0) + v1111;
		v810 = v810 - v1111;
		v814 = v814 + 1;
	end
	local v815 = {string.format("Disponível após reserva: %d", math.max(0, ((v808 and v808.Value) or 0) - v31.statReserve)),string.format("Lote: %d | Limite: %d", v31.statBatch, v31.statCap)};
	for v1114, v1115 in ipairs(v812) do
		table.insert(v815, string.format("%s: +%d → %d", v1115, v813[v1115] or 0, v811[v1115]));
	end
	if (v810 > 0) then
		table.insert(v815, string.format("Restante não distribuível: %d", v810));
	end
	return table.concat(v815, "\n");
end;
local function v198()
	local v816 = "DLCBoxData";
	pcall(function()
		local v1116 = v17(v15, "Controllers");
		local v1117 = require(v17(v1116, "BannerClient"));
		local v1118 = v1117.TryGetBannerItemIfActiveAsync();
		if (v1118 and (type(v1118.BoxName) == "string")) then
			v816 = v1118.BoxName;
		end
	end);
	local v817, v818, v819, v820 = pcall(function()
		return v23:InvokeServer("Cousin", "Check", v816);
	end);
	if not v817 then
		return nil, "Consulta indisponível";
	end
	return {boxName=v816,level=(tonumber(v819) or v134()),cost=tonumber(v820)};
end
local function v199(v821)
	local v822, v823 = v198();
	if not v822 then
		return false, v823;
	end
	local v824, v825 = pcall(function()
		return v23:InvokeServer("Cousin", "CheckTime", v822.boxName);
	end);
	if not v824 then
		return false, "Tempo do Zioles indisponível";
	end
	if (v825 ~= true) then
		return false, tostring(v825);
	end
	if not v821 then
		return true, string.format("Disponível | custo: $%s", (v822.cost and tostring(v822.cost)) or "?");
	end
	v47.fruitRollAttempts = v47.fruitRollAttempts + 1;
	local v827 = v18:FindFirstChild("Data");
	local v828 = v827 and v827:FindFirstChild("Beli");
	local v829 = (v828 and v828:IsA("ValueBase") and tonumber(v828.Value)) or nil;
	if (v822.cost and v829 and (v829 < v822.cost)) then
		v47.lastFruitRollMessage = string.format("Beli insuficiente: $%s / $%s", tostring(v829), tostring(v822.cost));
		return false, v47.lastFruitRollMessage;
	end
	local v830, v831, v832 = pcall(function()
		return v23:InvokeServer("Cousin", v822.boxName);
	end);
	if not v830 then
		v47.lastFruitRollMessage = "Falha de comunicação: " .. tostring(v831);
		return false, v47.lastFruitRollMessage;
	elseif (v831 == 1) then
		v47.lastFruitRollMessage = "O Zioles ainda está em recarga";
		return false, v47.lastFruitRollMessage;
	elseif (v831 == 2) then
		v47.lastFruitRollMessage = "Beli insuficiente para este roll";
		return false, v47.lastFruitRollMessage;
	elseif (v831 == 3) then
		v47.lastFruitRollMessage = "Nível mínimo do gacha ainda não foi atingido";
		return false, v47.lastFruitRollMessage;
	elseif (type(v831) == "string") then
		v47.lastFruitRollMessage = v831;
		return false, v47.lastFruitRollMessage;
	elseif ((typeof(v831) ~= "table") or not v831[2]) then
		v47.lastFruitRollMessage = "O servidor não confirmou a fruta recebida";
		return false, v47.lastFruitRollMessage;
	end
	v47.fruitRollSuccesses = v47.fruitRollSuccesses + 1;
	v47.lastFruitRollMessage = "Roll confirmado" .. ((v832 and (" | " .. tostring(v832))) or "");
	return true, v47.lastFruitRollMessage;
end
local function v200(v835)
	if (not v31.staffAlerts or (v835 == v18) or (game.CreatorType ~= Enum.CreatorType.Group) or v47.staffAlerted[v835.UserId]) then
		return;
	end
	task.spawn(function()
		local v1119, v1120 = pcall(function()
			return v835:GetRankInGroup(game.CreatorId);
		end);
		if (v1119 and (v1120 >= 200) and v31.staffAlerts and v4.alive()) then
			v47.staffAlerted[v835.UserId] = true;
			local v1687 = "rank " .. tostring(v1120);
			pcall(function()
				v1687 = v835:GetRoleInGroup(game.CreatorId);
			end);
			v54("Alerta de staff", string.format("%s entrou | %s\nNenhuma troca automática de servidor foi executada.", v835.Name, v1687), "shield-alert", 8);
		end
	end);
end
local function v201(v836)
	if ((v47.seaFarmTarget == v836) and v31.farmEnabled) then
		return true;
	end
	v191("Interrompido pela progressão de Sea");
	v181(true);
	v31.farmMode = "Mob selecionado";
	v31.selectedMob = v836;
	v31.skipBosses = false;
	v47.farmPlan = nil;
	local v841 = v151(true);
	if not v841 then
		return false;
	end
	v174();
	v31.farmEnabled = true;
	v47.seaFarmTarget = v836;
	v47.lastAttack = 0;
	v47.comboIndex = 0;
	v47.combatTarget = nil;
	v47.combatTargetHealth = nil;
	v47.combatGroupSize = 0;
	v47.combatGroupCursor = 0;
	v47.combatHealthByTarget = setmetatable({}, {__mode="k"});
	v47.combatGeneration = v47.combatGeneration + 1;
	v47.lastDamageObserved = os.clock();
	v47.remoteFallbackUntil = 0;
	v47.remoteFailureCount = 0;
	v47.spawnIndex = 0;
	v47.spawnTargetName = nil;
	v180(v50.farmToggle, true);
	v152("Quest de Sea", "Derrotando " .. v836);
	return true;
end
local function v202()
	if (game.PlaceId ~= 2753915549) then
		return "Disponível somente no First Sea", nil;
	end
	local v857 = v134();
	if (v857 < 700) then
		return string.format("Aguardando nível 700 | atual: %d", v857), nil;
	end
	local v858, v859 = pcall(function()
		return v23:InvokeServer("DressrosaQuestProgress");
	end);
	if (not v858 or (type(v859) ~= "table")) then
		return "Progresso da quest indisponível", nil;
	end
	if not v859.TalkedDetective then
		return "Etapa: falar com Military Detective", v859;
	elseif not v859.UsedKey then
		return "Etapa: usar a Key na porta de gelo", v859;
	elseif not v859.KilledIceBoss then
		return "Etapa: derrotar Ice Admiral", v859;
	end
	return "Quest concluída | viagem para Second Sea liberada", v859;
end
local function v203()
	local v860, v861 = v202();
	if not v861 then
		return false, v860;
	end
	if not v861.TalkedDetective then
		local v1395, v1396 = pcall(function()
			return v23:InvokeServer("DressrosaQuestProgress", "Detective");
		end);
		v1395 = v1395 and (v1396 ~= false);
		return v1395, (v1395 and "Military Detective solicitado") or "Falha no Military Detective";
	elseif not v861.UsedKey then
		local v1762, v1763 = v75();
		local v1764 = v18:FindFirstChildOfClass("Backpack");
		local v1765 = (v1762 and v1762:FindFirstChild("Key")) or (v1764 and v1764:FindFirstChild("Key"));
		local v1766 = workspace:FindFirstChild("Map");
		local v1767 = v1766 and v1766:FindFirstChild("Ice");
		local v1768 = v1767 and v1767:FindFirstChild("Door");
		if (not v1765 or not v1763 or not v1768 or not v1768:IsA("BasePart")) then
			return false, "Aguardando a Key oficial ou a porta de gelo";
		end
		if (v1765.Parent ~= v1762) then
			v1763:EquipTool(v1765);
		end
		v192("Porta de gelo", v1768.Position + Vector3.new(0, 4, 0));
		return true, "Indo até a porta com a Key";
	elseif not v861.KilledIceBoss then
		local v1908 = v201("Ice Admiral");
		return v1908, (v1908 and "Auto Farm iniciado contra Ice Admiral") or "Spawn do Ice Admiral ainda não foi encontrado";
	end
	v47.seaFarmTarget = nil;
	v181(true);
	local v863, v864 = pcall(function()
		return v23:InvokeServer("TravelDressrosa");
	end);
	v863 = v863 and (v864 ~= false);
	return v863, (v863 and "Viagem oficial para Second Sea solicitada") or "Viagem recusada pelo servidor";
end
local function v204()
	if (game.PlaceId ~= 4442272183) then
		return "Disponível somente no Second Sea", nil;
	end
	local v865 = v134();
	if (v865 < 1500) then
		return string.format("Aguardando nível 1500 | atual: %d", v865), nil;
	end
	local v866, v867 = pcall(function()
		return v23:InvokeServer("ZQuestProgress", "Check");
	end);
	if not v866 then
		return "Progresso da quest indisponível", nil;
	end
	if (v867 == 0) then
		return "Etapa: iniciar missão com King Red Head", v867;
	elseif (v867 == 1) then
		return "Quest concluída | viagem para Third Sea liberada", v867;
	end
	return "Requisitos pendentes: nível 1500 e Don Swan", v867;
end
local function v205()
	local v868, v869 = v204();
	if (v869 == nil) then
		return false, v868;
	elseif (v869 == 0) then
		local v1769, v1770 = pcall(function()
			return v23:InvokeServer("ZQuestProgress", "Begin");
		end);
		v1769 = v1769 and (v1770 ~= false);
		return v1769, (v1769 and "Missão do King Red Head iniciada") or "Início recusado pelo servidor";
	elseif (v869 == 1) then
		v181(true);
		local v1909, v1910 = pcall(function()
			return v23:InvokeServer("TravelZou");
		end);
		v1909 = v1909 and (v1910 ~= false);
		return v1909, (v1909 and "Viagem oficial para Third Sea solicitada") or "Viagem recusada pelo servidor";
	end
	return false, "Requisitos da missão ainda estão pendentes";
end
local function v206()
	local v870 = {};
	local v871 = {{v31.farmEnabled,"Auto Farm"},{v31.manualTravel,"Travel"},{v31.chestFarm,"Chest Farm"},{v31.fruitCollector,"Coletor de frutas"},{v31.smartCollector,"Coletor inteligente"},{v31.autoStoreFruit,"Auto Store"},{v31.autoStats,"Auto Stats"},{v31.autoRollFruit,"Auto Roll"},{v31.autoSetSpawn,"Auto Spawn"},{v31.autoSecondSea,"Second Sea"},{v31.autoThirdSea,"Third Sea"},{v31.movementEnabled,"Movimento"},{v31.noclip,"Noclip"},{v31.walkOnWater,"Walk on Water"},{v31.fpsBoost,"FPS Boost"}};
	for v1121, v1122 in ipairs(v871) do
		if v1122[1] then
			table.insert(v870, v1122[2]);
		end
	end
	return v870;
end
local function v207()
	local v872 = {};
	local v873 = {{v19,"_WorldOrigin"},{v20,"Enemies"},{v23,"CommF_"},{v25,"RegisterAttack"},{v26,"RegisterHit"}};
	for v1123, v1124 in ipairs(v873) do
		if (not v1124[1] or not v1124[1].Parent) then
			table.insert(v872, v1124[2]);
		end
	end
	local v874 = v206();
	local v875 = 0;
	if v31.manualTravel then
		v875 = v875 + 1;
	end
	if (v47.collectionOverride or (not v31.farmEnabled and (v31.chestFarm or v31.fruitCollector))) then
		v875 = v875 + 1;
	end
	if (v31.farmEnabled and not v47.collectionOverride) then
		v875 = v875 + 1;
	end
	local v876 = {};
	for v1125, v1126 in ipairs({"RoyalHub_TravelAnchor","RoyalHub_FarmStabilizer","RoyalHub_WaterPlatform"}) do
		local v1127 = ((v1126 == "RoyalHub_WaterPlatform") and v31.walkOnWater) or ((v1126 ~= "RoyalHub_WaterPlatform") and (v875 > 0));
		if (workspace:FindFirstChild(v1126, true) and not v1127) then
			table.insert(v876, v1126:gsub("RoyalHub_", ""));
		end
	end
	local v877, v877, v878 = v75();
	local v879 = v4.alive() and (#v872 == 0) and (v875 <= 1) and ((v878 == nil) or not v878.Anchored) and (#v876 == 0);
	local v880 = ((#v874 > 0) and table.concat(v874, ", ")) or "nenhuma";
	local v881 = ((#v872 > 0) and table.concat(v872, ", ")) or "nenhum";
	local v882 = ((#v876 > 0) and table.concat(v876, ", ")) or "nenhum";
	return v879, string.format("Estado: %s\nPainel: v%s | %s\nConfiguração: %s\nAtivos: %s\nDonos do movimento: %d\nRecursos ausentes: %s\nResíduos locais: %s\nErros recuperados: %d\nCorreções de rota: %d\nWindUI: %s", (v879 and "OK") or "ATENÇÃO", v32, (v5 and "standalone") or "live-reload", v47.configLoadMessage, v880, v875, v881, v882, v47.totalRuntimeErrors, v47.serverCorrectionCount, v72);
end
v76();
if not v44 then
	v31.walkSpeed = v49.walkSpeed;
	v31.jumpPower = v49.jumpPower;
	v31.fov = v49.cameraFov;
end
local v208 = {};
for v883, v884 in ipairs(v30:GetChildren()) do
	v208[v884] = true;
end
local v209 = Instance.new("ScreenGui");
v209.Name = "RoyalHub_OffscreenIndicators";
v209.IgnoreGuiInset = true;
v209.ResetOnSpawn = false;
v209.DisplayOrder = 998;
v209.Parent = v30;
v47.bubbleLayer = Instance.new("ScreenGui");
v47.bubbleLayer.Name = "RoyalHub_BubbleLayer";
v47.bubbleLayer.IgnoreGuiInset = true;
v47.bubbleLayer.ResetOnSpawn = false;
v47.bubbleLayer.DisplayOrder = 1001;
v47.bubbleLayer.Parent = v30;
v47.reopenBubble = Instance.new("TextButton");
v47.reopenBubble.Name = "ReopenBubble";
v47.reopenBubble.AnchorPoint = Vector2.new(0.5, 0.5);
v47.reopenBubble.Position = UDim2.new(1, -58, 0.5, 0);
v47.reopenBubble.Size = UDim2.fromOffset(54, 54);
v47.reopenBubble.BackgroundColor3 = Color3.fromRGB(76, 92, 220);
v47.reopenBubble.BackgroundTransparency = 0.08;
v47.reopenBubble.BorderSizePixel = 0;
v47.reopenBubble.Font = Enum.Font.GothamBold;
v47.reopenBubble.Text = "RM";
v47.reopenBubble.TextColor3 = Color3.fromRGB(255, 255, 255);
v47.reopenBubble.TextSize = 15;
v47.reopenBubble.Visible = false;
v47.reopenBubble.Parent = v47.bubbleLayer;
do
	local v886 = Instance.new("UICorner");
	v886.CornerRadius = UDim.new(1, 0);
	v886.Parent = v47.reopenBubble;
	local v890 = Instance.new("UIStroke");
	v890.Color = Color3.fromRGB(173, 190, 255);
	v890.Thickness = 2;
	v890.Transparency = 0.15;
	v890.Parent = v47.reopenBubble;
end
v48.setPanelMinimized = function(v895)
	if not v51 then
		return;
	end
	pcall(function()
		if v895 then
			v51:Close();
		else
			v51:Open();
		end
	end);
	v47.reopenBubble.Visible = v895;
end;
v48.isGuiTreeVisible = function(v897)
	local v898 = v897;
	while v898 and (v898 ~= v30) do
		if (v898:IsA("GuiObject") and not v898.Visible) then
			return false;
		end
		v898 = v898.Parent;
	end
	return (v897 ~= nil) and (v897.Parent ~= nil);
end;
v47.bubbleDragging = false;
v47.bubbleDragStart = nil;
v47.bubbleStartPosition = nil;
v4.connect(v47.reopenBubble.InputBegan, function(v899)
	if ((v899.UserInputType == Enum.UserInputType.MouseButton1) or (v899.UserInputType == Enum.UserInputType.Touch)) then
		v47.bubbleDragging = true;
		v47.bubbleDragStart = v899.Position;
		v47.bubbleStartPosition = v47.reopenBubble.Position;
	end
end);
v4.connect(v9.InputChanged, function(v900)
	if (v47.bubbleDragging and v47.bubbleDragStart and v47.bubbleStartPosition and ((v900.UserInputType == Enum.UserInputType.MouseMovement) or (v900.UserInputType == Enum.UserInputType.Touch))) then
		local v1402 = v900.Position - v47.bubbleDragStart;
		v47.reopenBubble.Position = UDim2.new(v47.bubbleStartPosition.X.Scale, v47.bubbleStartPosition.X.Offset + v1402.X, v47.bubbleStartPosition.Y.Scale, v47.bubbleStartPosition.Y.Offset + v1402.Y);
	end
end);
v4.connect(v9.InputEnded, function(v901)
	if ((v901.UserInputType == Enum.UserInputType.MouseButton1) or (v901.UserInputType == Enum.UserInputType.Touch)) then
		v47.bubbleDragging = false;
	end
end);
v4.connect(v47.reopenBubble.Activated, function()
	if not v47.bubbleDragging then
		v48.setPanelMinimized(false);
	end
end);
local function v241(v902)
	if (v902.indicator and v902.indicator.Parent) then
		return v902.indicator;
	end
	local v903 = Instance.new("TextLabel");
	v903.Name = "Indicator";
	v903.AnchorPoint = Vector2.new(0.5, 0.5);
	v903.BackgroundColor3 = Color3.fromRGB(20, 24, 34);
	v903.BackgroundTransparency = 0.18;
	v903.BorderSizePixel = 0;
	v903.Size = UDim2.fromOffset(130, 28);
	v903.Font = Enum.Font.GothamMedium;
	v903.TextColor3 = Color3.fromRGB(255, 255, 255);
	v903.TextSize = 12;
	v903.Visible = false;
	local v915 = Instance.new("UICorner");
	v915.CornerRadius = UDim.new(0, 8);
	v915.Parent = v903;
	v903.Parent = v209;
	v902.indicator = v903;
	return v903;
end
v52 = v74();
v52:SetParent(v30);
v52:SetNotificationLower(true);
local v242 = (workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize) or Vector2.new(1280, 720);
local v243 = math.floor(math.clamp(v242.X * 0.68, 520, 760));
local v244 = math.floor(math.clamp(v242.Y * 0.72, 390, 580));
v51 = v52:CreateWindow({Title=("RoyalHub v" .. v32),Icon="shield-check",Author="Automação controlada | início sempre seguro",Folder="RoyalHubV2",Size=UDim2.fromOffset(v243, v244),MinSize=Vector2.new(500, 380),MaxSize=Vector2.new(850, 620),Theme=v31.interfaceTheme,Transparent=v31.interfaceTransparency,Resizable=true,SideBarWidth=(((v242.X < 900) and 165) or 190),HideSearchBar=false,ScrollBarEnabled=true,OpenButton={Title="RoyalHub",Icon="shield-check",Enabled=true,OnlyIcon=true,Draggable=true,OnlyMobile=false,Position=UDim2.new(1, -78, 0.5, 0),CornerRadius=UDim.new(1, 0),StrokeThickness=2,Color=ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(77, 141, 255)),ColorSequenceKeypoint.new(1, Color3.fromRGB(102, 54, 220))})},User={Enabled=true,Anonymous=false}});
pcall(function()
	v51:SetToggleKey(v48.getShortcutKeyCode(v31.panelKey, Enum.KeyCode.K));
	v51:SetUIScale(v31.interfaceScale);
end);
local v245 = v30:FindFirstChild("WindUI");
local v246 = v245 and v245:FindFirstChild("Window");
v53 = nil;
if v246 then
	for v1405, v1406 in ipairs(v246:GetChildren()) do
		if (v1406:IsA("GuiObject") and v1406:FindFirstChild("Main")) then
			v53 = v1406;
			break;
		end
	end
end
local function v247()
	local v920 = v51:Tab({Title="Painel",Icon="layout-dashboard"});
	local v921 = v51:Tab({Title="Central",Icon="activity"});
	local v922 = v51:Tab({Title="Movimento",Icon="person-standing"});
	local v923 = v51:Tab({Title="Farm",Icon="swords"});
	local v924 = v51:Tab({Title="Travel",Icon="map"});
	local v925 = v51:Tab({Title="Coletores",Icon="package-search"});
	local v926 = v51:Tab({Title="Progressão",Icon="chart-no-axes-combined"});
	local v927 = v51:Tab({Title="Visual",Icon="eye"});
	local v928 = v51:Tab({Title="Interface",Icon="palette"});
	local v929 = v51:Tab({Title="Perfis",Icon="save"});
	local v930 = v51:Tab({Title="Atualizações",Icon="refresh-cw"});
	local v931 = v51:Tab({Title="Utilidades",Icon="wrench"});
	local v932 = v51:Tab({Title="Segurança",Icon="shield-alert"});
	v50.activityCard = v921:Button({Title="Atividade: inicializando",Desc="Aguardando a primeira leitura da sessão",Icon="activity",Callback=function()
		v54("Atividade atual", v47.farmState .. "\n" .. v47.farmDetail, "activity", 5);
	end});
	v50.worldRadarCard = v921:Button({Title="Radar: calculando",Desc="NPCs, baús e frutas carregados",Icon="radar",Callback=function()
		local v1135, v1136 = v126();
		v54("Radar do mundo", string.format("NPCs: %d\nBaús: %d\nFrutas: %d\nÚltima fruta: %s\nÚltimo baú: %s", #v20:GetChildren(), v1136, v1135, v47.lastFruitSeen, v47.lastChestSeen), "radar", 7);
	end});
	v50.sessionCard = v921:Button({Title="Sessão: 00m 00s",Desc="0 NPCs | 0 baús | 0 frutas",Icon="chart-no-axes-combined",Callback=function()
		v54("Estatísticas da sessão", string.format("Tempo: %s\nNPCs derrotados: %d\nBaús coletados: %d\nFrutas coletadas: %d\nTrocas de alvo: %d\nErros recuperados: %d", v48.formatDuration(os.clock() - v47.sessionStartedAt), v47.npcsDefeated, v47.chestsCollected, v47.fruitsCollected, v47.targetSwitches, v47.totalRuntimeErrors), "chart-no-axes-combined", 7);
	end});
	v921:Button({Title="Histórico da atividade",Desc="Últimos eventos, mudanças de alvo, coletas e recuperações",Icon="history",Callback=function()
		v54("Histórico", v48.getActivityHistory(14), "history", 10);
	end});
	v921:Button({Title="Copiar diagnóstico completo",Desc="Copia um relatório técnico sem dados sensíveis",Icon="clipboard-copy",Callback=function()
		local v1137, v1138 = v126();
		local v1139 = string.format("RoyalHub v%s\nModo: %s\nPlaceId: %d\nEstado: %s | %s\nSessão: %s\nFPS: %d | Ping: %.0f ms\nNPCs: %d | Baús: %d | Frutas: %d\nErros: %d | Correções: %d\nWindUI: %s", v32, (v5 and "standalone") or "live-reload", game.PlaceId, v47.farmState, v47.farmDetail, v48.formatDuration(os.clock() - v47.sessionStartedAt), v47.currentFps, v48.getNetworkPingMilliseconds(), #v20:GetChildren(), v1138, v1137, v47.totalRuntimeErrors, v47.serverCorrectionCount, v72);
		if (type(setclipboard) == "function") then
			setclipboard(v1139);
			v54("Diagnóstico copiado", "Relatório enviado para a área de transferência.", "clipboard-check", 4);
		else
			v54("Diagnóstico", v1139, "activity", 10);
		end
	end});
	local v936 = {"Padrão","Farm","Travel","FPS","Visual"};
	v50.profileDropdown = v929:Dropdown({Title="Perfil selecionado",Desc="Presets locais; automações nunca são salvas ligadas",Values=v936,Value=v31.selectedProfile,Callback=function(v1140)
		v31.selectedProfile = v1140 or "Padrão";
	end});
	v929:Button({Title="Aplicar preset",Desc="Aplica o preset embutido sem ativar funções",Icon="wand-sparkles",Callback=function()
		local v1142, v1143 = v48.applyBuiltInProfile(v31.selectedProfile);
		if v1142 then
			v46();
			v54("Preset aplicado", string.format("%s | %d opções. Reabra o painel para sincronizar todos os controles.", v31.selectedProfile, v1143), "circle-check", 6);
		end
	end});
	v929:Button({Title="Salvar perfil atual",Desc="Salva somente valores seguros no armazenamento local",Icon="save",Callback=function()
		local v1144, v1145 = v48.saveProfile(v31.selectedProfile);
		v54((v1144 and "Perfil salvo") or "Falha ao salvar", tostring(v1145), (v1144 and "save") or "circle-alert", 5);
	end});
	v929:Button({Title="Carregar perfil salvo",Desc="Carrega valores; funções continuam desligadas",Icon="folder-open",Callback=function()
		local v1146, v1147 = v48.loadProfile(v31.selectedProfile);
		if v1146 then
			v46();
		end
		v54((v1146 and "Perfil carregado") or "Perfil indisponível", (v1146 and (tostring(v1147) .. " opções restauradas. Reabra para sincronizar controles.")) or tostring(v1147), (v1146 and "folder-check") or "circle-alert", 6);
	end});
	v929:Button({Title="Salvar configurações agora",Desc=v47.configLoadMessage,Icon="hard-drive-download",Callback=function()
		local v1148, v1149 = v46();
		v54((v1148 and v56("configSaved")) or "Falha ao salvar", tostring(v1149), (v1148 and "save") or "circle-alert", 4);
	end});
	v929:Button({Title="Exportar configurações",Desc="Copia JSON e também grava export.json",Icon="file-output",Callback=function()
		local v1150 = v12:JSONEncode({version=v32,settings=v42()});
		if v41() then
			pcall(writefile, v35 .. "/export.json", v1150);
		end
		if (type(setclipboard) == "function") then
			setclipboard(v1150);
		end
		v54("Configuração exportada", v35 .. "/export.json", "file-check", 5);
	end});
	v929:Button({Title="Importar de import.json",Desc="Lê RoyalHub/import.json; automações são ignoradas",Icon="file-input",Callback=function()
		local v1151 = v35 .. "/import.json";
		if (not v40() or not isfile(v1151)) then
			v54("Importação indisponível", "Crie " .. v1151 .. " com o JSON exportado.", "circle-alert", 6);
			return;
		end
		local v1152, v1153 = pcall(function()
			return v12:JSONDecode(readfile(v1151));
		end);
		if (not v1152 or (type(v1153) ~= "table")) then
			v54("JSON inválido", "O arquivo não pôde ser interpretado.", "circle-alert", 5);
			return;
		end
		local v1154 = v43(v1153.settings or v1153);
		v46();
		v48.appendActivity("Configuração", string.format("Importadas %d opções", v1154));
		v54("Importação concluída", string.format("%d opções seguras. Reabra para sincronizar controles.", v1154), "file-check", 6);
	end});
	v50.updateStatusCard = v930:Button({Title=("Versão instalada: v" .. v32),Desc=v47.updateStatus,Icon="badge-check",Callback=function()
		v54("Status da versão", string.format("Instalada: v%s\nCanal: %s\nDisponível: %s\nCompatibilidade: %s\nManifest: %s", v32, v31.updateChannel, (v47.availableVersion and ("v" .. v47.availableVersion)) or "não verificada", ((v47.updateCompatible == nil) and "não verificada") or (v47.updateCompatible and "compatível") or "requer atenção", ((v34 ~= "") and v34) or "não configurado"), "badge-check", 8);
	end});
	v930:Dropdown({Title="Canal de atualização",Desc="Stable prioriza estabilidade; Beta recebe recursos antecipados",Values={"Stable","Beta"},Value=v31.updateChannel,Callback=function(v1155)
		v31.updateChannel = v1155 or "Stable";
		v47.availableVersion = nil;
		v47.updateCompatible = nil;
		v47.updateStatus = "Canal alterado; verifique novamente";
		pcall(function()
			v50.updateStatusCard:SetDesc(v47.updateStatus);
		end);
	end});
	v930:Button({Title="Verificar atualização agora",Desc="Consulta manifest.json sem executar código novo",Icon="cloud-download",Callback=function()
		task.spawn(function()
			local v1407, v1408 = v48.checkForUpdates();
			pcall(function()
				v50.updateStatusCard:SetTitle(string.format("Instalada v%s | disponível %s", v32, (v47.availableVersion and ("v" .. v47.availableVersion)) or "—"));
				v50.updateStatusCard:SetDesc(v1408);
			end);
			v54((v1407 and "Verificação concluída") or "Verificação indisponível", v1408, (v1407 and "circle-check") or "circle-alert", 7);
		end);
	end});
	v930:Button({Title="Ver changelog disponível",Desc="Exibe as notas publicadas no manifest ou pelo loader",Icon="notebook-tabs",Callback=function()
		local v1160 = v47.updateRelease or v33.release or v33;
		local v1161 = ((type(v1160) == "table") and v1160.changelog) or nil;
		local v1162 = ((type(v1161) == "table") and table.concat(v1161, "\n• ")) or tostring(v1161 or "Nenhum changelog carregado");
		if ((type(v1161) == "table") and (#v1161 > 0)) then
			v1162 = "• " .. v1162;
		end
		v54("Changelog", v1162, "notebook-tabs", 10);
	end});
	v930:Button({Title="Copiar URL da versão",Desc="Copia a URL publicada; a atualização continua sob seu controle",Icon="copy",Callback=function()
		local v1163 = v47.updateRelease or v33.release;
		local v1164 = ((type(v1163) == "table") and (v1163.script or v1163.url)) or nil;
		if ((type(v1164) ~= "string") or (v1164 == "") or (type(setclipboard) ~= "function")) then
			v54("URL indisponível", "Verifique o manifest primeiro ou carregue pelo loader oficial.", "circle-alert", 5);
			return;
		end
		setclipboard(v1164);
		v54("URL copiada", v1164, "clipboard-check", 5);
	end});
	v920:Button({Title="Diagnóstico da sessão",Desc="Mostra jogador, vida, posição, entidades e integridade do painel",Icon="activity",Callback=function()
		local v1165, v1166, v1167 = v75();
		local v1168 = (v1167 and v1167.Position) or Vector3.zero;
		local v1169 = (v1166 and string.format("%.0f/%.0f", v1166.Health, v1166.MaxHealth)) or "indisponível";
		local v1170 = v206();
		v54("Diagnóstico", string.format("Jogador: %s\nVida (somente leitura): %s\nPosição: %.0f, %.0f, %.0f\nNPCs: %d | Jogadores: %d\nAtivos: %s\nErros recuperados: %d", v18.Name, v1169, v1168.X, v1168.Y, v1168.Z, #v20:GetChildren(), #v6:GetPlayers(), ((#v1170 > 0) and table.concat(v1170, ", ")) or "nenhum", v47.totalRuntimeErrors), "activity", 7);
	end});
	v920:Button({Title="Auditoria de integridade",Desc="Verificação somente leitura de remotes, conflitos, resíduos e versão da interface",Icon="shield-check",Callback=function()
		local v1171, v1172 = v207();
		v54((v1171 and "Integridade confirmada") or "Integridade requer atenção", v1172, (v1171 and "shield-check") or "shield-alert", 8);
	end});
	v920:Button({Title="NPC mais próximo",Desc="Consulta sem mover o personagem",Icon="scan-search",Callback=function()
		local v1173 = v151(true);
		local v1174, v1175, v1176, v1177 = v155(v1173);
		if (v1174 and v1175) then
			v54("NPC encontrado", string.format("%s | %.0f studs | %.0f de vida", v1174.Name, v1177, v1175.Health), "crosshair", 5);
		elseif v1173 then
			v54("Plano calculado", v1173.targetName .. " ainda não está carregado; o farm viajará ao spawn.", "route", 5);
		else
			v54("Nenhum plano", "Não foi encontrada missão compatível com o nível e o mar atuais.", "circle-alert", 4);
		end
	end});
	v920:Button({Title="Testar notificações",Desc="Confirma que a WindUI está respondendo",Icon="bell",Callback=function()
		v54("RoyalHub", "Interface e callbacks funcionando corretamente.", "circle-check", 4);
	end});
	v50.movementToggle = v922:Toggle({Title="Aplicar movimento personalizado",Desc="Mantém WalkSpeed e JumpPower nos valores escolhidos",Icon="gauge",Value=false,Callback=function(v1178)
		if v47.syncingUi then
			return;
		end
		v31.movementEnabled = v1178;
		if v1178 then
			v77();
		else
			v78();
		end
	end});
	v50.walkSlider = v922:Slider({Title="WalkSpeed",Desc="Limite moderado para teste local",Value={Min=16,Max=120,Default=math.clamp(math.floor(v31.walkSpeed + 0.5), 16, 120)},Step=1,Callback=function(v1180)
		v31.walkSpeed = v1180;
		v77();
	end});
	v50.jumpSlider = v922:Slider({Title="JumpPower",Desc="Força do salto quando o ajuste está ativo",Value={Min=50,Max=150,Default=math.clamp(math.floor(v31.jumpPower + 0.5), 50, 150)},Step=1,Callback=function(v1182)
		v31.jumpPower = v1182;
		v77();
	end});
	v50.jumpToggle = v922:Toggle({Title="Salto infinito",Desc="Permite saltar novamente no ar",Icon="arrow-up",Value=false,Callback=function(v1184)
		if not v47.syncingUi then
			v31.infiniteJump = v1184;
		end
	end});
	v50.noclipToggle = v922:Toggle({Title="Noclip local",Desc="Desativa colisão do personagem; use com cuidado",Icon="door-open",Value=false,Callback=function(v1185)
		if v47.syncingUi then
			return;
		end
		v31.noclip = v1185;
		if (not v1185 and not v31.farmEnabled) then
			v80();
		end
	end});
	v50.waterWalkToggle = v922:Toggle({Title="Walk on Water",Desc="Cria uma superfície local removível somente quando água é detectada abaixo",Icon="waves",Value=false,Callback=function(v1187)
		v31.walkOnWater = v1187;
		if not v1187 then
			v81();
		end
	end});
	v922:Button({Title="Restaurar movimento",Desc="Desliga ajustes, salto infinito e noclip",Icon="rotate-ccw",Callback=function()
		v31.movementEnabled = false;
		v31.infiniteJump = false;
		v31.noclip = false;
		v31.walkOnWater = false;
		v78();
		if not v31.farmEnabled then
			v80();
		end
		v180(v50.movementToggle, false);
		v180(v50.jumpToggle, false);
		v180(v50.noclipToggle, false);
		v180(v50.waterWalkToggle, false);
		v54("Movimento restaurado", "Valores originais reaplicados.", "circle-check", 4);
	end});
	local function v945()
		v50.farmStatus = v923:Button({Title="Status: Parado",Desc="Auto farm desligado",Icon="activity",Callback=function()
			v54("Status do farm", v47.farmState .. "\n" .. v47.farmDetail, "activity", 5);
		end});
		v923:Dropdown({Title="Modo de farm",Desc="Auto Level gerencia missão; Mob selecionado ignora quests",Values={"Auto Level","Mob selecionado"},Value="Auto Level",Callback=function(v1409)
			v31.farmMode = v1409 or "Auto Level";
			v47.farmPlan = nil;
		end});
		v50.npcDropdown = v923:Dropdown({Title="Mob manual",Desc="Usado somente no modo Mob selecionado",Values=v183(),Value="Automático",SearchBarEnabled=true,Callback=function(v1412)
			v31.selectedMob = v1412 or "Automático";
			v47.farmPlan = nil;
		end});
		v923:Toggle({Title="Missão automática",Desc="Aceita, valida e troca a missão conforme o nível",Icon="scroll-text",Value=true,Callback=function(v1415)
			v31.autoQuest = v1415;
		end});
		v923:Toggle({Title="Ignorar missões de chefe",Desc="Prioriza NPCs comuns para progressão contínua",Icon="shield",Value=true,Callback=function(v1417)
			v31.skipBosses = v1417;
			v47.farmPlan = nil;
		end});
		v923:Dropdown({Title="Deslocamento",Desc="Tween linear suave ou tween rápido a 650+ studs/s",Values={"Suave","Rápido"},Value="Suave",Callback=function(v1420)
			v31.movementMode = v1420 or "Suave";
			v159();
		end});
		v923:Toggle({Title="Usar portais em rotas longas",Desc="Evita correções do servidor entre ilhas distantes",Icon="door-open",Value=true,Callback=function(v1422)
			v31.useEntrances = v1422;
			v159();
		end});
		v923:Slider({Title="Velocidade de viagem",Desc="Usada pelo deslocamento Suave",Value={Min=100,Max=650,Default=v31.travelSpeed},Step=25,Callback=function(v1424)
			v31.travelSpeed = v1424;
			v159();
		end});
		v923:Slider({Title="Altura de combate",Desc="Altura do voo durante o ataque remoto; padrão profissional: 18",Value={Min=2,Max=40,Default=v31.hoverHeight},Step=1,Callback=function(v1426)
			v31.hoverHeight = v1426;
		end});
		v923:Slider({Title="Distância atrás do NPC",Desc="Recuo horizontal usado pelo Tween para perseguir o alvo",Value={Min=2,Max=12,Default=v31.followOffset},Step=1,Callback=function(v1428)
			v31.followOffset = v1428;
			if v31.farmEnabled then
				v159();
			end
		end});
		v923:Toggle({Title="Priorizar grupos naturais",Desc="Escolhe NPCs que já estejam próximos entre si, sem mover os inimigos",Icon="users-round",Value=false,Callback=function(v1430)
			v31.prioritizeNaturalGroups = v1430;
			v47.combatTarget = nil;
			v47.combatGroupSize = 0;
			v47.combatGeneration = v47.combatGeneration + 1;
		end});
		v923:Slider({Title="NPCs por ataque",Desc="Agrupa até este total de NPCs válidos da mesma missão em um único ataque",Value={Min=1,Max=6,Default=v31.maxCombatTargets},Step=1,Callback=function(v1435)
			v31.maxCombatTargets = math.floor(v1435);
		end});
		v923:Slider({Title="Raio do grupo",Desc="Distância máxima entre o alvo principal e os NPCs adicionais",Value={Min=25,Max=250,Default=v31.combatGroupRadius},Step=10,Callback=function(v1437)
			v31.combatGroupRadius = v1437;
		end});
		v923:Slider({Title="Tempo máximo por alvo",Desc="Troca de NPC quando a perseguição excede este tempo sem conclusão",Value={Min=8,Max=45,Default=v31.targetTimeout},Step=1,Callback=function(v1439)
			v31.targetTimeout = v1439;
		end});
		v923:Slider({Title="Detecção de farm travado",Desc="Tempo sem dano ou aproximação antes de recalcular o alvo",Value={Min=4,Max=20,Default=v31.stuckTimeout},Step=1,Callback=function(v1441)
			v31.stuckTimeout = v1441;
		end});
		v923:Button({Title="Limpar alvos temporariamente ignorados",Desc="Remove a lista criada pela recuperação de farm travado",Icon="list-restart",Callback=function()
			v47.npcBlacklist = setmetatable({}, {__mode="k"});
			v47.targetAcquiredAt = 0;
			v47.lastTargetProgress = os.clock();
			v54("Lista limpa", "Todos os NPCs carregados podem ser selecionados novamente.", "circle-check", 4);
		end});
		v923:Slider({Title="Intervalo de ataque",Desc="Ataque remoto rápido; nenhum clique físico é utilizado",Value={Min=0.1,Max=0.5,Default=v31.attackInterval},Step=0.05,Callback=function(v1446)
			v31.attackInterval = v1446;
		end});
		v923:Slider({Title="Alcance do farm",Desc="Acima deste limite o tween aproxima e continua usando somente dano remoto",Value={Min=100,Max=1000,Default=v31.remoteAttackRange},Step=20,Callback=function(v1448)
			v31.remoteAttackRange = v1448;
		end});
		local v1195 = v184();
		local v1196 = (table.find(v1195, "Combat") and "Combat") or "Automático";
		v31.selectedTool = v1196;
		v50.toolDropdown = v923:Dropdown({Title="Ferramenta",Desc="Selecione por nome ou categoria (Melee, Sword, Fruit ou Gun)",Values=v1195,Value=v1196,SearchBarEnabled=true,Callback=function(v1450)
			v31.selectedTool = v1450 or "Automático";
		end});
		v923:Toggle({Title="Equipar automaticamente",Desc="Equipa a ferramenta selecionada quando necessário",Icon="hand",Value=true,Callback=function(v1452)
			v31.autoEquip = v1452;
		end});
		v923:Toggle({Title="Aura automática",Desc="Ativa Enhancement durante o combate quando disponível",Icon="sparkles",Value=true,Callback=function(v1454)
			v31.autoAura = v1454;
		end});
		v923:Toggle({Title="Usar habilidade Z",Value=false,Callback=function(v1456)
			v31.skillZ = v1456;
		end});
		v923:Toggle({Title="Usar habilidade X",Value=false,Callback=function(v1458)
			v31.skillX = v1458;
		end});
		v923:Toggle({Title="Usar habilidade C",Value=false,Callback=function(v1460)
			v31.skillC = v1460;
		end});
		v923:Toggle({Title="Usar habilidade V",Value=false,Callback=function(v1462)
			v31.skillV = v1462;
		end});
		v923:Slider({Title="Intervalo de habilidades",Desc="Alterna entre as habilidades habilitadas",Value={Min=1,Max=8,Default=v31.skillInterval},Step=0.5,Callback=function(v1464)
			v31.skillInterval = v1464;
		end});
		v923:Button({Title="Recalcular plano do Auto Level",Desc="Lê nível, missão, quest giver e spawn novamente",Icon="refresh-cw",Callback=function()
			local v1466 = v151(true);
			if v1466 then
				local v1771 = (v1466.questName and (v1466.questName .. " #" .. tostring(v1466.questTier))) or "sem missão";
				v54("Plano atualizado", string.format("%s | %s | nível %d", v1466.targetName, v1771, v1466.requiredLevel or v1466.level), "route", 6);
			else
				v54("Plano indisponível", "Nenhuma missão compatível foi encontrada.", "circle-alert", 5);
			end
		end});
		v50.farmToggle = v923:Toggle({Title="Auto Farm Profissional",Desc="Quest automática, viagem, combate, respawn e recuperação",Icon="play",Value=false,Callback=function(v1467)
			if v47.syncingUi then
				return;
			end
			if v1467 then
				v191("Interrompido pelo Auto Farm");
				v31.chestFarm = false;
				v31.fruitCollector = false;
				v180(v50.chestFarmToggle, false);
				v180(v50.fruitCollectorToggle, false);
				v159();
				v160();
				local v1774 = v151(true);
				if not v1774 then
					v31.farmEnabled = false;
					task.defer(function()
						v180(v50.farmToggle, false);
					end);
					v54("Farm não iniciado", "Não existe plano válido para a configuração atual.", "circle-alert", 5);
					return;
				end
				v174();
				v31.farmEnabled = true;
				v47.lastEntrance = 0;
				v47.lastServerCorrection = 0;
				v47.serverCorrectionCount = 0;
				v47.safeTravelUntil = 0;
				v47.travelRetryAfter = 0;
				v47.lastAttack = 0;
				v47.comboIndex = 0;
				v47.combatTarget = nil;
				v47.combatTargetHealth = nil;
				v47.combatGroupSize = 0;
				v47.combatHealthByTarget = setmetatable({}, {__mode="k"});
				v47.combatGeneration = v47.combatGeneration + 1;
				v47.lastDamageObserved = os.clock();
				v47.remoteFallbackUntil = 0;
				v47.remoteFailureCount = 0;
				v47.lastSkill = 0;
				v47.lastQuestAction = 0;
				v47.spawnIndex = 0;
				v47.spawnTargetName = nil;
				v47.lastSpawnAdvance = 0;
				v152("Preparando", v1774.targetName .. " | nível " .. tostring(v1774.requiredLevel or v1774.level));
				v54("Auto Farm iniciado", "Alvo: " .. v1774.targetName .. ". Pressione END para emergência.", "swords", 5);
			else
				v181(false);
			end
		end});
		v923:Button({Title="Parar farm agora",Desc="Cancela viagem, missão automática e combate",Icon="square",Callback=function()
			v181(true);
			v54("Farm parado", "Automação interrompida.", "circle-stop", 3);
		end});
		v50.travelStatus = v924:Button({Title="Travel: Parado",Desc="Nenhuma rota manual ativa",Icon="route",Callback=function()
			v54("Status do Travel", (v31.manualTravel and (v47.manualTravelName or "Em rota")) or "Parado", "route", 4);
		end});
		v50.islandDropdown = v924:Dropdown({Title="Ilha de destino",Desc="Destinos oficiais carregados em _WorldOrigin.Locations",Values=v187,Value=v31.selectedIsland,SearchBarEnabled=true,Callback=function(v1468)
			v31.selectedIsland = v1468 or v31.selectedIsland;
		end});
		v924:Button({Title="Viajar para ilha por Tween",Desc="Usa rota segmentada, noclip temporário e redução após correções do servidor",Icon="navigation",Callback=function()
			local v1470 = v185[v31.selectedIsland];
			if not v1470 then
				v54("Destino indisponível", "Atualize a lista ou selecione outra ilha.", "circle-alert", 4);
				return;
			end
			local v1471 = ((v1470.Y < 100) and 65) or 25;
			v192(v31.selectedIsland, v1470 + Vector3.new(0, v1471, 0));
			v54("Travel iniciado", v31.selectedIsland, "navigation", 4);
		end});
		v924:Button({Title="Adicionar/remover ilha favorita",Desc="Alterna a ilha selecionada na lista persistente de favoritos",Icon="star",Callback=function()
			local v1472 = v31.selectedIsland;
			if not v1472 then
				return;
			end
			v47.favoriteIslands[v1472] = not v47.favoriteIslands[v1472];
			v189();
			v46();
			v54((v47.favoriteIslands[v1472] and "Favorito adicionado") or "Favorito removido", v1472, (v47.favoriteIslands[v1472] and "star") or "star-off", 4);
		end});
		v924:Button({Title="Favoritos e destinos recentes",Desc="Mostra os destinos persistidos nesta instalação",Icon="history",Callback=function()
			local v1474 = {};
			for v1689, v1690 in pairs(v47.favoriteIslands) do
				if v1690 then
					table.insert(v1474, v1689);
				end
			end
			table.sort(v1474);
			v54("Travel salvo", string.format("Favoritos: %s\nRecentes: %s", ((#v1474 > 0) and table.concat(v1474, ", ")) or "nenhum", ((#v47.recentDestinations > 0) and table.concat(v47.recentDestinations, ", ")) or "nenhum"), "map", 8);
		end});
		v924:Button({Title="Viajar ao NPC do plano atual",Desc="Usa o alvo calculado sem iniciar combate",Icon="locate-fixed",Callback=function()
			local v1475 = v151(true);
			local v1476, v1477, v1478 = v155(v1475);
			if (not v1476 or not v1478) then
				v54("NPC não carregado", (v1475 and (v1475.targetName .. " não está disponível agora.")) or "Nenhum plano válido.", "circle-alert", 5);
				return;
			end
			v192("NPC: " .. v1476.Name, v1478.Position + Vector3.new(0, v31.hoverHeight, 0));
		end});
		v924:Button({Title="Viajar ao quest giver atual",Desc="Vai até o marcador oficial da missão calculada",Icon="scroll-text",Callback=function()
			local v1479 = v151(true);
			local v1480, v1480, v1481 = v75();
			local v1482 = (v1479 and v146(v1479.questName, v1479.requiredLevel or 0)) or {};
			local v1483 = (v1481 and v148(v1482, v1481.Position)) or v1482[1];
			if not v1483 then
				v54("Quest giver indisponível", "Nenhum marcador carregado para a missão atual.", "circle-alert", 5);
				return;
			end
			v192("Quest: " .. tostring(v1479.questName), v1483 + Vector3.new(0, 3, 0));
		end});
		v924:Button({Title="Cancelar Travel",Desc="Interrompe o Tween e remove âncora, voo e noclip temporário",Icon="square",Callback=function()
			v191("Rota cancelada pelo usuário");
			v54("Travel cancelado", "Estado de movimento restaurado.", "circle-stop", 3);
		end});
		v50.autoSetSpawnToggle = v924:Toggle({Title="Auto Set Spawn Point",Desc="Solicita o spawn oficial somente ao chegar a uma ilha diferente",Icon="map-pin-check",Value=false,Callback=function(v1484)
			v31.autoSetSpawn = v1484;
			v47.lastSpawnIsland = nil;
			v47.lastSetSpawn = 0;
		end});
		v924:Button({Title="Atualizar destinos",Desc="Relê os marcadores oficiais do mar atual",Icon="refresh-cw",Callback=function()
			v187 = v186();
			pcall(function()
				v50.islandDropdown:Refresh(v187);
			end);
			v31.selectedIsland = v187[1];
			pcall(function()
				v50.islandDropdown:Select(v31.selectedIsland);
			end);
			v54("Destinos atualizados", tostring(#v187) .. " ilhas encontradas.", "map", 4);
		end});
		v50.chestFarmToggle = v925:Toggle({Title="Chest Farm com tween",Desc="Viaja até o baú visível mais próximo e repete após a coleta",Icon="archive",Value=false,Callback=function(v1490)
			v31.chestFarm = v1490;
			if v1490 then
				v191("Interrompido pelo Chest Farm");
				v31.chestFarm = true;
				v31.fruitCollector = false;
				v180(v50.fruitCollectorToggle, false);
				v31.farmEnabled = false;
				v180(v50.farmToggle, false);
				v47.farmPlan = nil;
				v162();
				v175();
				v176();
				v152("Parado", "Chest Farm ativo na aba Coletores");
			else
				v159();
				v160();
				v162();
				if not v31.noclip then
					v80();
				end
			end
		end});
		v50.fruitCollectorToggle = v925:Toggle({Title="Coletar frutas físicas",Desc="Usa o mesmo tween seguro para alcançar frutas no mapa",Icon="apple",Value=false,Callback=function(v1492)
			v31.fruitCollector = v1492;
			if v1492 then
				v191("Interrompido pelo coletor de frutas");
				v31.fruitCollector = true;
				v31.chestFarm = false;
				v180(v50.chestFarmToggle, false);
				v31.farmEnabled = false;
				v180(v50.farmToggle, false);
				v47.farmPlan = nil;
				v162();
				v175();
				v176();
				v152("Parado", "Coletor de frutas ativo na aba Coletores");
			else
				v159();
				v160();
				v162();
				if not v31.noclip then
					v80();
				end
			end
		end});
		v50.smartCollectorToggle = v925:Toggle({Title="Coletor inteligente unificado",Desc="Cria uma fila de frutas e baús e retoma o Auto Farm quando a fila esvazia",Icon="list-checks",Value=false,Callback=function(v1494)
			v31.smartCollector = v1494;
			v47.collectionOverride = false;
			v47.collectionTarget = nil;
			v47.collectionTargetPart = nil;
			v47.collectionTargetType = nil;
			if (not v1494 and not v31.chestFarm and not v31.fruitCollector) then
				v159();
				v160();
				v162();
				if (not v31.noclip and not v31.farmEnabled) then
					v80();
				end
			end
			v48.appendActivity("Coletor", (v1494 and "Fila inteligente ativada") or "Fila inteligente desativada");
		end});
		v50.collectorStatus = v925:Button({Title="Fila: vazia",Desc="Nenhum objeto elegível no raio configurado",Icon="list-ordered",Callback=function()
			local v1500, v1500, v1501 = v75();
			local v1502, v1503;
			if v1501 then
				v1502, v1503 = v127(v1501.Position);
			else
				v1503 = {};
			end
			v54("Fila de coleta", (v1502 and string.format("%d itens\nPróximo: %s | %s | %.0f studs", #v1503, v1502.kind, v1502.instance.Name, v1502.distance)) or "Nenhum objeto elegível", "list-ordered", 6);
		end});
		v925:Dropdown({Title="Prioridade da fila",Desc="Frutas raras sempre ficam no topo",Values={"Frutas primeiro","Baús primeiro","Mais próximo"},Value=v31.collectorPriority,Callback=function(v1504)
			v31.collectorPriority = v1504 or "Mais próximo";
		end});
		v925:Slider({Title="Raio máximo de coleta",Desc="Objetos além deste limite não interrompem a atividade atual",Value={Min=100,Max=5000,Default=v31.collectorMaxDistance},Step=100,Callback=function(v1506)
			v31.collectorMaxDistance = v1506;
		end});
		v925:Toggle({Title="Retomar Auto Farm após coleta",Desc="A fila interrompe temporariamente o movimento e depois devolve o controle ao farm",Icon="refresh-cw",Value=v31.collectorResumeFarm,Callback=function(v1508)
			v31.collectorResumeFarm = v1508;
		end});
		v925:Toggle({Title="Alertar frutas raras",Desc="Notifica uma vez quando uma fruta rara aparece no mundo carregado",Icon="bell-ring",Value=v31.rareFruitAlerts,Callback=function(v1510)
			v31.rareFruitAlerts = v1510;
		end});
		v50.autoStoreFruitToggle = v925:Toggle({Title="Armazenar frutas automaticamente",Desc="Tenta armazenar somente Tools de fruta encontradas na mochila/personagem",Icon="package-check",Value=false,Callback=function(v1512)
			v31.autoStoreFruit = v1512;
			if v1512 then
				v47.fruitStoreRetryAt = {};
			end
		end});
		v925:Button({Title="Localizar itens próximos",Desc="Mostra a fruta e o baú visíveis mais próximos",Icon="radar",Callback=function()
			local v1514, v1514, v1515 = v75();
			if not v1515 then
				return;
			end
			local v1516, v1514, v1517 = v123(v1515.Position);
			local v1518, v1514, v1519 = v122(v1515.Position);
			v54("Itens próximos", string.format("Fruta: %s\nBaú: %s", (v1516 and (v1516.Name .. " | " .. math.floor(v1517) .. " studs")) or "nenhuma", (v1518 and (v115(v1518) .. " | " .. math.floor(v1519) .. " studs")) or "nenhum"), "radar", 6);
		end});
		v925:Button({Title="Ir até a fruta mais próxima",Desc="Executa um Travel único por Tween até a fruta física carregada",Icon="locate-fixed",Callback=function()
			local v1520, v1520, v1521 = v75();
			local v1522, v1523, v1524 = nil, nil, math.huge;
			if v1521 then
				v1522, v1523, v1524 = v123(v1521.Position);
			end
			if (not v1522 or not v1523) then
				v54("Nenhuma fruta", "Não existe fruta física carregada no mapa.", "apple", 4);
				return;
			end
			v192("Fruta: " .. v1522.Name, v1523.Position + Vector3.new(0, 2, 0));
			v54("Indo até a fruta", string.format("%s | %.0f studs", v1522.Name, v1524), "navigation", 5);
		end});
		v925:Button({Title="Abrir loja de frutas",Desc="Abre a interface oficial atual de Blox Fruits",Icon="store",Callback=function()
			local v1525, v1526 = pcall(function()
				assert(typeof(v27.OpenFruitShop) == "function", "OpenFruitShop indisponível");
				v27.OpenFruitShop();
			end);
			if not v1525 then
				v54("Loja indisponível", tostring(v1526), "circle-alert", 5);
			end
		end});
		v925:Button({Title="Consultar Zioles",Desc="Verifica disponibilidade e custo sem comprar uma fruta",Icon="badge-dollar-sign",Callback=function()
			task.spawn(function()
				local v1691, v1692 = v199(false);
				v54((v1691 and "Roll disponível") or "Zioles indisponível", v1692, (v1691 and "circle-check") or "clock", 5);
			end);
		end});
		v50.autoRollFruitToggle = v925:Toggle({Title="Auto Roll Fruit",Desc="Compra automaticamente quando o Zioles liberar; pode gastar Beli",Icon="dices",Value=false,Callback=function(v1527)
			v31.autoRollFruit = v1527;
			v47.lastFruitRoll = (v1527 and 0) or os.clock();
		end});
		v925:Button({Title="Roll Fruit agora",Desc="Tenta uma compra oficial imediata; esta ação pode gastar Beli",Icon="dices",Callback=function()
			task.spawn(function()
				local v1693, v1694 = v199(true);
				v54((v1693 and "Roll solicitado") or "Roll não realizado", v1694, (v1693 and "dices") or "circle-alert", 5);
			end);
		end});
		v925:Button({Title="Histórico do Zioles",Desc="Mostra somente as tentativas desta sessão, sem realizar uma compra",Icon="history",Callback=function()
			v54("Zioles nesta sessão", string.format("Tentativas de compra: %d\nConfirmadas: %d\nÚltimo resultado: %s", v47.fruitRollAttempts, v47.fruitRollSuccesses, v47.lastFruitRollMessage), "history", 6);
		end});
	end
	v945();
	local function v946()
		v50.autoStatsToggle = v926:Toggle({Title="Auto Stats",Desc="Distribui pelo perfil, preserva a reserva e respeita o limite configurado",Icon="chart-no-axes-column-increasing",Value=false,Callback=function(v1530)
			v31.autoStats = v1530;
			if v1530 then
				v47.statFailureCount = 0;
			end
		end});
		v926:Dropdown({Title="Perfil de distribuição",Desc="O modo balanceado sempre prioriza o atributo de menor nível",Values={"Atributo único","Melee + Defense","Melee + Defense + Sword","Melee + Defense + Fruit","Todos balanceados"},Value=v31.statProfile,Callback=function(v1532)
			v31.statProfile = v1532 or "Atributo único";
		end});
		v926:Dropdown({Title="Atributo",Desc="Usado quando o perfil está em Atributo único",Values={"Melee","Defense","Sword","Gun","Demon Fruit"},Value=v31.statName,Callback=function(v1534)
			v31.statName = v1534 or "Melee";
		end});
		v926:Button({Title="Diagnóstico de Stats",Desc="Mostra pontos, níveis atuais e o próximo atributo priorizado",Icon="chart-bar-big",Callback=function()
			local v1536 = v18:FindFirstChild("Data");
			local v1537 = v1536 and v1536:FindFirstChild("Points");
			local v1538 = v1536 and v1536:FindFirstChild("Stats");
			local v1539 = {("Pontos: " .. tostring((v1537 and v1537.Value) or 0))};
			for v1695, v1696 in ipairs({"Melee","Defense","Sword","Gun","Demon Fruit"}) do
				local v1697 = v1538 and v1538:FindFirstChild(v1696);
				local v1698 = v1697 and v1697:FindFirstChild("Level");
				table.insert(v1539, v1696 .. ": " .. tostring((v1698 and v1698.Value) or "?"));
			end
			table.insert(v1539, "Próximo: " .. tostring(v194() or "todos no limite"));
			table.insert(v1539, "Solicitados nesta sessão: " .. tostring(v47.statPointsRequested));
			table.insert(v1539, "Último atributo: " .. tostring(v47.lastStatTarget or "nenhum"));
			v54("Auto Stats", table.concat(v1539, "\n"), "chart-bar-big", 7);
		end});
		v926:Button({Title="Prévia da distribuição",Desc="Simula localmente o resultado sem enviar ou gastar pontos",Icon="list-tree",Callback=function()
			v54("Prévia de Auto Stats", v48.buildStatPreview(), "list-tree", 9);
		end});
		v926:Button({Title="Histórico de Stats",Desc="Mostra as distribuições confirmadas nesta sessão",Icon="history",Callback=function()
			v54("Histórico de Auto Stats", v48.getStatHistoryText(), "history", 8);
		end});
		v926:Slider({Title="Pontos por envio",Desc="Nunca ultrapassa os pontos realmente disponíveis",Value={Min=1,Max=100,Default=v31.statBatch},Step=1,Callback=function(v1540)
			v31.statBatch = v1540;
		end});
		v926:Slider({Title="Reserva de pontos",Desc="Mantém esta quantidade sem distribuir",Value={Min=0,Max=1000,Default=v31.statReserve},Step=10,Callback=function(v1542)
			v31.statReserve = v1542;
		end});
		v926:Slider({Title="Limite por atributo",Desc="Auto Stats interrompe o atributo ao alcançar este valor",Value={Min=100,Max=2800,Default=v31.statCap},Step=50,Callback=function(v1544)
			v31.statCap = v1544;
		end});
		v50.secondSeaToggle = v926:Toggle({Title="Assistente automático do Second Sea",Desc="Avança somente etapas oficiais liberadas; aguarda nível 700, Key e Ice Admiral",Icon="ship",Value=false,Callback=function(v1546)
			v31.autoSecondSea = v1546;
			v47.lastSeaProgress = 0;
			if v1546 then
				v31.autoThirdSea = false;
				v180(v50.thirdSeaToggle, false);
			elseif v47.seaFarmTarget then
				v181(true);
			end
		end});
		v926:Button({Title="Diagnóstico do Second Sea",Desc="Consulta a etapa atual sem modificar o progresso",Icon="list-checks",Callback=function()
			local v1549 = v202();
			v54("Second Sea", v1549, "ship", 6);
		end});
		v50.thirdSeaToggle = v926:Toggle({Title="Assistente automático do Third Sea",Desc="Avança somente etapas oficiais liberadas; aguarda nível 1500 e Don Swan",Icon="ship-wheel",Value=false,Callback=function(v1550)
			v31.autoThirdSea = v1550;
			v47.lastSeaProgress = 0;
			if v1550 then
				v31.autoSecondSea = false;
				v180(v50.secondSeaToggle, false);
			end
		end});
		v926:Button({Title="Diagnóstico do Third Sea",Desc="Consulta a etapa atual sem modificar o progresso",Icon="list-checks",Callback=function()
			local v1553 = v204();
			v54("Third Sea", v1553, "ship-wheel", 6);
		end});
		v50.observationToggle = v926:Toggle({Title="Observation Haki automático",Desc="Solicita Ken periodicamente enquanto estiver desativado",Icon="eye",Value=false,Callback=function(v1554)
			v31.autoObservation = v1554;
		end});
		v50.raceAbilityToggle = v926:Toggle({Title="Habilidade racial automática",Desc="Ativa a habilidade disponível com intervalo seguro",Icon="zap",Value=false,Callback=function(v1556)
			v31.autoRaceAbility = v1556;
		end});
		v50.antiAfkToggle = v926:Toggle({Title="Anti-AFK",Desc="Responde apenas quando o evento Idled do Roblox ocorrer",Icon="coffee",Value=false,Callback=function(v1558)
			v31.antiAfk = v1558;
		end});
		v50.fovToggle = v927:Toggle({Title="FOV personalizado",Desc="Mantém o campo de visão escolhido",Icon="scan",Value=false,Callback=function(v1560)
			if v47.syncingUi then
				return;
			end
			v31.fovEnabled = v1560;
			if not v1560 then
				v89();
			end
		end});
		v927:Slider({Title="Campo de visão",Desc="Aplicado quando FOV personalizado está ativo",Value={Min=60,Max=120,Default=math.clamp(math.floor(v31.fov + 0.5), 60, 120)},Step=1,Callback=function(v1562)
			v31.fov = v1562;
		end});
		v50.fullBrightToggle = v927:Toggle({Title="FullBright",Desc="Iluminação clara e sombras globais desativadas",Icon="sun",Value=false,Callback=function(v1564)
			if not v47.syncingUi then
				v31.fullBright = v1564;
				if v1564 then
					v88();
				else
					v84();
				end
			end
		end});
		v927:Slider({Title="Brilho global",Desc="Intensidade da luz quando FullBright está ativo",Value={Min=2,Max=6,Default=v31.fullBrightBrightness},Step=0.25,Callback=function(v1565)
			v31.fullBrightBrightness = v1565;
			if v31.fullBright then
				v88();
			end
		end});
		v927:Slider({Title="Exposição",Desc="Clareia a imagem sem alterar horário, sol ou Sky",Value={Min=0,Max=1,Default=v31.fullBrightExposure},Step=0.05,Callback=function(v1567)
			v31.fullBrightExposure = v1567;
			if v31.fullBright then
				v88();
			end
		end});
		v50.noFogToggle = v927:Toggle({Title="Remover neblina",Desc="Aumenta apenas a distância visual local",Icon="cloud-off",Value=false,Callback=function(v1569)
			if not v47.syncingUi then
				v31.noFog = v1569;
				if v1569 then
					v88();
				else
					v87();
				end
			end
		end});
		v50.gameNotificationsToggle = v927:Toggle({Title="Desativar notificações do jogo",Desc="Oculta somente PlayerGui.Notifications; avisos do painel continuam ativos",Icon="bell-off",Value=false,Callback=function(v1570)
			v31.disableGameNotifications = v1570;
			if v1570 then
				v90();
			else
				v91();
			end
		end});
		v50.damageCounterToggle = v927:Toggle({Title="Desativar contador de dano",Desc="Desliga localmente Global.dmgCounter sem alterar a configuração da conta",Icon="badge-minus",Value=false,Callback=function(v1572)
			v31.disableDamageCounter = v1572;
			if v1572 then
				v92();
			else
				v93();
			end
		end});
		v50.fpsBoostToggle = v927:Toggle({Title="FPS Boost reversível",Desc="Simplifica materiais do mapa e desliga partículas, sombras e pós-processamento",Icon="gauge",Value=false,Callback=function(v1574)
			v31.fpsBoost = v1574;
			if v1574 then
				task.spawn(function()
					v95();
					if v4.alive() then
						v54("FPS Boost aplicado", "Efeitos locais foram reduzidos e podem ser restaurados.", "gauge", 4);
					end
				end);
			else
				v96();
			end
		end});
		v50.espToggle = v927:Toggle({Title="ESP de NPCs",Desc="Destaque local; jogadores nunca são marcados",Icon="scan-eye",Value=false,Callback=function(v1576)
			if not v47.syncingUi then
				v31.npcEsp = v1576;
				v103();
			end
		end});
		v50.fruitEspToggle = v927:Toggle({Title="ESP de frutas",Desc="Destaca frutas físicas que aparecerem no mapa",Icon="apple",Value=false,Callback=function(v1577)
			if not v47.syncingUi then
				v31.fruitEsp = v1577;
				v117();
			end
		end});
		v50.chestEspToggle = v927:Toggle({Title="ESP de baús",Desc="Cores diferentes para baús comuns, dourados e especiais",Icon="archive",Value=false,Callback=function(v1578)
			if not v47.syncingUi then
				v31.chestEsp = v1578;
				v118();
			end
		end});
		v50.islandEspToggle = v927:Toggle({Title="ESP de ilhas",Desc="Destaca os marcadores oficiais em _WorldOrigin.Locations",Icon="map-pinned",Value=false,Callback=function(v1579)
			if not v47.syncingUi then
				v31.islandEsp = v1579;
				v120();
			end
		end});
		v927:Slider({Title="Distância máxima do ESP",Desc="Objetos além deste limite não recebem destaque ou rótulo",Value={Min=250,Max=10000,Default=v31.espMaxDistance},Step=250,Callback=function(v1580)
			v31.espMaxDistance = v1580;
			v121();
		end});
		v927:Slider({Title="Limite de objetos do ESP",Desc="Protege o FPS em áreas com muitas entidades",Value={Min=10,Max=200,Default=v31.espMaxObjects},Step=10,Callback=function(v1582)
			v31.espMaxObjects = v1582;
			v121();
		end});
		v927:Toggle({Title="Rótulos no ESP",Desc="Exibe nome, distância e vida quando aplicável",Icon="tags",Value=v31.espShowLabels,Callback=function(v1584)
			v31.espShowLabels = v1584;
			v121();
		end});
		v927:Toggle({Title="Indicadores fora da tela",Desc="Mostra direção, nome e distância nas bordas da tela",Icon="move-up-right",Value=v31.espOffscreenIndicators,Callback=function(v1586)
			v31.espOffscreenIndicators = v1586;
			if not v1586 then
				for v1887, v1888 in pairs(v47.espLabels) do
					if v1888.indicator then
						v1888.indicator.Visible = false;
					end
				end
			end
		end});
		v927:Button({Title="Restaurar visual",Desc="Restaura câmera, iluminação, neblina e destaques",Icon="rotate-ccw",Callback=function()
			v31.fovEnabled = false;
			v31.fullBright = false;
			v31.noFog = false;
			v31.disableGameNotifications = false;
			v31.disableDamageCounter = false;
			v31.fpsBoost = false;
			v31.npcEsp = false;
			v31.fruitEsp = false;
			v31.chestEsp = false;
			v31.islandEsp = false;
			v89();
			v84();
			v87();
			v91();
			v93();
			v96();
			v101();
			v104("RoyalHub_FruitHighlight");
			v104("RoyalHub_ChestHighlight");
			v119();
			v180(v50.fovToggle, false);
			v180(v50.fullBrightToggle, false);
			v180(v50.noFogToggle, false);
			v180(v50.gameNotificationsToggle, false);
			v180(v50.damageCounterToggle, false);
			v180(v50.fpsBoostToggle, false);
			v180(v50.espToggle, false);
			v180(v50.fruitEspToggle, false);
			v180(v50.chestEspToggle, false);
			v180(v50.islandEspToggle, false);
			v54("Visual restaurado", "Configurações originais reaplicadas.", "circle-check", 4);
		end});
		local v1225 = {"Dark","Midnight","Indigo","Violet","Sky","Emerald","Plant","Amber","Rose","Crimson","Red","CottonCandy","MonokaiPro","Light","Rainbow"};
		v50.themeDropdown = v928:Dropdown({Title="Tema do painel",Desc="Altera cores sem reiniciar as funções",Values=v1225,Value=v31.interfaceTheme,SearchBarEnabled=true,Callback=function(v1598)
			if v1598 then
				v31.interfaceTheme = v1598;
				pcall(function()
					v51:SetTheme(v1598);
				end);
			end
		end});
		v50.transparencyToggle = v928:Toggle({Title="Transparência",Desc="Ativa o fundo translúcido do WindUI",Icon="blend",Value=v31.interfaceTransparency,Callback=function(v1599)
			v31.interfaceTransparency = v1599;
			pcall(function()
				v51:ToggleTransparency(v1599);
			end);
		end});
		v50.scaleSlider = v928:Slider({Title="Escala da interface",Desc="Ajusta o tamanho geral do painel",Value={Min=0.65,Max=1.25,Default=v31.interfaceScale},Step=0.05,Callback=function(v1601)
			v31.interfaceScale = v1601;
			pcall(function()
				v51:SetUIScale(v1601);
			end);
		end});
		v928:Dropdown({Title="Idioma",Desc="Português ou mensagens centrais em inglês",Values={"Português","English"},Value=v31.language,Callback=function(v1603)
			v31.language = v1603 or "Português";
			pcall(function()
				v52:SetLanguage(((v31.language == "English") and "en") or "pt");
			end);
			v54("Idioma atualizado", "Mensagens centrais usarão " .. v31.language .. ".", "languages", 4);
		end});
		v928:Button({Title="Minimizar para bolha",Desc="Oculta a janela e mantém um ícone arrastável na tela",Icon="circle-dot",Callback=function()
			v48.setPanelMinimized(true);
		end});
		v928:Button({Title="Centralizar janela",Desc="Reposiciona o painel no centro da tela",Icon="focus",Callback=function()
			pcall(function()
				v51:SetToTheCenter();
			end);
		end});
		v928:Button({Title="Restaurar interface",Desc="Tema Dark, transparência ativa, escala 100% e posição central",Icon="rotate-ccw",Callback=function()
			pcall(function()
				v51:SetTheme("Dark");
				v51:ToggleTransparency(true);
				v51:SetUIScale(1);
				v51:SetToTheCenter();
				v50.themeDropdown:Select("Dark");
				v50.transparencyToggle:Set(true);
				v50.scaleSlider:Set(1);
			end);
			v31.interfaceTheme = "Dark";
			v31.interfaceTransparency = true;
			v31.interfaceScale = 1;
			v54("Interface restaurada", "Tema, escala e posição foram redefinidos.", "circle-check", 4);
		end});
		v928:Dropdown({Title="Atalho do painel",Desc="Alterna entre a janela e a bolha minimizada",Values={"K","L","M","RightShift","Insert","Home"},Value=v31.panelKey,Callback=function(v1608)
			v31.panelKey = v1608 or "K";
			pcall(function()
				v51:SetToggleKey(v48.getShortcutKeyCode(v31.panelKey, Enum.KeyCode.K));
			end);
			v54("Atalho atualizado", "Painel: " .. v31.panelKey, "keyboard", 4);
		end});
		v928:Dropdown({Title="Atalho de emergência",Desc="Restaura todas as alterações locais imediatamente",Values={"End","Delete","Home","Insert"},Value=v31.emergencyKey,Callback=function(v1610)
			v31.emergencyKey = v1610 or "End";
			v54("Atalho atualizado", "Emergência: " .. v31.emergencyKey, "keyboard", 4);
		end});
		v931:Button({Title="Copiar coordenadas",Desc="Copia X, Y e Z para a área de transferência",Icon="copy",Callback=function()
			local v1612, v1612, v1613 = v75();
			if v1613 then
				local v1815 = string.format("%.3f, %.3f, %.3f", v1613.Position.X, v1613.Position.Y, v1613.Position.Z);
				local v1816 = pcall(setclipboard, v1815);
				if v1816 then
					v54("Coordenadas copiadas", v1815, "clipboard-check", 4);
				else
					v54("Falha ao copiar", "O executor não disponibilizou a área de transferência.", "circle-alert", 4);
				end
			else
				v54("Sem personagem", "Não foi possível ler a posição atual.", "circle-alert", 4);
			end
		end});
		v931:Button({Title="Copiar JobId",Desc="Identificador do servidor atual",Icon="server",Callback=function()
			local v1614 = pcall(setclipboard, game.JobId);
			if v1614 then
				v54("JobId copiado", game.JobId, "clipboard-check", 5);
			else
				v54("Falha ao copiar", "O executor não disponibilizou a área de transferência.", "circle-alert", 4);
			end
		end});
		v931:Button({Title="Desequipar ferramentas",Desc="Move ferramentas equipadas de volta à mochila",Icon="package",Callback=function()
			local v1615, v1616 = v75();
			if v1616 then
				v1616:UnequipTools();
				v54("Ferramentas desequipadas", "Itens devolvidos à mochila.", "circle-check", 3);
			end
		end});
		v931:Button({Title="Resgatar códigos conhecidos",Desc="Tenta códigos públicos de experiência, reset e títulos; códigos usados são ignorados pelo servidor",Icon="ticket-check",Callback=function()
			task.spawn(function()
				local v1699 = v22:FindFirstChild("Redeem");
				if not v1699 then
					v54("Códigos indisponíveis", "Remote Redeem não encontrado.", "circle-alert", 4);
					return;
				end
				for v1817, v1818 in ipairs(v132) do
					if not v4.alive() then
						return;
					end
					pcall(function()
						v1699:InvokeServer(v1818);
					end);
					task.wait(0.08);
				end
				v54("Códigos processados", tostring(#v132) .. " códigos enviados com intervalo seguro.", "ticket-check", 5);
			end);
		end});
		v931:Button({Title="Entrar na equipe Piratas",Desc="Solicita ao servidor a equipe Pirates",Icon="skull",Callback=function()
			local v1617 = pcall(function()
				v23:InvokeServer("SetTeam", "Pirates");
			end);
			v54((v1617 and "Equipe solicitada") or "Falha na equipe", (v1617 and "Pirates") or "Solicitação recusada.", (v1617 and "circle-check") or "circle-alert", 4);
		end});
		v931:Button({Title="Entrar na equipe Marines",Desc="Solicita ao servidor a equipe Marines",Icon="shield",Callback=function()
			local v1618 = pcall(function()
				v23:InvokeServer("SetTeam", "Marines");
			end);
			v54((v1618 and "Equipe solicitada") or "Falha na equipe", (v1618 and "Marines") or "Solicitação recusada.", (v1618 and "circle-check") or "circle-alert", 4);
		end});
		v931:Button({Title="Viajar para Sea 1",Desc="Usa o comando oficial TravelMain",Icon="ship-wheel",Callback=function()
			pcall(function()
				v23:InvokeServer("TravelMain");
			end);
		end});
		v931:Button({Title="Viajar para Sea 2",Desc="Requer os requisitos normais do jogo",Icon="ship-wheel",Callback=function()
			pcall(function()
				v23:InvokeServer("TravelDressrosa");
			end);
		end});
		v931:Button({Title="Viajar para Sea 3",Desc="Requer os requisitos normais do jogo",Icon="ship-wheel",Callback=function()
			pcall(function()
				v23:InvokeServer("TravelZou");
			end);
		end});
		v931:Button({Title="Trocar para servidor público",Desc="Procura uma instância pública disponível diferente da atual",Icon="server-cog",Callback=function()
			task.spawn(function()
				local v1700, v1701 = pcall(v133);
				if (v1700 and v1701) then
					v182(true);
					local v1889 = pcall(function()
						v14:TeleportToPlaceInstance(game.PlaceId, v1701, v18);
					end);
					if (not v1889 and v4.alive()) then
						v54("Falha ao trocar servidor", "O Roblox recusou o teleporte.", "circle-alert", 5);
					end
				else
					v54("Servidor não encontrado", "Nenhuma instância disponível foi localizada agora.", "circle-alert", 5);
				end
			end);
		end});
		v931:Button({Title="Reconectar ao servidor",Desc="Entra novamente na mesma instância do jogo",Icon="refresh-cw",Callback=function()
			v182(true);
			v54("Reconectando", "Solicitação enviada ao Roblox.", "loader", 3);
			task.defer(function()
				local v1702 = pcall(function()
					v14:TeleportToPlaceInstance(game.PlaceId, game.JobId, v18);
				end);
				if (not v1702 and v4.alive()) then
					v54("Falha ao reconectar", "O Roblox recusou a solicitação de teleporte.", "circle-alert", 5);
				end
			end);
		end});
		v50.staffAlertsToggle = v932:Toggle({Title="Alerta informativo de staff",Desc="Avisa sobre cargos altos do grupo; não troca de servidor nem tenta evitar moderação",Icon="user-round-cog",Value=false,Callback=function(v1619)
			v31.staffAlerts = v1619;
			v47.staffAlerted = {};
			if v1619 then
				for v1890, v1891 in ipairs(v6:GetPlayers()) do
					v200(v1891);
				end
			end
		end});
		v932:Button({Title="PARADA DE EMERGÊNCIA",Desc="Desliga farm, movimento, noclip, FOV, iluminação e ESP",Icon="octagon-alert",Color=Color3.fromRGB(210, 55, 55),Callback=function()
			v182(true);
			v54("Tudo interrompido", "Todos os recursos foram restaurados.", "shield-check", 5);
		end});
		v932:Button({Title="Restaurar configurações",Desc="Mantém o painel aberto, mas restaura o jogo",Icon="rotate-ccw",Callback=function()
			v182(true);
			v54("Restauração concluída", "Estado local original reaplicado.", "circle-check", 4);
		end});
		v932:Button({Title="Descarregar painel",Desc="Restaura tudo e remove completamente a interface",Icon="power",Callback=function()
			if v47.unloading then
				return;
			end
			v47.unloading = true;
			task.defer(function()
				v46();
				v182(false);
				pcall(function()
					if (v51 and v51.Destroy) then
						v51:Destroy();
					end
				end);
				for v1819, v1820 in ipairs(v47.createdUi) do
					pcall(function()
						v1820:Destroy();
					end);
				end
				if (v5 and (type(v4.cleanup) == "function")) then
					v4.cleanup();
				end
			end);
		end});
		v932:Button({Title="Atalho de emergência configurável",Desc="Consulte ou altere a tecla na aba Interface",Icon="keyboard",Callback=function()
			v54("Atalho ativo", "A tecla " .. v31.emergencyKey .. " executa a parada de emergência.", "keyboard", 4);
		end});
	end
	v946();
end
v247();
v0.__ROYALHUB_PANEL_V2 = {version=v32,getSnapshot=function()
	return {farmEnabled=v31.farmEnabled,manualTravel=v31.manualTravel,collectionOverride=v47.collectionOverride,autoStats=v31.autoStats,movementEnabled=v31.movementEnabled,noclip=v31.noclip,farmState=v47.farmState,farmDetail=v47.farmDetail,queueSize=v47.collectionQueueSize,errors=v47.totalRuntimeErrors,fps=v47.currentFps,sessionSeconds=(os.clock() - v47.sessionStartedAt)};
end,emergencyStop=function()
	v182(true);
end,setMinimized=function(v947)
	v48.setPanelMinimized(v947 == true);
end};
v4.connect(v18.CharacterAdded, function(v948)
	v159();
	v160();
	v162();
	v47.combatGeneration = v47.combatGeneration + 1;
	local v950 = v948:WaitForChild("Humanoid", 15);
	if (not v950 or not v4.alive()) then
		return;
	end
	task.wait(0.5);
	v76();
	if v31.movementEnabled then
		v77();
	end
end);
v4.connect(v9.JumpRequest, function()
	if not v31.infiniteJump then
		return;
	end
	local v951, v952 = v75();
	if (v952 and (v952.Health > 0)) then
		v952:ChangeState(Enum.HumanoidStateType.Jumping);
	end
end);
v4.connect(v9.InputBegan, function(v953, v954)
	if (not v954 and (v953.KeyCode == v48.getShortcutKeyCode(v31.emergencyKey, Enum.KeyCode.End))) then
		v182(true);
		v54("Parada de emergência", "Todos os recursos foram interrompidos.", "shield-check", 5);
	end
end);
v4.connect(v18.Idled, function()
	if v31.antiAfk then
		pcall(function()
			v11:CaptureController();
			v11:ClickButton2(Vector2.new());
		end);
	end
end);
v4.connect(v6.PlayerAdded, function(v955)
	v200(v955);
end);
local v249 = v18:FindFirstChildOfClass("PlayerGui");
if v249 then
	v4.connect(v249.ChildAdded, function(v1623)
		if (v31.disableGameNotifications and (v1623.Name == "Notifications")) then
			task.defer(v90);
		end
	end);
end
v4.connect(workspace.DescendantAdded, function(v956)
	task.defer(function()
		if (not v4.alive() or not v956.Parent) then
			return;
		end
		local v1230, v1231 = v114(v956);
		if v1230 then
			v47.lastFruitSeen = v1230.Name;
			v48.appendActivity("Radar", "Fruta detectada: " .. v1230.Name);
			if (v31.rareFruitAlerts and v125(v1230.Name) and not v47.rareFruitAlerted[v1230]) then
				v47.rareFruitAlerted[v1230] = true;
				v54("Fruta rara detectada", v1230.Name, "bell-ring", 8);
			end
		end
		if (v1230 and v31.fruitEsp) then
			local v1705 = v108(v1230);
			if v1705 then
				v105(v1230, v1705, "RoyalHub_FruitHighlight", Color3.fromRGB(255, 92, 92));
			end
		end
		if (v1231 and v31.chestEsp) then
			local v1706 = v108(v1231);
			if v1706 then
				v105(v1231, v1706, "RoyalHub_ChestHighlight", v116(v1231));
			end
		end
		if v1231 then
			v47.lastChestSeen = v115(v1231);
		end
	end);
	if v31.fpsBoost then
		task.defer(function()
			if (v4.alive() and v956.Parent) then
				pcall(v94, v956);
			end
		end);
	end
end);
v4.connect(workspace.DescendantRemoving, function(v957)
	v106.fruits[v957] = nil;
	v106.chests[v957] = nil;
end);
v4.connect(v13.DescendantAdded, function(v960)
	if v31.fpsBoost then
		task.defer(function()
			if (v4.alive() and v960.Parent) then
				pcall(v94, v960);
			end
		end);
	end
end);
v4.connect(v20.ChildAdded, function(v961)
	task.defer(function()
		task.wait(0.2);
		if (v4.alive() and v961.Parent) then
			local v1708 = v961:FindFirstChild("HumanoidRootPart");
			if v1708 then
				v142(v140(v961.Name), v1708.Position);
			end
			if v31.npcEsp then
				v102(v961);
			end
		end
	end);
end);
v4.connect(v7.RenderStepped, function()
	v47.framesThisSecond = v47.framesThisSecond + 1;
	local v963 = os.clock();
	local v964 = v963 - v47.lastFpsSample;
	if (v964 >= 1) then
		v47.currentFps = math.floor((v47.framesThisSecond / v964) + 0.5);
		v47.framesThisSecond = 0;
		v47.lastFpsSample = v963;
	end
	if (v31.fullBright or v31.noFog) then
		v88();
	end
end);
v4.connect(v7.Stepped, function()
	if (v31.noclip or v31.farmEnabled or v31.chestFarm or v31.fruitCollector or v31.smartCollector or v31.manualTravel) then
		v79();
	end
end);
v4.connect(v7.Heartbeat, function()
	if v31.walkOnWater then
		v82();
	elseif v47.waterPlatform then
		v81();
	end
	if ((v31.farmEnabled or v31.chestFarm or v31.fruitCollector or v31.smartCollector or v31.manualTravel) and v47.travelTween and (v47.travelTween.PlaybackState == Enum.PlaybackState.Playing)) then
		local v1627 = v47.travelTweenRoot;
		local v1628 = v47.travelAnchor;
		if (v1627 and v1627.Parent and v1628 and v1628.Parent) then
			local v1821 = (v1627.Position - v1628.Position).Magnitude;
			if (v1821 <= 90) then
				v1627.AssemblyLinearVelocity = Vector3.zero;
				v1627.AssemblyAngularVelocity = Vector3.zero;
				v1627.CFrame = v1628.CFrame;
			else
				v159();
				v47.lastServerCorrection = os.clock();
				v47.serverCorrectionCount = v47.serverCorrectionCount + 1;
				v47.safeTravelUntil = os.clock() + math.min(12, 3 + (v47.serverCorrectionCount * 2));
				v47.travelRetryAfter = os.clock() + math.min(2, 0.35 + (v47.serverCorrectionCount * 0.25));
				v152("Recalculando rota", string.format("Correção do servidor | modo seguro %d", v47.serverCorrectionCount));
			end
		else
			v159(false);
		end
	elseif ((v47.serverCorrectionCount > 0) and ((os.clock() - v47.lastServerCorrection) > 10)) then
		v47.serverCorrectionCount = 0;
		v47.safeTravelUntil = 0;
	end
end);
task.spawn(function()
	while v4.alive() do
		local v1232 = os.clock();
		local v1233, v1234 = xpcall(function()
			if ((v1232 - v47.lastTelemetryUpdate) >= 1) then
				v47.lastTelemetryUpdate = v1232;
				if (v53 and v53.Parent and not v47.unloading) then
					v47.reopenBubble.Visible = not v48.isGuiTreeVisible(v53);
				end
				v48.updateQuestTelemetry(v1232);
				local v1825, v1826 = v126();
				v47.lastWorldCounts = {npcs=#v20:GetChildren(),chests=v1826,fruits=v1825};
				local v1828 = (v31.manualTravel and "Travel") or (v47.collectionOverride and "Coletor inteligente") or (v31.farmEnabled and v47.farmState) or ((v31.chestFarm or v31.fruitCollector or v31.smartCollector) and v47.collectionState) or "Parado";
				local v1829 = (v31.manualTravel and (v47.manualTravelName or "Em rota")) or (v47.collectionOverride and v47.collectionDetail) or (v31.farmEnabled and (v47.farmDetail .. v48.getQuestProgressSummary())) or ((v31.chestFarm or v31.fruitCollector or v31.smartCollector) and v47.collectionDetail) or "Nenhuma automação de movimento ativa";
				if v50.activityCard then
					pcall(function()
						v50.activityCard:SetTitle("Atividade: " .. v1828);
						v50.activityCard:SetDesc(v1829);
					end);
				end
				if v50.worldRadarCard then
					pcall(function()
						v50.worldRadarCard:SetTitle(string.format("Radar: %d NPCs | %d baús | %d frutas", v47.lastWorldCounts.npcs, v1826, v1825));
						v50.worldRadarCard:SetDesc(string.format("FPS %d | Ping %.0f ms | Streaming dinâmico", v47.currentFps, v48.getNetworkPingMilliseconds()));
					end);
				end
				if v50.sessionCard then
					pcall(function()
						v50.sessionCard:SetTitle("Sessão: " .. v48.formatDuration(v1232 - v47.sessionStartedAt));
						v50.sessionCard:SetDesc(string.format("%d NPCs | %d baús | %d frutas | %d erros", v47.npcsDefeated, v47.chestsCollected, v47.fruitsCollected, v47.totalRuntimeErrors));
					end);
				end
				if v50.collectorStatus then
					pcall(function()
						v50.collectorStatus:SetTitle(string.format("Fila: %d item%s", v47.collectionQueueSize, ((v47.collectionQueueSize == 1) and "") or "s"));
						v50.collectorStatus:SetDesc(v47.collectionDetail);
					end);
				end
				if (v31.manualTravel and v47.manualTravelPosition) then
					local v1922, v1922, v1923 = v75();
					local v1924 = (v1923 and (v1923.Position - v47.manualTravelPosition).Magnitude) or 0;
					v47.travelEta = v1924 / math.max(v31.travelSpeed, 1);
				end
			end
			if ((v1232 - v47.lastLabelUpdate) >= 0.4) then
				v47.lastLabelUpdate = v1232;
				local v1831, v1831, v1832 = v75();
				local v1833 = workspace.CurrentCamera;
				for v1893, v1894 in pairs(v47.espLabels) do
					if (not v1893.Parent or not v1894.gui or not v1894.gui.Parent or not v1894.adornee or not v1894.adornee.Parent) then
						if v1894.gui then
							pcall(function()
								v1894.gui:Destroy();
							end);
						end
						if v1894.indicator then
							pcall(function()
								v1894.indicator:Destroy();
							end);
						end
						v47.espLabels[v1893] = nil;
					elseif (v1894.label and v1832) then
						local v1985 = (v1832.Position - v1894.adornee.Position).Magnitude;
						local v1986 = v1985 <= v31.espMaxDistance;
						v1894.gui.Enabled = v1986;
						local v1988 = "";
						if (v1894.humanoid and v1894.humanoid.Parent) then
							v1988 = string.format(" | %.0f/%.0f HP", v1894.humanoid.Health, v1894.humanoid.MaxHealth);
						end
						v1894.label.Text = string.format("%s | %.0f studs%s", v1894.displayName, v1985, v1988);
						local v1990 = false;
						if (v1833 and v1986 and v31.espOffscreenIndicators) then
							local v2026, v2027 = v1833:WorldToViewportPoint(v1894.adornee.Position);
							v1990 = not v2027 or (v2026.Z <= 0);
							if v1990 then
								local v2057 = v241(v1894);
								local v2058 = v1833.ViewportSize;
								local v2059 = v2058 / 2;
								local v2060 = Vector2.new(v2026.X, v2026.Y) - v2059;
								if (v2026.Z <= 0) then
									v2060 = -v2060;
								end
								if (v2060.Magnitude < 1) then
									v2060 = Vector2.new(0, -1);
								end
								v2060 = v2060.Unit;
								local v2062 = math.max(60, (v2058.X / 2) - 78);
								local v2063 = math.max(50, (v2058.Y / 2) - 34);
								local v2064 = math.min(v2062 / math.max(math.abs(v2060.X), 0.01), v2063 / math.max(math.abs(v2060.Y), 0.01));
								local v2065 = v2059 + (v2060 * v2064);
								local v2066;
								if (math.abs(v2060.X) > math.abs(v2060.Y)) then
									v2066 = ((v2060.X > 0) and "▶") or "◀";
								else
									v2066 = ((v2060.Y > 0) and "▼") or "▲";
								end
								v2057.Position = UDim2.fromOffset(v2065.X, v2065.Y);
								v2057.BackgroundColor3 = v1894.color:Lerp(Color3.fromRGB(18, 21, 30), 0.6);
								v2057.Text = string.format("%s %s · %.0f", v2066, v1894.displayName, v1985);
								v2057.Visible = true;
							end
						end
						if (not v1990 and v1894.indicator) then
							v1894.indicator.Visible = false;
						end
					end
				end
			end
			if ((v1232 - v47.lastConfigSave) >= 3) then
				v47.lastConfigSave = v1232;
				local v1835 = v12:JSONEncode(v42());
				if (v47.lastConfigFingerprint == nil) then
					v47.lastConfigFingerprint = v1835;
				elseif (v1835 ~= v47.lastConfigFingerprint) then
					local v1963 = v46();
					if v1963 then
						v47.lastConfigFingerprint = v1835;
					end
				end
			end
			if v31.movementEnabled then
				v77();
			end
			if v31.disableGameNotifications then
				v90();
			end
			if v31.disableDamageCounter then
				v92();
			end
			if (v31.autoStats and ((v1232 - v47.lastStatPoint) >= 0.35)) then
				v47.lastStatPoint = v1232;
				local v1837 = v18:FindFirstChild("Data");
				local v1838 = v1837 and v1837:FindFirstChild("Points");
				if (v1838 and v1838:IsA("IntValue") and (v1838.Value > v31.statReserve)) then
					local v1927 = v194();
					local v1928 = v1837:FindFirstChild("Stats");
					local v1929 = v1927 and v1928 and v1928:FindFirstChild(v1927);
					local v1930 = v1929 and v1929:FindFirstChild("Level");
					if (v1927 and v1930 and v1930:IsA("IntValue")) then
						local v1964 = math.max(0, v1838.Value - v31.statReserve);
						local v1965 = math.min(v31.statBatch, v1964, math.max(0, v31.statCap - v1930.Value));
						if (v1965 > 0) then
							local v1995, v1996 = pcall(function()
								return v23:InvokeServer("AddPoint", v1927, v1965);
							end);
							if (v1995 and (v1996 ~= false)) then
								local v2030 = v47.lastStatTarget ~= v1927;
								v47.statFailureCount = 0;
								v47.statPointsRequested = v47.statPointsRequested + v1965;
								v47.lastStatTarget = v1927;
								v48.recordStatAllocation(v1927, v1965);
								if v2030 then
									v48.appendActivity("Stats", string.format("Distribuindo em %s | lote %d", v1927, v1965));
								end
							else
								v47.statFailureCount = v47.statFailureCount + 1;
								if (v47.statFailureCount >= 3) then
									v31.autoStats = false;
									v180(v50.autoStatsToggle, false);
									v54("Auto Stats pausado", "O servidor recusou três solicitações consecutivas; nenhum novo ponto será enviado.", "shield-alert", 6);
								end
							end
						end
					elseif not v1927 then
						v31.autoStats = false;
						v180(v50.autoStatsToggle, false);
						v54("Auto Stats concluído", "Todos os atributos do perfil atingiram o limite configurado.", "circle-check", 5);
					end
				end
			end
			if (v31.autoObservation and ((v1232 - v47.lastObservation) >= 2.5)) then
				v47.lastObservation = v1232;
				local v1840 = v18:FindFirstChildOfClass("PlayerGui");
				local v1841 = v1840 and v1840:FindFirstChild("Main");
				local v1842 = v1841 and v1841:FindFirstChild("ScreenGui");
				local v1843 = v1842 and v1842:FindFirstChild("ImageLabel");
				if (not v1843 or not v1843.Visible) then
					local v1931 = v22:FindFirstChild("CommE");
					if v1931 then
						pcall(function()
							v1931:FireServer("Ken", true);
						end);
					end
				end
			end
			if (v31.autoRaceAbility and ((v1232 - v47.lastRaceAbility) >= 4)) then
				v47.lastRaceAbility = v1232;
				local v1845 = v18.Character;
				local v1846 = v1845 and v1845:FindFirstChild("RaceTransformed");
				local v1847 = v1846 ~= nil;
				if (v1846 and v1846:IsA("BoolValue")) then
					v1847 = v1846.Value;
				end
				if not v1847 then
					local v1933 = v22:FindFirstChild("CommE");
					if v1933 then
						pcall(function()
							v1933:FireServer("ActivateAbility");
						end);
					end
				end
			end
			if (v31.autoStoreFruit and ((v1232 - v47.lastFruitStore) >= 2)) then
				v47.lastFruitStore = v1232;
				v131();
			end
			if (v31.autoRollFruit and ((v1232 - v47.lastFruitRoll) >= 60)) then
				v47.lastFruitRoll = v1232;
				local v1850, v1851 = v199(true);
				if v1850 then
					v54("Auto Roll Fruit", v1851, "dices", 5);
				end
			end
			if (v31.autoSetSpawn and ((v1232 - v47.lastSetSpawn) >= 4)) then
				local v1852, v1853, v1854 = v75();
				if (v1853 and v1854 and (v1853.Health > 0) and (v1854.AssemblyLinearVelocity.Magnitude <= 12)) then
					local v1934, v1935 = v188(v1854.Position);
					if (v1934 and (v1935 <= 900) and (v1934 ~= v47.lastSpawnIsland)) then
						v47.lastSetSpawn = v1232;
						local v1967, v1968 = pcall(function()
							return v23:InvokeServer("SetSpawnPoint");
						end);
						if (v1967 and (v1968 ~= false)) then
							v47.lastSpawnIsland = v1934;
							v47.lastSpawnRequestStatus = "Confirmado em " .. v1934;
							v54("Spawn atualizado", v1934, "map-pin-check", 4);
						else
							v47.lastSpawnRequestStatus = "Recusado pelo servidor em " .. v1934;
						end
					end
				end
			end
			if ((v31.autoSecondSea or v31.autoThirdSea) and ((v1232 - v47.lastSeaProgress) >= 6)) then
				v47.lastSeaProgress = v1232;
				local v1856, v1857;
				if v31.autoSecondSea then
					v1856, v1857 = v203();
				else
					v1856, v1857 = v205();
				end
				if (v1856 and v1857) then
					v54("Progressão de Sea", v1857, "ship", 5);
				end
			end
			if (v31.smartCollector and not v31.manualTravel) then
				local v1858, v1859, v1860 = v75();
				if (v1859 and v1860 and (v1859.Health > 0)) then
					local v1936 = v127(v1860.Position);
					if (v47.collectionTarget and not v48.isCollectionTargetValid(v47.collectionTarget, v47.collectionTargetType)) then
						v48.clearSmartCollectionTarget(true);
					end
					if v1936 then
						if (v47.collectionTarget ~= v1936.instance) then
							v159();
							if v47.collectionTarget then
								v48.clearSmartCollectionTarget(false, "Fila repriorizada");
							end
							v47.collectionTarget = v1936.instance;
							v47.collectionTargetPart = v1936.part;
							v47.collectionTargetType = v1936.kind;
							v47.collectionTargetSince = v1232;
							v48.appendActivity("Coletor", string.format("Próximo: %s | %s | %.0f studs", v1936.kind, v1936.instance.Name, v1936.distance));
						elseif (((v1232 - v47.collectionTargetSince) > 25) and (v1936.distance > 8)) then
							v47.collectionIgnoredUntil[v1936.instance] = v1232 + 15;
							v48.clearSmartCollectionTarget(false, "Ignorado por 15s");
							v159();
						end
						v47.collectionOverride = v47.collectionTarget ~= nil;
						if v47.collectionOverride then
							v47.collectionState = "Fila inteligente";
							v47.collectionDetail = string.format("%s | %s | %.0f studs | fila %d", v1936.kind, v1936.instance.Name, v1936.distance, v47.collectionQueueSize);
							v165(v1860, v1936.part.Position + Vector3.new(0, 2, 0));
						end
					else
						local v1970 = v47.collectionTarget ~= nil;
						if v47.collectionTarget then
							local v2010 = not v48.isCollectionTargetValid(v47.collectionTarget, v47.collectionTargetType);
							if v2010 then
								v48.clearSmartCollectionTarget(true);
							else
								v48.clearSmartCollectionTarget(false, "Não elegível nesta fila");
							end
						end
						v47.collectionOverride = false;
						v47.collectionState = "Fila vazia";
						v47.collectionDetail = (v31.farmEnabled and "Auto Farm retomado") or "Aguardando novos objetos";
						if (v1970 and v31.farmEnabled and not v31.collectorResumeFarm) then
							v181(true);
							v47.collectionDetail = "Auto Farm permaneceu pausado conforme configuração";
						end
						if not v31.farmEnabled then
							v159();
							v162();
						end
					end
				else
					v47.collectionOverride = false;
					v47.collectionState = "Recuperando";
					v47.collectionDetail = "Aguardando o personagem reaparecer";
				end
			elseif v47.collectionOverride then
				v47.collectionOverride = false;
				v48.clearSmartCollectionTarget(false, "Fila interrompida");
				v159();
			end
			if v31.manualTravel then
				local v1861, v1862, v1863 = v75();
				local v1864 = v47.manualTravelPosition;
				if (not v1862 or not v1863 or (v1862.Health <= 0)) then
					v159();
					v162();
					if v50.travelStatus then
						pcall(function()
							v50.travelStatus:SetTitle("Travel: Recuperando");
							v50.travelStatus:SetDesc("Aguardando o personagem reaparecer");
						end);
					end
				elseif (typeof(v1864) ~= "Vector3") then
					v191("Destino deixou de ser válido");
				else
					local v1974 = (v1863.Position - v1864).Magnitude;
					if (v1974 <= 12) then
						local v2012 = v47.manualTravelName or "Destino";
						v191("Destino alcançado: " .. v2012);
						v54("Travel concluído", v2012, "map-pin-check", 4);
					else
						if v50.travelStatus then
							pcall(function()
								v50.travelStatus:SetTitle("Travel: Em rota");
								v50.travelStatus:SetDesc(string.format("%s | %.0f studs | ETA %.0fs", v47.manualTravelName or "Destino", v1974, v47.travelEta));
							end);
						end
						v165(v1863, v1864);
					end
				end
			end
			if (not v31.farmEnabled and (v31.chestFarm or v31.fruitCollector)) then
				local v1865, v1866, v1867 = v75();
				if (not v1866 or not v1867 or (v1866.Health <= 0)) then
					v159();
					v162();
					v47.collectionState = "Recuperando";
					v47.collectionDetail = "Aguardando o personagem reaparecer";
				elseif v31.chestFarm then
					local v1975, v1976, v1977 = v122(v1867.Position);
					if (v1975 and v1976) then
						v47.collectionState = "Chest Farm";
						v47.collectionDetail = string.format("%s | %.0f studs", v115(v1975), v1977);
						v165(v1867, v1976.Position + Vector3.new(0, 2, 0));
					else
						v159();
						v162();
						v47.collectionState = "Aguardando baú";
						v47.collectionDetail = "Nenhum baú visível carregado";
					end
				elseif v31.fruitCollector then
					local v2017, v2018, v2019 = v123(v1867.Position);
					if (v2017 and v2018) then
						v47.collectionState = "Coletando fruta";
						v47.collectionDetail = string.format("%s | %.0f studs", v2017.Name, v2019);
						v165(v1867, v2018.Position + Vector3.new(0, 2, 0));
					else
						v159();
						v162();
						v47.collectionState = "Aguardando fruta";
						v47.collectionDetail = "Nenhuma fruta física carregada";
					end
				end
			end
			if v31.fovEnabled then
				local v1868 = workspace.CurrentCamera;
				if v1868 then
					v1868.FieldOfView = v31.fov;
				end
			end
			if (v31.farmEnabled and not v47.collectionOverride) then
				local v1869, v1870, v1871 = v75();
				if (not v1869 or not v1870 or not v1871 or (v1870.Health <= 0)) then
					if v47.combatTarget then
						v47.combatGeneration = v47.combatGeneration + 1;
						v47.combatTarget = nil;
						v47.combatTargetHealth = nil;
						v47.combatGroupSize = 0;
					end
					v159();
					v162();
					v152("Recuperando", "Aguardando o personagem reaparecer");
				else
					local v1945 = v151(false);
					if not v1945 then
						v181(true);
						v54("Farm interrompido", "Nenhum alvo compatível foi encontrado.", "circle-alert", 5);
					else
						local v1982 = true;
						if (v1982 and (v1945.mode == "Auto Level") and v31.autoQuest) then
							local v2020 = v135();
							local v2021 = (v2020 and v2020.Visible) or false;
							if (v2021 and not v168(v1945)) then
								v1982 = false;
								if v47.combatTarget then
									v47.combatGeneration = v47.combatGeneration + 1;
									v47.combatTarget = nil;
									v47.combatTargetHealth = nil;
									v47.combatGroupSize = 0;
								end
								v159();
								v152("Trocando missão", "Removendo a missão incompatível");
								if ((v1232 - v47.lastQuestAction) >= 1.5) then
									v47.lastQuestAction = v1232;
									pcall(function()
										v23:InvokeServer("AbandonQuest");
									end);
								end
							elseif not v2021 then
								v1982 = false;
								if v47.combatTarget then
									v47.combatGeneration = v47.combatGeneration + 1;
									v47.combatTarget = nil;
									v47.combatTargetHealth = nil;
									v47.combatGroupSize = 0;
								end
								local v2080 = v1945.questPosition + Vector3.new(0, 3, 0);
								local v2081 = (v1871.Position - v2080).Magnitude;
								if (v2081 > 8) then
									v152("Indo à missão", string.format("%s #%s | %.0f studs", v1945.questName, tostring(v1945.questTier), v2081));
									v165(v1871, v2080);
								else
									v159();
									v163(v1871);
									v152("Aceitando missão", v1945.questName .. " #" .. tostring(v1945.questTier));
									if ((v1232 - v47.lastQuestAction) >= 1.5) then
										v47.lastQuestAction = v1232;
										pcall(function()
											v23:InvokeServer("StartQuest", v1945.questName, v1945.questTier);
										end);
									end
								end
							end
						end
						if v1982 then
							local v2022, v2023, v2024, v2025 = v155(v1945);
							if (v2022 and v2023 and v2024) then
								local v2040 = v47.combatHealthByTarget[v2022];
								if (v2040 and (v2023.Health < v2040)) then
									v47.lastDamageObserved = v1232;
									v47.lastTargetProgress = v1232;
									v47.remoteFallbackUntil = 0;
									v47.remoteFailureCount = 0;
								end
								v47.combatHealthByTarget[v2022] = v2023.Health;
								if (v47.combatTarget ~= v2022) then
									v159();
									v47.combatGeneration = v47.combatGeneration + 1;
									v47.combatTarget = v2022;
									v47.combatTargetHealth = v2023.Health;
									v47.combatGroupCursor = 0;
									v47.targetAcquiredAt = v1232;
									v47.lastTargetProgress = v1232;
									v47.lastTargetDistance = v2025;
									v47.lastDamageObserved = v1232;
									v47.remoteFallbackUntil = 0;
									v47.remoteFailureCount = 0;
									v47.targetSwitches = v47.targetSwitches + 1;
									v48.appendActivity("Farm", string.format("Alvo: %s | %.0f studs", v2022.Name, v2025));
									if not v47.trackedNpcDeaths[v2023] then
										v47.trackedNpcDeaths[v2023] = true;
										v4.connect(v2023.Died, function()
											v47.npcsDefeated = v47.npcsDefeated + 1;
											v48.appendActivity("Farm", "NPC derrotado: " .. v2022.Name);
										end);
									end
								end
								v47.combatTargetHealth = v2023.Health;
								if ((v2025 + 5) < v47.lastTargetDistance) then
									v47.lastTargetDistance = v2025;
									v47.lastTargetProgress = v1232;
								end
								if ((v1232 - v47.targetAcquiredAt) >= v31.targetTimeout) then
									v154(v2022, "tempo máximo excedido");
									v47.combatTarget = nil;
									v47.combatGeneration = v47.combatGeneration + 1;
								elseif ((v1232 - v47.lastTargetProgress) >= v31.stuckTimeout) then
									v154(v2022, "sem dano ou aproximação");
									v47.combatTarget = nil;
									v47.combatGeneration = v47.combatGeneration + 1;
								end
								local v2044 = v156(v1945, v2022, v31.remoteAttackRange);
								for v2071, v2072 in ipairs(v2044) do
									local v2073 = v2072:FindFirstChildOfClass("Humanoid");
									if v2073 then
										local v2107 = v47.combatHealthByTarget[v2072];
										if (v2107 and (v2073.Health < v2107)) then
											v47.lastDamageObserved = v1232;
											v47.lastTargetProgress = v1232;
											v47.remoteFallbackUntil = 0;
											v47.remoteFailureCount = 0;
										end
										v47.combatHealthByTarget[v2072] = v2073.Health;
									end
								end
								local v2045 = v31.remoteAttackRange;
								if (v1232 < v47.remoteFallbackUntil) then
									local v2102 = ((v47.remoteFailureCount >= 2) and 25) or 60;
									v2045 = math.min(v2045, v2102);
								end
								local v2046 = v2025 <= v2045;
								if (v2046 and (v1232 >= v47.remoteFallbackUntil) and ((v1232 - v47.lastDamageObserved) > 2.5)) then
									v47.remoteFailureCount = v47.remoteFailureCount + 1;
									v47.remoteFallbackUntil = v1232 + 3;
									local v2105 = ((v47.remoteFailureCount >= 2) and 25) or 60;
									v2045 = math.min(v31.remoteAttackRange, v2105);
									v2046 = v2025 <= v2045;
								end
								local v2047 = (v2046 and v156(v1945, v2022, v2045)) or {};
								v47.combatGroupSize = #v2047;
								local v2049 = v167(v2047, v2024);
								local v2050 = (v1871.Position - v2049).Magnitude;
								if not v2046 then
									v152("Aproximando para ataque remoto", string.format("%s | %.0f / %.0f studs", v1945.targetName, v2025, v2045));
									v165(v1871, v2049, 4);
								else
									v152(((v2050 > 5) and "Perseguindo e atacando") or "Ataque remoto em movimento", string.format("%s | %.0f studs | %d NPC%s | altura %.0f%s", v1945.targetName, v2025, #v2047, ((#v2047 == 1) and "") or "s", v31.hoverHeight, v48.getQuestProgressSummary()));
									if (v2050 > 5) then
										v165(v1871, v2049, 3);
									else
										v159();
										local v2117 = v163(v1871);
										v2117.Velocity = Vector3.zero;
										v1871.AssemblyLinearVelocity = Vector3.zero;
										v1871.AssemblyAngularVelocity = Vector3.zero;
										local v2122 = Vector3.new(v2024.Position.X, v1871.Position.Y, v2024.Position.Z);
										if ((v2122 - v1871.Position).Magnitude > 0.1) then
											v1871.CFrame = CFrame.lookAt(v1871.Position, v2122);
										end
									end
									if (v31.autoAura and not v1869:FindFirstChild("HasBuso") and ((v1232 - v47.lastAura) >= 3)) then
										v47.lastAura = v1232;
										local v2124 = pcall(function()
											v23:InvokeServer("Buso");
										end);
										if v2124 then
											v47.auraActivatedByFarm = true;
										end
									end
									if ((v1232 - v47.lastAttack) >= v31.attackInterval) then
										v47.lastAttack = v1232;
										local v2126 = v177(v1869, v1870);
										v179(v2126, v2047);
									end
									if ((v1232 - v47.lastSkill) >= v31.skillInterval) then
										v47.lastSkill = v1232;
										pcall(v170);
									end
								end
							else
								if v47.combatTarget then
									v47.combatGeneration = v47.combatGeneration + 1;
								end
								v47.combatTarget = nil;
								v47.combatTargetHealth = nil;
								v47.combatGroupSize = 0;
								local v2054 = v157(v1945, v1871.Position, v1232);
								local v2055 = v2054 + Vector3.new(0, v31.hoverHeight, 0);
								local v2056 = (v1871.Position - v2055).Magnitude;
								v152("Aguardando respawn", string.format("%s | %.0f studs", v1945.targetName, v2056));
								v165(v1871, v2055);
							end
						end
					end
				end
			end
			if (v47.uiReady and not v47.unloading) then
				if (not v53 or not v53.Parent) then
					v47.unloading = true;
					v182(false);
					return;
				end
			end
		end, function(v1629)
			return debug.traceback(tostring(v1629), 2);
		end);
		if not v1233 then
			v47.iterationErrorCount = v47.iterationErrorCount + 1;
			v47.totalRuntimeErrors = v47.totalRuntimeErrors + 1;
			v47.lastRuntimeError = tostring(v1234);
			warn("[RoyalHub] Recuperação automática: " .. v47.lastRuntimeError);
			v159();
			v162();
			if v31.farmEnabled then
				v152("Recuperando de erro", "Tentativa " .. tostring(v47.iterationErrorCount) .. " de 3");
			end
			if (v47.iterationErrorCount >= 3) then
				v182(true);
				v47.iterationErrorCount = 0;
				v54("Proteção automática acionada", "Uma função falhou repetidamente e todos os recursos foram restaurados.", "shield-alert", 6);
			end
		else
			v47.iterationErrorCount = 0;
		end
		if v47.unloading then
			return;
		end
		task.wait((v31.farmEnabled and 0.12) or 0.25);
	end
end);
task.wait();
for v965, v966 in ipairs(v30:GetChildren()) do
	if not v208[v966] then
		table.insert(v47.createdUi, v966);
	end
end
v47.uiReady = true;
v182(true);
v48.appendActivity("Segurança", "Inicialização segura confirmada: automações desligadas");
task.defer(function()
	task.wait(0.6);
	pcall(function()
		if (v51.TabModule and v51.TabModule.SelectTab) then
			v51.TabModule:SelectTab(1);
		end
	end);
end);
v4.onCleanup(function()
	if (v0.__ROYALHUB_PANEL_V2 and (v0.__ROYALHUB_PANEL_V2.version == v32)) then
		v0.__ROYALHUB_PANEL_V2 = nil;
	end
	v46();
	v182(false);
	pcall(function()
		if (v51 and v51.Destroy) then
			v51:Destroy();
		end
	end);
	for v1235, v1236 in ipairs(v47.createdUi) do
		pcall(function()
			v1236:Destroy();
		end);
	end
end);
v54("Painel profissional carregado", "Recursos iniciam desligados. END executa a parada de emergência.", "shield-check", 6);
return "RoyalHub carregado";
