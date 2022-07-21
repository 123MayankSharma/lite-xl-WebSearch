-- mod-version:2 -- lite-xl 2.0
local core = require "core"
local command = require "core.command"
local keymap = require "core.keymap"
local config = require "core.config"

--functions for encoding the url
--before sending it to browser
local char_to_hex = function(c)
  return string.format("%%%02X", string.byte(c))
end

local function urlencode(url)
  if url == nil then
    return
  end
  url = url:gsub("\n", "\r\n")
  url = string.gsub(url, "([^%w _ %- . ~])", char_to_hex)
  url = url:gsub(" ", "+")
  return url
end

--function to search for a given string after urlencoding it
local function Search(text)
    local query=text
    --encoding the text
    text=urlencode(text)
    --the default search engine is google
    local searchEngine="google"
    if config.plugins.search~=nil then
        searchEngine=config.plugins.search
    end
    searchEngine=string.lower(searchEngine)
    core.log("Searching the web for \"%s\"...", query)
    
    if searchEngine == "google" and text~="" then
        if PLATFORM == "Windows" then
            system.exec(string.format("start https://www.google.com/search?q=%s",text))
        elseif PLATFORM == "Linux" then
            system.exec(string.format("xdg-open https://www.google.com/search?q=%s",text))
        else
            system.exec(string.format("open https://www.google.com/search?q=%s", text))
        end
    elseif searchEngine=="duckduckgo" and text~="" then
        if PLATFORM == "Windows" then
            system.exec(string.format("start https://www.duckduckgo.com/%s",text))
        elseif PLATFORM == "Linux" then
            system.exec(string.format("xdg-open https://www.duckduckgo.com/%s",text))
        else
            system.exec(string.format("open https://www.duckduckgo.com/%s", text))
        end 
    elseif searchEngine == "bing" and text~="" then
        if PLATFORM == "Windows" then
            system.exec(string.format("start https://www.bing.com/search?q=%s",text))
        elseif PLATFORM == "Linux" then
            system.exec(string.format("xdg-open https://www.bing.com/search?q=%s",text))
        else
            system.exec(string.format("open https://www.bing.com/search?q=%s", text))
        end
    elseif searchEngine == "yahoo" and #text then
        if PLATFORM == "Windows" then
            system.exec(string.format("start https://search.yahoo.com/search?p=%s",text))
        elseif PLATFORM == "Linux" then
            system.exec(string.format("xdg-open https://search.yahoo.com/search?p=%s",text))
        else
            system.exec(string.format("open https://search.yahoo.com/search?p=%s", text))
        end 
    else
    end
end 



command.add("core.docview", {
  ["WebSearch:search-on-web"] = function()
    local doc = core.active_view.doc
    local text=""
    text=doc:get_text(doc:get_selection())
     core.command_view:set_text(text)
     core.command_view:enter("WebSearch",function(text)
        Search(text)
     end
    ,nil)
  end
})

keymap.add { ["ctrl+shift+b"] = "WebSearch:search-on-web" }
