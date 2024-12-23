firebase = {}
firebase.__index = firebase

local ffi = require("ffi")
--ffi.cdef[[int code, string body, table headers request(string url, table options)]]
--ffi.cdef([[typedef struct lua_State lua_State;
--        int luaopen_https(lua_State);
--        int request();]])
local json = require("json")
local utf8 = require("utf8")
local https = require("https")
--local https = package.loadlib("https","luaopen_https")
--local https = package.loadlib('https', 'luaopen_https')
--local https = ffi.load("https")
-- local osString = love.system.getOS()
-- if osString == 'Windows' then
--     https = ffi.load("https.dll")
-- elseif osString == 'Android' then
--     https = ffi.load("https.so")
-- end
function firebase:new(apiKey,realtimeDatabase)
    local self = {}
    setmetatable(self,firebase)
    self.apiKey = apiKey
    self.realtimeDatabase = realtimeDatabase
    self.localId = ''
    self.idToken = ''
    self.refreshToken = ''
    self.expiresIn = -1
    self.code = ''
    self.body = ''
    self.headers = ''
    self.writeThreadCode = [[
        -- Receive values sent via thread:start
        local realtimeDatabase, localId, idToken, data = ...
        local ffi = require("ffi")
        local https = nil
        local osString = love.system.getOS()
        if osString == 'Windows' then
            https = require("https")
        elseif osString == 'Android' then
            https = ffi.load("https.so")
        end
        local code, body, headers = https.request(realtimeDatabase.."/users/"..localId.."/data.json?auth="..idToken,{method = "put", headers = {}, data = data})
        love.thread.getChannel('fb_db_code'):push(code)
        love.thread.getChannel('fb_db_body'):push(body)
        love.thread.getChannel('fb_db_headers'):push(headers)
        ]]
    self.writethread = love.thread.newThread(self.writeThreadCode)
    self.getNewTokenCode = [[
        local apiKey, refreshToken = ...
        local ffi = require("ffi")
        local https = nil
        local osString = love.system.getOS()
        if osString == 'Windows' then
            https = require("https")
        elseif osString == 'Android' then
            https = ffi.load("https.so")
        end
        local json = require("json")
        local url = string.format("https://securetoken.googleapis.com/v1/token?key=%s",apiKey)
        local headers = {}  
        headers["content-type"] = "application/json"
        local datastring = json.encode({grant_type = 'refresh_token', refresh_token = refreshToken})
        local code, body, headers = https.request(url,{method = "POST", headers = headers, data = datastring})
        love.thread.getChannel('fb_token_code'):push(code)
        love.thread.getChannel('fb_token_body'):push(body)
        love.thread.getChannel('fb_token_headers'):push(headers)
        ]]
    self.getNewToken = love.thread.newThread(self.getNewTokenCode)
    return self
end

local function post_request(email, password, endpoint, apikey)
    local url = string.format("https://www.googleapis.com/identitytoolkit/v3/relyingparty/%s?key=%s",endpoint,apikey)
	local headers = {}  
	headers["content-type"] = "application/json"
	local datastring = json.encode({email = email, password = password, returnSecureToken = true})
    local code, body, headers = https.request(url,{method = "POST", headers = headers, data = datastring})
    return body
end

function firebase:decode_body(body)
    if json.decode(body).refreshToken then
        self.refreshToken = json.decode(body).refreshToken
    end
    if json.decode(body).idToken then
        self.idToken = json.decode(body).idToken
    elseif json.decode(body).id_token then
        self.idToken = json.decode(body).id_token
    end
    if json.decode(body).expiresIn then
        self.expiresIn =  tonumber(json.decode(body).expiresIn)
    elseif json.decode(body).expires_in then
        self.expiresIn =  tonumber(json.decode(body).expires_in)
    end
    if json.decode(body).localId then
        self.localId = json.decode(body).localId
    elseif json.decode(body).user_id then
        self.localId = json.decode(body).user_id
    elseif json.decode(body).error and json.decode(body).error.message then
        return json.decode(body).error.message
    end
    return true
end

function firebase:signup_email(email, password)
    return self:decode_body(post_request(email, password, "signupNewUser", self.apiKey))
end 

function firebase:signin_email(email, password)
    return self:decode_body(post_request(email, password, "verifyPassword", self.apiKey))
end 

function firebase:signout_email()
    --Reset local variables
    self.localId = ''
    self.idToken = ''
    self.refreshToken = ''
    self.expiresIn = -1
    self.code = ''
    self.body = ''
    self.headers = ''
    return true
end 

function firebase:get_new_token()
    if self.getNewToken:isRunning() == false and self.apiKey ~= '' and self.refreshToken ~= '' then
        self.getNewToken:start(self.apiKey, self.refreshToken)
    end
end

function firebase:write_database(data)
    if self.writethread:isRunning() == false and self.realtimeDatabase ~= '' and self.localId ~= '' and self.idToken ~= '' then
        self.writethread:start(self.realtimeDatabase,self.localId,self.idToken,data)
    end
end

function firebase:get_response(prefix)
    local code = love.thread.getChannel(prefix..'code'):pop()
    if code ~= nil then
        self.code = code
        self.body = love.thread.getChannel(prefix..'body'):pop()
        self.headers = love.thread.getChannel(prefix..'headers'):pop()
        self:decode_body(self.body)
        return true
    end
    return false
end

function firebase:get_token_response()
    return self:get_response("fb_token_")
end

function firebase:get_database_response()
    return self:get_response("fb_db_")
end

function firebase:update(dt)
    if self.refreshToken ~= '' then
        if self.expiresIn > 0 then
            self.expiresIn = self.expiresIn - dt
        end
        -- Will get new token if the old one expires in less than 10 secounds
        if self.expiresIn < 10 and self:get_token_response() == false then
            self:get_new_token()
        else
            self:get_database_response()
        end
    end
end