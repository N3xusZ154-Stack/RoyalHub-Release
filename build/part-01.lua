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
			task.wait(0.35);
		end
	end
	error("[RoyalHub] WindUI indisponível: " .. v341);
end
local v75;
local v76;
local v77;
local v78;
local v79;
local v80;
local v81;
local v82;
local v83;
local v84;
local v85;
local v86;
local v87;
local v88;
local v89;
local v90;
local v91;
local v92;
local v93;
local v94;
local v95;
local v96;
local v97;
local v98;
local v99;
local v100;
local v101;
local v102;
local v103;
local v104;
local v105;
local v106;
local v107;
local v108;
local v109;
local v110;
local v111;
local v112;
local v113;
local v114;
local v115;
local v116;
local v117;
local v118;
local v119;
local v120;
local v121;
local v122;
local v123;
local v124;
local v125;
local v126;
local v127;
local v128;
local v129;
local v130;
local v131;
local v132;
local v133;
local v134;
local v135;
local v136;
local v137;
local v138;
local v139;
local v140;
local v141;
local v142;
local v143;
local v144;
local v145;
local v146;
local v147;
local v148;
local v149;
local v150;
local v151;
local v152;
local v153;
local v154;
local v155;
local v156;
local v157;
local v158;
local v159;
local v160;
local v161;
local v162;
local v163;
local v164;
local v165;
local v166;
local v167;
local v168;
local v169;
local v170;
local v171;
local v172;
local v173;
local v174;
local v175;
local v176;
local v177;
local v178;
local v179;
local v180;
local v181;
local v182;
local v183;
local v184;
local v185;
local v186;
local v187;
local v188;
local v189;
local v190;
local v191;
local v192;
local v193;
local v194;
local v195;
local v196;
local v197;
local v198;
local v199;
local v200;
local v201;
local v202;
local v203;
local v204;
local v205;
local v206;
local v207;
local v208;
local v209;
local v210;
local v211;
local v212;
local v213;
local v214;
local v215;
local v216;
local v217;
local v218;
local v219;
local v220;
local v221;
local v222;
local v223;
local v224;
local v225;
local v226;
local v227;
local v228;
local v229;
local v230;
local v231;
local v232;
local v233;
local v234;
local v235;
local v236;
local v237;
local v238;
local v239;
local v240;
local v241;
local v242;
local v243;
local v244;
local v245;
local v246;
local v247;
local v248;
local v249;
local v250;
