--!nonstrict
repeat task.wait() until game:IsLoaded()

local WORKER_URL = "https://royalhub-auth.zayro154stack.workers.dev"
local EXPECTED_GAME_ID = 994732206
local LOGO_URL = "https://raw.githubusercontent.com/N3xusZ154-Stack/RoyalHub-Release/main/assets/royalhub-logo.png"
local GET_KEY_URL = WORKER_URL .. "/get-key"

local Environment = getgenv()
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local RequestedLanguage = Environment.ROYALHUB_LANGUAGE
if RequestedLanguage == nil and type(isfile) == "function" and type(readfile) == "function" and isfile("RoyalHub/settings.json") then
    pcall(function()
        local saved = HttpService:JSONDecode(readfile("RoyalHub/settings.json"))
        local savedSettings = type(saved) == "table" and (saved.settings or saved) or nil
        if type(savedSettings) == "table" and savedSettings.language == "Português" then
            RequestedLanguage = "pt-BR"
        end
    end)
end
local Language = tostring(RequestedLanguage or "en"):lower()
local IsPortuguese = Language == "pt" or Language:sub(1, 3) == "pt-"

local function L(english, portuguese)
    return IsPortuguese and portuguese or english
end

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
assert(type(requestFn) == "function", L("[RoyalHub] HTTP requests are not supported by this executor", "[RoyalHub] Requisições HTTP não são suportadas por este executor"))

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
    error(L("[RoyalHub] WindUI could not be loaded: ", "[RoyalHub] Não foi possível carregar a WindUI: ") .. lastError)
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
        lastValidationError = L("Enter a key", "Digite uma key")
        return false
    end

    if game.GameId ~= EXPECTED_GAME_ID then
        lastValidationError = string.format(
            L("Unsupported game | GameId: %d | PlaceId: %d", "Jogo não suportado | GameId: %d | PlaceId: %d"),
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
        lastValidationError = L("Could not contact the authorization server", "Falha ao contatar o servidor de autorização")
        return false
    end

    local auth, statusCode = decodeResponse(authResponse)
    if statusCode < 200 or statusCode >= 300 or not auth or auth.ok ~= true then
        local serverError = auth and tostring(auth.error or L("Authorization denied", "Autorização negada")) or L("Invalid server response", "Resposta inválida do servidor")
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
        lastValidationError = L("Invalid authorization session", "Sessão de autorização inválida")
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
        lastValidationError = L("Private build unavailable", "Build privado indisponível")
        return false
    end

    local buildStatus = tonumber(buildResponse.StatusCode or buildResponse.Status or 0) or 0
    local source = tostring(buildResponse.Body or buildResponse.body or "")
    if buildStatus < 200 or buildStatus >= 300 or #source < 1000 then
        lastValidationError = L("Private build unavailable", "Build privado indisponível")
        return false
    end

    local chunk, compileError = loadstring(source, "@RoyalHub-private")
    if not chunk then
        warn("[RoyalHub] Build compilation failed: " .. tostring(compileError))
        lastValidationError = L("Private build compilation failed", "Falha ao compilar o build privado")
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
    Icon = LOGO_URL,
    Author = L("Secure Access", "Acesso seguro"),
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
        Title = L("RoyalHub Access", "Acesso RoyalHub"),
        Note = L("Enter your 1-day key to continue. Use Get Key if you do not have one.", "Digite sua key de 1 dia para continuar. Use Get Key caso ainda não tenha uma."),
        Thumbnail = {
            Image = LOGO_URL,
            Title = "RoyalHub",
        },
        URL = GET_KEY_URL,
        SaveKey = false,
        KeyValidator = function(key)
            local valid = authorizeKey(key)
            if not valid then
                pcall(function()
                    WindUI:Notify({
                        Title = L("Access denied", "Acesso negado"),
                        Content = lastValidationError or L("Invalid key", "Key inválida"),
                        Icon = "circle-alert",
                        Duration = 6,
                    })
                end)
            end
            return valid
        end,
    },
})

assert(finalChunk and finalAuth and finalKey, L("[RoyalHub] Authentication was not completed", "[RoyalHub] A autenticação não foi concluída"))

Environment.ROYALHUB_KEY = finalKey
Environment.ROYALHUB_LOGO_URL = LOGO_URL
Environment.ROYALHUB_LANGUAGE = IsPortuguese and "pt-BR" or "en"
Environment.__ROYALHUB_LICENSE = {
    expiresAt = tonumber(finalAuth.licenseExpiresAt),
    sessionExpiresAt = tonumber(finalAuth.sessionExpiresAt),
    gameId = tonumber(finalAuth.gameId),
    placeId = tonumber(finalAuth.placeId),
    language = Environment.ROYALHUB_LANGUAGE,
}

pcall(function()
    GateWindow:Destroy()
end)

local ok, result = pcall(finalChunk)
assert(ok, L("[RoyalHub] Runtime error: ", "[RoyalHub] Erro em tempo de execução: ") .. tostring(result))
return result
