--!nonstrict
repeat task.wait() until game:IsLoaded()

local OWNER = "N3xusZ154-Stack"
local REPOSITORY = "RoyalHub-Release"
local BRANCH = "main"

local Environment = getgenv()
local HttpService = game:GetService("HttpService")
local channel = tostring(Environment.ROYALHUB_CHANNEL or "stable"):lower()
channel = channel == "beta" and "beta" or "stable"

local rawBase = string.format("https://raw.githubusercontent.com/%s/%s/%s/", OWNER, REPOSITORY, BRANCH)
local manifestUrl = rawBase .. "manifest.json"

local function download(url)
    local ok, body = pcall(function()
        return game:HttpGet(url)
    end)
    if ok and type(body) == "string" and #body > 10 then
        return body
    end
    return nil, tostring(body)
end

local manifestBody, manifestError = download(manifestUrl)
assert(manifestBody, "[RoyalHub] Release manifest unavailable: " .. tostring(manifestError))

local decodeOk, manifest = pcall(function()
    return HttpService:JSONDecode(manifestBody)
end)
assert(decodeOk and type(manifest) == "table", "[RoyalHub] Invalid release manifest")

local release = manifest[channel]
if type(release) ~= "table" and channel == "beta" then
    channel = "stable"
    release = manifest.stable
end
assert(type(release) == "table" and type(release.version) == "string", "[RoyalHub] Invalid release")

if type(release.placeIds) == "table" and #release.placeIds > 0 and not table.find(release.placeIds, game.PlaceId) then
    error(string.format("[RoyalHub] PlaceId %d is not supported by this release", game.PlaceId))
end

local testedVersions = release.testedPlaceVersions
local testedVersion = type(testedVersions) == "table" and tonumber(testedVersions[tostring(game.PlaceId)]) or nil
if testedVersion and testedVersion ~= game.PlaceVersion then
    warn(string.format("[RoyalHub] Current place version: %d; validated version: %d", game.PlaceVersion, testedVersion))
end

local scriptReference = release.script
assert(type(scriptReference) == "string" and scriptReference ~= "", "[RoyalHub] Missing release script")
local scriptUrl = scriptReference:match("^https?://") and scriptReference or (rawBase .. scriptReference)

local source, sourceError = download(scriptUrl)
assert(source and #source > 1000, "[RoyalHub] Release build unavailable: " .. tostring(sourceError))

local chunk, compileError = loadstring(source, "@RoyalHub-" .. tostring(release.version))
assert(chunk, "[RoyalHub] Build compilation failed: " .. tostring(compileError))

Environment.__ROYALHUB_RELEASE = {
    version = release.version,
    channel = channel,
    manifestUrl = manifestUrl,
    scriptUrl = scriptUrl,
    release = release,
}
Environment.ROYALHUB_MANIFEST_URL = manifestUrl

local runOk, result = pcall(chunk)
assert(runOk, "[RoyalHub] Runtime error: " .. tostring(result))
return result
