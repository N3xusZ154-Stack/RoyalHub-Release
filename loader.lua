--!nonstrict
repeat task.wait() until game:IsLoaded()

local WORKER_URL = "https://royalhub-auth.zayro154stack.workers.dev"
local EXPECTED_GAME_ID = 994732206

local Environment = getgenv()
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer

local requestFn = rawget(Environment, "request") or rawget(Environment, "http_request")
if type(requestFn) ~= "function" then
    local httpLibrary = rawget(Environment, "http")
    if type(httpLibrary) == "table" then
        requestFn = rawget(httpLibrary, "request")
    end
end
if type(requestFn) ~= "function" then
    local synLibrary = rawget(Environment, "syn")
    if type(synLibrary) == "table" then
        requestFn = rawget(synLibrary, "request")
    end
end
assert(type(requestFn) == "function", "[RoyalHub] HTTP request não suportado")

local gethuiFn = rawget(Environment, "gethui")
local UiParent = game:GetService("CoreGui")
if type(gethuiFn) == "function" then
    local ok, result = pcall(gethuiFn)
    if ok and typeof(result) == "Instance" then
        UiParent = result
    end
end

local WindUISources = {
    "https://github.com/Footagesus/WindUI/releases/download/1.6.62/main.lua",
    "https://github.com/Footagesus/WindUI/releases/download/1.6.66/main.lua",
}

local function loadWindUI()
    local lastError = "unknown"
    for _, url in ipairs(WindUISources) do
        local ok, source = pcall(function()
            return game:HttpGet(url)
        end)
        if ok and type(source) == "string" and #source > 1000 then
            local chunk, compileError = loadstring(source, "@WindUI")
            if chunk then
                local runOk, library = pcall(chunk)
                if runOk and type(library) == "table" then
                    return library
                end
                lastError = tostring(library)
            else
                lastError = tostring(compileError)
            end
        else
            lastError = tostring(source)
        end
    end
    error("[RoyalHub] Não foi possível carregar a WindUI: " .. lastError)
end

local function normalizeKey(value)
    return tostring(value or ""):upper():gsub("^%s+", ""):gsub("%s+$", "")
end

local function decodeResponse(response)
    if type(response) ~= "table" then
        return nil, 0
    end

    local statusCode = tonumber(response.StatusCode or response.Status or 0) or 0
    local body = tostring(response.Body or response.body or "")
    local ok, decoded = pcall(function()
        return HttpService:JSONDecode(body)
    end)

    if not ok or type(decoded) ~= "table" then
        return nil, statusCode
    end

    return decoded, statusCode
end

local finalChunk = nil
local finalAuth = nil
local finalKey = nil
local lastValidationError = nil

local function authorizeKey(rawKey)
    local key = normalizeKey(rawKey)
    lastValidationError = nil

    if key == "" then
        lastValidationError = "Key vazia"
        return false
    end

    if game.GameId ~= EXPECTED_GAME_ID then
        lastValidationError = string.format(
            "Jogo não suportado | GameId: %d | PlaceId: %d",
            game.GameId,
            game.PlaceId
        )
        return false
    end

    local requestOk, authResponse = pcall(function()
        return requestFn({
            Url = WORKER_URL .. "/v1/authorize",
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json",
                ["Accept"] = "application/json",
            },
            Body = HttpService:JSONEncode({
                key = key,
                userId = tostring(Player.UserId),
                gameId = game.GameId,
                placeId = game.PlaceId,
                placeVersion = game.PlaceVersion,
            }),
        })
    end)

    if not requestOk then
        lastValidationError = "Falha ao contatar o servidor de autorização"
        return false
    end

    local auth, statusCode = decodeResponse(authResponse)
    if statusCode < 200 or statusCode >= 300 or not auth or auth.ok ~= true then
        local serverError = auth and tostring(auth.error or "Autorização negada") or "Resposta inválida do servidor"
        lastValidationError = string.format(
            "%s | GameId: %d | PlaceId: %d",
            serverError,
            game.GameId,
            game.PlaceId
        )
        return false
    end

    local session = tostring(auth.session or "")
    if #session < 32 then
        lastValidationError = "Sessão de autorização inválida"
        return false
    end

    local buildResponseOk, buildResponse = pcall(function()
        return requestFn({
            Url = WORKER_URL .. "/v1/build?session=" .. HttpService:UrlEncode(session),
            Method = "GET",
            Headers = {
                ["Accept"] = "text/plain",
            },
        })
    end)

    if not buildResponseOk or type(buildResponse) ~= "table" then
        lastValidationError = "Build privado indisponível"
        return false
    end

    local buildStatus = tonumber(buildResponse.StatusCode or buildResponse.Status or 0) or 0
    local source = tostring(buildResponse.Body or buildResponse.body or "")
    if buildStatus < 200 or buildStatus >= 300 or #source < 1000 then
        lastValidationError = "Build privado indisponível"
        return false
    end

    local chunk, compileError = loadstring(source, "@RoyalHub-private")
    if not chunk then
        warn("[RoyalHub] Build compilation failed: " .. tostring(compileError))
        lastValidationError = "Falha ao compilar o build privado"
        return false
    end

    finalKey = key
    finalAuth = auth
    finalChunk = chunk
    return true
end

local WindUI = loadWindUI()
WindUI:SetParent(UiParent)
WindUI:SetNotificationLower(true)

local GateWindow = WindUI:CreateWindow({
    Title = "RoyalHub",
    Icon = "shield-check",
    Author = "Secure Access",
    Folder = "RoyalHubKeyGate",
    Size = UDim2.fromOffset(500, 360),
    Theme = "Dark",
    Resizable = false,
    HideSearchBar = true,
    ScrollBarEnabled = false,
    User = {
        Enabled = false,
        Anonymous = true,
    },
    KeySystem = {
        Title = "RoyalHub Access",
        Note = "Enter your 1-day RoyalHub key to continue.",
        SaveKey = false,
        KeyValidator = function(key)
            local valid = authorizeKey(key)
            if not valid then
                pcall(function()
                    WindUI:Notify({
                        Title = "Access denied",
                        Content = lastValidationError or "Invalid key",
                        Icon = "circle-alert",
                        Duration = 6,
                    })
                end)
            end
            return valid
        end,
    },
})

assert(finalChunk and finalAuth and finalKey, "[RoyalHub] A autenticação não foi concluída")

Environment.ROYALHUB_KEY = finalKey
Environment.__ROYALHUB_LICENSE = {
    expiresAt = tonumber(finalAuth.licenseExpiresAt),
    sessionExpiresAt = tonumber(finalAuth.sessionExpiresAt),
    gameId = tonumber(finalAuth.gameId),
    placeId = tonumber(finalAuth.placeId),
}

pcall(function()
    GateWindow:Destroy()
end)

local ok, result = pcall(finalChunk)
assert(ok, "[RoyalHub] Erro em tempo de execução: " .. tostring(result))
return result
